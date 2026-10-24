# Ficha do Projeto — PI III — Motor de Busca
*última atualização: Aula 07 Parte D, 2026-10-23, motor07*

## 1. Repositório e Grupo
- Repositório: https://github.com/Marques07/3mkt-pi3
- Integrantes: Ana, Bruno, Timoteo Blank, Lucas Marques

## 2. Tema e Corpus
- Tema: Bairros e atrativos de Santos
- Corpus congelado: `corpus.csv`

## 3. Necessidades de Busca e Consultas
- Arquivo: `necessidades.csv` (consultas dev e teste)

## 4. Avaliação e Gabarito
- Juízes e Limiar: limiar = 2
- Gabarito: arquivos `qrels_*.csv`

## 5. Arquitetura do Motor e Linha do Tempo
- Realimentação (Rocchio, pseudo-realimentação) | 06 | `estrutura/codigo/aula06.ipynb` | testado, ativado
- LSA e busca híbrida | 07 | `estrutura/codigo/aula07.ipynb` | testado, ativado
- Decisões para o R: `limiar = 2`, `prf_k = 3`, `rocchio = c(a = 1, b = 0.75, g = 0.15)`, `modelo = "hibrido"`, `lsa_k = 20`, `rrf_c = 60`

## 6. Registro de Experimentos e Decisões
- Aula 06: pseudo-realimentação usar com $k = 3$, porque obteve o maior ganho no MAP dev (0,333 → 0,478), com ressalva de drift em q03 · `cfg$prf_k = 3`, `cfg$rocchio = c(a = 1, b = 0.75, g = 0.15)`
- Aula 06: resultado — Rocchio na consulta q01: validação teórica e residual executadas com sucesso.
- Aula 07: modelo do motor = híbrido (BM25 + LSA, fusão RRF com $c = 60$), $k = 20$, porque obteve MAP dev 0,800 (contra 0,531 do LSA puro e 0,875 do BM25) e confirmou no teste com MAP 0,800 (contra 0,670 do BM25) · `cfg$modelo = "hibrido"`, `cfg$lsa_k = 20`, `cfg$rrf_c = 60`

## 7. Histórico de Sessões
- Aula 06 Parte D (2026-10-09): Presentes: Grupo; Digitação alternada entre módulos. Realizada a análise de Rocchio no gabarito e otimização do parâmetro k para PRF.
- Aula 07 Parte D (2026-10-23): Presentes: Ana, Bruno, Timoteo Blank, Lucas Marques; Digitação alternada entre os Módulos 7, 8 e 9. LSA e busca híbrida implementados e testados no corpus do grupo; modelo híbrido ($k = 20$, $c = 60$) escolhido e registrado no `config.R`. Pendência: avaliar combinação de PRF com LSA/Híbrido nas próximas etapas.

---

<!-- estado-R:inicio -->
## Estado do R ao fim da sessão
*gerado por `anexar_estado()` em 2026-10-23 22:05 · R version 4.6.1 (2026-06-24) · motor07 v1 2026-10-15 · não edite à mão*

### Objetos

