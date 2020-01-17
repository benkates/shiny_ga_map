#load libraries
#note: use library() funs and not pacman if using shinyapps.io
if (!require(pacman)) install.packages('pacman')
pacman::p_load(
  shiny,
  shinydashboard,
  shinydashboardPlus,
  scales,
  shinyjs,
  googleAnalyticsR,
  googleAuthR,
  data.table,
  tidyverse,
  deckgl,
  colourpicker,
  grDevices,
  stringi,
  janitor
)

pacman::p_load_gh(
  "rstudio/fontawesome"
)

#set client ID + secret
gar_set_client(
  web_json = "client-web-id.json",
  scopes = c(
    "https://www.googleapis.com/auth/analytics",
    "https://www.googleapis.com/auth/analytics.readonly"
  )
)

#mapbox token, go to mapbox.com to create an accont/token
Sys.setenv(MAPBOX_API_TOKEN = "YOUR_MAPBOX_TOKEN")

lat_long_data <- read_csv("data/uscities.csv")