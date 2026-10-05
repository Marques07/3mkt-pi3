====================================================================
DOCUMENTAÇÃO DO PROJETO DOS 3Mkt
====================================================================

SOBRE O PROJETO

Este projeto foi desenvolvido para fins acadêmicos na disciplina de
Projeto Integrador III.

O objetivo principal é entender na prática como textos brutos são
tratados, normalizados e transformados em dados estruturados que um
computador consegue analisar, e como avaliar a qualidade dos
resultados que um motor de busca devolve sobre esse corpus.

Para isso, construímos uma base de dados (corpus) composta por 194
parágrafos descritivos extraídos de artigos da Wikipédia sobre
bairros e municípios da Baixada Santista, como Gonzaga e Boqueirão
(Santos), Praia do Tombo e Praia das Astúrias (Guarujá), Cubatão,
São Vicente e Praia Grande. Cada parágrafo é tratado como um
documento, identificado de forma estável por um id do tipo
"bairro-pN" (ex.: gonzaga-santos-p1).

A partir dessa base, aplicamos etapas de limpeza textual,
normalização, tokenização, extração de vocabulário e construção da
matriz termo-documento. Sobre essa matriz, implementamos os modelos
de recuperação vistos em aula (busca booleana, TF-IDF com cosseno e
BM25) e, por fim, construímos um gabarito de relevância para avaliar
esses modelos com as métricas de ranking (P@k, AP, MAP, MRR, nDCG).


ORGANIZAÇÃO E ESTRUTURA DE PASTAS

O projeto está estruturado em três pastas organizacionais:

1. Estrutura/
   Contém os notebooks interativos desenvolvidos no ambiente R (.ipynb)

2. Consolidado/
   Guarda os arquivos exportados em formato Markdown (.md) a partir dos
   notebooks das aulas, servindo para leitura rápida e documentação:

3. To delete/
   Pasta reservada para arquivos temporários, testes e rascunhos de
   descarte.


