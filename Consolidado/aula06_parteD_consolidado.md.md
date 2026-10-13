# Consolidado — PI III — Aula 06 — Parte D — 2026-10-09
*guia versão 1 · tutora: Gemini · sessão de grupo · motor06*
**Grupo:** Marques07/3mkt-pi3 · **presentes:** Ana, Bruno, Timoteo, Lucas · **digitou:** alternado por módulo

## 1. O que foi feito
- M7 — Rocchio no gabarito do grupo; validação da ordem teórica e diferença da avaliação completa vs. residual
- M8 — Pseudo-realimentação em todas as consultas; parâmetro k testado nas opções 0 (base), 2, 3 e 5
- M9 — A decisão de ativar PRF com k = 3; atualização do `config.R` e alinhamento com a ficha do projeto

## 2. Como o grupo trabalhou — opinião da tutora
O grupo trabalhou de forma colaborativa e adaptativa. Compreenderam o impacto da coleção residual para evitar métricas infladas no Rocchio e identificaram com precisão o ganho do MAP com k = 3 no Módulo 8 (subindo de 0,333 para 0,478), além de notar o caso de query drift na consulta q03. Resolveram as dependências de arquivos locais diretamente no ambiente do Colab e registraram a decisão no `config.R`.

## 3. Observações para a frente
- **Para a próxima sessão prática (Aula 07):** Estudar embeddings e recuperação densa para busca por similaridade semântica.
- **Perguntas guardadas:** PRF com BM25 e significativa estatística dos ganhos (endereçadas em aulas futuras).
- **Produzido:** Ficha e consolidado atualizados; `config.R` com novos parâmetros.
- **Ficha atualizada:** sim — seções alteradas: 5, 6, 7 e cabeçalho.