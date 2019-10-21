# Create a simulator object
set ns [new Simulator -multicast on]
# Open the nam trace file, associated with nf, log everything as nam
output in nf
set nf [open out.nam w]
$ns namtrace-all $nf
set node_(n0) [$ns node]
set node_(n1) [$ns node]
set node_(n2) [$ns node]
set node_(n3) [$ns node]
set node_(n4) [$ns node] 
set node_(n5) [$ns node]
set node_(n6) [$ns node]
set node_(n7) [$ns node]
set node_(n8) [$ns node]
set node_(n9) [$ns node]
set node_(n10) [$ns node]
set node_(n11) [$ns node]
set node_(n12) [$ns node]
set node_(n13) [$ns node]
set node_(n14) [$ns node]
set node_(n15) [$ns node]
set node_(n16) [$ns node]
set node_(n17) [$ns node]
set node_(n18) [$ns node]
set node_(n19) [$ns node]
set node_(n20) [$ns node]
set node_(n21) [$ns node]
set node_(n22) [$ns node]
set node_(n23) [$ns node]
set node_(n24) [$ns node]
set node_(n25) [$ns node]
#Create a duplex link between the nodes
$ns duplex-link $node_(n0) $node_(n2) 3.0Mb 10ms DropTail
$ns duplex-link $node_(n0) $node_(n1) 3.0Mb 10ms DropTail
$ns duplex-link $node_(n1) $node_(n3) 2.0Mb 10ms DropTail
$ns duplex-link $node_(n3) $node_(n4) 1.5Mb 10ms DropTail
$ns duplex-link $node_(n3) $node_(n7) 1.5Mb 10ms DropTail 
$ns duplex-link $node_(n2) $node_(n5) 1.0Mb 10ms DropTail
$ns duplex-link $node_(n2) $node_(n6) 1.5Mb 10ms DropTail
$ns duplex-link $node_(n0) $node_(n3) 1.5Mb 10ms DropTail
$ns duplex-link $node_(n8) $node_(n9) 2.0Mb 10ms DropTail
$ns duplex-link $node_(n8) $node_(n10) 3.0Mb 10ms DropTail
$ns duplex-link $node_(n9) $node_(n11) 2.0Mb 10ms DropTail
$ns duplex-link $node_(n11) $node_(n12) 1.5Mb 10ms DropTail
$ns duplex-link $node_(n11) $node_(n15) 1.5Mb 10ms DropTail
$ns duplex-link $node_(n10) $node_(n13) 1.0Mb 10ms DropTail
$ns duplex-link $node_(n10) $node_(n14) 1.5Mb 10ms DropTail
$ns duplex-link $node_(n8) $node_(n11) 1.5Mb 10ms DropTail
$ns duplex-link $node_(n16) $node_(n18) 3.0Mb 10ms DropTail
$ns duplex-link $node_(n16) $node_(n17) 3.0Mb 10ms DropTail
$ns duplex-link $node_(n17) $node_(n19) 2.0Mb 10ms DropTail
$ns duplex-link $node_(n19) $node_(n20) 1.5Mb 10ms DropTail
$ns duplex-link $node_(n19) $node_(n23) 1.5Mb 10ms DropTail
$ns duplex-link $node_(n18) $node_(n21) 1.0Mb 10ms DropTail
$ns duplex-link $node_(n18) $node_(n22) 1.5Mb 10ms DropTail
$ns duplex-link $node_(n16) $node_(n19) 1.5Mb 10ms DropTail
$ns duplex-link $node_(n24) $node_(n0) 3.0Mb 10ms DropTail
$ns duplex-link $node_(n24) $node_(n8) 3.0Mb 10ms DropTail
$ns duplex-link $node_(n25) $node_(n8) 3.0Mb 10ms DropTail
$ns duplex-link $node_(n16) $node_(n25) 3.0Mb 10ms DropTail
#setting orientation of links
$ns duplex-link-op $node_(n0) $node_(n3) orient down
$ns duplex-link-op $node_(n0) $node_(n1) orient left-down
$ns duplex-link-op $node_(n0) $node_(n2) orient right-down 
$ns duplex-link-op $node_(n1) $node_(n3) orient right-down
$ns duplex-link-op $node_(n3) $node_(n4) orient left-down
$ns duplex-link-op $node_(n3) $node_(n7) orient right-down
$ns duplex-link-op $node_(n2) $node_(n5) orient right-down
$ns duplex-link-op $node_(n2) $node_(n6) orient right
$ns duplex-link-op $node_(n8) $node_(n11) orient down
$ns duplex-link-op $node_(n8) $node_(n9) orient left-down
$ns duplex-link-op $node_(n8) $node_(n10) orient right-down
$ns duplex-link-op $node_(n9) $node_(n11) orient right-down
$ns duplex-link-op $node_(n11) $node_(n12) orient left-down
$ns duplex-link-op $node_(n11) $node_(n15) orient right-down
$ns duplex-link-op $node_(n10) $node_(n13) orient right-down
$ns duplex-link-op $node_(n10) $node_(n14) orient right
$ns duplex-link-op $node_(n16) $node_(n19) orient down
$ns duplex-link-op $node_(n16) $node_(n17) orient left-down
$ns duplex-link-op $node_(n16) $node_(n18) orient right-down
$ns duplex-link-op $node_(n17) $node_(n19) orient right-down
$ns duplex-link-op $node_(n19) $node_(n20) orient left-down
$ns duplex-link-op $node_(n19) $node_(n23) orient right-down
$ns duplex-link-op $node_(n18) $node_(n21) orient right-down
$ns duplex-link-op $node_(n18) $node_(n22) orient right
$ns duplex-link-op $node_(n24) $node_(n0) orient left-down
$ns duplex-link-op $node_(n24) $node_(n8) orient right-down
$ns duplex-link-op $node_(n25) $node_(n8) orient left-down
$ns duplex-link-op $node_(n25) $node_(n16) orient right-down
$node_(n0) set X_ -57.6704
$node_(n0) set Y_ 74.9762 
$node_(n0) set Z_ 0.0
$node_(n1) set X_ -74.9762
$node_(n1) set Y_ 50.9936
$node_(n1) set Z_ 0.0
$node_(n2) set X_ -36.0815
$node_(n2) set Y_ 48.2768
$node_(n2) set Z_ 0.0
$node_(n3) set X_ -56.8873
$node_(n3) set Y_ 38.8308
$node_(n3) set Z_ 0.0
$node_(n4) set X_ -76.5445
$node_(n4) set Y_ 10.1674
$node_(n4) set Z_ 0.0
$node_(n5) set X_ -38.0313
$node_(n5) set Y_ 7.9817
$node_(n5) set Z_ 0.0
$node_(n6) set X_ -19.8069
$node_(n6) set Y_ 7.9817
$node_(n6) set Z_ 0.0
$node_(n7) set X_ -57.8945
$node_(n7) set Y_ 10.2669
$node_(n7) set Z_ 0.0
$node_(n8) set X_ 39.0212
$node_(n8) set Y_ 74.9762
$node_(n8) set Z_ 0.0
$node_(n9) set X_ 8.07317
$node_(n9) set Y_ 50.9936 
$node_(n9) set Z_ 0.0
$node_(n10) set X_ 88.6017
$node_(n10) set Y_ 50.9936
$node_(n10) set Z_ 0.0
$node_(n11) set X_ 37.3668
$node_(n11) set Y_ 50.9936
$node_(n11) set Z_ 0.0
$node_(n12) set X_ 16.88
$node_(n12) set Y_ 10.1674
$node_(n12) set Z_ 0.0
$node_(n13) set X_ 64.635
$node_(n13) set Y_ 27.4717
$node_(n13) set Z_ 0.0
$node_(n14) set X_ 86.0753
$node_(n14) set Y_ 7.9817
$node_(n14) set Z_ 0.0
$node_(n15) set X_ 45.6967
$node_(n15) set Y_ 29.2669
$node_(n15) set Z_ 0.0
$node_(n16) set X_ 148.967
$node_(n16) set Y_ 72.6919
$node_(n16) set Z_ 0.0
$node_(n17) set X_ 125.115
$node_(n17) set Y_ 49.8054
$node_(n17) set Z_ 0.0
$node_(n18) set X_ 183.037
$node_(n18) set Y_ 49.8054 
$node_(n18) set Z_ 0.0
$node_(n19) set X_ 152.962
$node_(n19) set Y_ 50.868
$node_(n19) set Z_ 0.0
$node_(n20) set X_ 133.147
$node_(n20) set Y_ 10.096
$node_(n20) set Z_ 0.0
$node_(n21) set X_ 208.519
$node_(n21) set Y_ 11.5933
$node_(n21) set Z_ 0.0
$node_(n22) set X_ 183.386
$node_(n22) set Y_ 10.0766
$node_(n22) set Z_ 0.0
$node_(n23) set X_ 161.768
$node_(n23) set Y_ 10.4865
$node_(n23) set Z_ 0.0
$node_(n24) set X_ -10.6704
$node_(n24) set Y_ 100.9762
$node_(n24) set Z_ 0.0
$node_(n25) set X_ 100.00
$node_(n25) set Y_ 100.9762
$node_(n25) set Z_ 0.0
$ns at 0.0 "$node_(n0) label S"
$ns at 0.0 "$node_(n1) label N1"
$ns at 0.0 "$node_(n2) label N3"
$ns at 0.0 "$node_(n3) label N2"
$ns at 0.0 "$node_(n4) label R1" 
$ns at 0.0 "$node_(n7) label R2"
$ns at 0.0 "$node_(n5) label R3"
$ns at 0.0 "$node_(n6) label R4"
$ns at 0.0 "$node_(n8) label S"
$ns at 0.0 "$node_(n9) label N1"
$ns at 0.0 "$node_(n10) label N3"
$ns at 0.0 "$node_(n11) label N2"
$ns at 0.0 "$node_(n12) label R1"
$ns at 0.0 "$node_(n13) label R2"
$ns at 0.0 "$node_(n14) label R3"
$ns at 0.0 "$node_(n15) label R4"
$ns at 0.0 "$node_(n16) label S"
$ns at 0.0 "$node_(n17) label N1"
$ns at 0.0 "$node_(n18) label N3"
$ns at 0.0 "$node_(n19) label N2"
$ns at 0.0 "$node_(n20) label R1"
$ns at 0.0 "$node_(n21) label R2"
$ns at 0.0 "$node_(n22) label R3"
$ns at 0.0 "$node_(n23) label R4"
$ns at 0.0 "$node_(n24) label Overlay"
$ns at 0.0 "$node_(n25) label Overlay"
$ns color 1 blue
# Define a 'finish' procedure
proc finish {} {
global ns nf
$ns flush-trace
#Close the trace file 
close $nf
#Execute nam on the trace file
exec nam out.nam &
exit 0
}
#Call the finish procedure after 5 seconds of simulation time
$ns at 5.0 "finish"
# Run the simulation
$ns run