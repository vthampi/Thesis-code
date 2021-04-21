    clc;
clear all;
%%
options = odeset ('Reltol',1e-4,'NonNegative',[1 2 3 4]);
% x1(1) = 0;
% x2(1) = 0;
% x3(1) = 0;

%Specify target values for parameterizing the model
s = linspace(0,0.6,13);
sigma = 0;

% Make dimensions of vector for x1,x2,x3
x10 = 0.1:0.2:0.9;
x20 = 0.1:0.2:0.9;
x30 = 0.1:0.2:0.9;
x40 = 0.1:0.2:0.9;

% Makes my matrix of all values it can take on
[x1,x2,x3,x4]=ndgrid(x10,x20,x30,x40);
x1 = x1(:);
x2 = x2(:);
x3 = x3(:);
x4 = x4(:);
% Restriction on what values these IC's can take on
I = (x1 + x2 <= 1);
%I2 = (0.05 <= x4) & (x4 <= 0.1);
%I3 = (x3 <= 0.6);
%I4 = (0.5<= x2) & (x2 <=0.6);

% Now it only calculates it for the stuff we want
x1 = x1(I);
x2 = x2(I);
x3 = x3(I);
x4 = x4(I);
%Y1 = zeros(length(x1),4);
%Y2 = zeros(length(x1),4);
%Y3 = zeros(length(x1),4);
%Y4 = zeros(length(x1),4);
%Y5 = zeros(length(x1),4);
%Y6 = zeros(length(x1),4);
%Y7 = zeros(length(x1),4);
%Y8 = zeros(length(x1),4);
tic;

figure('Visible','off')
count = 1;
for jj = 1:length(s)
    
            
            for ii = 1:length(x1)
                  
   [t,x] = ode45(@(t,x) systemnewde3(t,x,s(jj),sigma),[0:1:2000],[x1(ii),x2(ii),x3(ii),x4(ii)],options);
    
   clf;
   
    axis([0 2000 0 1]); 
    xlabel('Time (Years)');
    ylabel('Proportion of Population');
    plot(t,x(:,1),'o',t,x(:,2),'d',t,x(:,3),'+',t,x(:,4),'s');
    legend('Macroalgae','Coral','Parrotfish','Human Opinion');
    title(['s = ',num2str(s(jj)), ' sigma = ',num2str(sigma), ' x1 = ', num2str(x1(ii)), ' x2 = ', num2str(x2(ii)), ' x3 = ', num2str(x3(ii)), ' x4 = ', num2str(x4(ii))]);
    saveas(gcf, ['s = ',num2str(s(jj)), ' sigma = ',num2str(sigma), ' x1 = ', num2str(x1(ii)), ' x2 = ', num2str(x2(ii)), ' x3 = ', num2str(x3(ii)), ' x4 = ', num2str(x4(ii)), '.png'] )%gcf = get current figure

   waitbar(count/(length(x1)*length(s)));
   count = count + 1;
           
        end
    
end
toc;
