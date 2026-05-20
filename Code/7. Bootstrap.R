# SPADE course July 2025
# 7. Bootstrap

# Load SPADE
library(SPADE.RIVM)

# Load data
data("DNFCSmanual")

# Exercise 1
# 1a)
f.spade3(
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
  age.classes  = c(0, 18, 79),
  spade.output.path = "SPADE Output - 7. Bootstrap",
  output.name = "output_exercise_1a"
)

# b)
f.spade.bootstrap(
  FUN = f.spade3,
  
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
  age.classes  = c(0, 18, 79),
  prb = c(25, 50, 75, 90, 95) / 100,
  spade.output.path = "SPADE Output - 7. Bootstrap",
  output.name = "output_exercise_1b",
  
  # Number of bootstrap samples:
  n.boot = 10 # We recommend to first test with n.boot = 3
)
