#Create a simulator object
set ns [new Simulator]

#Open the nam trace file
set nf [open out.nam w]
$ns namtrace-all $nf

set tf [open lab5DV.tr w]
$ns trace-all $tf

set networkSize 7
for {set i 0} {$i < $networkSize} {incr i} {
	set n($i) [$ns node]
}


for {set i 0} {$i < $networkSize} {incr i} {
	$ns duplex-link $n($i) $n([expr ($i+1)%$networkSize]) 10Mb     10ms DropTail
}

# use the distance vector routing protocol
$ns rtproto DV

#create a UDP agent and attach it to node n(0)
set udp0 [new Agent/UDP]
$ns attach-agent $n(0) $udp0

# create a CBR traffic source and attach it to udp0
set cbr0 [new Application/Traffic/CBR]
$cbr0 set packetSize_ 500
$cbr0 set interval_ 0.002
$cbr0 attach-agent $udp0

set null0 [new Agent/Null]
$ns attach-agent $n(3) $null0

$ns connect $udp0 $null0

$ns at 0.5 "$cbr0 start"
$ns at 4.5 "$cbr0 stop"

$ns rtmodel-at 1.0 down $n(1) $n(2)
$ns rtmodel-at 2.0 up $n(1) $n(2)


#Define a 'finish' procedure
proc finish {} {
        global ns nf tf
        $ns flush-trace
	#Close the trace file
        close $nf
        close $tf
	#Execute nam on the trace file
        exec nam out.nam &
        exit 0
}


# Insert your own code for topology creation
# and agent definitions, etc. here


#Call the finish procedure after 5 seconds simulation time
$ns at 5.0 "finish"

#Run the simulation
$ns run


