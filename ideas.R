# read drugs
drugs <- read_csv("drugs.csv")

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
