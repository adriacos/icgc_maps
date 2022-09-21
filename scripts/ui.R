library(shiny)
library(shinyjs)
library(leaflet)


shinyUI(fluidPage(
  
  # Application title
  titlePanel("ICGCMaps"),
  
  tags$script('
      $(document).ready(function () {
        navigator.geolocation.getCurrentPosition(onSuccess, onError);
              
        function onError (err) {
          Shiny.onInputChange("geolocation", false);
        }
              
        function onSuccess (position) {
          setTimeout(function () {
            var coords = position.coords;
            console.log(coords.latitude + ", " + coords.longitude);
            Shiny.onInputChange("geolocation", true);
            Shiny.onInputChange("lat", coords.latitude);
            Shiny.onInputChange("long", coords.longitude);
          }, 1100)
        }
      });
              '),
  
  verticalLayout(
    actionButton("refresh","refresh"),
    leafletOutput("map", height=624),
    conditionalPanel('false', column(width = 5,
                                     verbatimTextOutput("lat"),
                                     verbatimTextOutput("long"),
                                     verbatimTextOutput("geolocation"),
                                     verbatimTextOutput("accuracy"),
                                     verbatimTextOutput("time")))
  )
))





