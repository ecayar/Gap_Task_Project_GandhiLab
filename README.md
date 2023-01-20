# Gap-Task-Project

To perform GPFA follow Byron Yu's public software (links below): <br>
[DataHigh](https://users.ece.cmu.edu/~byronyu/software/DataHigh/datahigh.html) <br>
[GPFA MATLAB code](https://users.ece.cmu.edu/~byronyu/software.shtml) <br>

###### Navigating DataHigh
After creating the usable structure D, <br>
write DataHigh(D,'DimReduce') in the command window <br>
the DataHigh GUI will then execute. <br>
Adjust your parameters. To use the same parameters used in this manuscript follow the following image <br>
<img width="924" alt="Screen Shot 2023-01-20 at 3 35 14 PM" src="https://user-images.githubusercontent.com/115491172/213800691-c7ae6f96-f9ed-49a7-9e20-2c6b25adfc2e.png">
Time bin width: 20 ms <br>
Mean spikes/sec threshold: 1 spikes/sec <br>
Method: GPFA <br>
Select Dimensionality: 3 <br>
After adjusting parameters, click "Perform dim reduction" and another window, like the image below, will appear <br>
<img width="522" alt="Screen Shot 2023-01-20 at 3 36 39 PM" src="https://user-images.githubusercontent.com/115491172/213800944-5d88f92a-6ef4-4142-b561-8da9f85788e0.png">
Click "Save and upload" to save the file


and use the following codes to reproduce our sample figures: 
###### [Fig1b_code.m](Fig1b_code.m)
###### [Fig2a_code.m](Fig2a_code.m)
###### [Fig2b_and_d_code.m](Fig2b_and_d_code.m)
###### [Fig3a_4a_5a_and_b_code.m](Fig3a_4a_5a_and_b_code.m)

