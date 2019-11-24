import os
import sys
import argparse

parse = argparse.ArgumentParser()
parse.add_argument("tracefile", help = "Pass the tracefile you wish to parse here")
args = parse.parse_args()

# store each line and row in a 2D array: arr[x][y], [x] is the line number and [y] is the trace file field

# fields are defined below
EVENT = 0
TIME = 1
FROMNODE = 2
TONODE = 3
PKTTYPE = 4
PKTSIZE = 5
FLAGS = 6
FID = 7
SRCADDR = 8
DSTADDR = 9
SEQNUM = 10
PKTID = 11

def populatetrace(trf):
	f = open(trf, "r")
	trc = []
	for line in f:
		trc.append(line.split())
	f.close()
	return trc

trace = populatetrace(args.tracefile)

print "Done!"
