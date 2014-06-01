#! /usr/bin/python

import sys
import csv


#import reinput 

input= "boldOut/part-r-00000"
matrix = {"head":["id"],"data":[]}
genes = []

def initGenes(lines):
	global genes
	for line in lines:
		for i in range(1, len(line.split())):
			if (i%2 == 1 and i>0):
				gene = line.split()[i]
				genes.append(gene)
	genes = set(genes)
	genes = sorted(genes)
	matrix["head"].extend(genes)

def createMatrixRow(line):
	partialRow = []

	splitted = line.split()
	id = splitted[0]
	for i in range(1, len(splitted)-1):
		token = splitted[i]
		
		if (i%2 == 1):
			window = token
		else:
			partialRow.append( (window, token) )

	partialRow = sorted(partialRow)
	setFullRow(id,partialRow)
	#print partialRow
	#matrix['data'].append( (id,partialRow) )



def setFullRow(id, partialRow):
	global genes
	row = [id]
	iterator1 = 0
	iterator2 = 0
	while iterator1<len(partialRow) and iterator2<len(genes):
		if partialRow[iterator1][0] == genes[iterator2]:
			row.append(partialRow[iterator1][1])
			iterator1 += 1
			iterator2 += 1
		else:
			row.append(0)
			iterator2 += 1
	matrix['data'].append( (row) )


#Main

lines = open(input,'r').readlines()

initGenes(lines)

for line in lines:
	createMatrixRow(line)

writer = csv.writer(open("matrix.csv", 'w'))
writer.writerow(matrix['head'])

for gene in matrix['data']:
	writer.writerow(gene)