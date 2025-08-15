% --- Definicoes ---
f = @(t, y) y - t.^2 + 1; % Funcao da EDO
y_exata = @(t) (t+1).^2 - 0.5*exp(t); % Solucao exata

t_inicio = 0;
t_fim = 2;
h = 0.2;
y0 = 0.5;

% --- Metodo de Euler ---
t_euler = t_inicio:h:t_fim;
w_euler = zeros(size(t_euler));
w_euler(1) = y0;
for i = 1:length(t_euler)-1
    w_euler(i+1) = w_euler(i) + h * f(t_euler(i), w_euler(i));
end

% --- Calculo da solucao exata e do erro ---
t_plot = linspace(t_inicio, t_fim, 200); % Pontos para um grafico suave
y_plot = y_exata(t_plot);
y_nos_pontos_euler = y_exata(t_euler);
erro_abs = abs(y_nos_pontos_euler - w_euler);


% --- NOVO: Impressao da Tabela de Resultados ---
fprintf('\n'); % Pula uma linha para limpar a visualizacao
fprintf('===================================================================\n');
fprintf('                Tabela Comparativa de Resultados\n');
fprintf('===================================================================\n');
fprintf('  t_i   |   w_i (Aproximado)  |   y_i (Exato)   |   Erro Absoluto\n');
fprintf('-------------------------------------------------------------------\n');

% Loop para imprimir cada linha da tabela
for i = 1:length(t_euler)
    fprintf('  %.1f   |      %.4f       |     %.4f      |      %.4f\n', ...
            t_euler(i), w_euler(i), y_nos_pontos_euler(i), erro_abs(i));
end
fprintf('===================================================================\n\n');


% --- Plotagem ---
figure;

% Grafico 1: Solucoes
subplot(2, 1, 1);
plot(t_plot, y_plot, 'b-', 'LineWidth', 2); % Exata (linha azul)
hold on;
plot(t_euler, w_euler, 'r--o'); % Euler (tracejado vermelho com pontos)
title('Solucao Exata vs. Solucao Aproximada (Euler)');
xlabel('t');
ylabel('y(t)');
legend('Exata', 'Euler (h=0.2)');
grid on;

% Grafico 2: Erro Absoluto
subplot(2, 1, 2);
plot(t_euler, erro_abs, 'k-s'); % Erro (preto com quadrados)
title('Erro Absoluto |y_i - w_i|');
xlabel('t');
ylabel('Erro');
grid on;
