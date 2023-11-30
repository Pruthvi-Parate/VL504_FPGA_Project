# VL504_System_Design_With_FPGA_Project
-------------------
## Submitted By: Pruthvi Parate (MS2023009) , Bhargav D V (MS2023003)
---------------------
## Project
Displaying Image on the VGA monitor from SD Card  

**Aim:** Load images from SD card to DDR memory on an FPGA such as Zedboard. Transmit the data from DDR to BlockRam, perform an image transformation such as blurring/edge detection and display the image on VGA.

-----------------------
## Hardware Requirements: 

1. Zedboard evaluation board
2. SD Card and SD card reader.
3. VGA Monitor and Cable
-------------------------
## Software Requirements: 
1. Vivado 2019.2
2. Vitis 2019.2
----------------------------
## Implementation

--------------------
## Software Simulation Results  
 
**Input Image**  

![sw_sim_input_img](https://github.com/Pruthvi-Parate/VL504_FPGA_Project/assets/72121158/951e0943-ce3f-4635-89d5-96dbbfd0c7b7)  

**Output Image**  

![sw_sim_output_img](https://github.com/Pruthvi-Parate/VL504_FPGA_Project/assets/72121158/f119e64b-6c09-450c-a2f1-3c5ec57161ec)   


---------------------------------
## Hardware Simulation Results
**Input Image**
![hw_sim_input_img](https://github.com/Pruthvi-Parate/VL504_FPGA_Project/assets/72121158/ead477db-b66c-48f3-8909-5aeec5624971)  

**Output Image**
![hw_sim_output_img](https://github.com/Pruthvi-Parate/VL504_FPGA_Project/assets/72121158/6429fdfc-3476-4b8c-af49-d05b9dcc174d)  

## Acknowledgement
We would like to thank following people for supporting us in completing this project.
1. Professor Nanditha Rao, IIITB
2. Jay Shah, Research Scholar, IIITB
3. Himanshu Kumar Rai, Research Scholar, IIITB
4. Shubhayu Das, IMtech, IIITB
5. Kanish R, Mtech, IIITB
6. Alwin Shaju, Mtech, IIITB


## References
1. https://github.com/Shubhayu-Das/VL504-project/tree/main
2. https://github.com/Gowtham1729/Image-Processing
3. https://www.youtube.com/playlist?list=PLXHMvqUANAFOviU0J8HSp0E91lLJInzX1
4. https://www.microcontrollertips.com/understanding-ddr-sdram-faq/
5. https://www.allaboutcircuits.com/technical-articles/introduction-to-the-advancedextensible-interface-axi/
6. https://www.avnet.com/wps/wcm/connect/onesite/a43adf00-158c-4614-b2c7-4a7f35b53f25/FY23_800_ZedBoard_Product_Brief_r2.pdf?MOD=AJPERES&CACHEID=ROOTWORKSPACE.Z18_NA5A1I41L0ICD0ABNDMDDG0000-a43adf00-158c-4614-b2c7-4a7f35b53f25-oj5IUo.
7. https://embeddedthoughts.com/2016/07/29/driving-a-vga-monitor-using-an-fpga/
