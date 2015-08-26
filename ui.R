library(shiny)
if (!exists("all_cities")) all_cities = readRDS("data/cities.rds")
if (!exists("usa_cities")) usa_cities = readRDS("data/usa_cities.rds")
if (!exists("usa_cities")) usa_cities = readRDS("data/brazil_cities.rds")


shinyUI(fluidPage(
  tags$head(
    tags$link(rel="stylesheet", type="text/css", href="custom_styles.css")
  ),
  
  title = "Cálculo de Rotas com baixo Custo Computacional",
  
  tags$h2(tags$a(href="/traveling-salesman", "Cálculo de Rotas", target="_blank")),
  
  plotOutput("map", height="550px"),
  
  fluidRow(
    column(5,
      tags$ol(
        tags$li("Personalize a lista de cidades , baseado no mapa mundial ou no mapa do Brasil"),
        tags$li("Ajuste os parâmetros do método de arrefecimento ao seu gosto"),
        tags$li("Click no botão Resolver")
      )
    ),
    column(3,
      tags$button("Resolver", id="go_button", class="btn btn-info btn-large action-button shiny-bound-input")
    ),
    column(3,
      HTML("<button id='set_random_cities_2' class='btn btn-large action-button shiny-bound-input'>
              <i class='fa fa-refresh'></i>
              Definir cidades aleatoriamente
            </button>")
    ), class="aaa"
  ),
  
  hr(),
  
  fluidRow(
    column(5,
      h4("Selecione um mapa"),
      selectInput("map_name", NA, c("World", "Brazil"), "World", width="100px"),
      p("Escreva abaixo o nome das cidades, ou", actionButton("set_random_cities", "Definir Aleatoriamente", icon=icon("refresh"))),
      selectizeInput("cities", NA, all_cities$full.name, multiple=TRUE, width="100%",
                     options = list(maxItems=30, maxOptions=100, placeholder="Start typing to select some cities...",
                                    selectOnTab=TRUE, openOnFocus=FALSE, hideSelected=TRUE)),
      checkboxInput("label_cities", "Colocar rótulos das cidades no mapa?", FALSE)
    ),
    
    column(2,
      h4("Parâmetros do Arrefecimento"),
      inputPanel(
        numericInput("s_curve_amplitude", "Amplitude da curva S", 4000, min=0, max=10000000),
        numericInput("s_curve_center", "Centro da curva S", 0, min=-1000000, max=1000000),
        numericInput("s_curve_width", "Largura da curva S", 3000, min=1, max=1000000),
        numericInput("total_iterations", "Número de Iterações da Execução", 25000, min=0, max=1000000),
        numericInput("plot_every_iterations", "Desenhar no mapa a cada n iterações", 1000, min=1, max=1000000)
      ),
      class="numeric-inputs"
    ),
    
    column(5,
      plotOutput("annealing_schedule", height="260px"),
      plotOutput("distance_results", height="260px")
    )
  )
))
