library(ff)
library(ffbase)

baseFinal <- NULL

# Extrai as bases de 2011 a 2020 (da pasta 'bases_originais') no padrão ff e
# junta-as em um único objeto ff, 'baseFinal'

for (i in 2011:2020) {

  caminho <- paste("bases_originais/situacaofinalalunos", i, ".csv", sep = "")
  
  base <- read.csv2.ffdf(file = caminho)
    
  baseFinal <- ffdfappend(baseFinal, base)
  
}

# Limpa a staging area

rm(list=(ls()[ls() != "baseFinal"]))

# Exporta a base única em formato nativo do R

saveRDS(baseFinal, "bases_tratadas/situacaofinalalunos.rds")
