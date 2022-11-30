# 1er systeme
A = [2 3; 0 0];

[x1,x2] = meshgrid(-1.5:0.1:1.5);

x1_values = A(1,1)*x1+A(1,2)*x2;
x2_values = A(2,1)*x1+A(2,2)*x2;

norms=sqrt(x1_values.^2+x2_values.^2);
x1_normalized = x1_values ./ norms;
x2_normalized = x2_values ./norms;

# isoclines
line_range = -1.5:.1:1.5;
isocline_1 = -(A(1,1)/A(1,2)) * line_range;
# isocline_2 = -(A(2,1)/A(2,2)) * line_range;
# 2nd isocline has no equation so commented 
# to avoid error raised by division by zero

figure(1);
hold on;
vector_scale = .5;
quiver(x1,x2,x1_normalized,x2_normalized, vector_scale);
plot(line_range,isocline_1,"linewidth", 3, "linestyle", ":");
hold off;

figure(2);
hold on;
x1dot = @(t, x) A(1,1)*x(1)+A(1,2)*x(2);
x2dot = @(t, x) A(2,1)*x(1)+A(2,2)*x(2);
xdot = @(t,x) [x1dot(t, x);x2dot(t, x)];
xdot1 = @(t,x1) [x1dot(t, x1);x2dot(t, x1)];
[t,x] = ode23(xdot, [0, 10], [2, 0]);
#[t,x] = ode23(xdot, [0, 10], [0, 3]);
#[t,x] = ode23(xdot, [0, 10], [-2, 3]);
#[t,x] = ode23(xdot1, [0, 10], [2, -3]);
#[t,x] = ode23(xdot, [0, 10], [2, 2]);

plot(t,x)

hold off;