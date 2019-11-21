#Create a simulator object
set ns [new Simulator]

#Open a nam trace file
set nf [open out.nam w]
$ns namtrace-all $nf
#Define a 'finish' procedure

proc finish {} {
global ns nf
$ns flush-trace
close $nf
exec nam out.nam &
exit 0
}

set n0 [$ns node]
set n1 [$ns node]
$n0 color blue
$n1 color red

#Connect the nodes with two links
$ns duplex-link $n0 $n1 1Mb 10ms DropTail

proc www_traffic { node0 node1 } {

global ns
set www_UDP_agent [new Agent/UDP]
set www_UDP_sink [new Agent/Null]
$ns attach-agent $node0 $www_UDP_agent
$ns attach-agent $node1 $www_UDP_sink
$ns connect $www_UDP_agent $www_UDP_sink
set www_CBR_source [new Application/Traffic/CBR]
$www_CBR_source attach-agent $www_UDP_agent
$www_CBR_source set packetSize_ 48
$www_CBR_source set interval_ 50ms
$ns at 0.2 "$www_CBR_source start"
#$ns at 0.2 "$cbr0 start"
$ns at 4.5 "$www_CBR_source stop"
}

www_traffic $n0 $n1
$ns at 4.0 "finish"
$ns run
