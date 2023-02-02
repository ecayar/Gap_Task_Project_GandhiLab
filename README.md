# Distinct context- and content-dependent population codes in superior colliculus during sensation and action

To perform GPFA follow Byron Yu's public software (links below): <br>
[DataHigh](https://users.ece.cmu.edu/~byronyu/software/DataHigh/datahigh.html) <br>
[GPFA MATLAB code](https://users.ece.cmu.edu/~byronyu/software.shtml) <br>

## Navigating DataHigh
### 1. Type DataHigh(D,'DimReduce') in the command window <br>
D is a struct that contains: <br>
  a) spiking activity from the interested time interval (used by GPFA algorithm)
  b) trial ids (not seen/used by GPFA algorithm) <br>
  c) task type (not seen/used by GPFA algorithm) <br>
(see Methods in manuscript for more information) <br>
DataHigh GUI will then execute. <br>
### 2. Adjust your parameters. To use the same parameters used in this manuscript follow the following image <br>
Time bin width: 20 ms <br>
Mean spikes/sec threshold: 1 spikes/sec <br>
Method: GPFA <br>
Select Dimensionality: 3 <br>
<img width="924" alt="Screen Shot 2023-01-20 at 3 35 14 PM" src="https://user-images.githubusercontent.com/115491172/213800691-c7ae6f96-f9ed-49a7-9e20-2c6b25adfc2e.png"> <br>
### 3. After adjusting parameters, click "Perform dim reduction" and another window, like the image below, will appear <br>
<img width="522" alt="Screen Shot 2023-01-20 at 3 36 39 PM" src="https://user-images.githubusercontent.com/115491172/213800944-5d88f92a-6ef4-4142-b561-8da9f85788e0.png"> <br>
### 4. Click "Save and upload" to save the file


## Reproduce sample figures:
### 1. Download data (.mat files):
###### [data_1c_d.mat](data_1c_d.mat)
###### [data_3a_4a_5ab.mat](data_3a_4a_5ab.mat)
###### [data_3b_4b_5ce.mat](data_3b_4b_5ce.mat)
###### [data_6.mat](data_6.mat)


### 2. Download codes (.m files): 
###### [Fig1c_d_code.m](Fig1c_d_code.m)
###### [Fig3a_4a_5a_and_b_code.m](Fig3a_4a_5a_and_b_code.m)
###### [Fig3b_4b_5c_and_e_code.m](Fig3b_4b_5c_and_e_code.m)
###### [Fig6_code.m](Fig6_code.m)

