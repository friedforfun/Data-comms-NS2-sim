import argparse
import os
import matplotlib.pyplot as plt

DATA = 0
TIME = 1
QSIZE = 2

def processList(trace):
	aveque = []
	crntque = []
	for x in trace:
		if x[0] == 'a':
			aveque.append(x)
		elif x[0] == 'Q':
			crntque.append(x)

	return (aveque, crntque)


def generateLine(glist):
	xline = []
	yline = []
	for x in glist:
		xline.append(x[TIME])
		yline.append(x[QSIZE])

	return (xline, yline)


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

    quetuple = processList(trace)
    aline = generateLine(quetuple[0])
    qline = generateLine(quetuple[1])

    plt.plot(aline[0], aline[1], label = "Average Queue")
    plt.plot(qline[0], qline[1], label = "Current Queue")

    plt.xlabel('Time')
    plt.ylabel('Queue')

    plt.title('RED Queue monitor')

    plt.legend()

    plt.show()
    