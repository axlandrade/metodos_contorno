# Relatório de Exercícios de Métodos Numéricos Computacionais

![Language](https://img.shields.io/badge/Language-Octave-blue.svg) ![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)

## Sobre o Projeto

Este repositório contém os códigos-fonte em Octave/MATLAB desenvolvidos como parte da avaliação da disciplina **IC-7215 - Métodos Numéricos Computacionais**, do Mestrado em Modelagem Matemática e Computacional da Universidade Federal Rural do Rio de Janeiro (UFRRJ).

O objetivo é fornecer implementações práticas e didáticas para uma variedade de métodos numéricos aplicados a Equações Diferenciais Ordinárias (EDOs) e Parciais (EDPs), servindo como um complemento computacional para o relatório técnico detalhado.

## Estrutura dos Arquivos

O repositório está organizado nos seguintes scripts, cada um correspondendo a um ou mais exercícios do relatório:

* `euler_pvi.m`: Soluciona um Problema de Valor Inicial para uma EDO de 1ª ordem via **Método de Euler**, compara com a solução exata e plota os resultados.
* `mdf_laplace.m`: Resolve a **Equação de Laplace** em um domínio quadrado utilizando o **Método das Diferenças Finitas (MDF)**. Demonstra um caso onde a solução numérica é exata.
* `fbr_weierstrass.m`: Interpola a função patológica de **Weierstrass** utilizando três tipos de **Funções de Base Radial (FBR)**, demonstrando as limitações de métodos suaves para funções não-diferenciáveis.
* `galerkin_systems.m`: Verifica computacionalmente as soluções dos sistemas lineares obtidos pela aplicação do **Método de Galerkin** em problemas de contorno 1D.
* `msf_laplace_circle.m`: Implementa o **Método das Soluções Fundamentais (MSF)** para resolver a Equação de Laplace em um domínio circular, calculando o erro da solução.

## Conceitos Abordados

-   **Equações Diferenciais Ordinárias:**
    -   Método de Euler
    -   Análise de Erro (Local e Global)
-   **Equações Diferenciais Parciais:**
    -   Método das Diferenças Finitas (MDF) para a Equação de Laplace
    -   Erro de Truncamento
-   **Métodos Sem Malha (Meshless):**
    -   Funções de Base Radial (FBR) para Interpolação (Gaussiana, Multiquádrica, etc.)
    -   Interpolação de funções patológicas (Weierstrass)
    -   Método das Soluções Fundamentais (MSF)
-   **Fundamentos do Método dos Elementos Finitos (MEF):**
    -   Formulação Fraca
    -   Método de Galerkin
    -   Ortogonalidade de Galerkin

## Como Executar

Todos os scripts foram desenvolvidos e testados em **GNU Octave** e são compatíveis com **MATLAB**. Cada arquivo `.m` é autocontido e pode ser executado de forma independente para reproduzir os resultados do exercício correspondente.

## Relatório Técnico Associado

Estes códigos são o complemento computacional de um relatório técnico detalhado que analisa cada exercício com profundidade matemática. Recomenda-se a leitura do relatório (`Exercicios_Metodos_dos_Elementos_de_Contorno - Axl_Andrade.pdf`) para o completo entendimento do contexto, das derivações teóricas e da análise dos resultados.

## Autor

* **Axl Silva de Andrade**

## Licença

Este projeto é licenciado sob a Licença MIT - veja o arquivo `LICENSE.md` para detalhes.
