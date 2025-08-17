% -------------------------------------------------------------------
% Arquivo: galerkin_systems.m
% Descricao: Solucao computacional dos sistemas lineares do
%            Metodo de Galerkin.
% -------------------------------------------------------------------
clear; clc;

%% --- Exercicio 2: Aproximacao Quadratica ---
fprintf('--- Exercicio 2: Aproximacao Quadratica ---\n');
% Sistema linear A*alpha = b para encontrar [alpha1; alpha2]
% Equacao 1: 2*a1 - 4*a2 = 4
% Equacao 2: -4*a1 + (32/3)*a2 = -8
A_ex2 = [2, -4; -4, 32/3];
b_ex2 = [4; -8];
alpha_ex2 = A_ex2 \ b_ex2;

fprintf('Coeficientes encontrados:\n');
fprintf('alpha_1 = %f\n', alpha_ex2(1));
fprintf('alpha_2 = %f (como esperado, e zero)\n', alpha_ex2(2));
u_str = sprintf('1 + %.1f*(x-3) + %.1f*(x-3)^2', alpha_ex2(1), alpha_ex2(2));
fprintf('Solucao: u(x) = %s = 2x - 5\n\n', u_str);

%% --- Exercicio 3: Problema Nao-Homogeneo ---
fprintf('--- Exercicio 3: Problema Nao-Homogeneo ---\n');
% Equacao: integral(w''*u')dx = 2*w(0) - integral(2*w)dx
% u(x) = a1*(x-1) -> u' = a1
% w(x) = x-1     -> w' = 1

% Lado Esquerdo da equacao (LHS): integral(1*a1)dx de 0 a 1 = a1
% Lado Direito da equacao (RHS): 2*w(0) - integral(2*w)dx
w = @(x) x-1;
integral_2w = integral(@(x) 2*w(x), 0, 1);
rhs = 2*w(0) - integral_2w;
alpha1_ex3 = rhs; % Como o coeficiente do LHS e 1

fprintf('Calculo do lado direito (RHS):\n');
fprintf('2*w(0) = 2*(%d) = %d\n', w(0), 2*w(0));
fprintf('integral(2w)dx de 0 a 1 = %f\n', integral_2w);
fprintf('RHS = %d - (%f) = %f\n', 2*w(0), integral_2w, rhs);
fprintf('Coeficiente encontrado: alpha_1 = %f\n', alpha1_ex3);
fprintf('Solucao: u(x) = %.1f*(x-1) = %.1f - %.1fx\n\n', ...
        alpha1_ex3, -alpha1_ex3, alpha1_ex3);