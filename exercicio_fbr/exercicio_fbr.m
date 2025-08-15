% --- Parametros do Problema ---
a = 0.5;
b = 13;
N_pontos = 41;
epsilon = 2.0; % Parametro de forma

% --- Funcao de Weierstrass (soma finita) ---
function y = weierstrass(x, a, b)
    y = zeros(size(x));
    for n = 0:100 % Soma ate n=100 eh suficiente para convergencia
        y = y + a^n * cos(b^n * pi * x);
    end
end

% --- Geracao dos pontos de interpolacao ---
x_dados = linspace(-1, 1, N_pontos)';
y_dados = weierstrass(x_dados, a, b);

% --- Pontos para plotagem do resultado (malha fina) ---
x_plot = linspace(-1, 1, 1000)';
y_verdadeiro = weierstrass(x_plot, a, b);

% --- Definicao das FBRs ---
rbf_ga = @(r, ep) exp(-(ep*r).^2);
rbf_mq = @(r, ep) sqrt(1 + (ep*r).^2);
rbf_iq = @(r, ep) 1 ./ (1 + (ep*r).^2);

fbrs = {rbf_ga, rbf_mq, rbf_iq};
nomes_fbrs = {'Gaussiana', 'Multiquadrica', 'Inversa Quadratica'};
estilos = {'g-', 'm--', 'c-.'}; % Estilos de linha para o plot
y_interpolado = zeros(length(x_plot), length(fbrs));

% --- Loop para calcular a interpolacao para cada FBR ---
for k = 1:length(fbrs)
    rbf = fbrs{k};

    % 1. Montar a matriz de interpolacao A
    dist_matrix = abs(x_dados - x_dados');
    A = rbf(dist_matrix, epsilon);

    % 2. Resolver o sistema A*lambda = y
    lambda = A \ y_dados;

    % 3. Avaliar o interpolante s(x) na malha fina
    dist_plot = abs(x_plot - x_dados');
    phi_plot = rbf(dist_plot, epsilon);
    y_interpolado(:, k) = phi_plot * lambda;

    fprintf('Condicionamento da matriz A para FBR %s: %e\n', nomes_fbrs{k}, cond(A));
end

% --- Plotagem dos Resultados ---
figure('Position', [100, 100, 1000, 700]);
hold on;
% Plot da funcao verdadeira
plot(x_plot, y_verdadeiro, 'k-', 'LineWidth', 2, 'DisplayName', 'Weierstrass (Verdadeira)');
% Plot dos pontos de interpolacao
plot(x_dados, y_dados, 'ro', 'MarkerFaceColor', 'r', 'DisplayName', 'Pontos de Interpolacao');

% Plot de cada interpolante FBR
for k = 1:length(fbrs)
    plot(x_plot, y_interpolado(:,k), estilos{k}, 'LineWidth', 1.5, 'DisplayName', nomes_fbrs{k});
end

hold off;
title(['Interpolacao da Funcao de Weierstrass (N=', num2str(N_pontos), ', \epsilon=', num2str(epsilon), ')']);
xlabel('x');
ylabel('W(x)');
legend('show', 'Location', 'southoutside', 'Orientation', 'horizontal');
grid on;
ylim([-2, 2]);
