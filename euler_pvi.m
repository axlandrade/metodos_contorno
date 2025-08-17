% -------------------------------------------------------------------
% Arquivo: euler_pvi.m
% Descricao: Solucao do PVI y' = y - t^2 + 1 via Metodo de Euler.
% -------------------------------------------------------------------
clear; clc; close all;

%% --- Definicoes do Problema ---
f = @(t, y) y - t.^2 + 1; % Funcao da EDO
y_exata = @(t) (t+1).^2 - 0.5*exp(t); % Solucao exata
t_inicio = 0;
t_fim = 2;
h = 0.2;
y0 = 0.5;

%% --- Implementacao do Metodo de Euler ---
t_euler = t_inicio:h:t_fim;
w_euler = zeros(size(t_euler));
w_euler(1) = y0;
for i = 1:length(t_euler)-1
    w_euler(i+1) = w_euler(i) + h * f(t_euler(i), w_euler(i));
end

%% --- Analise de Resultados ---
y_nos_pontos_euler = y_exata(t_euler);
erro_abs = abs(y_nos_pontos_euler - w_euler);

% Impressao da Tabela de Resultados para o console
fprintf('===================================================================\n');
fprintf('                Tabela Comparativa de Resultados (Euler)\n');
fprintf('===================================================================\n');
fprintf('  t_i   |   w_i (Aproximado)  |   y_i (Exato)   |   Erro Absoluto\n');
fprintf('-------------------------------------------------------------------\n');
for i = 1:length(t_euler)
    fprintf('  %.1f   |      %.4f       |     %.4f      |      %.4f\n', ...
            t_euler(i), w_euler(i), y_nos_pontos_euler(i), erro_abs(i));
end
fprintf('===================================================================\n\n');

%% --- Plotagem Grafica ---
figure('Position', [100, 100, 800, 600]);
% Grafico 1: Solucoes
subplot(2, 1, 1);
t_plot = linspace(t_inicio, t_fim, 200);
plot(t_plot, y_exata(t_plot), 'b-', 'LineWidth', 2, 'DisplayName', 'Exata');
hold on;
plot(t_euler, w_euler, 'r--o', 'DisplayName', 'Euler (h=0.2)');
title('Solucao Exata vs. Solucao Aproximada (Euler)');
xlabel('t');
ylabel('y(t)');
legend show; grid on;

% Grafico 2: Erro Absoluto
subplot(2, 1, 2);
plot(t_euler, erro_abs, 'k-s', 'DisplayName', 'Erro Absoluto');
title('Erro Absoluto |y_i - w_i|');
xlabel('t');
ylabel('Erro');
legend show; grid on;