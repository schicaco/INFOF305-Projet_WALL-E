#A = [2 3; -3 -2]; #centre
A = [3 2; -2 -3]; #selle

#TODO: vérifier si isoclines de graph avec nbrs complexes est bon 

[x1,x2] = meshgrid(-1.5:0.1:1.5);

x1_values = A(1,1)*x1+A(1,2)*x2;
x2_values = A(2,1)*x1+A(2,2)*x2;

norms=sqrt(x1_values.^2+x2_values.^2);
x1_normalized = x1_values ./ norms;
x2_normalized = x2_values ./norms;

# Isoclines
line_range = -1.5:.1:1.5;
isocline_1 = -(A(1,1)/A(1,2)) * line_range;
isocline_2 = -(A(2,1)/A(2,2)) * line_range;

# Droites invariantes (vecteurs propres) 
[V,L] = eig(A);
eigenvector_1 = (V(2,1)/V(1,1)) * line_range;
eigenvector_2 = (V(2,2)/V(1,2)) * line_range;

# Figure 1: portrait de phase, isoclines et vecteurs propres
figure(1);
hold on;
vector_scale = .5;

quiver(x1,x2,x1_normalized,x2_normalized, vector_scale);

# commenter isocline 1 et vecteur propre 1 pour le centre
plot(line_range,isocline_1,"linewidth", 2, "linestyle", ":");
plot(line_range,isocline_2,"linewidth", 2, "linestyle", ":");

plot(line_range,eigenvector_1,"linewidth",2);
plot(line_range,eigenvector_2,"linewidth",2);
quiver([0;0],[0;0],V(1,:),V(2,:),"linewidth",5,"color","k");

legend("portrait de phase","isocline 1","isocline 2", "v_1","v_2","location","south");
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