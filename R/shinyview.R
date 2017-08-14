#' Display a data.frame through a Shiny application.
#'
#' @param df data.frame. The data to display.
#' @param open logical. Whether to automatically open the web page view system call.
#' @export
#' @examples
#' \dontrun{
#'   shiny_view(iris) # Will open a nice web page to browse through the iris dataset.
#' }
shiny_view <- function(df) {
  tempdir <- testthatsomemore::create_file_structure()
  testthatsomemore::within_file_structure(dir = tempdir, list(
    server.R = paste0('shiny::shinyServer(function(input, output) { ',
       'output$data <- shiny::renderDataTable({ readRDS("',
       datapath <- file.path(tempdir, 'data'), '") }) })'),
    ui.R = paste0(' shiny::shinyUI(shiny::bootstrapPage(shiny::mainPanel({ shiny::dataTableOutput("data") }))) ')), {
    saveRDS(df, datapath)
    shiny::runApp(tempdir)
  })
}
