rm(list=ls(all=TRUE))
library(XML)
library(bitops)
library(RCurl)
library(NLP)
library(httr)


#Sys.setlocale("LC_ALL", "cht")


alldata = read.csv('./wordcloud/alldata.csv')
orgURL = 'http://www.boxofficemojo.com'
alldataResult = data.frame()
errorid = c()
for( i in 30:35 )#1:length(alldata$link))
{
  tempdata= data.frame
  pttURL <- paste(orgURL, alldata$link[i], sep='')
  urlExists = url.exists(pttURL)
  
  print(i)
  
  if(urlExists)
  {
    html = getURL(pttURL, ssl.verifypeer = FALSE, encoding='UTF-8')
    xml = htmlParse(html, encoding='UTF-8')
    
    #saveXML(xml, "test.html")
    
    tryCatch({
      budg = xpathSApply(xml, "//div[@id='body']/table", xmlValue)
      start = gregexpr("Budget", budg)
      testbudg = substr(budg, start[[1]][1], start[[1]][1]+30)
      testbudg = gsub('\n','',testbudg)
      testbudg = gsub('\t','',testbudg)
      testbudg = gsub(' ','',testbudg)
      testbudg = gsub('[A-Za-z]','',testbudg)
      testbudg = gsub(':','',testbudg)
      testbudg = gsub('.','',testbudg)
      budg = gsub('$','',testbudg)
      tempdata = data.frame(budg)},
      error = function(e) {
        errorid = rbind(errorid, i)
        tempdata = data.frame(i)})

    
    #dis = xpathSApply(xml, "//td[1]/b/a", xmlValue)
    #InR = xpathSApply(xml, "//table[3]/tbody/tr/td[2]", xmlValue)
    #open = xpathSApply(xml, "//div[2]/div[2]/table[1]/tbody/tr[1]/td[2]", xmlValue)
    #char = xpathSApply(xml,"//center/table/tbody/tr[3]/td[1]", xmlValue)
  }
  alldataResult = rbind(alldataResult, tempdata)
}
write.csv(alldataResult,"./wordcloud/alldata2.csv")