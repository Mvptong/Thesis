function [c, ceq] = maximize_power_const (x)
load 'neural network 3 hidden layer.mat' net
a = x(1) ; b = x(2) ; c = x(3) ; t = x(4) ; i = x(5) ; v = x(6) ;
input = [a; b; c; t; i];
%net([(a-0.6557)/0.1459; (b-1.5575)/4.2643; (c-0.6142)/0.229; (t-45.1525)/11.0079; (i-0.3811)/0.3784])
c = [];
ceq = net(input) - v;
end 