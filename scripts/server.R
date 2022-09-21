
library(shiny)
library(sqldf)
library(shiny)

source("create_map.R")

shinyServer(function(input, output, session) {
  
  output$map <- renderLeaflet(
    if(input$geolocation==T){
      create_map(input$lat,input$long)
    }
  )
  
  #toListen <- reactive({
  #  list(input$lat,input$long)
  #})
  observeEvent(input$refresh, {
    output$map <- renderLeaflet(
      if(input$geolocation==T){
        create_map(input$lat,input$long)
      }
    )
  })
})
