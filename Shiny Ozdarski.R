dane <- read.csv(file = "D:/aaaOzdar/kolokwiumR/Dane_R.csv")




library(shinythemes)
library(ggplot2)
library(shiny)
library(leaflet)
library(RColorBrewer)
library(knitr)
library(maps)
library(rvest)
library(stringr)
library(stringi)

ui<-fluidPage(title = "Oferty pracy Warszawa",theme = shinytheme("cerulean"),
              h1(textOutput("currentTime")),h5(textOutput("oferty")),
              
              headerPanel("Oferty pracy w IT w Warszawie, z podzia³em na dzielnice."),
              
              sidebarPanel(sliderInput(inputId = "slider",label = "Choose number of Id",min = 1,max=length(dane[,1]),step = 1,value = 1)),
              selectInput(inputId = "select",label = ("Choose Value"),choices = c("Dzielnica" = 1,"Stanowisko" = 2,"Wynagrodzenie" = 3)),
              
              
              
              
              
              
              mainPanel(
                
                tabsetPanel(
                  
                  tabPanel(title = "Dane",
                           fluidRow(column(12, verbatimTextOutput("value")))),
                  
                  tabPanel("BoxPlot",plotOutput("box",width = 850,height = 500)),
                  
                  tabPanel("Raport",uiOutput('markdown', width = 850,height = 500))
                  
                  
                )
                
              )
          
              
)


server<-function(input,output,session)
{

  output$value<-renderPrint(dane[input$slider,as.numeric(input$select)])
  
  Legend <- data[,1]
  library(ggplot2)
  hgg<-ggplot(data = data,aes(x=data[3]))
  hgg2<-hgg + geom_histogram(binwidth = 300,aes(fill=Legend),colour = "black") + xlab(colnames(data)[3]) + ylab("Count")
  
  
  output$box <- renderPlot(hgg2)
  
  output$markdown <- renderUI({
    HTML(markdown::markdownToHTML(knit('D:/aaaOzdar/kolokwiumR/MarkDown Lukasz Ozdarski.Rmd', quiet = FALSE)))
  })
  
  output$currentTime <- renderText({
    invalidateLater(1000, session)
    paste("", Sys.time())
  }) 
  
}


shinyApp(ui,server)