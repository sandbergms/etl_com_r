library(tidyverse)

# Nesta atividade, será utilizada a base 'WorldPhones', do R base. Ela é uma
# matriz com formato wide.

WorldPhonesLong <- WorldPhones %>%
  
  # transforma a base 'WorldPhones' para data frame
  as.data.frame() %>%
  
  # transforma os nomes das linhas em uma nova coluna (com o nome 'year')
  rownames_to_column(var = "year") %>%
  
  # converte os valores da coluna 'year' para numeric
  mutate(year = as.numeric(year)) %>%
  
  # pivota o data frame de wide para long
  pivot_longer(!year, names_to = "region", values_to = "nTelephones")
