# Consolidado — PI III — Aula 00 — Parte D — 2026-10-16
*guia versão 3 · tutora: DeepSeek · sessão prática, individual · sem motor*
**Aluno:** <nome>

## 1. O que foi passado
- M12 — três frases próprias (sujas), pipeline de limpeza em 4 linhas montado por ele; `unique`; tokenização; contagem com `table`; observou que a palavra mais frequente era de conteúdo ("dados", 3x) e a segunda vazia ("de")
- M13 — regex nas frases sujas: `[A-Z]`, `^`, `$`, `[^a-z ]`, `.*`, `\\s*`; ele escreveu as cinco missões e o checkpoint
- M14 — o fluxo do curso: `source` por endereço, `list.files`, `anexar_estado`, `readLines`, `tail`, `estado`; upload, anexação do estado, download; GitHub (repositório, upload, endereço Raw) e leitura de volta pela internet

## 2. Como foi o aprendizado — opinião da tutora
Escreveu as frases e as regex **sozinho** — não pediu para eu fazer nenhuma. O pipeline saiu na
ordem certa de primeira (o `tolower` antes do `[^a-z ]`), e ele entendeu por quê quando eu
apontei a consequência. Acertou o mecanismo da limpeza e da contagem sem tropeço.

Onde travou:
- **M13, missão 3:** colou a regex da missão 1 na frente da missão 3 (`^\\s*[A-Z].*[^a-z ]$`) e
  a saída saiu `FALSE TRUE FALSE` em vez de `TRUE TRUE TRUE`. Corrigiu quando eu mostrei que a
  missão 3 pedia só o fim. Lição: separar as condições quando a pergunta pede uma só.
- **M14, upload:** o arquivo chegou ao Colab com nome dobrado (`aula00_consolidado.md.md`) e
  depois o endereço Raw veio como endereço de pasta (`/tree/…`) antes de vir certo. Resolveu os
  dois sozinho, com orientação passo a passo.

Acertou quase todas as previsões. Explorou todos os "explore" pedidos. Boa autonomia no Colab e
no GitHub — fez cada passo e relatou o que viu.

**Checkpoint 13:** correto (`^[A-Z].*a$`), com a explicação certa de por que deu `FALSE FALSE FALSE`.
**Checkpoint 14:** as duas respostas completas e corretas.

## 3. Observações para a frente
- **Revisar antes da Aula 01:** nada bloqueante. Se quiser, rever o `^` dentro de `[ ]` (negação)
  versus `^` fora (início) — foi o único ponto de precisão na teoria.
- **Para a próxima tutora:** autônomo no Colab e no GitHub; escreve o código antes de pedir ajuda;
  entende a consequência de cada passo do pipeline quando questionado. Bom ritmo.
- **Perguntas guardadas:** "como tirar acento e pontuação" — Aula 03; "idf" / "matriz
  termo-documento" — Aula 01.
- **Produzido:** três frases sobre o tema "dados/estatística" (a mais frequente: `dados`, 3x;
  segunda: `de`, 2x); pipeline de limpeza montado por ele; cinco regex escritas por ele
  (`^\\s*[A-Z]`, `[0-9]`, `[^a-z ]$`, `sub(" .*$", "", x)`, `gsub(" ", "_", x)`); regex do
  checkpoint (`^[A-Z].*a$`). **Repositório de treino criado; estado anexado e lido de volta:
  sim.**
- **Parte D:** concluída. Aula 00 inteira concluída — pronto para a Aula 01.