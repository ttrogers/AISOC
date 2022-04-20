function(w){
	nrc <- get_sentiments("nrc")
	eord <- c(4,1,3,6,8,2,10,7,5,9) #Reasonable ordering for emotions

	#Get text from URL paragraph objects
	words <- read_html(w) %>%
				html_nodes("p") %>%
				html_text()
	
	#Define stop words
	data(stop_words)
	
	#Convert to tiblle and strip out stop words
	wt <- tibble(line = 1:length(words), words) %>%
		unnest_tokens(word, words) %>%
		anti_join(stop_words)
	
	scnt <- inner_join(wt, nrc) %>% count(sentiment)
	scnt[eord,]
}
