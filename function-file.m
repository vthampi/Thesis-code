% MCTPx model
%
% Implements a comparmental SIR-like model
%   
%  Inputs:
%   t       - Time variable
%
%   x       - Independent variable: percentage of live coral density at "t"
%      
%   y       - Independent variable: percentage of dead coral density time "t"
%
%   z       - Independent variable: percentage of parrotfish density at time "t"
% Output:
%
%   dx      - First derivative: the rate of change of the populations
%
%   gamma   - natural death rate of parrotfish
%
%   alpha   - grazing intensity
%             
%   mu      - natural birth rate of live coral
%
%   phi     - growth rate of parrotfish
%
%   ro      - effect of predation
%
%   d       - natural mortality rate of corals
%
%   K       - carrying capacity of coral population

function dydt = systemnewde3(t,x,s,sigma)

dx = [0; 0; 0; 0];
a = 0.1; % or 0.18-0.39
gamma = 0.8; %
r = 1;
d = 0.44; 
%s = 0.49;
z = 0.5;
 
%sigma= 0.34; % This is parameter has range 0<sigma<=1
Kappa = 1.014;
M = 1.68;
Phi = 0.2;

dx(1) = (a * x(1) * x(2) - x(3) * x(1)/( x(1) + (1- x(1)-x(2)) ) + gamma * x(1) * (1- x(1)-x(2)));
dx(2) = (r * x(2) * (1- x(1)-x(2)) - d * x(2) - a * x(1) * x(2));
dx(3) = (s * x(3)*(1 - x(3) / (1-z*x(2))) - sigma * x(3) * (1 - x(4)));
dx(4) = (Kappa * x(4) * ( 1 - x(4) ) * ( -1 +  M * ( 1 - x(2) ) - sigma * x(3)*(1 - x(4)) + Phi * ( 2 * x(4) - 1 )));

dydt=dx;
