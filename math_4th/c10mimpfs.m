function y = c10mimpfs(u)
y=1/8*u*(ml_func([1,1.8],-u/2)*ml_func([1,1.2],-u/2)+...
    ml_func([1,1.7],-u/2)*ml_func([1,1.3],-u/2));
