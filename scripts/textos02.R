library(dplyr)
library(pdftools)
library(textreadr)

# Lê o pdf

ementaAL <- read_pdf('documentos/ementaAL2021-1.pdf', ocr = T)

# Junta todas as páginas do pdf em uma única string

ementaALAll <- ementaAL %>%
  group_by(element_id) %>%
  mutate(all_text = paste(text, collapse = " | ")) %>%
  select(element_id, all_text) %>%
  unique()

ementaALModif <- ementaALAll

# Modifica as '/' das datas por '-'. Primeiro, eu troquei os '-' que já existiam
# por ' - ' somente nos trechos que poderiam ser confundidos como datas quando
# as mesmas forem ser extraídas mais adiante. Depois, eu troquei '/' por '-',
# fazendo uma série de controles, para tentar garantir que essa substituição
# ocorra somente nas '/' que realmente correspondem a datas, e que as demais '/'
# do texto permaneçam inalteradas.

ementaALModif$all_text <-
  str_replace_all(string = ementaALModif$all_text,
                  c("(\\d{2})-(\\d{2})" = "\\1 - \\2",
                    "([0-3]\\d{1})/([01]\\d{1})" = "\\1-\\2"))

# Extrai as datas do texto, usando o novo padrão

datas <- str_extract_all(ementaALModif$all_text, "\\d{2}-\\d{2}")
