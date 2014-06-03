#!/bin/bash
#@author Andrea Iuliano & Valerio Cestarelli

input="multifasta/"
output="jellyfish/"

if [ -d "$output" ]; then
	rm -R "$output"
fi

mkdir "$output"

for dir in "$input"*; do

	dir_name=$(echo "$dir" | awk -v FS="/" '{print $NF}')
	dir_output="$output$dir_name"
	mkdir "$dir_output"

	for file in "$input/$dir_name"/*.fas; do

		name_file=$(echo "$file" | awk -v FS="/" '{print $NF}')
		name_file="${name_file::(-4)}" #Con -4 si elimina ".fas"
		gene_sequence_length=$(cat "$file" | grep '^[^>]' | awk -FS='\n' '{print $1}' | tr '\n' ' ' | wc -c)
		specie_name=$(sed -n "1p" "$file" | awk -v FS="|" '{print $2}' | tr " " "_")

		jellyfish count -m 4 -o tmp.bin -c 2 -s 10M -t 4 -C "$file"
		jellyfish dump -c -o "$dir_output/""$name_file""[specie=$specie_name]""[length=$gene_sequence_length]""[k=4]"".occ" tmp.bin
		rm tmp.bin

	done

	echo "$dir terminato"

done