ls() # lista todos os objetos no R

# Ao rodar esse 'for', podemos ver quanto de memória cada um dos objetos está
# ocupando. O objeto que está ocupando mais memória é 'sinistrosRecifeRaw'.

for (itm in ls()) { 
  print(formatC(c(itm, object.size(get(itm))), 
                format = "d",
                width = 30),
        quote=F)
}

gc() # uso explícito do garbage collector

# Removendo todos os objetos da memória, menos 'naZero' e 'sinistrosRecifeRaw'

rm(list=(ls()[ls() != "naZero" & ls() != "sinistrosRecifeRaw"]))
