# Shiny GA Map

This repo is part of a post detailing how to create a custom Google Analytics Shiny app [found here](https://compassred.shinyapps.io/shiny_ga_map/).

In order to run, make the following changes:

- `global.R`:  create/set your own client ID/secret from GCP and set your own Mapbox token
- `ui.R`: uncomment  `googleAuthUI()` and remove the placeholder below
- `server.R`: uncomment the `ga_data()` reactive variable and remove the placeholder below
