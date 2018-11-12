lapply(c("tidyverse", "lubridate"), require, character.only = TRUE)

# read drugs
drugs <- read_csv("drugs.csv")
groups <- read_csv("groups.csv")

# types distribution
drugs %>% 
  select(created, type) %>% 
  group_by(type) %>%
  ggplot(aes(x = factor(year(created)), fill = type)) +
  geom_bar() +
  labs(title = "Biotech vs. Small Molecule",
       x = "Year",
       y = "Number of drugs",
       fill = "Drug Types")

# types increase
drugs %>% 
    select(created, type) %>% 
    group_by(type, year(created)) %>% 
    summarize(n = n()) %>% 
    mutate(count = cumsum(n)) %>% 
    ggplot(aes(x = `year(created)` , y = count, col = type)) +
    geom_line() +
    labs(title = "Biotech and Small Molecule increase over time",
         x = "Year",
         y = "Number of drugs",
         fill = "Drug Types")

# groups distributions
groups %>% 
    group_by(text) %>% 
    summarize(count = n()) %>%
    ggplot(aes(x = text, y = count, fill = count)) +
    geom_bar(stat = "identity") + 
    coord_flip()
   
# groups distributions by drug type
drugs %>% 
    select(primary_key, type) %>% 
    full_join(groups, by = c("primary_key" = "parent_key")) %>% 
    group_by(text, type) %>% 
    summarize(count = n()) %>%
    ggplot(aes(x = text, y = count, fill = type)) +
    geom_bar(stat = "identity", position = "dodge2") + 
    coord_flip()
 
# take glimpse
glimpse(drugs)

# drug types
table(as.factor(drugs$type))

# drug state
table(as.factor(drugs$state))

# top products
drugs %>% select(name, products_count) %>% top_n(10) %>% arrange(desc(products_count))

# top manufacturers
drugs %>% select(name, manufacturers_count) %>% top_n(10) %>% arrange(desc(manufacturers_count))

# top prices
drugs %>% select(name, prices_count) %>% top_n(10) %>% arrange(desc(prices_count))

# cateogries count
drugs %>% select(name, categories_count) %>% top_n(10) %>% arrange(desc(categories_count))

# food interactions
drugs %>% select(name, food_interactions) %>% top_n(10) %>% arrange(desc(food_interactions))

# drug interaction
drugs %>% select(name, drug_interactions_count) %>% top_n(10) %>% arrange(desc(drug_interactions_count))

# reactions count
drugs %>% select(name, reactions_count) %>% top_n(10) %>% arrange(desc(reactions_count))

# target count
drugs %>% select(name, targets_count) %>% top_n(10) %>% arrange(desc(targets_count))

# affected organizms
drugs %>% select(name, affected_organisms_count) %>% top_n(10) %>% arrange(desc(affected_organisms_count))
