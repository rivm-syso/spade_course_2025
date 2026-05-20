# SPADE course July 2025
# 6. Subgroups

# Load SPADE package
library(SPADE.RIVM)

# Load data
data("DNFCSmanual")
data("HC2018_EAR.men")
data("HC2018_EAR.women")

# Example shown in presentation
f.spade.subgroups(
  
  ## Specific arguments of f.spade.subgroups ##
  FUN = f.spade,        # function to apply to every subgroup
  groups.frml  = ~ sex, # subgroups to model
  
  ## Usual arguments of FUN ##
  frml.ia = potato ~ fp(age),
  frml.if = potato ~ cs(age),
  data    = DNFCSmanual,
  min.age = 1,
  max.age = 79,
  seed    = 29062025,
  age.classes = list( # Can now define multiple age-classes
    BE   = c(0, 12, 18, 30, 50, 79),
    EFSA = c(0, 12, 18, 30, 79),
    NL   = c(0, 6, 12, 18, 30, 79)
  ),
  spade.output.path = "SPADE Output - 6. Subgroups",
  output.name = "output_example_subgroups"
)

# Exercise 1
# a) and b)
f.spade.subgroups(
  
  ## Arguments specific to f.spade.subgroups ##
  FUN = f.spade,                    # Function to apply to every subgroup
  groups.frml  = ~ sex + edu_level, # Defines subgroups
  
  ## Usual arguments of FUN ##
  frml.ia = ca ~ fp(age),
  frml.if = 'no.if',
  data    = DNFCSmanual,
  min.age = 1,
  max.age = 79,
  seed    = 29062025,
  age.classes = list(NL = c(0, 18, 79)), # Needs to be a list - age.classes = c(0, 18, 79) won't work
  weights.name = "w_demog_season_wk_wknd",
  spade.output.path = "SPADE Output - 6. Subgroups",
  output.name = "output_exercise_1a_and_1b"
)

# 1c)
f.spade.subgroups(
  ## Arguments specific to f.spade.subgroups ##
  FUN = f.spade,                    # Function to apply to every subgroup
  groups.frml  = ~ sex + edu_level, # Defines subgroups
  
  ## Usual arguments of FUN ##
  frml.ia = ca ~ fp(age),
  frml.if = "no.if",
  data    = DNFCSmanual, 
  min.age = 1,
  max.age = 79, 
  seed    = 29062025,
  weights.name = "w_demog_season_wk_wknd",
  age.classes = list(NL = c(0, 18, 79)),   # Needs to be a list - multiple age-classes possible
  EAR.men   = list(NL = HC2018_EAR.men),   # Needs to be a list - multiple EAR's possible
  EAR.women = list(NL = HC2018_EAR.women), # Needs to be a list - multiple EAR's possible
  spade.output.path = "SPADE Output - 6. Subgroups",
  output.name = "output_exercise_1c"
) 

# 1d)
f.spade.subgroups(
  ## Arguments specific to f.spade.subgroups ##
  FUN = f.spade,                    # Function to apply to every subgroup
  groups.frml  = ~ sex + edu_level, # Defines subgroups
  
  ## Usual arguments of FUN ##
  frml.ia = ca ~ fp(age),
  frml.if = "no.if",
  data    = DNFCSmanual, 
  min.age = 1,
  max.age = 79, 
  seed    = 29062025,
  weights.name = "w_demog_season_wk_wknd",
  age.classes = list(NL= c(0, 18, 49, 79)), # Needs to be a list - multiple age-classes possible
  EAR.men   = list(NL = HC2018_EAR.men),    # Needs to be a list - multiple EAR's possible
  EAR.women = list(NL= HC2018_EAR.women),   # Needs to be a list - multiple EAR's possible
  spade.output.path = "SPADE Output - 6. Subgroups",
  output.name = "output_exercise_1d"
) 
