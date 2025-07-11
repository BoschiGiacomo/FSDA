function rhoOPT=OPTrho(u, c)
%OPTrho computes rho function for optimal weight function
%
%<a href="matlab: docsearchFS('OPTrho')">Link to the help function</a>
%
%  Required input arguments:
%
%    u:         scaled residuals or Mahalanobis distances. Vector. 
%               Vector of length n containing residuals or Mahalanobis distances
%               for the n units of the sample
%    c :        tuning parameter. Scalar. Scalar greater than 0 which
%               controls the robustness/efficiency of the estimator
%               (beta in regression or mu in the location case ...) 
%
%  Optional input arguments: TODO_OPTrho_INPUT_OPTIONS
%
%  Output:
%
%
%   rhoOPT :      residuals after rho filter. Vector. Vector of length n which contains
%                optima rho values associated to the residuals or
%                Mahalanobis distances for the n units of the sample.
%               Function OPTrho transforms vector u as follows
%
% 
% More About:
%
%  Yohai and Zamar (1997)  showed that the $\rho$ function given above
%  is optimal in the following highly desirable sense: the final M estimate
%  has a breakdown point of one-half and minimizes the maximum bias under
%  contamination distributions (locally for small fraction of
%  contamination), subject to achieving a desidered nominal asymptotic
%  efficiency when the data are Gaussian.
%
% \[
% \label{opt}
% \rho(x) = \begin{cases}
%  1.3846 \left( \frac{x}{c} \right)^2  \qquad |x| \leq \frac{2}{3} c \\
%  0.5514-2.6917\left( \frac{x}{c} \right)^2+10.7668\left( \frac{x}{c} \right)^4-11.6640\left( \frac{x}{c} \right)^6+4.0375\left( \frac{x}{c} \right)^8  
%  \qquad  \frac{2}{3} c <  |x|  \leq c 
% \\
% 1 \qquad                   |x| >c
% \end{cases}
% \]
%
% See also HYPrho, HArho, TBrho
%
% References:
%
% Maronna, R.A., Martin D. and Yohai V.J. (2006), "Robust Statistics, Theory
% and Methods", Wiley, New York.
% Riani, M., Cerioli, A. and Torti, F. (2014), On consistency factors and
% efficiency of robust S-estimators, "TEST", Vol. 23, pp. 356-387.
% http://dx.doi.org/10.1007/s11749-014-0357-7
% Yohai V.J., Zamar R.H. (1997) Optimal locally robust M-estimates of
% regression. "Journal of Planning and Statistical Inference", Vol. 64, pp.
% 309-323.
%
% Copyright 2008-2025.
% Written by FSDA team
%
%
%<a href="matlab: docsearchFS('OPTrho')">Link to the help page for this function</a>
%
%$LastChangedDate::                      $: Date of the last commit
%
% Examples:

%{
    % Plot of rho function. 
    x=-6:0.01:6;
    rhoOPT=OPTrho(x,2);
    plot(x,rhoOPT)
    xlabel('x','Interpreter','Latex')
    ylabel('$\rho (x)$','Interpreter','Latex')

%}

%% Beginning of code

c=c(1); % MATLAB Ccoder instruction to enforce that c is a scalar

rhoOPT = ones(size(u));
absx=abs(u);
u=u/c;

%  if x <=(2/3)*c
inds1 = absx <= (2/3)*c;
rhoOPT(inds1) = 1.3846*u(inds1).^2;

%  if    (2/3)*c< |x| <c
inds1 = (absx > (2/3)*c)&(absx <= c);
x1 = u(inds1);
rhoOPT(inds1) = (0.5514 -2.6917 * x1.^2  + 10.7668 * x1.^4  - 11.6640 * x1.^6  + 4.0375 * x1.^8 );

% 1 if r >*c



%% Old implementation in terms of 0<|u|<2c, 2c<|u|<3c, |u|>3c
%
%               |  1/(3.25*c^2) x^2/2                                                     |x|<=2c
%               |   
%   \rho(x,c) = |  (1/3.25) * (1.792 - 0.972 * (x/c)^2 + 0.432 * (x/c)^4 - 0.052 * (x/c)^6 + 0.002 * (x/c)^8)    2c<=|x|<=3c
%               |
%               |   1                                                                      |x|>3c                              
%
% c=c(1); % MATLAB Ccoder instruction to enforce that c is a scalar
% 
% rhoOPT = ones(size(u));
% absx=abs(u);
% 
% % x^2/2 /(3.25c^2) if x <=2*c
% inds1 = absx <= 2*c;
% rhoOPT(inds1) = u(inds1).^2 / 2 / (3.25*c^2);
% 
% % 1/(3.25) * ( 1.792 .... +0.002 (r/c)^8 )    if    2c< |x| <3c
% inds1 = (absx > 2*c)&(absx <= 3*c);
% x1 = u(inds1);
% rhoOPT(inds1) = (1.792 - 0.972 * x1.^2 / c^2 + 0.432 * x1.^4 / c^4 - 0.052 * x1.^6 / c^6 + 0.002 * x1.^8 / c^8) / 3.25;
% 
% % 1 if r >3*c
end

%% 



%FScategory:UTISTAT