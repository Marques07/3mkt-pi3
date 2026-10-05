# ============================================================================
# SISTEMA DE RECUPERAÇÃO DE INFORMAÇÃO
# Busca Booleana | TF-IDF | Busca Vetorial (cosseno) | BM25
# ============================================================================
#
# Estrutura do arquivo:
#   BLOCO 0 -> util/pré-processamento (carregar corpus, tokenizar, matriz termo-doc)
#   BLOCO 1 -> Busca Booleana
#   BLOCO 2 -> TF-IDF
#   BLOCO 3 -> Busca Vetorial (TF-IDF + similaridade de cosseno)
#   BLOCO 4 -> BM25
#   BLOCO 5 -> main() - aplica tudo sobre o corpus e imprime de forma
#              estruturada. É a única parte que executa algo; os blocos
#              acima só DEFINEM funções.
#
# Para rodar:  Rscript busca_ri.R
# (o script espera um "corpus.csv" com colunas id,texto no diretório atual;
#  se não encontrar, usa um corpus de exemplo embuatido)
# ============================================================================

# Este script usa apenas funções base do R (sem pacotes externos), então
# roda em qualquer instalação sem precisar instalar nada.

# ============================================================================
# BLOCO 0 — PRÉ-PROCESSAMENTO (compartilhado pelos demais blocos)
# ============================================================================

#' Lê o corpus de um CSV com colunas "id" e "texto" e devolve um vetor
#' nomeado (nome = id do documento, valor = texto).
carregar_corpus <- function(caminho = "corpus.csv") {
  dados <- read.csv(caminho, stringsAsFactors = FALSE, encoding = "UTF-8")
  setNames(dados$texto, dados$id)
}

#' Tokenização simples (minúsculas + split por espaço). Usada pela busca
#' booleana clássica / TF-IDF "cru".
tokenizar <- function(texto) {
  texto <- tolower(texto)
  unlist(strsplit(texto, "\\s+"))
}

#' Normalização mais agressiva: minúsculas, remove acentos, remove tudo que
#' não é letra/número, colapsa espaços.
limpar <- function(x) {
  x <- tolower(x)
  x <- iconv(x, to = "ASCII//TRANSLIT")
  x <- gsub("[^a-z0-9 ]", " ", x)
  x <- gsub("\\s+", " ", x)
  trimws(x)
}

STOPWORDS <- c("da", "do", "de", "o", "a", "os", "as", "e", "em", "um", "uma",
               "uns", "umas", "no", "na", "por", "como", "para", "mas")

#' Tokenização "limpa": normaliza acentos/pontuação e remove stopwords.
#' É a tokenização usada por TF-IDF, busca vetorial e BM25 neste script.
tokenizar_limpo <- function(x) {
  t <- unlist(strsplit(limpar(x), " "))
  t[!t %in% STOPWORDS & t != ""]
}

#' Constrói o vocabulário (termos únicos, ordenados) a partir de uma lista
#' de tokens por documento.
construir_vocab <- function(tokens_por_doc) {
  sort(unique(unlist(tokens_por_doc)))
}

#' Constrói a matriz termo-documento (linhas = termos do vocab, colunas =
#' documentos), com a frequência de cada termo em cada documento.
construir_tdm <- function(tokens_por_doc, vocab) {
  tdm <- sapply(tokens_por_doc, function(tk) {
    as.integer(table(factor(tk, levels = vocab)))
  })
  rownames(tdm) <- vocab
  colnames(tdm) <- names(tokens_por_doc)
  tdm
}

# ============================================================================
# BLOCO 1 — BUSCA BOOLEANA
# ============================================================================

#' Devolve os documentos onde `termo` ocorre pelo menos uma vez.
busca_booleana <- function(termo, tdm) {
  termo <- tolower(termo)
  if (!termo %in% rownames(tdm)) return(character(0))
  colnames(tdm)[tdm[termo, ] > 0]
}

#' Índice invertido: lista nomeada termo -> vetor de ids de documentos.
construir_postings <- function(tokens_por_doc) {
  postings <- list()
  for (d in names(tokens_por_doc)) {
    termos_doc <- unique(tokens_por_doc[[d]])
    for (termo in termos_doc) {
      postings[[termo]] <- c(postings[[termo]], d)
    }
  }
  postings
}

#' Busca booleana AND: interseção dos postings de cada termo da consulta.
#' `consulta` é uma string (ex.: "praia bairro") tokenizada com `tokenizar_fn`.
busca_and <- function(consulta, postings, tokenizar_fn = tokenizar_limpo) {
  termos <- tokenizar_fn(consulta)
  termos <- termos[termos %in% names(postings)]
  if (length(termos) == 0) return(character(0))
  Reduce(intersect, postings[termos])
}

# ============================================================================
# BLOCO 2 — TF-IDF
# ============================================================================

