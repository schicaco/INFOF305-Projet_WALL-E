A = [2 0;3 0];
[x1,x2] = meshgrid(-1.5:0.1:1.5);

x1_values = A(1,1)*x1+A(1,2)*x2;
x2_values = A(2,1)*x1+A(2,2)*x2;

norms=sqrt(x1_values.^2+x2_values.^2);
x1_normalized = x1_values ./ norms;
x2_normalized = x2_values ./norms;

# Pas d'isoclines, double division par zéro

# Droites invariantes (vecteurs propres) 
[V,L] = eig(A);
eigenvector_1 = (V(2,1)/V(1,1)) * line_range;
eigenvector_2 = (V(2,2)/V(1,2)) * line_range;

# Figure 1: portrait de phase, isoclines et vecteurs propres
figure(1);
hold on;
vector_scale = .5;

quiver(x1,x2,x1_normalized,x2_normalized, vector_scale);

plot(line_range,eigenvector_1,"linewidth",3);
plot(line_range,eigenvector_2,"linewidth",3);
quiver([0;0],[0;0],V(1,:),V(2,:),"linewidth",3,"color","k");

legend("portrait de phase", "v_1","v_2","location","south");
hold off;

# Figure 2: trajectoires e(t), w(t) avec 5 conditions initiales
figure(2);
hold on;
x1dot = @(t, x) A(1,1)*x(1)+A(1,2)*x(2);
x2dot = @(t, x) A(2,1)*x(1)+A(2,2)*x(2);
xdot = @(t,x) [x1dot(t, x);x2dot(t, x)];
[t1,x1] = ode23(xdot, [0, 10], [2, 0]);
[t2,x2] = ode23(xdot, [0, 10], [0, 3]);
[t3,x3] = ode23(xdot, [0, 10], [-2, 3]);
[t4,x4] = ode23(xdot, [0, 10], [2, -3]);
[t5,x5] = ode23(xdot, [0, 10], [2, 2]);

plot(t1,x1);
plot(t2,x2);
plot(t3,x3);
plot(t4,x4);
plot(t5,x5);

hold off;