# SPADE course July 2025
# 3. Daily Food Intake
# SPADE 1-part model

# Load SPADE
library(SPADE.RIVM)

# Load example data (comes with SPADE package)
data("DNFCSmanual")

# Show columns in example data
str(DNFCSmanual)

### BASIC MODEL ###

# Exercises 1-3
# 1 part model SPADE - Most basic call
f.spade(
  frml.ia = ca ~ fp(age), # Intake amounts are dependent on age
  frml.if = "no.if", # No intake frequencies for daily intakes
  data = DNFCSmanual,
  min.age = 1,
  max.age = 79,
  sex.label = "female",
  seed = 29062025,
  spade.output.path = "SPADE Output - 3. Daily Food Intake",
  output.name = "output_exercise_1_to_3"
)

### BASIC MODEL WITH DRIs ###

# Exercise 4a
# calcium intake above UL for men 30-40

# Load UL data men (comes with package)
data("HC2018_UL.men")
# Show columns of UL data men
str(HC2018_UL.men)

# SPADE call
f.spade(
  frml.ia = ca ~ fp(age), # Model intake amounts dependent on age
  frml.if = "no.if", # Don't model intake frequencies
  data = DNFCSmanual,
  min.age = 1,
  max.age = 79,
  sex.label = "male",
  seed = 29062025,
  age.classes = c(29, 40),
  prb = c(0.25, 0.50, 0.75),
  weights.name = "w_demog_season_wk_wknd", # Use survey weights
  UL.names = "HC2018_UL.men", # UL data
  spade.output.path = "SPADE Output - 3. Daily Food Intake",
  output.name = "output_exercise_4a"
)

# Exercise 4b
# calcium intake girls 1-9 and 10-17, 10th, 50th 90th percentile

# Load data on EAR, AI and UL for women (comes with package)
data("HC2018_EAR.women")
data("HC2018_AI.women")
data("HC2018_UL.women")
# Show columns
str(HC2018_EAR.women)
str(HC2018_AI.women)
str(HC2018_UL.women)

# SPADE call
f.spade(
  frml.ia = ca ~ fp(age), # intake amounts age-dependent
  frml.if = "no.if",      # don't model intake frequencies (daily intakes)
  data = DNFCSmanual,
  min.age = 1,
  max.age = 79,
  sex.label = "female",
  seed = 29062025,
  age.classes = c(0, 8, 13, 17, 30, 50, 79),
  prb = c(0.05, 0.95),
  weights.name = "w_demog_season_wk_wknd", # Use survey weights
  EAR.names = "HC2018_EAR.women", # EAR data
  AI.names = "HC2018_AI.women",   # AI data
  UL.names = "HC2018_UL.women",   # UL data
  spade.output.path = "SPADE Output - 3. Daily Food Intake",
  output.name = "output_exercise_4b"
)

# Exercise 4c
# Compare calcium intake for men 30yr
# between age dependent and non age dependent modelling.
# Focus on proportion below EAR.

# Load EAR data men (comes with package)
data("HC2018_EAR.men")
# Show first 6 rows
head(HC2018_EAR.men)
# Show last 6 rows
tail(HC2018_EAR.men)

# SPADE call - age dependent Model
f.spade(
  frml.ia = ca ~ fp(age), # age dependent
  frml.if = "no.if",
  data = DNFCSmanual,
  min.age = 1,
  max.age = 79,
  sex.label = "male",
  seed = 29062025,
  age.classes = c(29, 30, 31),
  prb = c(0.25, 0.50, 0.75),
  weights.name = "w_demog_season_wk_wknd",
  EAR.names = "HC2018_EAR.men", # EAR data
  spade.output.path = "SPADE Output - 3. Daily Food Intake",
  output.name = "output_exercise_4c_age_dependent"
)

# SPADE call - age independent model
f.spade(
  frml.ia = ca ~ 1, # age independent
  frml.if = "no.if",
  data = DNFCSmanual,
  min.age = 1,
  max.age = 79,
  sex.label = "male",
  seed = 29062025,
  age.classes = c(29, 30, 31),
  prb = c(0.25, 0.50, 0.75),
  weights.name = "w_demog_season_wk_wknd",
  EAR.names = "HC2018_EAR.men", # EAR data
  spade.output.path = "SPADE Output - 3. Daily Food Intake",
  output.name = "output_exercise_4c_age_independent"
)

### BASIC MODEL WITH ADDITIONAL OPTIONS ###

# Exercise 5
# 1-part model SPADE - with age classes and percentiles

f.spade(
  frml.ia = ca ~ fp(age),
  frml.if = "no.if",
  data = DNFCSmanual,
  min.age = 1,
  max.age = 79,
  sex.label = "female",
  seed = 29062025,
  age.classes = c(0, 13, 17, 50, 79), # age-classes to report
  prb = c(1, 5, 10, 25, 50, 75, 90, 95, 99) / 100, # percentiles to report
  spade.output.path = "SPADE Output - 3. Daily Food Intake",
  output.name = "output_exercise_5"
)

# Excercise 6
# 1-part model SPADE -
# with age classes, percentiles, survey weights

f.spade(
  frml.ia = ca ~ fp(age),
  frml.if = "no.if",
  data = DNFCSmanual,
  min.age = 1,
  max.age = 79,
  sex.label = "female",
  seed = 29062025,
  weights.name = "w_demog_season_wk_wknd", # use survey weights
  age.classes = c(0, 13, 17, 50, 79), # age-classes to report
  prb = c(1, 5, 10, 25, 50, 75, 90, 95, 99) / 100, # percentiles to report
  spade.output.path = "SPADE Output - 3. Daily Food Intake",
  output.name = "output_exercise_6"
)

# Exercise 7
# 1-part model SPADE for vitd
# with age classes, percentiles, survey weights

f.spade(
  frml.ia = vitd ~ fp(age),
  frml.if = "no.if",
  data = DNFCSmanual,
  min.age = 1,
  max.age = 79,
  sex.label = "female",
  seed = 29062025,
  age.classes = c(0, 3, 6, 10, 14, 17, 50, 79), # age-classes to report
  prb = c(2.5, 5, 10, 25, 50, 75, 90, 95, 97.5) / 100, # percentiles to report
  weights.name = "w_demog_season_wk_wknd", # use survey weights
  spade.output.path = "SPADE Output - 3. Daily Food Intake",
  output.name = "output_exercise_7"
)
