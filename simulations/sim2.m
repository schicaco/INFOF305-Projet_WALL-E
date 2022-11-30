#A = [3 2; 2 3]; #noeud instable 
A = [2 3; 3 2]; #selle 

[x1,x2] = meshgrid(-1.5:0.1:1.5);

x1_values = A(1,1)*x1+A(1,2)*x2;
x2_values = A(2,1)*x1+A(2,2)*x2;

norms=sqrt(x1_values.^2+x2_values.^2);
x1_normalized = x1_values ./ norms;
x2_normalized = x2_values ./norms;

line_range = -1.5:.1:1.5;
# isoclines
isocline_1 = -(A(1,1)/A(1,2)) * line_range;
isocline_2 = -(A(2,1)/A(2,2)) * line_range;

# Droites invariantes (vecteurs propres) 
[V,L] = eig(A);
eigenvector_1 = (V(2,1)/V(1,1)) * line_range;
eigenvector_2 = (V(2,2)/V(1,2)) * line_range;

figure(1);
hold on;
vector_scale = .5;
quiver(x1,x2,x1_normalized,x2_normalized, vector_scale);

plot(line_range,isocline_1,"linewidth", 2, "linestyle", ":");
plot(line_range,isocline_2,"linewidth", 2, "linestyle", ":");

plot(line_range,eigenvector_1,"linewidth",2);
plot(line_range,eigenvector_2,"linewidth",2);
quiver([0;0],[0;0],V(1,:),V(2,:),"linewidth",5,"color","k");
hold off;