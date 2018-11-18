lapply(c("tidyverse", "lubridate"), require, character.only = TRUE)

# ================================================

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

# ================================================

drugs <- read_csv("drugs.csv")
groups <- read_csv("groups.csv")
targets <- read_csv('targets.csv')

## get all actual groups
get_all_actual_groups <- function(x) {
    ## apply the 'get_actual_group' function to each drug
    x <- sapply(x, get_actual_group)
    
    ## return the actual groups for all drugs
    x
}

## get actual group for a single drug
get_actual_group <- function(x) {
    ## withdrawn > approved > investigational > experimental > other
    if (grepl('withdrawn', x)) {               actual_group <- 'withdrawn'
    } else if (grepl('approved', x)) {         actual_group <- 'approved'
    } else if (grepl('investigational', x)) {  actual_group <- 'investigational'
    } else if (grepl('experimental', x)) {     actual_group <- 'experimental'
    } else {                                   actual_group <- 'other'}
    
    ## return actual final tag for the drug
    actual_group
}

drugbank <- 
    drugs %>% 
    select(primary_key, created, type) %>% 
    rename(parent_key = primary_key,
           creationDate = created)

groups <- 
    groups %>% 
    group_by(parent_key) %>%
    summarise(allgroups = paste(text, collapse=';')) %>%
    mutate(final_group = get_all_actual_groups(allgroups)) %>% 
    select(-allgroups) %>% 
    rename(status = final_group)

targets <- 
    targets %>%
    group_by(parent_key) %>%
    summarise(targets = paste(id,collapse = ';'))
    
drugbank <- 
    drugbank %>% 
    left_join(groups, by = 'parent_key') %>% 
    left_join(targets, by = 'parent_key') %>% 
    rename(drug = parent_key) %>% 
    select(drug,creationDate,type, status, targets)

write_csv(drugbank, 'drugbank.csv')

# ================================================

## plot actual groups of the drugs
groups %>% 
group_by(status) %>% 
summarize(count = n()) %>%
ggplot(aes(x = reorder(status,count), 
           y = count, 
           fill = letters[1:5])) +    ## alternative: fill = count
geom_bar(stat = "identity") + 
guides(fill=FALSE) +    ## removes legend for the bar colors
coord_flip()            ## switches the X and Y axes

# ================================================

## get status Data
statusData <- 
    drugbank %>% 
    mutate(creationDate = year(creationDate)) %>% 
    group_by(creationDate,status) %>% 
    summarise(count = n()) %>% 
    spread(status,count) %>% 
    ungroup()    # avoids trouble later when plotting using plotly

# remove any NA values that resulted from the spread() operation
statusData[is.na(statusData)] <- 0

### get plot of the quantities of the different drug statuses over time
#p2 <- 
#    statusData %>% 
#    plot_ly(  x = ~creationDate, y = ~cumsum(experimental),    type = 'scatter', mode = 'lines', name = 'experimental', height = 700) %>% 
#    add_trace(x = ~creationDate, y = ~cumsum(investigational), type = 'scatter', mode = 'lines', name = 'investigational') %>% 
#    add_trace(x = ~creationDate, y = ~cumsum(approved),        type = 'scatter', mode = 'lines', name = 'approved') %>% 
#    add_trace(x = ~creationDate, y = ~cumsum(withdrawn),       type = 'scatter', mode = 'lines', name = 'withdrawn') %>% 
#    add_trace(x = ~creationDate, y = ~cumsum(other),           type = 'scatter', mode = 'lines', name = 'other') %>% 
#    layout(title = 'Drug Status',  xaxis = list(title='Time'), yaxis = list(title='Quantity'))

### display plot
#embed_notebook(p2)

statusData %>% 
ggplot(aes(x = creationDate)) + 
geom_line(aes(y = cumsum(approved), col = 'approved')) + 
geom_line(aes(y = cumsum(experimental), col = 'experimental')) + 
geom_line(aes(y = cumsum(investigational), col = 'investigational')) + 
geom_line(aes(y = cumsum(withdrawn), col = 'withdrawn')) + 
geom_line(aes(y = cumsum(other), col = 'other')) + 
#scale_y_continuous(limits = c(0,12000)) + 
xlab('Time') + 
ylab('Quantity') + 
labs(title = 'Drug Status',
     subtitle = 'Proportions of the different status values over time', 
     caption = 'created by ggplot')

# ================================================

## cumulative bar chart (unfinished)
drugs %>% 
ggplot(aes(x = factor(year(created)), y = cumsum(..count..))) +
geom_bar()

# ================================================

## get status Data
statusData <- 
    drugbank %>% 
    mutate(creationDate = year(creationDate)) %>% 
    group_by(creationDate, status) %>% 
    summarise(count = n()) %>% 
    spread(status, count) %>% 
    ungroup()    # avoids trouble later when plotting using plotly

# remove any NA values that resulted from the spread() operation
statusData[is.na(statusData)] <- 0

## get plot of the quantities of the different drug statuses over time
p2 <- 
    statusData %>% 
    plot_ly(  x = ~creationDate, y = ~cumsum(experimental),    type = 'scatter', mode = 'lines', name = 'experimental') %>% 
    add_trace(x = ~creationDate, y = ~cumsum(investigational), type = 'scatter', mode = 'lines', name = 'investigational') %>% 
    add_trace(x = ~creationDate, y = ~cumsum(approved),        type = 'scatter', mode = 'lines', name = 'approved') %>% 
    add_trace(x = ~creationDate, y = ~cumsum(withdrawn),       type = 'scatter', mode = 'lines', name = 'withdrawn') %>% 
    add_trace(x = ~creationDate, y = ~cumsum(other),           type = 'scatter', mode = 'lines', name = 'other') %>% 
    layout(title = 'Drug Status',  xaxis = list(title='Time'), yaxis = list(title='Quantity'))

## display plot
p2

# NOTE: use embed_notebook(p2) if displaying in a jupyter notebook

# ================================================
# How drugs are connected to drugs
targets <- read_csv("targets.csv")
targets %>% select(id, parent_key) %>% group_by(parent_key) %>% summarise(count = n()) %>% top_n(10) %>% arrange(desc(count))  %>% as_tibble() %>%ggplot(aes(x=parent_key, y=count, size=count, color=factor(count))) +geom_point(alpha=0.4) + scale_size_continuous( trans="exp", range=c(4, 25)) +
  xlab("Drugs") +
  labs( size = "Top 10 drugs targets count" ) + scale_size_continuous(range = c(0.5, 16))

# a look at target actions
target_actions <- read_csv("target_actions.csv")
target_actions %>% group_by(text) %>% summarise(count = n()) %>% ggplot(aes(area=count, label=text, fill = factor(count))) +
  geom_treemap()+  geom_treemap_text(fontface = "italic", colour = "white", place = "centre",grow = TRUE)