% --- Gráfico da Solução Exata ---
[X, Y] = meshgrid(0:0.01:0.5); % Cria uma malha fina para um gráfico suave
U = 400 * X .* Y; % Calcula a solução em cada ponto

% --- Plotagem da Superfície 3D ---
figure;
surf(X, Y, U);
title('Solucao Exata u(x,y) = 400xy na Placa');
xlabel('Eixo x');
ylabel('Eixo y');
zlabel('u(x,y)');
colorbar; % Adiciona uma barra de cores