import csv
import argparse

from typing import Set, Any
if __name__ == '__main__':
	parse = argparse.ArgumentParser(formatter_class=argparse.RawTextHelpFormatter)
	parse.add_argument("-t", type=argparse.FileType('r'), help="Pass the tracefile you wish to parse here")
	args = vars(parse.parse_args())

	# fields are defined below
	EVENT = 0
	TIME = 1
	FROMNODE = 2
	TONODE = 3
	PKTTYPE = 4  # TCP/UDP/CBR
	PKTSIZE = 5
	FLAGS = 6
	FID = 7
	SRCADDR = 8
	DSTADDR = 9
	SEQNUM = 10
	PKTID = 11

	sent = 0
	dropped = 0
	recieved = 0
	thops = 0
	tdelay = 0.0

	def populatetrace(trf):
		f = open(trf, "r")
		trc = []
		for line in f:
			trc.append(line.split())
		f.close()
		return trc


	def uniquepackets(trf):
		x=[]
		for packet in trf:
			x.append(packet[PKTID])
		uniquepkt = set(x)
		return uniquepkt


	def getpacket(trf, pkt):
		# return all elements of trf such that the packet id == pkt
		pktlist = [packet for packet in trf if packet[PKTID] == pkt]
		return pktlist


	def calcpkthops(pktlist):
		# packet hops = number of 'r'
		hops = [packet for packet in pktlist if packet[EVENT] == "r"]
		return len(hops)


	def packetdelay(pktlist):
		start = pktlist[0]
		end = pktlist[-1]
		return end[TIME] - start[TIME]


	trace = populatetrace(args.t)

	for x in trace:
		if x[EVENT] == "d":
			dropped += 1
		elif x[EVENT] == "-":
			sent += 1
		elif x[EVENT] == "r":
			recieved += 1

	packets = uniquepackets(trace)

	allpktdata = []

	for x in packets:
		thispacket = getpacket(trace, x)
		thops += calcpkthops(thispacket)
		tdelay += packetdelay(thispacket)
		allpktdata.append([x, calcpkthops(thispacket), packetdelay(thispacket)])

	throughput = recieved / sent * 100
	collisions = sent - recieved - dropped

	print("Packets sent: " + sent)
	print("Packets recieved: " + recieved)
	print("Packets dropped: " + dropped)
	print("Total number of hops for all packets: " + thops)
	print("Total delay for all packets: " + tdelay)

	with open('totals.csv', 'wb') as csvfile:
		writer = csv.writer(csvfile, delimiter=',', quotechar='|', quoting=csv.QUOTE_MINIMAL)
		writer.writerow(['Sent', 'Recieved', 'Dropped', 'Total hops', 'Total delay'])
		writer.writerow([sent, recieved, dropped, thops, tdelay])

	with open('packetdata', 'wb') as csvfile:
		writer = csv.writer(csvfile, deimiter=',', quotechar='|', quoting=csv.QUOTE_MINIMAL)
		writer.writerow(['Packet ID', 'Hops', 'End-to-end Delay'])
		for x in allpktdata:
			writer.writerow([x[0], x[1], x[2]])

	print("Done!")