% -------------------------------------------------------------------
% Arquivo: mdf_laplace.m
% Descricao: Solucao da Equacao de Laplace em uma placa quadrada
%            via Metodo das Diferencas Finitas (MDF).
% -------------------------------------------------------------------
clear; clc; close all;

%% --- Definicoes do Problema ---
L = 0.5; % Dimensao da placa (0 a L)
h = 0.125; % Passo da malha
N_int = (L/h) - 1; % Numero de pontos internos em uma direcao (3)
N_vars = N_int^2; % Numero total de incognitas (9)

% Solucao exata e condicoes de contorno
u_exata = @(x,y) 400 * x .* y;

%% --- Montagem do Sistema Linear A*w = b ---
A = zeros(N_vars, N_vars);
b = zeros(N_vars, 1);
x_grid = linspace(0, L, N_int+2);
y_grid = linspace(0, L, N_int+2);

% Mapeamento de (i,j) 2D para k 1D
map = @(i,j) (j-1)*N_int + i;

for j = 1:N_int % Loop em y
    for i = 1:N_int % Loop em x
        k = map(i,j);
        
        % Diagonal principal (4*w_ij)
        A(k,k) = 4;
        
        % Vizinho da direita (w_{i+1,j})
        if i < N_int
            A(k, map(i+1,j)) = -1;
        else % Fronteira Direita (x=L)
            b(k) = b(k) + u_exata(x_grid(i+2), y_grid(j+1));
        end
        
        % Vizinho da esquerda (w_{i-1,j})
        if i > 1
            A(k, map(i-1,j)) = -1;
        else % Fronteira Esquerda (x=0)
            b(k) = b(k) + u_exata(x_grid(1), y_grid(j+1));
        end
        
        % Vizinho de cima (w_{i,j+1})
        if j < N_int
            A(k, map(i,j+1)) = -1;
        else % Fronteira Superior (y=L)
            b(k) = b(k) + u_exata(x_grid(i+1), y_grid(j+2));
        end

        % Vizinho de baixo (w_{i,j-1})
        if j > 1
            A(k, map(i,j-1)) = -1;
        else % Fronteira Inferior (y=0)
            b(k) = b(k) + u_exata(x_grid(i+1), y_grid(1));
        end
    end
end

%% --- Resolucao e Analise ---
w_vec = A \ b;
W_aprox = reshape(w_vec, N_int, N_int)'; % Remodelar para matriz 2D

% Calcular solucao exata nos mesmos pontos para comparacao
W_exata = zeros(N_int, N_int);
for j=1:N_int
    for i=1:N_int
        W_exata(j,i) = u_exata(x_grid(i+1), y_grid(j+1));
    end
end
erro = abs(W_exata - W_aprox);

%% --- Exibicao dos Resultados ---
disp('Solucao Numerica (W_aprox):');
disp(W_aprox);
disp('Solucao Exata (W_exata):');
disp(W_exata);
disp('Erro Absoluto (deve ser proximo de zero):');
disp(erro);
fprintf('\nErro maximo encontrado: %e\n', max(erro(:)));

%% --- Plotagem da Superficie ---
figure;
[X, Y] = meshgrid(x_grid, y_grid);
U_surf = u_exata(X, Y); % A solucao eh exata em todo lugar
U_surf(2:end-1, 2:end-1) = W_aprox; % Preenche o interior com a solucao numerica
surf(X, Y, U_surf);
title('Superficie da Solucao Numerica (MDF)');
xlabel('x'); ylabel('y'); zlabel('u(x,y)');