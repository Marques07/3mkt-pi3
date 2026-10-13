# Consolidado — PI III — Aula 06 — 2026-10-09
*guia versão 1 · tutora: Gemini · sessão individual (teoria) · motor06*
**Aluno:** Timoteo Blank

## 1. O que foi passado
- M1 — o ciclo de realimentação; $D_r$ e $D_{nr}$ no ranking do cosseno
- M2 — a consulta como vetor; centroide; `rowMeans`, `drop = FALSE`
- M3 — a fórmula de Rocchio; `modelo` = 2,426 à mão; expansão: 3 → 21 termos
- M4 — o novo ranking; cosseno negativo; AP $0{,}5 \to 1$
- M5 — coleção residual: `NA` com limiar 2, empate com limiar 1
- M6 — pseudo-realimentação; $k = 2$ (AP $0{,}833$) × $k = 3$ (AP $0{,}750$): drift

## 2. Como foi o aprendizado — opinião da tutora
O aluno demonstrou excelente acompanhamento prático e conceitual ao longo dos 6 módulos. Compreendeu de forma rápida e precisa a movimentação da consulta no espaço vetorial via centroide, realizando os cálculos manuais de Rocchio sem dificuldades. Captou adequadamente o motivo dos cossenos negativos gerados pelos pesos de feedback negativo ($-\gamma$) e identificou com clareza o problema do query drift na pseudo-realimentação quando o parâmetro $k$ inclui documentos não relevantes.

**Teste final:** acertou os Módulos M1, M2, M3, M4, M5 e M6.

## 3. Observações para a frente
- **Revisar antes da Aula 07:** O conceito da coleção residual e a transição da busca por termos exatos para busca vetorial/densa.
- **Para a próxima tutora:** Aluno com ótimo raciocínio lógico, responde de forma objetiva, boa assimilação de Álgebra Linear aplicada a RI e boa familiaridade com o ambiente R no Colab.
- **Produzido:** `rocchio`, `ranking_vetor`; ranking Rocchio `d3 d2 d1 d6 d8 d5 d7 d4`; residual: empate; PRF $k = 2$ e $k = 3$.
- **Parte D (sessão de grupo):** a marcar — com a ficha do projeto.