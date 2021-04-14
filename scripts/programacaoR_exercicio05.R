# Recuperação de dados da base 'mtcars': apenas as linhas em que o valor do
# 'drat' é maior do que 3 e o valor do 'gear' é diferente de 4. Para essa
# seleção, devem ser exibidas apenas 4 colunas: 'mpg', 'cyl', 'drat' e 'gear'.

mtcars[mtcars$drat > 3 & mtcars$gear != 4, c("mpg", "cyl", "drat", "gear")]
