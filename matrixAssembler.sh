input="boldOut/"
output="matrix/"

if [ -d "$output" ]; then
	rm -R "$output"
fi

mkdir "$output"

for dir in "$input"*; do

	dir_name=$(echo "$dir" | awk -v FS="/" '{print $NF}')

	python matrixAssembler.py "$dir/part-r-00000" "$output$dir_name"

	echo "$dir terminato"

done