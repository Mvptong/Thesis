load 'neural network 3 hidden layer.mat' net
fun = @maximize_power_objective_functions ;
nvars = 6;
A = [] ; b =[] ; Aeq=[] ; beq = [];

%lb=[0.5, 0, 0.3, 30, 0, 0.182] ; ub=[0.9000, 17.4479, 1.0000, 60.0000, 1.2000, 1.0300];
%lb=[-1.0672, -0.3652, -1.3721, -1.3765, -1.0071, -2.5778] ; ub=[1.6744, 3.7264, 1.6847, -0.4681, 2.1641, 1.468];
% Vary N:C and Pt loading  with low himidifier

lb=[-1.0672, 0.5845, 0.3554, -1.3765, -1.0071, -2.5778] ; ub=[-1.0672, 3.7245, 0.3554, -0.4681, 2.1641, 1.468];
%Fix N:C ratio and Pt loading

%lb=[-1.0672, 0.5845, 0.3554, -1.3765, -1.0071, -2.5778] ; ub=[1.6744, 3.7245, 1.6847, -0.4681, 2.1641, 1.468];
%Vary N:C and Pt loading   except SiO2 with low himidifier

nonlcon = @maximize_power_const;
%[x,fval] = ga(fun,nvars,A,b,Aeq,beq,lb,ub,nonlcon)
%rng default % For reproducibility
%options = optimoptions('ga','PlotFcn',{@gaplotdistance,@gaplotrange},'MaxStallGenerations',200,'MaxGenerations',1000,'FunctionTolerance',1e-10);
[x,fval,exitflag,output] = ga(fun,nvars,A,b,Aeq,beq,lb,ub,nonlcon)
%net([(a-0.6557)/0.1459; (b-1.5575)/4.2643; (c-0.6142)/0.229; (t-45.1525)/11.0079; (i-0.3811)/0.3784])
NC_ratio = (x(1)*0.1459)+0.6557
SiO2_additive = (x(2)*4.2643)+1.5575
Pt_loading = (x(3)*0.229)+0.6142
T_humidifier = (x(4)*11.0079)+45.1525
Current = (x(5)*0.3784)+0.3811
Voltage = (x(6)*0.2096)+0.7223