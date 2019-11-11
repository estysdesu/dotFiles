#!/usr/bin/env python3
import os

# inputs
search_path = input("Enter directory path to search : ")
file_type = input("File Type : ")
search_str = input("Enter the search string : ")

# if not (search_path.endswith("/") or search_path.endswith("\\")):
#     search_path = search_path + "/"

if not os.path.exists(search_path):
    raise ValueError("path specified does not exist")

for file_name in os.listdir(path=search_path):

    if file_name.endswith(file_type) or file_type == "*":

        with open(os.path.join(search_path, file_name), "rt") as f:
        
        old_line = None
        for i, line in enumerate(f):



            #### start here ###
            

        # Read the first line from the file
        line = fo.readline()

        # Initialize counter for line number
        line_no = 1

        # Loop until EOF
        while line != "":
            # Search for string in line
            index = line.find(search_str)
            if index != -1:
                print(fname, "[", line_no, ",", index, "] ", line, sep="")

            # Read next line
            line = fo.readline()

            # Increment line counter
            line_no += 1
        # Close the files
