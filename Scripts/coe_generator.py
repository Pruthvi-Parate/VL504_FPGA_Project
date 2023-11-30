import cv2

# Load the image in color format
image = cv2.imread('input_image4.png')

# Convert the image to grayscale
gray_image = cv2.cvtColor(image, cv2.COLOR_BGR2GRAY)
cv2.imwrite("input_image_gray.png", gray_image)
# Resize the image to 512x512
resized_image = cv2.resize(gray_image, (512, 512))
count=0
# Write the pixel values to a .dat file without "0b" prefix
with open('image_512x512.coe', 'w') as dat_file:
    dat_file.write("memory_initialization_radix=2;\n")
    dat_file.write("memory_initialization_vector=\n")
    for row in resized_image:
    
        for pixel in row:
            # Format the pixel value as an 8-bit binary string without "0b" prefix
            count=count+1
            binary_value = format(pixel, '08b')
            if(count==262144):
            	dat_file.write(binary_value + ';')
            else:
            	dat_file.write(binary_value + ',\n')

print("Input image written to image.coe")

