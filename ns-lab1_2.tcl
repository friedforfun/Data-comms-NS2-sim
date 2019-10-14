#Create a simulator object
set ns [new Simulator]

#Define different colors for data flows (for NAM)
$ns color 1 Blue
$ns color 2 Red
$ns color 3 Green

#Open the NAM trace file
set nf [open out.nam w]
$ns namtrace-all $nf

#Define a 'finish' procedure
proc finish {} {
        global ns nf
        $ns flush-trace
        #Close the NAM trace file
        close $nf
        #Execute NAM on the trace file
        exec nam out.nam &
        exit 0
}

#Create four nodes
set n0 [$ns node]
set n1 [$ns node]
set n2 [$ns node]
set n3 [$ns node]
set n4 [$ns node]

#Create links between the nodes
$ns duplex-link $n3 $n2 2.5Mb 10ms DropTail
$ns duplex-link $n2 $n0 2Mb 10ms DropTail
$ns duplex-link $n2 $n1 1.7Mb 20ms DropTail
$ns duplex-link $n1 $n4 2Mb 10ms DropTail
$ns duplex-link $n0 $n4 2Mb 10ms DropTail


#Set Queue Size of link (n2-n3) to 10
#$ns queue-limit $n2 $n1 1
#$ns queue-limit $n2 $n0 1

#Give node position (for NAM)
$ns duplex-link-op $n3 $n2 orient left
$ns duplex-link-op $n2 $n0 orient left-up
$ns duplex-link-op $n2 $n1 orient left-down
$ns duplex-link-op $n1 $n4 orient left-up
$ns duplex-link-op $n0 $n4 orient left-down

#Monitor the queue for link (n2-n3). (for NAM)
#$ns duplex-link-op $n2 $n1 queuePos 0.5
#$ns duplex-link-op $n2 $n0 queuePos 0.5

#Setup a UDP connection
set udp1 [new Agent/UDP]
$ns attach-agent $n1 $udp1
set null1 [new Agent/Null]
$ns attach-agent $n4 $null1
$ns connect $udp1 $null1
$udp1 set fid_ 2

#Setup a CBR over UDP connection
set cbr1 [new Application/Traffic/CBR]
$cbr1 attach-agent $udp1
$cbr1 set type_ CBR
$cbr1 set packet_size_ 1000
$cbr1 set rate_ 1mb
$cbr1 set random_ false

##############--UDP--#################
#Setup a UDP connection

set udp [new Agent/UDP]
$ns attach-agent $n3 $udp
set null [new Agent/Null]
$ns attach-agent $n4 $null
$ns connect $udp $null
$udp set fid_ 3

#Setup a CBR over udp1 connection
set cbr [new Application/Traffic/CBR]
$cbr attach-agent $udp
$cbr set type_ CBR
$cbr set packet_size_ 1000
$cbr set rate_ 1mb
$cbr set random_ false

############--TCP--################
#Setup a TCP connection
set tcp [new Agent/TCP]
$tcp set class_ 2
$ns attach-agent $n3 $tcp
set sink [new Agent/TCPSink]
$ns attach-agent $n1 $sink
$ns connect $tcp $sink
$tcp set fid_ 1

#Setup a FTP over TCP connection
set ftp [new Application/FTP]
$ftp attach-agent $tcp
$ftp set type_ FTP
###################################

#Schedule events for the CBR and FTP agents
$ns at 0.01 "$cbr start"
$ns at 0.02 "$ftp start"
$ns at 0.03 "$cbr1 start"
$ns at 4.0 "$ftp stop"
$ns at 4.5 "$cbr stop"
$ns at 4.6 "$cbr1 stop"


#Detach tcp and sink agents (not really necessary)
$ns at 4.5 "$ns detach-agent $n3 $tcp ; $ns detach-agent $n1 $sink"

#Call the finish procedure after 5 seconds of simulation time
$ns at 5.0 "finish"

#Print CBR packet size and interval
puts "CBR packet size = [$cbr set packet_size_]"
puts "CBR interval = [$cbr set interval_]"

#Run the simulation
$ns run

