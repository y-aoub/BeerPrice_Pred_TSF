serie = read.table("beer_projet_app.csv", header = F, sep=",")
serie = serie[,2] # On garde seulement la colonne des valeurs 
serie = ts(data = serie, start = c(1974,1), frequency = 12) # Transformation en série temporelle
# Coefficients saisonniers
CS = decompose(serie)$figure



