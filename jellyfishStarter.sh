#!/bin/bash
#@author Andrea Iuliano & Valerio Cestarelli

input="multifasta/"
output="jellyfish/"

if [ -d output ]; then
	rm -R "$output"
fi

mkdir "$output"

for file in "$input"*/*.fas; do

	name_file=$(echo "$file" | awk -v FS="/" '{print $NF}')
	name_file="${name_file::(-4)}" #Con -4 si elimina ".fas"

	jellyfish count -m 4 -o tmp.bin -c 2 -s 10M -t 4 -C "$file"
	jellyfish dump -c -o "$output""$name_file"".occ" tmp.bin
	rm tmp.bin

done