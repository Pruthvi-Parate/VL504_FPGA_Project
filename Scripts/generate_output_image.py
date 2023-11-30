import numpy as np
import cv2

# Define the dimensions of the image (512x512)
image_width = 128
image_height = 128

# Initialize an empty list to store the pixel values
pixel_values = []

# Read pixel values from the text file line by line
with open("output_image.txt", "r") as file:
    for line in file:
        # Convert each line to an integer and add it to the list
        #print(line.split(' ')[2])
        pixel_values.append(int(line.split(' ')[-1].rstrip()))

# Convert the list of pixel values to a NumPy array
pixel_array = np.array(pixel_values)

# Reshape the 1D array to a 2D array with the image dimensions
image = pixel_array.reshape(image_height, image_width)
#ret,thresh_img = cv2.threshold(image,2,255,cv2.THRESH_BINARY)
# Save the grayscale image using OpenCV
cv2.imwrite("output_image.png", image)

#image = cv2.imread('output_image.png')

# Convert the image to grayscale
#gray_image = cv2.cvtColor(image, cv2.COLOR_BGR2GRAY)

#ret,thresh_img = cv2.threshold(gray_image,128,255,cv2.THRESH_BINARY)
#cv2.imwrite("output_image.png", thresh_img)
#print("Output image generated!!")

