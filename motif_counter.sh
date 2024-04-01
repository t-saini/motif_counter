#!/usr/bin/env bash
# Goal: Analyze a reference FASTA file and a file containing motifs of interest.
# Author: Tanvir Saini

#reference_fasta pulled from the first
#command line argument
ref_fasta="$1"
#list of interesting motifs
#pulled from second command line argument
motifs="$2"

#extract file extensions by looking for 
#the first instance of '.' and only keeping 
#every thing after in the string
# ##* is one of Bash's pattern matching tools
#we lead with a '.' because the original '.'
#is removed
input_ref_extension=".${ref_fasta##*.}"
input_motifs_extension=".${motifs##*.}"

#expected file extensions based on the
#instructions from the assignment
fasta_extension=".fasta"
motifs_extension=".txt"

#first half of error message
#when the wrong file extension
#is passed
error_expected_extension="[ERROR] :: Expected file extension is"
#second half of error mesage
#when the wrong file extension
#is passed
error_recieved_extension="recieved the following >"


#if statement to check file extensions
#if extensions do not match for the FASTA
#the script exists with error code 1
if [ "${input_ref_extension}" != "${fasta_extension}" ]; then
    echo "${error_expected_extension} ${fasta_extension}, ${error_recieved_extension} ${input_ref_extension}"
    echo "[ERROR] :: Try again with the correct extensions. Exiting.."
    exit 1
fi

#if statement to check file extensions
#if extensions do not match for the motifs
#the script exists

if [ "${input_motifs_extension}" != "${motifs_extension}" ]; then
    echo "${error_expected_extension} ${motifs_extension}, ${error_recieved_extension} ${input_motifs_extension}"
    echo "[ERROR] :: Try again with the correct extensions. Exiting.."
    exit 1
fi

#presenting to the user the given files
echo "Reference FASTA: " ${ref_fasta}
echo "File For Motifs Of Interest: " ${motifs}

#using Mapfile to read the text file into an array
mapfile -t motif_array < ${motifs}


#letting the user know all initials checks
#have been complete and we are starting
#to run motif_counter
echo "Files Passed Initial Check, running motif_counter"

#create the array motif_counts
#this will store the motif and
#the number of times it appears
declare -a motif_counts=()


#check for the exisitence of
#the directory motif using 
#the command -d
#if the directory does not exist
#create it
if [ -d './motifs' ]; then
    echo "Directory motifs exists"
else
    echo "Directory motifs does not exist"
    echo "Creating directory motifs"
    mkdir motifs
    echo "Directory motifs created"
fi

#iterate through each motif found our array
for motif in "${motif_array[@]}"
do
    echo "Counting motifs for ${motif}"
    #motif_counts is the number of times the motif
    #is found, the numeric is created thanks to -c
    motif_count=$(grep "${motif}" -c ${ref_fasta})
    #concatinate the motif and the count
    #append into the array motif_counts
    motif_counts+=("${motif} ${motif_count}")
    #grep will find the motif in the ref fasta
    #the command -B1 will also pull the fasta header
    #tr -s will replace every every '\n--' with just a newline
    #and then we output a file based named after the motif
    echo "Outputting sequences with ${motif} to ./motifs/${motif}.txt"
    grep -B1 "${motif}" ${ref_fasta} | tr -s '\n--' '\n'  >> "./motifs/${motif}.txt"
done

#using the echo below to verify that the
#for loop above did in fact finish
echo "Writing motif counts found to motif_count.txt"
#printf is being used for formmating
#in the line below every entry in array motif_counts
#is being written to our file followed by a new line
printf "%s\n" "${motif_counts[@]}" > "motif_count.txt"
#displaying a message to indicate that all tasks have been successfully completed
echo "Done, all tasks finished."