#' IDF clássico: log(N / df). `tipo = "bm25"` calcula o IDF usado pelo BM25
#' (log((N - df + 0.5) / (df + 0.5) + 1)), útil para reaproveitar esta
#' função no Bloco 4.
calcular_idf <- function(tdm, tipo = c("classico", "bm25")) {
  tipo <- match.arg(tipo)
  N  <- ncol(tdm)
  df <- rowSums(tdm > 0)
  if (tipo == "classico") {
    log(N / df)
  } else {
    log((N - df + 0.5) / (df + 0.5) + 1)
  }
}

#' Pondera a matriz termo-documento (contagens) pelo IDF, gerando a matriz
#' TF-IDF (recicla o vetor idf linha a linha).
calcular_tfidf <- function(tdm, idf) {
  tdm * idf
}

#' Vetoriza uma consulta no mesmo espaço vetorial do vocabulário/IDF, para
#' poder ser comparada com as colunas da matriz TF-IDF.
vetorizar_consulta_tfidf <- function(consulta, vocab, idf, tokenizar_fn = tokenizar_limpo) {
  tk <- tokenizar_fn(consulta)
  contagem <- as.integer(table(factor(tk, levels = vocab)))
  contagem * idf
}

# ============================================================================
# BLOCO 3 — BUSCA VETORIAL (TF-IDF + similaridade de cosseno)
# ============================================================================

#' Similaridade de cosseno entre dois vetores numéricos.
similaridade_cosseno <- function(a, b) {
  norma_a <- sqrt(sum(a^2))
  norma_b <- sqrt(sum(b^2))
  if (norma_a == 0 || norma_b == 0) return(0)
  sum(a * b) / (norma_a * norma_b)
}

#' Ranking completo (todos os documentos, do mais similar ao menos similar)
#' de uma consulta contra a matriz TF-IDF.
ranking_vetorial <- function(consulta, vocab, idf, tfidf, tokenizar_fn = tokenizar_limpo) {
  vq <- vetorizar_consulta_tfidf(consulta, vocab, idf, tokenizar_fn)
  sims <- apply(tfidf, 2, function(col) similaridade_cosseno(vq, col))
  names(sort(sims, decreasing = TRUE))
}

#' Busca vetorial "amigável": devolve um data.frame com os top_n documentos,
#' score de cosseno e o texto do documento.
busca_vetorial <- function(consulta, vocab, idf, tfidf, docs, top_n = 5,
                           tokenizar_fn = tokenizar_limpo) {
  vq <- vetorizar_consulta_tfidf(consulta, vocab, idf, tokenizar_fn)
  sims <- apply(tfidf, 2, function(col) similaridade_cosseno(vq, col))
  ranking <- sort(sims, decreasing = TRUE)
  top <- ranking[seq_len(min(top_n, length(ranking)))]
  data.frame(
    documento = names(top),
    score     = round(as.numeric(top), 3),
    texto     = docs[names(top)],
    row.names = NULL
  )
}

# ============================================================================
# BLOCO 4 — BM25
# ============================================================================

#' Parâmetros derivados do corpus que o BM25 precisa: tamanho de cada
#' documento (dl) e tamanho médio dos documentos (avgdl).
calcular_parametros_bm25 <- function(tdm) {
  dl <- colSums(tdm)
  list(dl = dl, avgdl = mean(dl))
}

#' Score BM25 de um documento `d` para uma lista de termos já tokenizados.
bm25_doc <- function(termos, d, tdm, idf_bm25, dl, avgdl, k1 = 1.2, b = 0.75) {
  s <- 0
  vocab <- rownames(tdm)
  for (t in termos) {
    if (!(t %in% vocab)) next
    f <- unname(tdm[t, d])
    K <- k1 * (1 - b + b * unname(dl[d]) / avgdl)
    # unname() em cada lookup (idf_bm25[t], dl[d]) evita que o nome do termo
    # ou do documento "vaze" e se anexe ao id do documento em sapply() depois
    s <- s + unname(idf_bm25[t]) * (f * (k1 + 1)) / (f + K)
  }
  s
}

#' Ranking completo (todos os documentos) de uma consulta pelo BM25.
ranking_bm25 <- function(consulta, tdm, idf_bm25, dl, avgdl, k1 = 1.2, b = 0.75,
                         tokenizar_fn = tokenizar_limpo) {
  termos <- tokenizar_fn(consulta)
  scores <- sapply(colnames(tdm), function(d) {
    bm25_doc(termos, d, tdm, idf_bm25, dl, avgdl, k1, b)
  })
  names(sort(scores, decreasing = TRUE))
}

#' Busca BM25 "amigável": devolve um data.frame com os top_n documentos,
#' score BM25 e o texto do documento (mesmo formato de busca_vetorial()).
busca_bm25 <- function(consulta, tdm, idf_bm25, dl, avgdl, docs, top_n = 5,
                       k1 = 1.2, b = 0.75, tokenizar_fn = tokenizar_limpo) {
  termos <- tokenizar_fn(consulta)
  scores <- sapply(colnames(tdm), function(d) {
    bm25_doc(termos, d, tdm, idf_bm25, dl, avgdl, k1, b)
  })
  ranking <- sort(scores, decreasing = TRUE)
  top <- ranking[seq_len(min(top_n, length(ranking)))]
  data.frame(
    documento = names(top),
    score     = round(as.numeric(top), 3),
    texto     = docs[names(top)],
    row.names = NULL
  )
}

