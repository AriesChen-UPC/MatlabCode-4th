function YESNO = ismember_internal(x,p)
%ISMEMBER_INTERNAL Helper for ISMEMBER

% Author Johan L�fberg
% $Id: ismember_internal.m,v 1.10 2007/08/08 08:14:28 joloef Exp $

if isa(x,'sdpvar') & isa(p,'polytope')

    if length(p) == 1
        [H,K] = double(p);
        if min(size(x))>1
            error('first argument should be a vector');
        end
        if length(x) == size(H,2)
            x = reshape(x,length(x),1);
            YESNO = set(H*x <= K);
            return
        else
            disp('The polytope in the ismember condition has wrong dimension')
            error('Dimension mismatch.');
        end

    else
        d = binvar(length(p),1);
        YESNO = set(sum(d)==1);
        for i = 1:length(p)
            [H,K] = double(p(i));
            if min(size(x))>1
                error('first argument should be a vector');
            end
            if length(x) == size(H,2)
                x = reshape(x,length(x),1);
                lhs = H*x-K;
                [M,m] = derivebounds(lhs);
                YESNO = YESNO + set(H*x-K <= M.*(1-extsubsref(d,i)));
            else
                error('Dimension mismatch.');
            end
        end

    end
    return
end

if isa(x,'sdpvar') & isa(p,'double')
    
    x = reshape(x,prod(x.dim),1);
    p = p(:);

    if length(p)==1
        F = set(x == p);
    else
        Delta = binvar(length(x),length(p),'full');
        F = set(sum(Delta,2) == 1);       
        F = F + set(x == Delta*p);
    end

    YESNO = F;
    return
end