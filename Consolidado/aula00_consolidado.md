# Consolidado — PI III — Aula 00 — 2026-10-16
*guia versão 3 · tutora: DeepSeek · sessão individual (teoria) · sem motor*
**Aluno:** <nome>

## 1. O que foi passado
- M1 — Colab em R, `<-`, o corpus `docs` como vetor de 8; `[1]`; R começa em 1; vetorização
- M2 — nomes; `[ ]` preserva o nome, `[[ ]]` não; `==`
- M3 — `nchar` versus `length`; `toupper`/`tolower`; `substr`; `paste`/`paste0`/`collapse`
- M4 — `strsplit` (lista), `unlist`
- M5 — funções; a última expressão é devolvida; escreveu `tokenizar` e `maiuscula`
- M6 — `lapply` (lista) e `sapply` (simplifica); `sum`, `list`; `tokens`
- M7 — `table`; `factor(levels = …)` fixa categorias e zeros; `sort`; `%in%`, `!` e o filtro
- M8 — matriz por coluna; reciclagem em `m * peso`
- M9 — regex I: `grep`/`grepl`, `^ $ | [ ] +`; pedaço não é palavra (`grep("de", docs)`)
- M10 — regex II: `sub`/`gsub`, `. * {n} {n,} [^ ]`, `trimws`, o pipeline de limpeza; `tokenizar` com `\\s+`
- M11 — o mapa da Aula 01
- Todos os 11 módulos alcançados.

## 2. Como foi o aprendizado — opinião da tutora
Aluno de Python que nunca tinha usado R; o Colab já estava em R (`[1] 2` de primeira).
Trouxe o Python como muleta na hora certa: explicou o list comprehension (que virou
`lapply` no M6) e acertou quase todas as previsões — o `[0]` foi a única armadilha, e
ele mesmo viu que "não vem nada". Previsões certas: cerca de 30 de 34 ao longo da aula.

Onde travou de leve:
- **Precisão de vocabulário:** "devolve nada" em vez de "vetor vazio `named character(0)`"
  (M1); "retorna normal" em vez de "a última expressão" (M5); a descrição da reciclagem
  em M8 saiu confusa, mas o mecanismo estava certo; inverteu o `^` de `[^a-z ]` no M10.
- **Nada de conceito:** entendeu `strsplit`/`unlist`, `factor(levels=)`, reciclagem e a
  lição "pedaço não é palavra" sem tropeço.
- **Escreveu sozinho:** `maiuscula` (M5) — só dois deslizes de digitação.
- **Explorou por conta própria?** Sim, fez todos os "explore" pedidos; não fez além.

**Teste final:** acertou M1–M11. A revisar com precisão: M1 (nome do vetor vazio),
M5 (o que é devolvido), M8 (formulação da reciclagem), M10 (`^` dentro de `[ ]`).

## 3. Observações para a frente
- **Revisar antes da Aula 01:** o significado de `[^…]` (negação) versus `^` (início) — é o
  erro mais provável de reaparecer; e a formulação "um peso por linha" da reciclagem.
- **Para a próxima tutora:** ritmo bom; confortável com R; pensa em Python, mas não trava
  nisso; gostou de regex (explorou os `grep` sem reclamar).
- **Perguntas guardadas:** "o que é idf" / "o que é matriz termo-documento" — Aula 01;
  "e os acentos?" — Aula 03.
- **Produzido:** `docs` digitado; `tokenizar` (versão `\\s+`) e `maiuscula` escritas por ele;
  previsões certas: ~30 de ~34.
- **Parte D (frases próprias + Colab e GitHub):** não iniciada — fazer antes da Aula 01.

---

<!-- estado-R:inicio -->
## Estado do R ao fim da sessão
*gerado por `anexar_estado()` em 2026-10-16 14:58 · R version 4.6.1 (2026-06-24) · sem motor · não edite à mão*

### Objetos

| objeto | tipo | tamanho | valor / amostra |
|---|---|---|---|
| `docs` | character, nomeado | 8 | d1 recuperacao de informacao o..., d2 o modelo de espaco vetorial..., d3 bm25 e um modelo probabilis..., d4 aprendizado estatistico fun..., d5 o indice invertido acelera ..., d6 embeddings capturam a seman..., ... |
| `f` | character, nomeado | 3 | f1   gosto DE ciencia de dados! , f2 Odeio   estatistica e dados..., f3 vote em   lucas marques par... |
| `frase` | character | 1 | recuperacao de informacao |
| `freq` | table, nomeado | 12 | ciencia 1, dados 3, de 2, e 1, em 1, estatistica 1, ... |
| `m` | matrix | 2 × 2 | linhas: de, modelo \| colunas: d1, d2 |
| `peso` | numeric | 2 | 1, 10 |
| `sujo` | character | 1 |   O Modelo   de Espaco   Ve... |
| `ticoteco` | character | 3 | recuperacao, de, informacao |
| `tokens$f1` | character | 5 | gosto, de, ciencia, de, dados |
| `tokens$f2` | character | 4 | odeio, estatistica, e, dados |
| `tokens$f3` | character | 6 | vote, em, lucas, marques, para, dados |
| `vocab` | character | 3 | de, modelo, busca |
| `x` | character, nomeado | 3 | f1 gosto de ciencia de dados, f2 odeio estatistica e dados , f3 vote em lucas marques para ... |

### Funções definidas

`anexar_estado`, `estado`, `maiscula`, `tokenizar`
<!-- estado-R:fim -->

