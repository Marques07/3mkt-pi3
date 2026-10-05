# Aula 5.5: Validação de Sistemas de Recuperação de Informação (RI) com R

Este documento consolida os conceitos teóricos, as fórmulas matemáticas e a intuição prática para validação de sistemas de busca baseados em **BM25** e outras arquiteturas de recuperação de informação, desenvolvidos no contexto do *Projeto Integrador III*.

---

## 1. O Conceito de Vetor de Relevância (`rel`)
A avaliação de sistemas de busca parte da comparação entre a lista de documentos retornada pelo modelo e o gabarito oficial (relevância real dos documentos para uma dada consulta).
* **Vetor `rel`**: Um vetor binário ou graduado ordenado estritamente na **ordem do ranking do sistema**.
* **Exemplo de Ranking**: `d3, d1, d2, d4, d8, d6, d5, d7`
* **Gabarito Binário ($0/1$)**: Indica apenas se o documento recuperado é relevante ou não.
* **Gabarito Graduado**: Utiliza uma escala de graus de relevância (ex: de $0$ a $2$).

---

## 2. Precisão e Recall
* **Precisão ($\text{P}$)**: Mede a exatidão. Dos documentos retornados, quantos são realmente relevantes?
  $$\text{Precisão} = \frac{\text{Relevantes Recuperados}}{\text{Total Recuperados}}$$
  * *Nota*: Não exige o gabarito completo de todo o corpus, apenas a avaliação dos itens retornados.

* **Recall ($\text{R}$)**: Mede a abrangência. Dos documentos relevantes existentes em todo o acervo ($R$), quantos o sistema conseguiu encontrar?
  $$\text{Recall} = \frac{\text{Relevantes Recuperados}}{R \text{ (total no corpus)}}$$
  * *Nota*: **Exige o gabarito completo** de todo o corpus.

---

## 3. O Conceito de Corte em $k$ (`@k`)
Os motores de busca retornam listas ordenadas e dinâmicas, e não conjuntos fixos. O sufixo `@k` restringe a avaliação aos **$k$ primeiros resultados** apresentados ao usuário (ex: P@3, R@5).
* Exemplo: Mudar de $k=3$ para $k=2$ altera diretamente o denominador/numerador do cálculo de precisão imediata da janela.

---

## 4. O Comportamento Gráfico: Dente de Serra vs. Degraus
* **P@$k$ (Dente de Serra)**: Oscila a cada posição. Sobe quando o sistema acerta um relevante (o numerador cresce) e desce a cada erro (o denominador cresce sem incremento de acertos).
* **R@$k$ (Degraus)**: Monotonicamente crescente. Apenas sobe ou se estabiliza, travando em $1{,}0$ (ou no teto máximo alcançável) quando o último documento relevante do acervo é recuperado.

---

## 5. Average Precision (AP) e MAP
Dois rankings podem ter a mesma P@$k$, mas posições mais precoces de acerto devem ser premiadas. O **Average Precision** calcula a média das precisões calculadas estritamente nos pontos onde há documentos relevantes, **embutindo o recall** ao penalizar itens relevantes não encontrados (que entram valendo zero):

$$\text{AP} = \frac{1}{R}\sum_{k\,:\,rel_k = 1} \text{P@}k$$

* **MAP (Mean Average Precision)**: É a média do AP calculada sobre um conjunto de múltiplas consultas ($Q$).

---

## 6. MRR (Mean Reciprocal Rank)
* **Reciprocal Rank (RR)**: O inverso da posição em que aparece o **primeiro** documento relevante:
  $$\text{RR} = \frac{1}{\text{posição do primeiro relevante}}$$
* **MRR**: A média do RR sobre todas as consultas. É a métrica padrão para cenários onde **uma única resposta correta encerra a busca** (como em *Question Answering* e pipelines de RAG).

---

## 7. nDCG (Normalized Discounted Cumulative Gain)
Quando o gabarito possui múltiplos graus de relevância, o nDCG penaliza documentos relevantes que aparecem tarde no ranking utilizando um fator de desconto logarítmico.

* **DCG@$k$**:
  $$\text{DCG@}k = \sum_{i=1}^{k} \frac{rel_i}{\log_2(i+1)}$$
  *(O $+1$ no denominador evita divisão por zero na primeira posição, e o logaritmo suaviza o decaimento para que a cauda da lista ainda contribua).*

* **nDCG@$k$**:
  $$\text{nDCG@}k = \frac{\text{DCG@}k}{\text{IDCG@}k}$$
  Onde o **IDCG** (*Ideal DCG*) representa o ganho máximo possível se os melhores documentos estivessem ordenados perfeitamente no topo.

---

## 8. Guia de Escolha de Métricas
* **P@$k$**: Foco na experiência imediata do usuário nas primeiras posições.
* **MAP**: Visão global e rigorosa para rankings binários e comparação de modelos.
* **nDCG**: Essencial para buscas com relevância graduada (e-commerce, busca web).
* **MRR**: Ideal para busca de resposta única (*QA* / RAG).

---

## 9. Armadilhas Críticas na Validação
1. **Avaliar com uma única consulta**: Gera uma visão altamente viesada; validações exigem dezenas ou centenas de consultas representativas.
2. **Corpus excessivamente pequeno**: Com poucos documentos, todas as métricas tendem a inflar (próximas de $1{,}0$), perdendo o poder de discriminação entre algoritmos.
3. **Ignorar a significância estatística**: Diferenças numéricas mínimas (ex: MAP de $0{,}84$ vs $0{,}83$) podem ser apenas ruído estatístico e exigem testes de hipóteses adequados (como o teste t de Student ou Wilcoxon).