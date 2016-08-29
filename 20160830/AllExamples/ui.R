
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)
source('./TestAndRegression/ReFit.R')
source('./SVM/TestSVM.R')

shinyUI(navbarPage("GOLD and FX",
                   tabPanel("Regression and Test",
                            sidebarLayout(
                              sidebarPanel(
                                selectInput("selectFX", label = h2("Select FX"), 
                                            choices = list("EUR" = 2, "GBP" = 3,
                                                           "USD" = 4)),
                                checkboxGroupInput("Type", label=h2("Targets"),
                                                   choices=list("GOLD"=5,
                                                                "EUR"=2,
                                                                "GBP"=3,
                                                                "USD"=4),
                                                   selected = 2),
                                actionButton("SelectAll", label = "SelectAll"),
                                actionButton("DelAll", label = "DelAll")),
                              mainPanel(
                                plotOutput("fxToGold"),
                                dataTableOutput("fxTest"),
                                plotOutput("allPrices"),
                                plotOutput("regression"))
                            )
                   ),
                   tabPanel("SVM",
                            mainPanel(
                              dataTableOutput("svmResult")
                            ))
))
