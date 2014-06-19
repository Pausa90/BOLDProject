#! /usr/bin/python

import sys
import csv


#import reinput 

inputFile= sys.argv[1]
csvName = sys.argv[2]

matrix = {"head":["id"],"data":[]}
genes = []

def initGenes(lines):
	global genes
	for line in lines:
		for i in range(2, len(line.split())):
			if (i%2 == 0):
				gene = line.split()[i]
				genes.append(gene)
	genes = set(genes)
	genes = sorted(genes)
	genes.append("species")
	matrix["head"].extend(genes)

def createMatrixRow(line):
	partialRow = []

	splitted = line.split()
	id = splitted[0]
	species = splitted[1]
	for i in range(2, len(splitted)):
		token = splitted[i]
		
		if (i%2 == 0):
			window = token
		else:
			partialRow.append( (window, token) )

	partialRow = sorted(partialRow)
	setFullRow(id, species, partialRow)



def setFullRow(id, species, partialRow):
	global genes
	row = [id]
	iterator1 = 0
	iterator2 = 0
	while iterator1<len(partialRow) and iterator2<len(genes)-1:
		if partialRow[iterator1][0] == genes[iterator2]:
			row.append(partialRow[iterator1][1])
			iterator1 += 1
			iterator2 += 1
		else:
			row.append(0)
			iterator2 += 1
	#Concludo con le finestre mancanti
	while iterator2<len(genes)-1:
		row.append(0)
		iterator2 += 1

	row.append(species)
	matrix['data'].append( (row) )


#Main

lines = open(inputFile,'r').readlines()

initGenes(lines)

for line in lines:
	createMatrixRow(line)

writer = csv.writer(open(csvName + ".csv", 'w'))
writer.writerow(matrix['head'])

for gene in matrix['data']:
	writer.writerow(gene)