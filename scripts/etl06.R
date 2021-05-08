install.packages("XML")
install.packages("readxl")
install.packages("rjson")

library(XML)
library(readxl)
library(rjson)

# Lista de fornecedores do TPC-H Benchmark
# (exemplo de extração de dados a partir de um XML)

tpchSupplier <- xmlToDataFrame("http://aiweb.cs.washington.edu/research/projects/xmltk/xmldata/data/tpc-h/supplier.xml")

# Base de dados de vestidos
# (exemplo de extração de dados a partir de um XLSX)

dresses <- read_excel('bases_originais/Dresses_Attribute_DataSet.xlsx', sheet=1)

# Metadados da campanha de vacinação Covid-19
# (exemplo de extração de dados a partir de um JSON)

metadadosCovid <- as.data.frame(fromJSON(file = "http://dados.recife.pe.gov.br/dataset/72c94f87-1fcd-4145-9016-31dff794688a/resource/3b86294b-0050-484e-8c10-c0152a5ff8ac/download/metadados-covid19.json"))
