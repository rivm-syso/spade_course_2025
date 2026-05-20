# SPADE course July 2025
# 7b. Bootstrap for subgroups and difference testing (bonus)

# This script illustrates: 
# - how to run a bootstrap for a subgroup analysis
# - how to compare two subgroups, 
#   and obtain an estimate + confidence interval for the difference
#
# To this end, we run 3 SPADE calls:
# A) f.spade.subgroups: the original subgroup analysis
# B) f.spade.subgroups.bootstrap: bootstrap the subgroup analysis
# C) f.test.difference.with.bootstrap: test difference between two subgroups

# load SPADE package
library(SPADE.RIVM)

# load example data
data("DNFCSmanual")
data("HC2018_EAR.men")
data("HC2018_EAR.women")

# A) subgroup analysis: calcium intake (1-part model) 
#    stratified by sex and education_level
f.spade.subgroups(
  
  ## Specific arguments of f.spade.subgroups ##
  FUN = f.spade, # function to apply to every subgroup
  groups.frml  = ~ sex + edu_level, # subgroups to model
  
  ## Usual arguments of FUN ##
  frml.ia = ca ~ fp(age),
  frml.if = "no.if",
  data    = DNFCSmanual,
  min.age = 1,
  max.age = 79,
  seed    = 29062025,
  age.classes = list(
    BE   = c(0, 12, 18, 30, 50, 79),
    EFSA = c(0, 12, 18, 30, 79),
    NL   = c(0, 6, 12, 18, 30, 79)
  ),
  EAR.men   = list(NL = HC2018_EAR.men),
  EAR.women = list(NL= HC2018_EAR.women),
  spade.output.path = "SPADE Output - 7b. Bootstrap for Subgroups and Difference Testing",
  output.name = "example"
)

# B) Bootstrap for the subgoups analysis A)
#    --> Simply copy-paste all arguments of
#    f.spade.subgroups, and add argument n.boot
f.spade.subgroups.bootstrap(
  ## Same arguments as for f.spade.subgroups ##
  FUN = f.spade, 
  groups.frml  = ~ sex + edu_level, # Defines subgroups
  frml.ia = ca ~ fp(age),
  frml.if = "no.if",
  data    = DNFCSmanual,
  min.age = 1,
  max.age = 79,
  seed    = 29062025,
  age.classes = list(
    BE   = c(0, 12, 18, 30, 50, 79),
    EFSA = c(0, 12, 18, 30, 79),
    NL   = c(0, 6, 12, 18, 30, 79)
  ),
  spade.output.path = "SPADE Output - 7b. Bootstrap for Subgroups and Difference Testing",
  output.name = "example",
  
  ## Arguments specific to bootstrap ##
  # Here we take very few bootstrap samples to save time.
  # For real applications, we recommend n.boot = 200 or more.
  n.boot = 3
)

# C) Now we test for differences between the subgroups.
# Use the function f.test.diffence.with.bootstrap
#
# NB: It requires that f.spade.subgroups.bootstrap has already been run,
# because it will use its results. To be exact, it will use 
# the results saved in the subfolder 4_r_binaries in the file XXX__array.bin
#
# Steps: 
# 1. Execute the function call below
# 2. You will be prompted to make certain choices in the console:
#    - which age-classes do you want use for the comparison?
#    - which 2 subgroups do you want to compare?
#    Make these choices according to your interest.
# 3. After execution, an excel-file is written to disk.
#    Its location and its name are defined by 
#    arguments of f.test.difference.with.bootstrap.
#    In this excel-file you can find the difference between the two subgroups 
#    of several quantities (e.g. AM, P5, P10 etc):
#    - the tab HI_diff shows you the estimate of the difference
#    - the tab LB_diff shows the lower bound of the CI of the difference
#    - the tab UB_diff shows the upper bound of the CI of the difference
#    - if the CI (confidence interval) does *not* include 0, 
#      then the difference is significant

f.test.difference.with.bootstrap(
  # Arguments that define the location of the required bootstrap results
  spade.input.path = "SPADE Output - 7b. Bootstrap for Subgroups and Difference Testing",
  bin.dir = "4_r_binaries",
  file.names = "boot_spadeSUB_example__array.bin", # Name of the XXX__array.bin file
  
  # Arguments that define where the output of the difference-test is saved
  spade.output.path = "SPADE Output - 7b. Bootstrap for Subgroups and Difference Testing",
  output.file.name = "test_difference_example.xlsx"
  )