| objeto | tipo | tamanho | valor / amostra |
|---|---|---|---|
| `a` | character | 1 | qrels.csv |
| `arqs` | character | 1 | qrels.csv |
| `arvore` | data.frame | 17 × 6 | colunas: path, mode, type, sha, size, url |
| `cfg$minimo` | numeric | 1 | 40 |
| `cfg$limpar` | logical | 1 | TRUE |
| `cfg$acentos` | character | 1 | translit |
| `cfg$stopwords` | character | 19 | da, do, de, o, a, os, ... |
| `cfg$k1` | numeric | 1 | 1.2 |
| `cfg$b` | numeric | 1 | 0.75 |
| `cfg$limiar` | numeric | 1 | 2 |
| `cfg$prf_k` | numeric | 1 | 0 |
| `cfg$rocchio` | numeric, nomeado | 3 | a 1, b 0.75, g 0.15 |
| `cfg$modelo` | character | 1 | hibrido |
| `cfg$lsa_k` | numeric | 1 | 20 |
| `cfg$rrf_c` | numeric | 1 | 60 |
| `cfg$grupo` | character | 1 | 3Mkt |
| `consultas` | character, nomeado | 5 | q01 lugar calmo no gonzaga, q02 cubatao recuperacao ambient..., q03 monumentos historicos funda..., q04 praia do tombo surf ondas i..., q05 ciclovias orla praia grande... |
| `cp` | data.frame | 194 × 3 | colunas: id, titulo, texto |
| `dev` | character | 2 | q01, q02 |
| `docs` | character, nomeado | 194 | gonzaga-santos-p1 O Gonzaga é um bairro nobre..., gonzaga-santos-p2 O bairro do Gonzaga, fica d..., gonzaga-santos-p3 Surgido em 1889, o bairro d..., gonzaga-santos-p4 Uma importante referência a..., gonzaga-santos-p5 Inaugurado em 29 de novembr..., gonzaga-santos-p6 Nos anos 80 foi construido ..., ... |
| `escolha` | character | 1 | hibrido |
| `g` | numeric, nomeado | 10 | gonzaga-santos-p3 1, jose-menino-p4 0, gonzaga-santos-p5 1, gonzaga-santos-p1 2, gonzaga-santos-p6 1, guaruja-p7 0, ... |
| `ix$tokens` | list | 194 | elementos: gonzaga-santos-p1, gonzaga-santos-p2, gonzaga-santos-p3, gonzaga-santos-p4, gonzaga-santos-p5, gonzaga-santos-p6, gonzaga-santos-p7, boqueirao-santos-p1, ... |
| `ix$vocab` | character | 3305 | 0, 000, 000e, 01, 013, 0132, ... |
| `ix$tf` | matrix | 3305 × 194 | linhas: 0, 000, 000e, ... \| colunas: gonzaga-santos-p1, gonzaga-santos-p2, gonzaga-santos-p3, gonzaga-santos-p4, ... |
| `ix$N` | integer | 1 | 194 |
| `ix$df` | numeric, nomeado | 3305 | 0 7, 000 9, 000e 1, 01 1, 013 4, 0132 4, ... |
| `ix$idf_tfidf` | numeric, nomeado | 3305 | 0 3.322, 000 3.071, 000e 5.268, 01 5.268, 013 3.882, 0132 3.882, ... |
| `ix$w` | matrix | 3305 × 194 | linhas: 0, 000, 000e, ... \| colunas: gonzaga-santos-p1, gonzaga-santos-p2, gonzaga-santos-p3, gonzaga-santos-p4, ... |
| `ix$wn` | matrix | 3305 × 194 | linhas: 0, 000, 000e, ... \| colunas: gonzaga-santos-p1, gonzaga-santos-p2, gonzaga-santos-p3, gonzaga-santos-p4, ... |
| `ix$postings` | list | 3305 | elementos: gonzaga, bairro, nobre, cidade, santos, praca, independencia, situada, ... |
| `ix$dl` | numeric, nomeado | 194 | gonzaga-santos-p1 19, gonzaga-santos-p2 29, gonzaga-santos-p3 36, gonzaga-santos-p4 39, gonzaga-santos-p5 30, gonzaga-santos-p6 43, ... |
| `ix$avgdl` | numeric | 1 | 46.95 |
| `ix$idf_bm25` | numeric, nomeado | 3305 | 0 3.258, 000 3.022, 000e 4.868, 01 4.868, 013 3.769, 0132 3.769, ... |
| `k_esc` | numeric | 1 | 20 |
| `k_max` | numeric | 1 | 20 |
| `ks` | numeric | 3 | 10, 20, 50 |
| `m_esc$U` | matrix | 3305 × 20 | linhas: 0, 000, 000e, ... \| colunas: (sem nomes) |
| `m_esc$S` | numeric | 20 | 75.25, 61.58, 60.8, 57.65, 55.8, 53.93, ... |
| `m_esc$D` | matrix | 194 × 20 | linhas: gonzaga-santos-p1, gonzaga-santos-p2, gonzaga-santos-p3, ... \| colunas: (sem nomes) |
| `m20$U` | matrix | 3305 × 20 | linhas: 0, 000, 000e, ... \| colunas: (sem nomes) |
| `m20$S` | numeric | 20 | 75.25, 61.58, 60.8, 57.65, 55.8, 53.93, ... |
| `m20$D` | matrix | 194 × 20 | linhas: gonzaga-santos-p1, gonzaga-santos-p2, gonzaga-santos-p3, ... \| colunas: (sem nomes) |
| `motor` | character | 496 | # =========================..., #  motor07.R  --  Projeto I..., #  Para a Aula 07: as funco..., #  Gerado de motor_mestre.R..., # =========================..., #, ... |
| `MOTOR_VERSAO` | character | 1 | motor07 v1 2026-10-15 |
| `ms$k10` | list | 3 | elementos: U, S, D |
| `ms$k20` | list | 3 | elementos: U, S, D |
| `ms$k50` | list | 3 | elementos: U, S, D |
| `nec` | data.frame | 5 × 5 | colunas: consulta, texto_consulta, necessidade, escopo, conjunto |
| `q` | character | 1 | q01 |
| `qrels$q01` | numeric, nomeado | 10 | gonzaga-santos-p3 1, jose-menino-p4 0, gonzaga-santos-p5 1, gonzaga-santos-p1 2, gonzaga-santos-p6 1, guaruja-p7 0, ... |
| `qrels$q02` | numeric, nomeado | 11 | cubatao-p50 1, cubatao-p23 2, cubatao-p19 1, cubatao-p14 0, guaruja-p5 0, cubatao-p3 2, ... |
| `qrels$q03` | numeric, nomeado | 12 | cubatao-p50 0, guaruja-p14 0, sao-vicente-sao-paulo-p10 1, sao-vicente-sao-paulo-p2 1, sao-vicente-sao-paulo-p1 1, sao-vicente-sao-paulo-p19 0, ... |
| `qrels$q04` | numeric, nomeado | 11 | guaruja-p20 1, ponta-da-praia-p1 0, praia-das-asturias-p2 0, praia-grande-sao-paulo-p22 0, praia-das-asturias-p1 0, praia-do-tombo-p2 2, ... |
| `qrels$q05` | numeric, nomeado | 12 | sao-vicente-sao-paulo-p21 0, praia-grande-sao-paulo-p51 0, praia-grande-sao-paulo-p43 0, praia-grande-sao-paulo-p3 1, praia-grande-sao-paulo-p22 0, praia-grande-sao-paulo-p55 0, ... |
| `R_q` | integer, nomeado | 5 | q01 2, q02 2, q03 2, q04 1, q05 0 |
| `rb` | numeric, nomeado | 194 | gonzaga-santos-p1 5.617, gonzaga-santos-p3 5.005, jose-menino-p4 4.818, gonzaga-santos-p7 4.648, gonzaga-santos-p2 4.032, gonzaga-santos-p5 3.991, ... |
| `REPO` | character | 1 | https://raw.githubuserconte... |
| `rl` | numeric, nomeado | 194 | praia-do-tombo-p2 0.8769, praia-grande-sao-paulo-p4 0.8481, aparecida-santos-p3 0.828, aparecida-santos-p4 0.8208, praia-grande-sao-paulo-p48 0.8042, cubatao-p6 0.8038, ... |
| `so_lsa` | character | 5 | praia-do-tombo-p2, praia-grande-sao-paulo-p4, aparecida-santos-p3, aparecida-santos-p4, praia-grande-sao-paulo-p48 |
| `tab_dev` | matrix | 7 × 2 | linhas: bm25, lsa.k10, lsa.k20, ... \| colunas: q01, q02 |
| `tab_teste` | matrix | 2 × 2 | linhas: bm25, escolhido \| colunas: q03, q04 |
| `teste` | character | 2 | q03, q04 |
| `usar` | character | 4 | q01, q02, q03, q04 |

### Funções definidas

`anexar_estado`, `ap`, `ap_modelo`, `bm25`, `bm25_doc`, `busca_AND`, `busca_booleana`, `cfg_aula`, `cosseno`, `dcg`, `docs_aula`, `estado`, `gabarito_aula`, `idf_bm25`, `idf_classico`, `indice_invertido`, `kappa_cohen`, `kappa_matriz`, `ler_qrels`, `limpar`, `lsa`, `matriz_tf`, `metricas`, `montar`, `ndcg`, `norm_cols`, `precisao_k`, `preparar`, `prf`, `ranking_bm25`, `ranking_cosseno`, `ranking_lsa`, `ranking_modelo`, `ranking_motor`, `ranking_vetor`, `recall_k`, `relevancia`, `residual`, `rocchio`, `rr`, `rrf`, `saturacao`, `sem_stop`, `stopwords_aula`, `tokenizar`, `vetor_consulta`
<!-- estado-R:fim -->

