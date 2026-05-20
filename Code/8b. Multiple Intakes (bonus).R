# SPADE course July 2025
# 8b. Multiple sources (bonus)

# In this script we illustrate the use of f.spade4, which can be used 
# to model the habitual intake of multiple sources.
# NB: the data should already contain the intake from every separate source.

# load packages
library(SPADE.RIVM) # SPADE package
library(dplyr)      # For convenient data.frame manipulations

# load example data
data(DNFCSmanual)
data("HC2018_EAR.women")
data("HC2018_UL.women")
data("HC2018_AI.women")

# We model all the folate intakes:
# 1. Natural folate from food (daily intakes)
# 2. Synthetic folate from food (non-daily intakes)
# 3. Synthetic folate from supplements (non-daily intakes)

# To compare different types of folate, we first
# convert them to folate-equivalent
# - Folate equivalent of natural folate already in data (column "foleq").
# - Folate equivalent of synthetic folate ("syn_foleq"):
#     calculate it from synthetic folate intake ("syn_fol")
# - Folate equivalent of supplements of synthetic folate ("s_syn_foleq"):
#     calculate it from supplemental synthetic folate intake ("s_syn_fol")

DNFCSmanual <- DNFCSmanual |>
  mutate(
    syn_foleq = 1.7 * syn_fol,
    s_syn_foleq = 2 * s_syn_fol
  )

# Now run the model
f.spade4(
  ## All food sources ##
  frml.ia.multi = # Intake amount formula's
    c(
      foleq ~ fp(age),    # Natural folate from food
      syn_foleq ~ fp(age) # Synthetic folate from food
      ),
  frml.if.multi = # Intake frequency formula's
    c(
      "no.if",            # Natural folate from food
      syn_foleq ~ cs(age) # Synthetic folate from food
      ),
  
  ## One supplement source ##
  frml.ia.supp = s_syn_foleq ~ 1,       # Intake amount
  frml.if.supp = s_syn_foleq ~ cs(age), # Intake frequency
  only.supp.users.ok = FALSE,     # Is everyone a potential suppl. user? Use TRUE if no extra info on never-supplement users.
  supp.user.name = "use_s_foleq", # Column name of never-supplements-users (from *extra* question from e.g. FFQ)

  compound.name = "foleq", # only used for naming output-files. Dots are not allowed in compound.name
  
  ## Other arguments ##
  data = DNFCSmanual,
  min.age = 1,
  max.age = 79,
  sex.label = "female",
  seed = 10,
  age.classes = c(0, 3, 8, 13, 18, 30, 50, 79),
  weights.name = "w_demog_season_wk_wknd",
  EAR.names = "HC2018_EAR.women",
  AI.names = "HC2018_AI.women",
  UL.names = "HC2018_UL.women",
  spade.output.path = "SPADE Output - 8b. Multiple Intakes",
  output.name = "example"
  )
