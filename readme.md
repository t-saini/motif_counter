Motif Counter
Author: Tanvir Saini

The Motif Counter script is designed to analyze a reference FASTA file and a text file containing motifs of interest. It counts the occurrences of each motif in the reference file and creates a directory to store individual motif files.

How to Run

Execute the following command in the terminal when inside the week2_assignment directory using the provided files:

./motif_counter.sh "r_bifella.fasta" "interesting_motifs.txt"

If your reference FASTA file (`reference.fasta`) or motif list file (`motif_list.txt`) are located in a different directory, provide the full path to the files when executing the script. For example:

./motif_counter.sh "/path/to/your/reference.fasta" "/path/to/your/motif_list.txt"

Input Files

    Reference FASTA File (reference.fasta): This is the genomic reference file in FASTA format, r_bifella.fasta is the provided file.
    Motif List File (motif_list.txt): A text file containing motifs of interest, interesting_motifs.txt is the provided file.

Output

The script will generate a directory named "motifs" and individual files named after their motif inside the directory. These files will contain the genes and their corresponding seuqences with that motif. Additionally, it will produce a file named "motif_count.txt" summarizing the motifs and their respective counts.

Error Handling

The script performs checks on file extensions and exits if they do not match the expected extensions (.fasta for reference and .txt for motifs).

