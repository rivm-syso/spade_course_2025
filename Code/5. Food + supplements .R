# SPADE course July 2025
# 5. Food + Supplements

# Load packages
library(dplyr) # Useful for data-frame manipulations
library(SPADE.RIVM) # SPADE package

# Load example data
data(DNFCSmanual)

##### SPADE for only supplements (f.spade.supplements) #####

# Example shown in presentation
f.spade.supplement(
  data = DNFCSmanual,
  frml.ia.supp = s_syn_fol ~ age,     # Formula for intake amounts model (age-dependent)
  frml.if.supp = s_syn_fol ~ cs(age), # Formula for intake frequencies (age-dependent)
  only.supp.users.ok = FALSE,     # Is everyone a potential supplement user? Use TRUE if no extra info on never-supplement users.
  supp.user.name = "use_s_foleq", # Column name of never-supplements-users (from *extra* question from e.g. FFQ)
  sex.label = "female",
  min.age = 1,
  max.age = 79,
  seed = 9876,
  spade.output.path = "SPADE Output - 5. Food + Supplements",
  output.name = "output_example_only_supplements"
)

# Exercise 1
# 1a)
f.spade.supplement(
  data = DNFCSmanual,
  frml.ia.supp = s_syn_fol ~ age,     # Formula for intake amounts (age-dependent)
  frml.if.supp = s_syn_fol ~ cs(age), # Formula for intake frequencies (age-dependent)
  only.supp.users.ok = FALSE,     # Is everyone a potential suppl. user? Use TRUE if no extra info on never-supplement users.
  supp.user.name = "use_s_foleq", # Column name of never-supplements-users (from *extra* question from e.g. FFQ)
  sex.label = "men",
  min.age = 1,
  max.age = 79,
  seed = 20250807,
  age.classes = c(0, 18, 79), # Age-classes to distinguish youth and adults
  prb = c(5, 10, 25, 50, 75, 90, 95) / 100,
  spade.output.path = "SPADE Output - 5. Food + Supplements",
  output.name = "output_exercise_1a"
)
# 1b)
f.spade.supplement(
  data = DNFCSmanual,
  frml.ia.supp = s_syn_fol ~ age,
  frml.if.supp = s_syn_fol ~ cs(age),
  only.supp.users.ok = FALSE,
  supp.user.name = "use_s_foleq",
  min.age = 1,
  max.age = 79,
  sex.label = "men",
  seed = 20250807,
  age.classes = c(0, 18, 79),
  prb = c(5, 10, 25, 50:75, 90, 95)/100, # with 50:75 we get all (integer) percentile between 50-75
  spade.output.path = "SPADE Output - 5. Food + Supplements",
  output.name = "output_exercise_1b"
)

# 1c) Only meant for more advanced R-users

# Find percentage of never-users and ever-users among youth and adults
# directly from data

DNFCSmanual |> 
  filter(sex == 1) |>
  mutate(
    agegroup = 
      case_when(
        age <= 18 ~ "youth",
        age > 18 ~ "adults"
      ) |> as.factor()
  ) |>
  dplyr::select(agegroup, use_s_syn_fol) |>
  table() |>
  prop.table(margin = 1)

###### SPADE for food + supplements (f.spade3) #####

# Example shown in presentation
f.spade3(
  ## Required arguments ##
  
  # Formula's for food intake of never-suppl. users
  frml.ia.nonsu  = syn_fol ~ fp(age),   # Also possible: ~ 1; + covariate(s)
  frml.if.nonsu  = syn_fol ~ cs(age),   # Also possible: "no.if"; ~ cs1; + covariate(s)
  
  # Formula's for food intake of potential suppl. users
  frml.ia.su     = syn_fol ~ fp(age),   # Also possible: see above
  frml.if.su     = syn_fol ~ cs(age),   # Also possible: see above
  
  # Formula's for supplement intake
  frml.ia.supp   = s_syn_fol ~ age,     # Also possible: see above
  frml.if.supp   = s_syn_fol ~ cs(age), # Also possible: see above
  
  only.users.ok  = FALSE,               # Is everyone a potential suppl. user? Use TRUE if no extra info on never-supplement users.
  supp.user.name = "use_s_syn_fol",     # Column indicating supplement use (from *extra* question from e.g. FFQ)
  data           = DNFCSmanual,
  min.age        = 1,
  max.age        = 79,
  sex.label      = "female",
  seed           = 20250807,
  
  ## Selection of optional arguments ##
  age.classes  = c(0, 18, 79),              # age-classes to report
  prb = c(5, 10, 25, 50, 75, 90, 95) / 100, # percentiles to report
  weights.name = "w_demog_season_wk_wknd",  # survey weights
  EAR.names = NULL,
  AI.names = NULL,
  UL.names = NULL,
  spade.output.path = "SPADE Output - 5. Food + Supplements",
  output.name = "output_example_food_plus_supplements"
)

# Exercise 2
f.spade3(
  ## Required arguments ##
  frml.ia.nonsu  = syn_fol ~ fp(age),
  frml.if.nonsu  = syn_fol ~ cs(age),
  
  frml.ia.su     = syn_fol ~ fp(age),
  frml.if.su     = syn_fol ~ cs(age),
  
  frml.ia.supp   = s_syn_fol ~ age,
  frml.if.supp   = s_syn_fol ~ cs(age),
  
  only.users.ok  = FALSE,
  supp.user.name = "use_s_syn_fol",
  data           = DNFCSmanual,
  min.age        = 1,
  max.age        = 79,
  sex.label      = "male",
  seed           = 20250807,
  
  ## Selection of optional arguments ##
  age.classes  = c(0, 18, 79),
  prb = c(25, 50, 75, 90, 95) / 100,
  spade.output.path = "SPADE Output - 5. Food + Supplements",
  output.name = "output_exercise_2"
)