library(here)
library(tidyverse)
library(tidytext)
library(wordcloud2)
library(janeaustenr)

original_books <- austen_books() %>% 
  group_by(book) %>%
  mutate(line = row_number(),
         chapter = cumsum(str_detect(text, regex("^chapter [\\divxlc]", #count
                                                 ignore_case = TRUE)))) %>%
           ungroup()#ignore
 #ungroup it so we have a dataframe again

#dont try to view the entire things, its >73000 lines

head(original_books)

tidy_books <- original_books %>%
  unnest_tokens(output = word, input = text) #add a column named word

head(tidy_books) #there are now >725,00 rows. dont view the entire thing!

cleaned_books <- tidy_books %>%
  anti_join(get_stopwords()) #datadframe without the stopwords

### Joining,by = "word"

head(cleaned_books)


cleaned_books %>%
  count(word, sort = TRUE)

sent_word_counts <- tidy_books %>%
  inner_join(get_sentiments()) %>% #only keep pos or negative words
  count(word, sentiment, sort = TRUE) #count them

sent_word_counts %>%
  filter(n > 150) %>% #take only if there are over 150 instances of it 
  mutate(n = ifelse(sentiment == "negative", -n, n)) %>% #add a column where if the word is negagive make the count negative
  mutate(word = reorder(word, n)) %>% #sort it so it goes from largest to smallest
  ggplot(aes(word, n, fill = sentiment)) +
  geom_col() +
  coord_flip() +
  labs(y = "Contribution to sentiment")

head(sent_word_counts)

words<-cleaned_books %>%
  count(word) %>% #count all the words
  arrange(desc(n))%>% # sort the words
  slice(1:100) #take the top 100

wordcloud2(words, shape = 'tiangle', size=0.3) #make a word cloud

