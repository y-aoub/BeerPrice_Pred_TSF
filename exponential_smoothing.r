serie = read.table("beer_projet.csv", header = F, sep=",")
serie = serie[,2] # On garde seulement la colonne des valeurs 
serie = ts(data = serie, start = c(1974,1), frequency = 12) # Transformation en s?rie temporelle
show(decompose(serie))
serie.des = decompose(serie)$trend # s?rie d?saisonnalis?e
show(serie.des)
# Affichage série et série désaisonnalis?e
plot(serie,main="Production de bi?re en Australie entre janvier 1974 et d?cembre 1980",ylab="Bi?re",xlab="")
points(serie.des,type="l",col="red")

# Séparation en deux séries : application et validation
serie.LES.app=window(serie.des,start=c(1974,1),end=c(1979,7))
show(serie.LES.app)
serie.LES.val=window(serie.des,start=c(1979,8),end=c(1980,12))

# Lissge exponentiel simple sur la série application
library(forecast)
LES=ets(serie.LES.app,model="ANN",additive.only=TRUE)
summary(LES)

# Prévisions 
prev=forecast(LES,h=17) # 17 mois dans la série validation
plot(prev)
points(serie.LES.val,type="l",col="red") # Comparaison avec série de validation en rouge


# Lissage exponentiel de Holt-Winters
serie.HW.app=window(serie,start=c(1974,1),end=c(1979,7))
serie.HW.val=window(serie,start=c(1979,8),end=c(1980,12))

HW = ets(serie.HW.app,model="ANA",additive.only=TRUE)
summary(HW)

# Prévisions
prev=forecast(HW,h=17) # 17 mois dans la s?rie validation
plot(prev)
points(serie.HW.val,type="l",col="red") 

