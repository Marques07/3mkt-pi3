# 🌊 Motor de Busca: Baixada Santista

**Projeto Integrador III — Tecnologia em Ciência de Dados**

Um sistema de Recuperação de Informação desenhado para processar necessidades de informação sobre a geografia, turismo e infraestrutura da região metropolitana da Baixada Santista. 

## 🎯 Objetivos do Projeto
Em vez de se basear em consultas literais, o motor foca-se em responder a cenários práticos. Foi testado para resolver as seguintes questões:
* **Residencial:** Avaliar se o Gonzaga é um lugar calmo para se viver.
* **Ambiental:** Entender se Cubatão ainda sofre com poluição industrial ou se o cenário de facto melhorou.
* **Cultural:** Identificar os monumentos mais importantes relacionados com a fundação de São Vicente.

## 🗂️ Construção do Corpus
Os textos foram obtidos através da API do MediaWiki, extraindo dados da Wikipédia em português.
* **Dimensão:** O corpus final possui 194 documentos (parágrafos narrativos) provenientes de 12 páginas distintas.
* **Recolha e Filtragem:** A extração foi feita em R, incluindo a remoção de cabeçalhos e a divisão do texto por quebras de linha. Foi aplicado um filtro para manter apenas parágrafos com pelo menos 40 caracteres.
* **Tratamento de Ruído:** Após a limpeza manual, 30 linhas foram excluídas para eliminar duplicados e tabelas soltas.
* **Vocabulário:** A normalização removeu pontuação, acentuação e palavras funcionais, reduzindo o vocabulário de 4.371 termos brutos para cerca de 3.360 termos limpos e representativos do domínio.

## ⚙️ Tecnologias e Algoritmos
O guião principal do motor de busca efetua a ordenação dos documentos utilizando:
* **Busca Vetorial:** Operações baseadas em cálculo TF-IDF e similaridade de cosseno.
* **Algoritmo BM25:** Implementação do modelo probabilístico para ranqueamento.

## 🚀 Como Executar
O sistema foi desenvolvido utilizando apenas as funções base da linguagem R, não exigindo a instalação de quaisquer pacotes externos para a execução das buscas.
1. Clone este repositório.
2. Certifique-se de que o ficheiro `corpus.csv` e o script `busca_ri.R` se encontram na mesma diretoria.
