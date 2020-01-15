#############################
#HEADER
#############################

header <- dashboardHeader(title = "Map Google Analytics")

favicon <-
    tags$head(tags$link(rel = "shortcut icon", href = "https://rstudio.com/favicon-32x32.png"))

#update page title
update_title <-
    tags$script(HTML("document.title = 'Map Google Analytics Data';"))

#############################
#SIDEBAR
#############################

sidebar <- dashboardSidebar(sidebarMenu(id = "menuItems",
                                        menuItem(
                                            "Query Data", tabName = "queryData", icon = icon("spinner")
                                        )))

#############################
#QUERY/PREVIEW DATA
#############################

main_tab <- tabItem(
    tabName = "queryData",
    favicon,
    update_title,
    h2("Google Analytics"),
    br(),
    fluidRow(
        box(
            title = "Query data from Google Analytics",
            # googleAuthUI("auth"),tags$br(),
            
            #remove below and use above code
            actionButton(
                inputId = "dummyBtn",
                label = "Sign in with Google",
                icon = icon("google"),
                style = "color: #fff; background-color: #438CBF; border-color: #438CBF"
            ),
            tags$p(tags$i(
                "Disabled for public app, mock data provided"
            )),
            
            
            authDropdownUI("authMenu"),
            selectizeInput(
                inputId = "segmentSelect",
                label = "Segment (optional)",
                choices = c("All Users")
            ),
            dateRangeInput(
                inputId = "dateRange",
                label = "Date Range Selection",
                start = Sys.Date() - 365,
                end = Sys.Date() - 1
            ),
            actionButton(inputId = "loadDataGABtn", label = "Query Data from GA", icon = icon("download"))
        ),
        box(title = "Raw Data (Top 15)",
            tableOutput("rawDataTable"))
    ),
    
#############################
#MAP OUTPUT
#############################
    
    fluidRow(
        box(
            title = "Map Output (uses deck.gl)",
            width = 12,
            deckgl::deckglOutput("mapOutput"),
            shiny::checkboxInput("settingsCheckbox", label = "Settings", FALSE)
        )
    ),
    fluidRow(
        box(
            id = "mapSettings",
            width = 12,
            colourInput("colorPicker", "Color", value = "green"),
            sliderInput(
                inputId = "radiusSlider",
                label = "Radius",
                min = 100,
                max = 10000,
                value = 1000,
                step = 100
            ),
            sliderInput("opacitySlider", label = "Opacity", 0, 1, .2, step = .1)
        )
    )
)

#############################
#BUILD
#############################

body <- dashboardBody(tags$head(
    tags$link(rel = "stylesheet", type = "text/css", href = "custom.css")
),
tabItems(main_tab))

footer <- dashboardFooter(
    left_text = tags$div(tags$a(tags$img(src="https://images.squarespace-cdn.com/content/5cf6c4ed5171fc0001b43190/1559677094095-SX3U72EDS7F7DIV6C9QY/CompassRed+primary.png?format=1500w&content-type=image%2Fpng",style="width:100%;height:100%;"), href = "https://www.compassred.com"),style="width:15%;"),
    right_text = tags$a("Lat/Long Data provided by Simple Maps", href = "https://simplemaps.com/data/us-cities")
)

ui <- dashboardPagePlus(header,
                        sidebar,
                        body,
                        footer = footer,
                        useShinyjs()
)
