library(rvest)
library(stringr)
kontener<-data.frame()

for (a in 1:5) {
  
  url1<-"https://www.gumtree.pl/s-programisci-informatyka-i-internet/warszawa/page-"
  url2<-"/v1c9005l3200008p"
  
  
  u1<-paste(url1,a,sep = "")
  u2<-paste(u1,url2,sep="")
  url<-paste(u2,a,sep = "")
  
  
  link <- read_html(url)
  
  
  h<-html_nodes(link,'div .category-location')
  dane<-html_text(h)
  dane<-str_trim(dane)
  
  
  for (i in 1:length(dane)) {
    dana <- unlist(strsplit(dane[i], split=","))
    kontener[i+(23*(a-1)),1]<-dana[length(dana)]
  }
}


for (a in 1:5) {
  
  url1<-"https://www.gumtree.pl/s-programisci-informatyka-i-internet/warszawa/page-"
  url2<-"/v1c9005l3200008p"
  
  
  u1<-paste(url1,a,sep = "")
  u2<-paste(u1,url2,sep="")
  url<-paste(u2,a,sep = "")
  
  
  link <- read_html(url)
  
  
  h<-html_nodes(link,'div .href-link')
  dane<-html_text(h)
  dane<-str_trim(dane)
  
  
  for (i in 1:length(dane)) {
    kontener[i+(23*(a-2)),2]<-dane[i]
  }
}

a<-sample(4000:12000,length(kontener[,1]))


for (s in 1:length(kontener[,1])) {
  kontener[s,3]<-a[s]
}

colnames(kontener)<-c("Lokalizacja","Praca","Wynagrodzenie")

write.csv(kontener, file = "D:/aaaOzdar/kolokwiumR/Dane_R.csv",row.names=FALSE)

data <- read.csv(file = "D:/aaaOzdar/kolokwiumR/Dane_R.csv")

kontener