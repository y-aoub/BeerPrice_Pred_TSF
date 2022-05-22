serie = read.table("data/beer_projet.csv", header = F, sep=",")
serie = serie[,2] # We keep just the vales column
serie = ts(data = serie, start = c(1974,1), frequency = 12) # Transformation en s?rie temporelle
show(decompose(serie))
serie.des = decompose(serie)$trend # de-seasonalized serie
show(serie.des)
# Affichage série et série désaisonnalis?e
plot(serie,main="Beer production in Austarila between Jan 1974 and Dec 1980",ylab="Bi?re",xlab="")
points(serie.des,type="l",col="red")

# Spliting into 2 series: application and validation
serie.LES.app=window(serie.des,start=c(1974,1),end=c(1979,7))
show(serie.LES.app)
serie.LES.val=window(serie.des,start=c(1979,8),end=c(1980,12))

# Exponential smooting applied to the application serie
library(forecast)
LES=ets(serie.LES.app,model="ANN",additive.only=TRUE)
summary(LES)

# Prévisions 
prev=forecast(LES,h=17) # 17 months in the validation serie
plot(prev)
points(serie.LES.val,type="l",col="red") #comparaison with the validation serie (red)


# Holt-Winters exponential smooting
serie.HW.app=window(serie,start=c(1974,1),end=c(1979,7))
serie.HW.val=window(serie,start=c(1979,8),end=c(1980,12))

HW = ets(serie.HW.app,model="ANA",additive.only=TRUE)
summary(HW)

# Preds
prev=forecast(HW,h=17) # 17 mois dans la s?rie validation
plot(prev)
points(serie.HW.val,type="l",col="red") 

