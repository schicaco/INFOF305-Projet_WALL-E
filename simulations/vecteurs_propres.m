hold on;
function vecteurs_propres(A, intervalle)
    # Chaque vecteur propre se trouve dans une ligne de la matrice V.
    [V,L] = eig(A);
    eigenvector_1 = (V(1,2)/V(1,1)) * intervalle;
    eigenvector_2 = (V(2,2)/V(2,1)) * intervalle;
    plot(intervalle, eigenvector_1,"linewidth",10);
    plot(intervalle, eigenvector_2,"linewidth",10);
    if L(1, 1) > 0
        quiver(0, 0, V(1, 1), V(1, 2), "color", "k", "linewidth", 5);
    else
        quiver(V(1, 1), V(1, 2), -V(1, 1), -V(1, 2), "color", "k", "linewidth", 5);
    end
    if L(2, 2) > 0
        quiver(0, 0, V(2, 1), V(2, 2), "color", "k", "linewidth", 5);
    else
        quiver(V(2, 1), V(2, 2), -V(2, 1), -V(2, 2), "color", "k", "linewidth", 5);
    end
    legend("v_1","v_2","location","south");
endfunction

A = [2, 0;3, 0];
line_range = -1.5:1.5; # On va plot de -1.5 jusqu'à 1.5
vecteurs_propres(A, line_range);

hold off; # Montrer l'image