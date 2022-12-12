#CHICA COBO Sofia 518664 - PHAM Dang Phi L. 482207

figure(1)
hold on ;
function vecteurs_propres(A, intervalle)
    # Chaque vecteur propre se trouve dans une ligne de la matrice V.
    [V,L] = eig(A);
    eigenvector_1 = (V(1,2)/V(1,1)) * intervalle;
    eigenvector_2 = (V(2,2)/V(2,1)) * intervalle;
    plot(intervalle, eigenvector_1,"linewidth",3);
    plot(intervalle, eigenvector_2,"linewidth",3);
    if L(1, 1) > 0
        quiver(0, 0, V(1, 1), V(1, 2), "color", "k", "linewidth", 2);
    else
        quiver(V(1, 1), V(1, 2), -V(1, 1), -V(1, 2), "color", "k", "linewidth", 2);
    end
    if L(2, 2) > 0
        quiver(0, 0, V(2, 1), V(2, 2), "color", "k", "linewidth", 3);
    else
        quiver(V(2, 1), V(2, 2), -V(2, 1), -V(2, 2), "color", "k", "linewidth", 2);
    end
    legend("v_1","v_2","location","south");
endfunction

function isoclines(A, intervalle)
    isocline_1 = -(A(1,1)/A(1,2)) * intervalle;
    isocline_2 = -(A(2,1)/A(2,2)) * intervalle;

    plot(intervalle, isocline_1, "linewidth", 3, "linestyle", ":");
    plot(intervalle, isocline_2, "linewidth", 3, "linestyle", ":");
    legend("isocline_1","isocline_2","location","south");
endfunction

function vecteurs_vitesse(A, intervalle)
    hold on
    # On définit une grille de points dont les coordonnées sont dans (x1, x2)
    [x1,x2] = meshgrid(intervalle);
    
    # On calcule le vecteur vitesse pour chaque point de la grille
    x1_values = A(1,1)*x1 + A(1,2)*x2;
    x2_values = A(2,1)*x1 + A(2,2)*x2;  
    
    # On normalise des valeurs pour la représentation graphique
    norms=sqrt(x1_values.^2+x2_values.^2);
    x1_normalized = x1_values ./ norms; # Element-wise division
    x2_normalized = x2_values ./norms;

    # Et on dessine les vecteurs avec la fonction `quiver`
    vector_scale = .5;
    quiver(x1,x2,x1_normalized,x2_normalized, vector_scale);
endfunction
 
A = [3 2; 2 3]; #noeud instable 
#A = [2 3; 3 2]; #selle

line_range =-1.5:0.1:1.5; # On va plot de -1.5 jusqu'à 1.5

vecteurs_vitesse(A, line_range)
isoclines(A, line_range);
vecteurs_propres(A, line_range);

legend("portrait de phase","isocline_1","isocline_2", "v1", "v2")
hold off; # Montrer l'image

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

legend(
 "w(t) CI: [2,0]","e(t) CI: [2,0]",
 "w(t) CI: [0,3]","e(t) CI: [0,3]",
 "w(t) CI: [-2,3]","e(t) CI: [-2,3]",
 "w(t) CI: [2,-3]","e(t) CI: [2,-3]",
 "w(t) CI: [2,2]","e(t) CI: [2,2]",
 "location","northwest");
hold off;