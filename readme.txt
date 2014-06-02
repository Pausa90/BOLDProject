Commissione:

1) installare e documentarvi sul software jellyfish 
    http://www.genome.umd.edu/jellyfish.html
2) preprocessing dei dati:
     1 file per ogni id (campione) presente nel data set
3) estrarre per ogni id le occorrenze dei k-mers con k=4 con jellyfish 
                jellyfish count -m 4 -o output.bin -c 2 -s 10M -t 4 -C input.fas;
		jellyfish dump -c -o output2.occ output.bin;
4) calcolare le frequenze sulla base della formula occ / (n-k+1) in cui occ e' l'occorrenza, n la lunghezza della stringa considerata, k=4 
5) comporre la matrice con map reduce a partire dalle frequenze, nelle colonne le sottostringhe e sulle righe i campioni
                             ,AAAA,AAAC,...., specie
id_campione_1, freq11, freq12,...., plantA
id_campione_2, freq21,freq22,....., plantB


Realizzazione:
1) -
2) fastaSplitter.sh
3) jellyfishStarter.sh
4) bold.jar da usare con MapReduce
5) matrixAssembler.sh avvia più volte matrixAssembler.py (che scrive un file csv) 