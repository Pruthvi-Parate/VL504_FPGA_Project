with open('input_image.dat', 'r') as input_file:
    lines = input_file.readlines()
    with open('image.txt', 'wb') as output_file:  # Open the second file in binary write mode
        for i in lines:
            bin_txt = i.strip()  # Remove any leading/trailing whitespaces
            #print(type(int(bin_txt)))
            integer_value = int(bin_txt, 2)
            byte_data = integer_value.to_bytes(4, byteorder='little')
            output_file.write(byte_data)
