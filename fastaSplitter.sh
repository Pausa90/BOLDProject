#!/bin/bash
#@author Andrea Iuliano & Valerio Cestarelli
input_path="data/"
output="multifasta/"

if [ -d "$output" ]; then
	rm -R "$output"
fi

mkdir "$output"
for file in "$input_path"*.fas; do 

	input_path_length=$( echo $input_path | wc -c )
	let input_path_length--
	name_file="${file:$input_path_length:${#file}-4}" #Con -4 si elimina ".fas"
	name_file="$(echo "$name_file" | awk -v FS=" " '{print $1}')"


	out_path="$output""$name_file/"

	mkdir "$out_path"

	i=1 #si parte da 1
	rowsNumber=$(cat "$file" | wc -l )

	while [ $i -le $rowsNumber ]; do
		aux=$(echo $i)"p"
		row=$(sed -n "$aux" "$file")

		let res=i%2

		if [ "$res" -eq "1" ];then

			id=$(echo $row | awk -v FS="|" '{print $1}')
			id="${id:1}" #Elimino il > all'inizio del file
			id_header=$row

		else

			echo $id_header >> "$out_path""$id"".fas"
			echo $row >> "$out_path""$id"".fas"

		fi

		let i++
	done

	echo "$file terminato"

done
