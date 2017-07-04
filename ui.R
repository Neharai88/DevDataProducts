library(shiny)

dataType <- c("Select","URBAN", "RURAL","TOTAL")
data_graf <- c("Select","Male","Female", "Types", "Age group")

fluidPage(
  pageWithSidebar(
    headerPanel("Main Workers Classification of Bangalore -1991"),
    
    sidebarPanel(
      helpText("Please choose the Type to see the sample of Main Workers data by different category",
               "in a table form."),
      selectInput("dataType", label = "Select Type", choices = dataType),
      helpText("Please click PLOT Main Workers tab to see the graph.",
               "The plot display the general trend of Main Workers",
               "in Bangalore of the years 1991."),
      selectInput("graf1", label = "Select plot type", choices = data_graf),
      br(),
      a(href = "https://github.com/Neharai88/DevDataProducts.git", "The Shiny apps Source code")
    ),
    mainPanel(
      tabsetPanel(
        tabPanel("DISPLAY TABLE", tableOutput("data_table")),
        tabPanel("PLOT CASES", plotOutput("data_plot")))
    )
  )
)