function [model,changed] = convert_sigmonial_to_sdpfun(model)

% Always add this dummy struct
model.high_monom_model = [];

% Assume we don't do anything
changed = 0;

found_and_converted = [];
if any(model.variabletype > 3)
    % Bugger...
    changed = 1;

    % Find a higher order term
    sigmonials = find(model.variabletype == 4);

    model = update_monomial_bounds(model);

    monosig = sigmonials(find(sum(model.monomtable(sigmonials,:) | model.monomtable(sigmonials,:),2)==1));
    if ~isempty(monosig)
        % These are just monomial terms such as x^0.4 etc
        for i = 1:length(monosig)
            variable = find(model.monomtable(monosig(i),:));
            power = model.monomtable(monosig(i),variable);

            model = add_sigmonial_eval(model,monosig(i),variable,power);
            
            found_and_converted = [found_and_converted;variable power monosig(i)];
        end
    end
end
if any(model.variabletype > 3)
    % Bugger...we have mixed terms such as x/y etc

    % Find a higher order term
    sigmonials = find(model.variabletype == 4);

    for i = 1:length(sigmonials)
        n_old_monoms = size(model.monomtable,1);
        monoms = model.monomtable(sigmonials(i),:);
        sigs = find((monoms ~= fix(monoms)) | monoms<0);
        powers =  monoms(sigs);
        if ~isempty(found_and_converted)
            for j = 1:length(sigs)
                old_index = findrows(found_and_converted(:,1:2),[sigs(j) powers(j)]);
                if ~isempty(old_index)
                    corresponding_variable = found_and_converted(old_index,3);
                    model.monomtable(sigmonials(i),sigs(j)) = 0;
                    model.monomtable(sigmonials(i),corresponding_variable) = 1;
                    sigs(j)=nan;
                end
            end
        end
        powers(isnan(sigs)) = [];
        sigs(isnan(sigs)) = [];
        if length(sigs) > 0
            % Terms left that haven't been modeled
            model.monomtable(sigmonials(i),sigs) = 0;
            model.monomtable = blkdiag(model.monomtable,speye(length(sigs)));
            model.monomtable(sigmonials(i),n_old_monoms+1:n_old_monoms+length(sigs)) = 1;
            model.variabletype(sigmonials(i)) = 3;
            model.variabletype(end+1:end+length(sigs)) = 0;
            model.c(end+1:end+length(sigs)) = 0;
            model.Q = blkdiag(model.Q,zeros(length(sigs)));
            model.F_struc = [model.F_struc zeros(size(model.F_struc,1),length(sigs))];
            model.lb = [model.lb;-inf(length(sigs),1)];
            model.ub = [model.ub;inf(length(sigs),1)];
            model.x0 = [model.x0;model.x0(sigs).^powers(:)];
            for j = 1:length(sigs)
                model.evalVariables = [model.evalVariables n_old_monoms+j];
                model.evalMap{end+1}.fcn = 'power_internal2';
                model.evalMap{end}.arg{1} = recover(n_old_monoms+j);
                model.evalMap{end}.arg{2} = powers(j);
                model.evalMap{end}.arg{3} = [];
                model.evalMap{end}.variableIndex = sigs(j);
                model.evalMap{end}.properties.bounds = @power_bound;
                model.evalMap{end}.properties.convexhull = @power_convexhull;                
            end
        end
        if sum(model.monomtable(sigmonials(i),:))<=2
            if nnz(model.monomtable(sigmonials(i),:))==1
                model.variabletype(sigmonials(i)) = 2;
            else
                model.variabletype(sigmonials(i)) = 1;
            end
        end
    end
    model = update_eval_bounds(model);
end

function  model = add_sigmonial_eval(model,monosig,variable,power)
model.evalVariables = [model.evalVariables monosig];
model.evalMap{end+1}.fcn = 'power_internal2';
model.evalMap{end}.arg{1} = recover(variable);
model.evalMap{end}.arg{2} = power;
model.evalMap{end}.arg{3} = [];
model.evalMap{end}.variableIndex = find(model.monomtable(monosig,:));
model.evalMap{end}.properties.bounds = @power_bound;
model.evalMap{end}.properties.convexhull = @power_convexhull;
model.monomtable(monosig,variable) = 0;
model.monomtable(monosig,monosig) = 1;
model.variabletype(monosig) = 0;


% This should not be hidden here....
function [L,U] = power_bound(xL,xU,power)
if xL >= 0
    % This is the easy case
    % we use abs since 0 sometimes actually is -0 but still passes the test
    % above
    if power > 0
        L = abs(xL)^power;
        U = abs(xU)^power;
    else
        L = abs(xU)^power;
        U = abs(xL)^power;
    end
else
    if power < 0 & xU > 0
        % Nasty crossing around zero
        U = inf;
        L = -inf;
    elseif xU < 0
        L = xU^power;
        U = xL^power;       
    else        
        disp('Not implemented yet')
        error
    end
end

function [Ax, Ay, b] = power_convexhull(xL,xU,power)
fL = xL^power;
fU = xU^power;
dfL = power*xL^(power-1);
dfU = power*xU^(power-1);
if xL<0 & xU>0
    % Nasty crossing
    Ax = [];
    Ay = [];
    b = [];
    return
end
if power > 1 | power < 0
    [Ax,Ay,b] = convexhullConvex(xL,xU,fL,fU,dfL,dfU);
else
    [Ax,Ay,b] = convexhullConcave(xL,xU,fL,fU,dfL,dfU);
end
if ~isempty(Ax)
    if isinf(Ax(1))
        Ay(1) = 0;
        Ax(1) = -1;
        B(1)  = 0;
    end
end

