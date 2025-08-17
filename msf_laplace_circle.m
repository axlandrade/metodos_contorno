% -------------------------------------------------------------------
% Arquivo: msf_laplace_circle.m
% Descricao: Solucao da Equacao de Laplace no disco unitario
%            via Metodo das Solucoes Fundamentais (MSF).
% -------------------------------------------------------------------
clear; clc; close all;

%% --- Definicoes do Problema ---
N = 30; % Numero de pontos de contorno e de fontes
R_dominio = 1.0; % Raio do dominio (disco)
R_fonte = 2.0;   % Raio do circulo das fontes ficticias

% Solucao Fundamental 2D e Solucao Exata
G = @(p1, p2) -1/(2*pi) * log(norm(p1-p2));
u_exata = @(x,y) x.^2 - y.^2;

%% --- Geracao dos Pontos ---
theta = linspace(0, 2*pi, N+1)'; % N+1 para nao repetir o ultimo ponto
theta = theta(1:end-1); % Remove o ultimo ponto duplicado

% Pontos de Colocacao (na fronteira do dominio)
colloc_pts = R_dominio * [cos(theta), sin(theta)];

% Pontos Fonte (na fronteira ficticia)
source_pts = R_fonte * [cos(theta), sin(theta)];

%% --- Montagem do Sistema Linear A*c = b ---
A = zeros(N, N);
for i = 1:N
    for j = 1:N
        A(i,j) = G(colloc_pts(i,:), source_pts(j,:));
    end
end

% Vetor b com as condicoes de contorno
b = u_exata(colloc_pts(:,1), colloc_pts(:,2));

%% --- Resolucao e Analise de Erro ---
c = A \ b; % Coeficientes da combinacao linear

% Funcao para avaliar a solucao do MSF em qualquer ponto (x,y)
u_msf = @(x,y,sources,coeffs) ...
    arrayfun(@(px,py) sum(coeffs .* -log(sqrt((px-sources(:,1)).^2 + (py-sources(:,2)).^2)) / (2*pi)), x, y);

% Criar uma malha de pontos internos para testar o erro
[X, Y] = meshgrid(linspace(-R_dominio, R_dominio, 51));
R_test = sqrt(X.^2 + Y.^2);
interior_mask = R_test < 0.999; % Apenas pontos estritamente dentro do disco

X_int = X(interior_mask);
Y_int = Y(interior_mask);

% Avaliar solucoes e erro nos pontos internos
U_aprox_vals = u_msf(X_int, Y_int, source_pts, c);
U_exata_vals = u_exata(X_int, Y_int);
erro_abs = abs(U_aprox_vals - U_exata_vals);
rmse = sqrt(mean(erro_abs.^2));

fprintf('--- Analise de Erro do MSF ---\n');
fprintf('Numero de pontos (N): %d\n', N);
fprintf('Raio das fontes (Rs): %.1f\n', R_fonte);
fprintf('Erro Maximo Absoluto no interior: %e\n', max(erro_abs));
fprintf('Erro Quadratico Medio (RMSE) no interior: %e\n\n', rmse);

%% --- Plotagem dos Resultados ---
figure('Position', [100, 100, 1200, 500]);
% Plot da solucao aproximada
subplot(1, 2, 1);
U_plot = nan(size(X));
U_plot(interior_mask) = u_msf(X_int, Y_int, source_pts, c);
surf(X, Y, U_plot);
title('Solucao Aproximada (MSF)');
xlabel('x'); ylabel('y'); zlabel('u(x,y)');
axis equal; view(30, 30);

% Plot do erro absoluto
subplot(1, 2, 2);
Erro_plot = nan(size(X));
Erro_plot(interior_mask) = erro_abs;
surf(X, Y, Erro_plot);
title('Erro Absoluto |u_{exata} - u_{aprox}|');
xlabel('x'); ylabel('y'); zlabel('Erro');
axis equal; view(30, 30);