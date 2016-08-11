index = c("EUR", "GBP", "FXR", "USD", "goldPrice")
endid = 2

price = data.frame(c(1:499))
for( i in 1:2 )
{
  filename = paste(index[i],".csv",sep="")
  temp = read.csv(filename)
  price = data.frame( price, temp[,2] )
  print( summary(temp[,2]) )
  plot( temp[,2] )
}






