library(funModeling)
library(tidyverse)
library(poliscidata)

# Nesta atividade, será utilizada a base 'world', do pacote 'poliscidata'.

# Olhada nos dados

glimpse(world)

# Estrutura dos dados

status(world)

# Frequência das variáveis fator
# Aqui eu tive que colocar especificamente que era a função 'freq' do pacote
# 'funModeling', pois ela estava sendo mascarada pela função 'freq' do pacote
# 'poliscidata'.
# No 'RStudio', pode-se vizualizar os vários plots gerados (a partir das
# variáveis fator da base de dados) utilizando as setas para a esquerda e para a
# direita da aba 'Plots'.

funModeling::freq(world)

# Exploração das variáveis numéricas
# Como todos os histogramas são exibidos em um único plot e, nessa base de
# dados, há muitas variáveis numéricas, os histogramas ficam muito pequenos. No
# 'RStudio', isso pode ser resolvido com o botão 'Zoom' da aba 'Plots'.

plot_num(world)

# Estatísticas das variáveis numéricas
# No console do 'RStudio', são exibidas as 62 primeiras observações (as demais
# são omitidas). O segundo comando exibe as observações restantes.

profiling_num(world)

profiling_num(world)[63:69, ]
