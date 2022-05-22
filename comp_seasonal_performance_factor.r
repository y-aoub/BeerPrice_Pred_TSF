serie = read.table("data/beer_projet_app.csv", header = F, sep=",")
serie = serie[,2] # We keep just the values column
serie = ts(data = serie, start = c(1974,1), frequency = 12) # Transformation en série temporelle
# Seasonal factors
CS = decompose(serie)$figure



