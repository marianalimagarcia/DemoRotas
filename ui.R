library(shiny)
if (!exists("all_cities")) all_cities = readRDS("data/cities.rds")
if (!exists("usa_cities")) usa_cities = readRDS("data/usa_cities.rds")
if (!exists("brazil_cities")) brazil_cities = readRDS("data/brazil_cities.rds")


shinyUI(fluidPage(
  tags$head(
    tags$link(rel="stylesheet", type="text/css", href="custom_styles.css")
  ),
  
  title = "Demo Siqueira Campos Associados",
  
  tags$h2("Demo Siqueira Campos Associados"),
  tags$h2("Cálculo de Rotas"),
  
  fluidRow(
    column(6,
	plotOutput("map", height="550px"))
	,
	column(3,
#     h4("Selecione um mapa"),
#     selectInput("map_name", NA, c("World", "Brazil"), "Brazil", width="100px"),
      h4("Escreva abaixo o nome das cidades, ou", actionButton("set_random_cities", "Defina Aleatoriamente", icon=icon("refresh"))),
	  
      selectizeInput("cities", NA, brazil_cities$full.name, multiple=TRUE, width="100%",
                     options = list(maxItems=30, maxOptions=100, placeholder="Start typing to select some cities...",
                                    selectOnTab=TRUE, openOnFocus=FALSE, hideSelected=TRUE)),
      checkboxInput("label_cities", "Colocar nomes das cidades no mapa?", FALSE), tags$button("Calcular Rotas", id="go_button", class="btn btn-large action-button shiny-bound-input")
	  
    ),
	column(2,
      h4("Parâmetros do Arrefecimento"),
      inputPanel(
        numericInput("s_curve_amplitude", "Amplitude da curva S", 4000, min=0, max=10000000),
        numericInput("s_curve_center", "Centro da curva S", 0, min=-1000000, max=1000000),
        numericInput("s_curve_width", "Largura da curva S", 3000, min=1, max=1000000),
        numericInput("total_iterations", "Número de Iterações da Execução", 25000, min=0, max=1000000),
        numericInput("plot_every_iterations", "Número de iterações por desenho", 1000, min=1, max=1000000)
        
	  ),
      class="numeric-inputs"
    )
	
	),
	
#  fluidRow(
#
#  column(3,
#      tags$button("Calcular Rotas", id="go_button", class="btn btn-large action-button shiny-bound-input")
#    ),
#    column(3,
#      HTML("<button id='set_random_cities_2' class='btn btn-large action-button shiny-bound-input'>
#              <i class='fa fa-refresh'></i>
#              Defina aleatoriamente
#            </button>")
#    ),
#	class="aaa"
#  ),
  
#  hr(),
  
  fluidRow(
   column(5,
      plotOutput("annealing_schedule", height="260px")),
   column(5,
      plotOutput("distance_results", height="260px")
    )
  )
))
