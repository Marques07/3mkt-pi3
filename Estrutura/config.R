# ==========================================================================
#  config.R  --  Grupo 3Mkt (Baixada Santista: bairros, praias e municipios)
#  As decisoes que ja estao no busca_ri.R do grupo, no formato do curso.
#  Enviar para  estrutura/codigo/config.R  no repositorio do grupo.
#  Gerado em 2026-10-23 a partir de Estrutura/busca_ri.R e da Entrega 1.
#  Sem acento nas strings (locale do Colab/Windows).
# ==========================================================================

cfg <- list(
  # --- Aula 01: o que e um documento ------------------------------------
  minimo = 40,                  # paragrafo com pelo menos 40 caracteres (Entrega 1, Secao 3)

  # --- Aula 03: limpeza e stopwords (como em limpar() e STOPWORDS do busca_ri.R)
  limpar    = TRUE,             # minusculas, sem pontuacao, so letras e numeros
  acentos   = "translit",       # iconv(..., "ASCII//TRANSLIT"): "sao vicente", "guaruja"
  stopwords = c("da", "do", "de", "o", "a", "os", "as", "e", "em", "um", "uma",
                "uns", "umas", "no", "na", "por", "como", "para", "mas"),

  # --- Aula 04: BM25 (valores padrao usados no busca_ri.R) ----------------
  k1 = 1.2,
  b  = 0.75,

  # --- Aula 5,5: metricas (A DECIDIR: o busca_ri.R ainda nao mede) --------
  limiar = 2,                   # grau minimo para contar como relevante -- confirmar
  # juizes = c("<nome>", "<nome>"), # descomentar se houver mais de um juiz

  # --- Aula 06: realimentacao (A DECIDIR: o busca_ri.R nao usa) ----------
  prf_k   = 0,                            # 0 = sem pseudo-realimentacao
  rocchio = c(a = 1, b = 0.75, g = 0.15), # pesos do Rocchio

  # --- Aula 07: LSA e busca hibrida (decidir na Parte D da Aula 07) ------
# --- Aula 07: LSA e busca hibrida --------------------------------------
  modelo = "hibrido",                     # "bm25", "lsa" ou "hibrido"
  lsa_k  = 20,                            # dimensoes do LSA
  rrf_c  = 60,                            # constante da fusao RRF                # constante da fusao RRF

  # --- fim ----------------------------------------------------------------
  grupo = "3Mkt"                # ultimo campo, sem virgula depois
)
