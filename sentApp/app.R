library(shiny)
library(tidytext)
library(dplyr)
library(rvest)
library(textdata)
library(readr)


# Define UI for app that draws a histogram ----
ui <- fluidPage(
  
  # App title ----
  titlePanel("Sent-O-Meter"),
  
  # Sidebar layout with input and output definitions ----
  sidebarLayout(
    sidebarPanel(
    
    helpText("Evaluates the sentiment at a given URL."),
    
    textInput("url", 
              label = "Enter URL here.", 
              width = "100%",
              placeholder="https://my_awesome_webpage"
              ),
    
    actionButton("submit", "Submit")
    ),
  
    # Main panel for displaying outputs ----
    mainPanel(
      plotOutput("plot_data")
    )
  )
)

# Define server logic to render sentiment chart ----
server <- function(input, output) {
	#Get NRC database
	#if(!exists("nrc")) nrc <- get_sentiments("nrc")
	if(!exists("nrc")) nrc <- read_csv("nrc.csv")

	#Define stop words
	data(stop_words)

	#Colors for different emotions
	ecol <- c("orange","red","brown","black","blue","cyan","gray","white","yellow","limegreen")


	#Define functions here
	get.sentiment <- function(w){
		eord <- c(4,1,3,6,8,2,10,7,5,9) #Reasonable ordering for emotions

		#Get text from URL paragraph objects
		words <- read_html(w) %>%
					html_nodes("p") %>%
					html_text()
		
		
		#Convert to tibble and strip out stop words
		wt <- tibble(line = 1:length(words), words) %>%
			unnest_tokens(word, words) %>%
			anti_join(stop_words)
		
		scnt <- inner_join(wt, nrc) %>% count(sentiment)
		scnt[eord,]
	}

	#Make sure action only happens when submit is clicked
	plot_reactive = eventReactive(input$submit, {
		#Use custom function to get sentiment scores
		get.sentiment(input$url)
		
		#Below is for debugging
		#tibble(sentiment = c("a","b","c","d","e"), n = c(1:5))
		})
		
	output$plot_data = renderPlot({
		pdat <- plot_reactive()
		#Generate pie chart		
		pie(pdat$n, pdat$sentiment, col = ecol)
	})
		
}
	


shinyApp(ui, server)
