#!/usr/bin/python3.7

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
		xline.append(float(x[TIME]))
		yline.append(float(x[QSIZE]))

	return (xline, yline)


if __name__ == '__main__':
    parser = argparse.ArgumentParser(formatter_class=argparse.RawTextHelpFormatter)
    parser.add_argument('filename')
    args = parser.parse_args()

    with open(args.filename) as file:
        f = file
        trace = []
        for line in f:
            trace.append(line.split())
        f.close()

    quetuple = processList(trace)
    aline = generateLine(quetuple[0])
    qline = generateLine(quetuple[1])

    df0 = pd.DataFrame({'x': aline[0], 'y': aline[1]})
    df1 = pd.DataFrame({'x': qline[0], 'y': qline[1]})
    plt.plot(aline[0], aline[1], label = "Average Queue")
    plt.plot(qline[0], qline[1], label = "Current Queue")

    #plt.plot(data=df0)

    plt.xlabel('Time')
    plt.ylabel('Queue')

    plt.title('RED Queue monitor')

    plt.legend()
    

    #df = pd.DataFrame({'x': range(1,11), 'y': np.random.randn(10)})
    #plt.plot('x','y', data=df, label = 'Average Queue', color='blue')

    plt.show()
    