import csv
import argparse

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

    with open('tracefile.csv', 'w') as csvfile:
        writer = csv.writer(csvfile)
        writer.writerow(['Packet ID', 'Hops', 'End-to-end Delay'])
        for x in trace:
            writer.writerow(x)

    print("Done!")