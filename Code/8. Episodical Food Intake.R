# SPADE course July 2025
# 8. Episodical Food Intake

# load SPADE package
library(SPADE.RIVM)

# load example data
data("DNFCSmanual")

# Exercise 1a
# Try to run 1part for syn_fol (should give error because too many zeroes)
f.spade(
  frml.ia = syn_fol ~ fp(age), 
  frml.if = "no.if", 
  data = DNFCSmanual, 
  min.age = 7, 
  max.age = 69, 
  sex.label = "female",
  seed = 10,
  spade.output.path = "SPADE Output - 8. Episodical Food Intake",
  output.name = "exercise_1a"
)

# Exercise 1b
# potato intake 55yr old women
f.spade(
  frml.ia   = potato ~ fp(age), # formula for intake amounts (ia) 
  frml.if   = potato ~ cs(age), # formula for intake frequencies (if)
  data      = DNFCSmanual,
  min.age   =  1,
  max.age   = 79,
  age.classes = c(54, 55), # age-group of only 55 year
  sex.label = "female",
  seed      = 10, 
  spade.output.path = "SPADE Output - 8. Episodical Food Intake",
  output.name = "exercise_1b"
  )
