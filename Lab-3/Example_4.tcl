 #-------Event scheduler object creation--------#
 set ns [ new Simulator ]
#------------ CREATING NAM OBJECTS -----------------#
 set nf [open example4.nam w]
 $ns namtrace-all $nf
 
 #Open the trace file
 set nt [open example4.tr w]
 $ns trace-all $nt
 
 set proto rlm
#------------COLOR DESCRIPTION---------------#
 $ns color 1 dodgerblue
 $ns color 2 red
 $ns color 3 cyan
 $ns color 4 green
 $ns color 5 yellow
 $ns color 6 black
 $ns color 7 magenta
 $ns color 8 gold
 $ns color 9 red
# --------- CREATING SENDER - RECEIVER - ROUTER NODES-----------#
 set C1 [$ns node]
 set C2 [$ns node]
 set C3 [$ns node]
 set C4 [$ns node]
 set R1 [$ns node]
 set R2 [$ns node]
 set R3 [$ns node]
 set R4 [$ns node]
 set ROU1 [$ns node]
 set ROU2 [$ns node]
 set ROU3 [$ns node]
# --------------CREATING DUPLEX LINK -----------------------#
 $ns duplex-link $C1 $ROU1 1Mb 10ms DropTail
 $ns duplex-link $C2 $ROU1 500Kb 10ms DropTail
 $ns duplex-link $C3 $ROU1 750Kb 10ms DropTail
 $ns duplex-link $C4 $ROU2 1Mb 10ms DropTail
 $ns duplex-link $R1 $ROU1 1Mb 10ms DropTail
 $ns duplex-link $R2 $ROU1 1Mb 10ms DropTail
 $ns duplex-link $R3 $ROU1 1Mb 10ms DropTail
 $ns duplex-link $R4 $ROU3 1Mb 10ms DropTail
 $ns duplex-link $ROU2 $ROU1 1Mb 10ms DropTail
 $ns duplex-link $ROU2 $ROU3 1Mb 10ms DropTail
 $ns duplex-link $ROU1 $ROU3 1Mb 10ms DropTail
#-------------QUEUE SIZE DESCRIPTION---------------#
 $ns queue-limit $ROU1 $ROU2 18
 $ns queue-limit $ROU1 $ROU3 18
 $ns queue-limit $ROU2 $ROU1 20
 $ns queue-limit $ROU3 $ROU1 20
#-----------CREATING ORIENTATION -------------------------#
 $ns duplex-link-op $C1 $ROU1 orient down
 
$ns duplex-link-op $C2 $ROU1 orient down-right
$ns duplex-link-op $C3 $ROU1 orient down-left
$ns duplex-link-op $C4 $ROU2 orient up
$ns duplex-link-op $R1 $ROU1 orient up
$ns duplex-link-op $R2 $ROU1 orient up-right
$ns duplex-link-op $R3 $ROU1 orient up-left
$ns duplex-link-op $R4 $ROU3 orient down
$ns duplex-link-op $ROU1 $ROU2 orient down-right
$ns duplex-link-op $ROU3 $ROU2 orient down-right
# --------------LABELLING -----------------------------#
 $ns at 0.0 "$C1 label CL1"
 $ns at 0.0 "$C2 label CL2"
 $ns at 0.0 "$C3 label CL3"
 $ns at 0.0 "$C4 label CL4"
 $ns at 0.0 "$R1 label RC1"
 $ns at 0.0 "$R2 label RC2"
 $ns at 0.0 "$R3 label RC3"
 $ns at 0.0 "$R4 label RC4"
 $ns at 0.0 "$ROU1 label ROU1"
 $ns at 0.0 "$ROU2 label ROU2"
 $ns at 0.0 "$ROU3 label ROU3"
# --------------- CONFIGURING NODES -----------------#
 $ROU1 shape square
 $ROU2 shape square
 $ROU3 shape square
# ----------------QUEUES POSITIONING AND ESTABLISHMENT -------------#
$ns duplex-link-op $ROU2 $ROU1 queuePos 0.1
#$ns duplex-link-op $ROU2 $C5 queuePos 0.1
$ns duplex-link-op $ROU3 $ROU1 queuePos 0.1
#--------SETTING IDENTIFICATION COLORS TO ROUTER-LINKS----------#
 $ns duplex-link-op $ROU1 $ROU2 color cyan
 $ns duplex-link-op $ROU1 $ROU3 color cyan
 $ns duplex-link-op $ROU2 $ROU3 color cyan
# ---------------- FINISH PROCEDURE -------------#
proc finish {} {
     global ns nf nt nf1
     $ns flush-trace
	 close $nf
	 puts "running nam..."
	 exec nam example4.nam &
	 exit 0}
#Calling finish procedure
 $ns at 20.0 "finish"
 $ns run
#--------How to run---------#
