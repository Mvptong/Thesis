function f = maximize_power_objective_functions (x)
load 'neural network 3 hidden layer.mat' net
a = x(1) ; b = x(2) ; c = x(3) ; t = x(4) ; i = x(5) ; v = x(6) ;
f = -(((v*0.2096)+0.7223)*((i*0.3784)+0.3811));
end