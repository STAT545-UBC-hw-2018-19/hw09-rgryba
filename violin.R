library(tidyverse)
words <- readLines("words.txt")
words <- enframe(words) #convert to tibble
#create table of length of words by letter
letterLength <- words %>%
	select(-"name") %>%
	mutate_at(.vars = "value", .funs = tolower) %>% #convert to all lowercase
	mutate(start = substr(value, 1, 1), #get first letter of each word
				 length = nchar(value)) #get length of each word

#violin plots of word lenths for each letter
plotLength <- ggplot(letterLength, aes(as.factor(start), length)) +
	geom_violin() +
		xlab("Starting letter of word") +
		ylab("Word length") +
		theme_bw()

ggsave("plotLength.png")

write.table(letterLength, "letterLength.tsv",
						sep = "\t", row.names = FALSE, quote = FALSE)




	


				 