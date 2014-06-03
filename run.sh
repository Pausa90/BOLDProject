#!/bin/bash
#@author Andrea Iuliano & Valerio Cestarelli

#Pre-processing
./fastaSplitter
./jellyfishStarter

#Hadoop
start-all.sh
hadoop dfsadmin -safemode leave
hadoop dfs -rmr /BOLD/jellyfish
hadoop dfs -put jellyfish /BOLD
hadoop jar bold.jar /BOLD/jellyfish boldOut/
hadoop dfs -get boldOut/ .
stop-all.sh

#Post-processing
./matrixAssembler.sh
touch "finito"