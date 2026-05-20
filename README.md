# SPADE course material

This repository contains the code and slides for the SPADE course, held on July 8-9 2025 at RIVM, Bilthoven, The Netherlands. The contents of the folder _Slides_ are hopefully self-explanatory. The folder _Code_ contains:

- the code of the spade-calls that are shown in the slides
- the code that is required to solve the exercises
- code that shows how to run _f.spade4_ to model the habitual intake from multiple sources (_8b. Multiple Intake (bonus).R_)
- code that shows how to run the bootstrap for subgroups and subsequently test for differences between subgroups (_Bootstrap for Subgroups and Difference Testing.R_)

Compared to what we shared during the course, this code is cleaner and better annotated. In particular, _Bootstrap for Subgroups and Difference Testing.R_ now contains comments that explain step-by-step how to use this function.

# How to get the course material to my pc?

The easiest way: 
1. go to https://github.com/rivm-syso/spade_course_2025 (this may well be where you are at now)
2. click the green button "code"
3. in the dropdown menu, click "Download ZIP"
4. a ZIP-file with the course content will be downloaded
5. extract the ZIP-file to a directory of choice at your local pc

Alternatively - if you have experience with git - you can clone this repository to your local pc.

# How to run the R-scripts?

We strongly recommend to first open the file _Code.Rproj_, which is located In the subfolder _Code_. You can open it by simply double-clicking. Rstudio should then start as usual, except now it has opened a so-called R-project, which is called "Code". At the very top left of your screen - next to the R-logo - you should now see "Code - Rstudio". Working in this R-project means that the R-session will now recognize the subfolder _Code_ as its home folder. This is convenient for the following two reasons:

1. In the window that is (usually) at the bottom-right part of Rstudio is a tab "Files". If you click it, you will see all the files present in the subfolder _Code_, i.e. all the _XX.R_ scripts. You can simply click any script to open it directly.
2. When you refer to directories within R - e.g. to specify a directory to write SPADE output to - you can define paths relative to the current home-folder, i.e. relative to the folder _Code_. For example, when we call e.g. _f.spade_ with the argument _spade.output.path = output_folder_, SPADE will save its output in a folder called _output_folder_, which will be a subfolder of the folder _Code_. In this way you will conveniently have the code and output together - and this will even be true if you copy the whole repository to any other location.

Long story short: start by opening _Code.Rproj_ and open the other R-scripts from the Rstudio session that then opens. Running the provided calls to _f.spade_ and friends will then automatically save its output in subfolders of the folder _Code_.

# Contact

If you have any questions, feel free to contact the course organizers either directly or via spade@rivm.nl.

# License

The source code in this repository is licensed under the GPLv2 license, while the slides in the /slides folder are licensed separately under CC BY 4.0. Please see the respective LICENSE files for details.
