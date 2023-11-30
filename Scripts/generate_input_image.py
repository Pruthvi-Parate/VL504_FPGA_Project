import cv2

# Load the image in color format
image = cv2.imread('image.png')

# Convert the image to grayscale
gray_image = cv2.cvtColor(image, cv2.COLOR_BGR2GRAY)
cv2.imwrite("input_image_gray.png", gray_image)
# Resize the image to 512x512
resized_image = cv2.resize(gray_image, (128, 128))

# Write the pixel values to a .dat file without "0b" prefix
with open('input_image.dat', 'w') as dat_file:
    for row in resized_image:
        for pixel in row:
            # Format the pixel value as an 8-bit binary string without "0b" prefix
            binary_value = format(pixel, '08b')
            dat_file.write(binary_value + '\n')

print("Input image written to input_image.dat")

