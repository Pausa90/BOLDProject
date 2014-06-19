#!/bin/bash
#@author Andrea Iuliano & Valerio Cestarelli

function printRed () {
	echo -e "\e[0;31m$1\e[0m"
}



#Pre-processing
./fastaSplitter.sh
printRed "fastaSplitter terminato"
touch "finito_fastaSplitter"
./jellyfishStarter.sh
printRed "jellyfishStarter terminato"
rm "finito_fastaSplitter"
touch "finito_jellyfishStarter"

#Hadoop
start-all.sh
sleep 5
hadoop dfsadmin -safemode leave
sleep 2
hadoop dfs -mkdir /BOLD
hadoop dfs -put jellyfish /BOLD
hadoop jar bold.jar /BOLD/jellyfish boldOut/
hadoop dfs -get boldOut/ .
hadoop dfs -rmr /BOLD
stop-all.sh
printRed "hadoop terminato"
rm "finito_jellyfishStarter"
touch "finito_hadoop"

#Post-processing
./matrixAssembler.sh
printRed "matrixAssembler terminato"
rm "finito_hadoop"
touch "finito"
