# CysticFibrosisModelingSuite



* Q: What are the system requirements for the program?
* A: For the Matlab code, any computer running Matlab will work. For the executable, Windows 64bit systems are supported, although it may be possible to run the code on other systems.  
-------------------------
* Q: What do I need in order to be able to run the program?
* A: Both an executable file and Matlab code are provided. For the Matlab code, Matlab is required, all of the Matlab files must be put into the same folder and then the file startscreen.m should be run. For the executable the MCR R2012a is needed, it can be found at: http://www.mathworks.com/products/compiler/mcr/ once it is installed the executable can be run from any directory.
-------------------------
* Q: Is the Matlab code required if I want to run the executable?
* A: No, only the MCR
-------------------------
* Q: What do M, B, P, A, H, and D stand for?
* A: Mucus, Bacteria, Pro-Inflammatory Cytokines, Anti-Inflammatory Cytokines, Healthy Cells, and Dead Cells respectively.
-------------------------
* Q: In the “Exploring CF” page, where do graph’s and data save?
* A: They save into the folder from which the program is being run.

##How does the treatment section work?
* Q: What do the checkboxes do?
* A: The checkboxes determine whether the treatment is applied or not.
-------------------------
* Q: What does the selection drop down menu for each treatment do?
* A: This selection menu allows you to select a predefined treatment, which is based on scientific studies.
-------------------------
* Q: What do the numerical options do?
* A: They act as multipliers to determine the strength of the treatments.
    1. Antibiotics
        a. Inhibits bacteria growth: the number entered is the degree to which the bacteria’s growth is inhibited
            i. For example: if an antibiotic inhibits the bacteria’s growth by 40% then the multiplier is .4
        b. Kills bacteria: the number entered is the degree to which the rate of death of bacteria is increased
            i. For example: if an antibiotic increases the rate of bacteria death by 90% then the multiplier is 1.9
    2. Mucus Clearers: the number entered is the degree to which muculocilliary clearance is increased
        i. For example: if the mucus clearer increases muculocilliary transport by 40%, then the multiplier is 1.4
    3. Chest Physical Therapy: the number entered is the degree to which muculocilliary clearance is increased
        i. For example: if the CPT increases muculocilliary transport by 40%, then the multiplier is 1.4
    4. Anti-inflammatories
        a. Inhibits production of pro-inflammatory cytokines: the number entered is the degree to which pro-inflammatory cytokine production is inhibited
            i. For example: if an anti-inflammatory inhibits the pro-inflammatory cytokine production by 40% then the multiplier is .4
        b. Promotes breakdown of pro-inflammatory cytokines: the number entered is the degree to which the breakdown of pro-inflammatory cytokines is increased
            i. For example: if an anti-inflammatory increases the rate of breakdown of pro-inflammatory cytokines by 90% then the multiplier is 1.9
        c. Promotes production of anti-inflammatory cytokines: the number entered is degree to which the rate of the production of anti-inflammatory cytokines is increased.
            i. For example: if an anti-inflammatory increases the rate of production of anti-inflammatory cytokines by 40%, then the multiplier is 1.4
-------------------------
* Q: The program is crashing on me, what should I do?
* A: Try running the simulation for a shorter period of time.
