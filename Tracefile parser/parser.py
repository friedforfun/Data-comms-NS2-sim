import csv
import argparse
import os
from multiprocessing import Pool

EVENT = 0
TIME = 1
PKTID = 11

def sortTime(element):
    return float(element[TIME])

def processlist(trlist):
    sent = 0
    dropped = 0
    recieved = 0
    pktset = []
    for x in trlist:
        if x[EVENT] == '-':
            sent += 1
        elif x[EVENT] == 'd':
            dropped += 1
        elif x[EVENT] == 'r':
            recieved += 1

        pktset.append(int(x[PKTID]))
        pktset = sorted(set(pktset))
    return {'sent': sent, 'dropped': dropped, 'recieved': recieved, 'packetset': pktset}

def countsent(list):
    return len([x for x in list if x[EVENT] == '-'])

def countdropped(list):
    return len([x for x in list if x[EVENT] == 'd'])

def countrecieved(list):
    return len([x for x in list if x[EVENT] == 'r'])

def findPacketSet(list):
    temp = [int(x[PKTID]) for x in list]
    packetset = set(temp)
    return sorted(packetset)

def findPacketLines(list, packetid):
    # packetLines = [x for x in list if int(x[PKTID]) == packetid]
    # loops over list for evey element of packet id, really inefficient

    packetLines = {}
    for x in list:
        tempentry = packetLines.get(int(x[PKTID]), [])
        tempentry.append(x)
        packetLines.update({int(x[PKTID]): tempentry})

    print("Packet lines dict complete")
    return packetLines

def findPacketDelay(list):
    packets = sorted(list, key=sortTime)
    start = packets[0]
    end = packets[-1]
    avg = float(end[TIME]) - float(start[TIME])
    return avg

def averagedelayTHREADED(packetdict):
    pool = Pool(os.cpu_count())
    delays = pool.map(findPacketDelay, [packetdict.get(key) for key in packetdict], 400)
    print("Delays list populated")
    pool.close()
    pool.join()
    return sum(delays) / len(delays)

def averagedelay(packetdict):
    delays = [findPacketDelay(packetdict.get(key)) for key in packetdict]
    print("Found list of delays!")
    return sum(delays) / len(delays)

def averagedelay(packetdict):
    delays = [findPacketDelay(packetdict.get(key)) for key in packetdict]
    print("Found list of delays!")
    return sum(delays) / len(delays)

def writeTotals(list):
    global filen
    file = os.path.splitext(filen)[0] + '-totals.csv'
    with open(file, 'w') as csvfile:
        writer = csv.writer(csvfile)
        writer.writerow(['Total Packets', 'Total sent', 'Total recieved', 'Total Dropped', 'Average end-to-end Delay', 'Throughput', 'Lost'])
        writer.writerow(list)

def cleanlist(list):
    return [x for x in list if x[EVENT] != 'v']

def isdatatraffic(sublist):
    protocols = {'cbr', 'ftp', 'tcp', 'udp'}
    setlist = set(sublist)
    if (protocols & setlist):
        return True
    else:
        return False

def protocoltraffic(tlist):
    rlist = list(filter(isdatatraffic, tlist))
    return rlist

def prog(trace):
    tracelist = protocoltraffic(trace)

    print("Tracefile made!")
    #tracelist = cleanlist(trace)

    packetset = findPacketSet(tracelist)

    #dictionary = processlist(tracelist)
    #print("Dictionary Made")
    #packetset = dictionary.get('packetset')
    #sent = dictionary.get('sent')
    #dropped = dictionary.get('dropped')
    #recieved = dictionary.get('recieved')

    #total number of unique packets
    packets = len(packetset)
    print("Found packet set & length")
    #total number of packets sent from all nodes
    sent = countsent(tracelist)
    print("Found number of packets sent")
    # number of dropped packets
    dropped = countdropped(tracelist)
    print("Found number of packets dropped")
    # number of recieved packets
    recieved = countrecieved(tracelist)
    print("Found number of packets recieved")

    packetdict = findPacketLines(tracelist, packetset)

    avedelay = averagedelay(packetdict)

    # average delay for each packet
    #avedelay = averagedelay(tracelist, packetset)
    print("Found average delay of each packet")
    # Lost packets
    lost = sent - recieved

    # Throughput
    throughput = (recieved/sent) * 100

    print("Total number of packets:", packets)
    print("Sent:", sent)
    print("Recieved:", recieved)
    print("Dropped:", dropped)
    print("Average delay:", avedelay)
    print("Throughput:", throughput, "%")
    print("Lost:", lost)

    csvlist = [packets, sent, recieved, dropped, avedelay, throughput, lost]
    writeTotals(csvlist)


if __name__ == '__main__':
    parser = argparse.ArgumentParser(formatter_class=argparse.RawTextHelpFormatter)
    parser.add_argument('filename')
    args = parser.parse_args()

    global filen
    filen = args.filename

    with open(args.filename) as file:
        f = file
        trace = []
        for line in f:
            trace.append(line.split())
        f.close()

    prog(trace)

    print("Done!")
