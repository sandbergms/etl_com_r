library(rvest)
library(dplyr)

# Página com os recordes olímpicos do atletismo

url <- "https://pt.wikipedia.org/wiki/Recordes_ol%C3%ADmpicos_do_atletismo"

# Objeto com todas as tabelas da página html

urlTables <- url %>% read_html %>% html_nodes("table")

# Data frame com os recordes femininos
# OBS.: os nomes das atletas ficaram duplicados (nos 2 formatos:
#       'nome + sobrenome' e 'sobrenome + nome') dentro de cada posição da
#       coluna 'Atleta.s.' (provavelmente devido aos hyperlinks associados, na
#       tabela original). O tratamento desse caso foge do escopo deste
#       exercício.

recordesFemininos <- as.data.frame(html_table(urlTables[2]))
