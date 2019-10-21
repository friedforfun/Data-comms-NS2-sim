#-------Event scheduler object creation--------#

set ns [ new Simulator -multicast on]
#------------ CREATING NAM OBJECTS -----------------#
set nf [open rands2.nam w]
$ns namtrace-all $nf
#Open the trace file
set nt [open rands2.tr w]
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
#$ns queue-limit $ $n1 15
# --------------CREATING LABELLING -----------------------------#
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
#--------SETTING IDENTIFICATION COLORS TO ROUTER-LINKS--------#

$ns duplex-link-op $ROU1 $ROU2 color cyan
$ns duplex-link-op $ROU1 $ROU3 color cyan
$ns duplex-link-op $ROU2 $ROU3 color cyan
# ----------------ESTABLISHING COMMUNICATION -------------#

#--------------TCP CONNECTION BETWEEN NODES---------------#
 #$tcp0 set fid_ 3
 #$Base1 set fid_ 3
 #$tcp0 set window_ 15
 #$ftp0 set packetSize_ 1000
 #$ftp0 set interval_ .05


 set tcp1 [$ns create-connection TCP $C1 TCPSink $R4 1]
 $tcp1 set class_ 1
 $tcp1 set maxcwnd_ 16
 $tcp1 set packetsize_ 4000
 $tcp1 set fid_ 1
 set ftp1 [$tcp1 attach-app FTP]
 $ftp1 set interval_ .005
 $ns at 0.2 "$ftp1 start"
 $ns at 4.0 "$ftp1 stop"



 set tcp2 [$ns create-connection TCP $C2 TCPSink $R3 1]
 $tcp2 set class_ 1
 $tcp2 set maxcwnd_ 16
 $tcp2 set packetsize_ 4000
 $tcp2 set fid_ 2
 set ftp2 [$tcp2 attach-app FTP]
 $ftp2 set interval_ .005
 $ns at 0.7 "$ftp2 start"
 $ns at 4.0 "$ftp2 stop"
 

 set tcp3 [$ns create-connection TCP $C3 TCPSink $R2 1]
 $tcp3 set class_ 1
 $tcp3 set maxcwnd_ 16
 $tcp3 set packetsize_ 4000
 $tcp3 set fid_ 3
 set ftp3 [$tcp3 attach-app FTP]
 $ftp3 set interval_ .005
 $ns at 1.2 "$ftp3 start"
 $ns at 4.0 "$ftp3 stop"


 set tcp4 [$ns create-connection TCP $C4 TCPSink $R1 1]
 $tcp4 set class_ 1
 $tcp4 set maxcwnd_ 16
 $tcp4 set packetsize_ 4000
 $tcp4 set fid_ 4
 set ftp4 [$tcp4 attach-app FTP]
 $ftp1 set interval_ .005
 $ns at 2.5 "$ftp4 start"
 $ns at 4.0 "$ftp4 stop"


#---------------- FINISH PROCEDURE -------------#

proc finish {} {
 global ns nf nt nf1
 set PERL "/bin/perl5.8.2"
 set NSHOME "/home/ns-allinone-2.30"
 ;#change path
 set XGRAPH "$NSHOME/bin/xgraph"
 set SETFID "$NSHOME/ns-2.30/bin/set_flow_id"
 set RAW2XG_SCTP "$NSHOME/ns-2.30/bin/raw2xg-sctp"
 $ns flush-trace
 close $nf
 exec $PERL $SETFID -s Rands2.tr | \
 $PERL $RAW2XG_SCTP -A -q > Rands2.rands
 exec $XGRAPH -bb -tk -nl -m -x time -y packets
Rands2.rands &
 $ns flush-trace
 close $nf
 exit 0
 }
#Calling finish procedure
$ns at 20.0 "finish"
$ns run
