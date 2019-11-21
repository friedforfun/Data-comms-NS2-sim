
#-------Event scheduler object creation--------#
set ns [new Simulator]
#----------creating nam objects----------------#
set nf [open tcpred1.nam w]
$ns namtrace-all $nf
#open the trace file
set nt [open tcpred1.tr w]
$ns trace-all $nt
set proto rlm
$ns color 1 blue
$ns color 2 yellow
$ns color 3 red
#------- creating client- router- end server node-----------#
set Client1 [$ns node]
set Router1 [$ns node]
set Endserver1 [$ns node]
set Endserver2 [$ns node]
#---creating duplex link---------#
$ns duplex-link $Client1 $Router1 2Mb 100ms DropTail
$ns duplex-link $Router1 $Endserver1 100Kb 100ms DropTail
$ns duplex-link $Router1 $Endserver2 200Kb 100ms DropTail
#----------------creating orientation------------------#
$ns duplex-link-op $Client1 $Router1 orient right
$ns duplex-link-op $Router1 $Endserver1 orient up-right
$ns duplex-link-op $Router1 $Endserver2 orient down-right
#------------Labeling----------------#
$ns at 0.0 "$Client1 label Client1"
$ns at 0.0 "$Router1 label Router1"
$ns at 0.0 "$Endserver1 label Endserver1"
$ns at 0.0 "$Endserver2 label Endserver2"
#-----------Configuring nodes------------#
$Endserver1 shape hexagon
$Endserver2 shape hexagon
$Router1 shape square
#----------------Establishing queues---------#
#$ns duplex-link-op $Client1 $Router1 queuePos 0.1
#$ns duplex-link-op $Client2 $Router1 queuePos 0.1
#$ns duplex-link-op $Router1 $Router2 queuePos 0.1
#$ns duplex-link-op $Router2 $Endserver1 queuePos 0.5
#---------Establishing communication-------------#
#-------------Client1 to Endserver1---#
set tcp0 [new Agent/TCP]
$tcp0 set maxcwnd_ 16
$tcp0 set fid_ 1
$ns attach-agent $Client1 $tcp0
set sink0 [new Agent/TCPSink]
$ns attach-agent $Endserver1 $sink0
$ns connect $tcp0 $sink0
set ftp0 [new Application/FTP]
$ftp0 attach-agent $tcp0
$ns add-agent-trace $tcp0 tcp
$tcp0 tracevar cwnd_
$ns at 0.50 "$ftp0 start"
$ns at 8.5 "$ftp0 stop"
#-------------Client1 to Endserver2---#
set tcp1 [new Agent/TCP]
$tcp1 set maxcwnd_ 16
$tcp1 set fid_ 2
$ns attach-agent $Client1 $tcp1
set sink1 [new Agent/TCPSink]
$ns attach-agent $Endserver2 $sink1
$ns connect $tcp1 $sink1
set ftp1 [new Application/FTP]
$ftp1 attach-agent $tcp1
$ns add-agent-trace $tcp1 tcp
$tcp0 tracevar cwnd_
$ns at 0.50 "$ftp1 start"
$ns at 8.5 "$ftp1 stop"
#---------finish procedure--------#
proc finish {} {
 global ns nf nt
 $ns flush-trace
 close $nf
 puts "running nam..."
 exec nam tcpred1.nam &
 exit 0
 }
#Calling finish procedure
$ns at 10.0 "finish"
$ns run