# ============================================================================
# BLOCO 5 — MAIN: aplica tudo sobre o corpus e imprime de forma estruturada
# ============================================================================

main <- function(caminho_corpus = "corpus.csv",
                 consulta_exemplo = "praia bairro",
                 termo_booleano   = "praia",
                 top_n = 5) {
  
  linha <- function(titulo) {
    cat("\n", strrep("=", 70), "\n", titulo, "\n", strrep("=", 70), "\n", sep = "")
  }
  
  # --- Carga e pré-processamento --------------------------------------------
  linha("0. CARGA DO CORPUS E PRÉ-PROCESSAMENTO")
  
  if (file.exists(caminho_corpus)) {
    docs <- carregar_corpus(caminho_corpus)
  } else {
    cat("Aviso: '", caminho_corpus, "' não encontrado — usando corpus de exemplo.\n", sep = "")
    docs <- c(
      "gonzaga-santos-p1" = "O Gonzaga é um bairro nobre da cidade de Santos, com praça e comércio.",
      "praia-grande-p1"   = "Praia Grande é uma cidade litorânea vizinha de Santos, com praias extensas.",
      "guaruja-p1"        = "Guarujá é uma cidade praiana no litoral, com praias como Pitangueiras e Tombo."
    )
  }
  
  cat("Documentos carregados:", length(docs), "\n")
  
  tokens       <- lapply(docs, tokenizar_limpo)
  vocab        <- construir_vocab(tokens)
  tdm          <- construir_tdm(tokens, vocab)
  postings     <- construir_postings(tokens)
  
  cat("Tamanho do vocabulário:", length(vocab), "termos\n")
  
  # --- Bloco 1: Busca booleana ----------------------------------------------
  linha(paste0("1. BUSCA BOOLEANA — termo = \"", termo_booleano, "\""))
  
  resultado_bool <- busca_booleana(termo_booleano, tdm)
  cat("Documentos que contêm o termo (", length(resultado_bool), "):\n", sep = "")
  print(resultado_bool)
  
  cat("\nBusca AND para a consulta \"", consulta_exemplo, "\":\n", sep = "")
  resultado_and <- busca_and(consulta_exemplo, postings)
  print(resultado_and)
  
  # --- Bloco 2: TF-IDF --------------------------------------------------------
  linha("2. TF-IDF")
  
  idf_classico <- calcular_idf(tdm, "classico")
  idf_bm25     <- calcular_idf(tdm, "bm25")
  tfidf        <- calcular_tfidf(tdm, idf_classico)
  
  cat("IDF (clássico) dos 5 termos mais informativos:\n")
  print(round(sort(idf_classico, decreasing = TRUE), 3)[1:min(5, length(vocab))])
  
  cat("\nTrecho da matriz TF-IDF (5 termos x até 5 documentos):\n")
  n_docs_show <- min(5, ncol(tfidf))
  n_termos_show <- min(5, nrow(tfidf))
  print(round(tfidf[1:n_termos_show, 1:n_docs_show, drop = FALSE], 3))
  
  # --- Bloco 3: Busca vetorial -------------------------------------------------
  linha(paste0("3. BUSCA VETORIAL (TF-IDF + cosseno) — consulta = \"", consulta_exemplo, "\""))
  
  resultado_vetorial <- busca_vetorial(consulta_exemplo, vocab, idf_classico, tfidf,
                                       docs, top_n = top_n)
  print(resultado_vetorial)
  
  # --- Bloco 4: BM25 ------------------------------------------------------------
  linha(paste0("4. BM25 — consulta = \"", consulta_exemplo, "\""))
  
  params_bm25 <- calcular_parametros_bm25(tdm)
  resultado_bm25 <- busca_bm25(consulta_exemplo, tdm, idf_bm25,
                               params_bm25$dl, params_bm25$avgdl,
                               docs, top_n = top_n)
  print(resultado_bm25)
  
  # --- Comparação lado a lado ---------------------------------------------------
  linha("5. COMPARAÇÃO — TF-IDF/cosseno vs. BM25 (top documentos)")
  
  comparacao <- data.frame(
    posicao       = seq_len(top_n),
    doc_vetorial  = c(resultado_vetorial$documento,
                      rep(NA, top_n - nrow(resultado_vetorial))),
    doc_bm25      = c(resultado_bm25$documento,
                      rep(NA, top_n - nrow(resultado_bm25)))
  )
  print(comparacao, row.names = FALSE)
  
  invisible(list(
    docs = docs, tokens = tokens, vocab = vocab, tdm = tdm,
    postings = postings, idf_classico = idf_classico, idf_bm25 = idf_bm25,
    tfidf = tfidf, params_bm25 = params_bm25,
    resultado_booleana = resultado_bool, resultado_and = resultado_and,
    resultado_vetorial = resultado_vetorial, resultado_bm25 = resultado_bm25
  ))
}
