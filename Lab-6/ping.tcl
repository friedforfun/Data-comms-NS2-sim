#Create a simulator object
set ns [new Simulator]

#Open a trace file
set nf [open ping.nam w]
$ns namtrace-all $nf

#Open the trace file
set nt [open ping.tr w]
$ns trace-all $nt

#Define a 'finish' procedure
proc finish {} {
        global ns nf nt
        $ns flush-trace
        close $nf 
        puts "running nam..."
        exec nam ping.nam &
        exit 0
}

#Create three nodes
set n0 [$ns node]
set n1 [$ns node]
set n2 [$ns node]
#Connect the nodes with two links
$ns duplex-link $n0 $n1 1Mb 10ms DropTail
$ns duplex-link $n1 $n2 1Mb 10ms DropTail
#Define a 'recv' function for the class 'Agent/Ping'
Agent/Ping instproc recv {from rtt} {
$self instvar node_
puts "node [$node_ id] received ping answer from \
              $from with round-trip-time $rtt ms."
}
#Create two ping agents and attach them to the nodes n0 and n2
set p0 [new Agent/Ping]
$ns attach-agent $n0 $p0
set p1 [new Agent/Ping]
$ns attach-agent $n2 $p1
#Connect the two agents
$ns connect $p0 $p1
#Schedule events
$ns at 0.2 "$p0 send"
$ns at 0.4 "$p1 send"
$ns at 0.6 "$p0 send"
$ns at 0.6 "$p1 send"
$ns at 1.0 "finish"
#Run the simulation
$ns run

