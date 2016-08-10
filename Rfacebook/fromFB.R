#install.packages("devtools")
library(devtools)
#install_github("Rfacebook", "pablobarbera", subdir="Rfacebook")
library(Rfacebook)

token <- ""
me = getUsers("me", token, private_info = TRUE)
my_friends <- getFriends(token=token, simplify=TRUE)

for(i in 1:10)
{
  user = getUsers(my_friends$id[i], token, private_info = TRUE)
  print(user)
}

