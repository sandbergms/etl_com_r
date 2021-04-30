library(microbenchmark)
library(haven)

# exporta em formato nativo do R

saveRDS(sinistrosRecifeRaw, "bases_tratadas/sinistrosRecife.rds")

# exporta em formato tabular (.csv) - padrão para interoperabilidade

write.csv2(sinistrosRecifeRaw, "bases_tratadas/sinistrosRecife.csv")

# exporta em .dta, formato do Stata

write_dta(sinistrosRecifeRaw, "bases_tratadas/sinistrosRecife.dta")

# carrega base de dados em formato nativo R

sinistrosRecife <- readRDS("bases_tratadas/sinistrosRecife.rds")

# carrega base de dados em formato tabular (.csv) - padrão para
#                                                   interoperabilidade

sinistrosRecife <- read.csv2("bases_tratadas/sinistrosRecife.csv", sep = ";")

# carrega base de dados em .dta, formato do Stata

sinistrosRecife <- read_dta("bases_tratadas/sinistrosRecife.dta")

# compara os três processos de exportação, usando a função microbenchmark

microbenchmark(a <- saveRDS(sinistrosRecifeRaw,
                            "bases_tratadas/sinistrosRecife.rds"),
               b <- write.csv2(sinistrosRecifeRaw,
                               "bases_tratadas/sinistrosRecife.csv"),
               c <- write_dta(sinistrosRecifeRaw,
                              "bases_tratadas/sinistrosRecife.dta"),
               times = 10L)

# compara os três processos de leitura, usando a função microbenchmark

microbenchmark(a <- readRDS("bases_tratadas/sinistrosRecife.rds"),
               b <- read.csv2("bases_tratadas/sinistrosRecife.csv", sep = ';'),
               c <- read_dta("bases_tratadas/sinistrosRecife.dta"),
               times = 10L)
