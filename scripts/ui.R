library(shiny)
library(leaflet)
library(shinyMobile)


# shinyUI(f7Page(
#   title="ICGCMaps by Adrià Cos",
#   tags$script('
#       $(document).ready(function () {
#         navigator.geolocation.getCurrentPosition(onSuccess, onError);
#               
#         function onError (err) {
#           Shiny.onInputChange("geolocation", false);
#         }
#               
#         function onSuccess (position) {
#           setTimeout(function () {
#             var coords = position.coords;
#             console.log(coords.latitude + ", " + coords.longitude);
#             Shiny.onInputChange("geolocation", true);
#             Shiny.onInputChange("lat", coords.latitude);
#             Shiny.onInputChange("long", coords.longitude);
#           }, 1100)
#         }
#       });
#               '),
#   f7SingleLayout(
#     navbar = f7Navbar(
#       title="ICGCMaps by Adrià Cos",
#       hairline=FALSE,
#       shadow = TRUE
#     ),
#     f7Panel(
#       leafletOutput("map", height=624),
#       
#       inputId=NULL,
#       title=NULL,
#       side=c("left","right"),
#       theme=c("dark","light"),
#       effect=c("reveal","cover"),
#       resizable = FALSE,
#       
#       
#     ),
#     toolbar=f7Toolbar(
#       position = "bottom",
#       actionButton("refresh","refresh"),
#     )
#   )
# ))

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





