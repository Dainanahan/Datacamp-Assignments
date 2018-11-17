# Code for the first task
# It should consist of up to 10 lines of code (not including comments)
# and take at most 5 seconds to execute on an average laptop.


# ************
# CODE
# 
# You will create a cumulative plot starting from "2005-06-13" all the way till 
# the current day. It will be a line graph containing four different plots for 
# the four different statistics (X-axis = 'created' column of the 'drugs' data 
# frame, Y-axis = the different stats mentioned above). The values of the 
# different statistics at the current date should match those displayed at the 
# following link:
# https://www.drugbank.ca/stats
# 
# Wanna do something different?
# Figures 1c/1d of the paper, [2007] Drug-Target Network, offer an alternative 
# way of displaying the same above information; a bar graph for each year with 
# the bars being filled by subcategories. In this case, you will split the above
# cumulative graph into two bar plots because while the drugs are either 
# small-molecule or biotech (i.e. mutually exclusive), the 'approved' categories
# intersects with both (i.e. there are approved and non-approved biotech drugs 
# as well as approved and non-approved small-molecule drugs):
# - plot 1 --> bar length: #drugs in this year, each bar containing two 
#   sub-categories (small-molecule, biotech)
# - plot 2 --> bar length: #drugs in this year, each bar containing two 
#   sub-categories (approved, non-approved)
# 
# Wanna do something fancy?
# Let it be an interactive plot! Here's what it may look like. Depending on the 
# position of the mouse cursor, display a vertical line there along with a tool 
# tip that shows this info:
# - The value on the x-axis (i.e. the creation date)
# - The values of all the different stats at this date
# - (optional) log-scale y-axis?
# Need inspiration?  -->  check out these links:
# - https://www.r-graph-gallery.com/129-use-a-loop-to-add-trace-with-plotly/
# - https://www.r-graph-gallery.com/interactive-charts/
# - https://moderndata.plot.ly/interactive-r-visualizations-with-d3-ggplot2-rstudio/
# - https://www.r-graph-gallery.com/get-the-best-from-ggplotly/
# - https://www.datacamp.com/courses/ggvis-data-visualization-r-tutorial
# - https://www.statmethods.net/advgraphs/interactive.html
# 
# Wanna do something sneaky? (keep as last resort, we may not need this)
# Let tasks 1 and 2 be the same visualization, but the first is static and the 
# second is interactive. In the second, you can add check boxes to toggle on/off 
# some of the stats if the viz is getting crowded. You may also consider adding 
# more stats than what I mentioned above (e.g. #targets, #different subcategories 
# of targets, enzymes/carriers/transporters, #manufacturers, etc.). Again, check 
# the stats on the DrugBank website to make sure that the values of these stats 
# at the current date is correct (or close enough).
# 
# Finally
# If you're feeling creative, feel free to add your own touch. One other thing 
# that is worth mentioning is that there is some information that I couldn't 
# find in the files on the Git repo (most obvious is the drugs' market release 
# dates). What we have in the files is only the creation dates of their respective 
# records in the DrugBank database. For example, a drug released in 1982 would have 
# a creation date of "2005-06-13" as this is the date that the DrugBank database 
# was established. This is why, with the current data in the repo, we couldn't 
# display the visualization in Fig 1 of the paper: [2007] Drug-Target Network
# ************
# 
# 
# 
# ========================================================================
# 
# 
# 
# Code for the second task
# It should consist of up to 10 lines of code (not including comments)
# and take at most 5 seconds to execute on an average laptop.
# 
# 
# ************
# CODE
# 
# You will create a cumulative plot similar to the previous one, but with different 
# stats on the Y-axis. They are:
# - #targets
# - #membrane targets
# - #cytoplasm targets
# - #nucleus targets
# - #organelles targets
# - #exterior targets
# - #other targets?
# If one or two categories are particularly difficult/time-consuming to get, put 
# into "other targets". The information of which subcategories the targets belong 
# to will likely be in the Gene Ontology information of the targets. Unfortunately, 
# this information is probably external to DrugBank. If the above subcategories 
# are to tough to deal with, use the stats below instead:
# - #targets
# - #enzymes
# - #transporters
# - #carriers
# 
# Again...
# You may make this into an interactive plot if you wish (e.g. ggvis)
# 
# By the way...
# The following paper (Table 1) contains an evolution of the different stats of DrugBank over time:
# https://academic.oup.com/nar/article/46/D1/D1074/4602867
# ************
# 
# 
# 
# ========================================================================
# 
# 
# 
# Code for the third task
# It should consist of up to 10 lines of code (not including comments)
# and take at most 5 seconds to execute on an average laptop.


# ************
# CODE
# 
# You will create a network visualization similar to Fig 2 of the paper: 
# [2007] Drug-Target Network
# 
# I realize this may be too much to ask, but it would be cool if... (and you can 
# ignore this if it is too much):
# - the outputted visualization is modifiable by the user; i.e. there is a slider 
#   that the user can use to slide the time back and forth.
# - the user can drag components in the visualization as they please.
# 
# If it is more convenient for you, you can:
# - exclude drugs that are not approved (along with their targets)
# - keep only targets of a specific category (e.g. membrane proteins) and their 
# interacting drugs
# - exclude drugs for which "created < 01-01-2010" to make data size more manageable
# - ...
# 
# Again...
# You may make this into an interactive plot if you wish (or not).
# ************