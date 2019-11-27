#Create a simulator object
set ns [new Simulator]

# udp traffic = green 
$ns color 1 Blue
$ns color 2 Red
$ns color 3 Green

#Open the nam trace file
set nf [open out.nam w]
$ns namtrace-all $nf

set tf [open star75DV.tr w]
$ns trace-all $tf

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


set networkSize 75
for {set i 0} {$i < $networkSize} {incr i} {
    set n1($i) [$ns node]
    set n2($i) [$ns node]
}


set R1 [$ns node]
set R2 [$ns node]
set R3 [$ns node]

$R1 shape square
$R2 shape square
$R3 shape square

$ns duplex-link $R1 $R2 100Mb 15ms DropTail
$ns duplex-link $R1 $R3 50Mb 8ms DropTail
$ns duplex-link $R2 $R3 50Mb 8ms DropTail

$ns duplex-link $R1 $n1(0) 10Mb 5ms DropTail
$ns duplex-link $R3 $n2(0) 10Mb 5ms DropTail



for {set i 0} {$i < $networkSize} {incr i} {
    $ns duplex-link $n1($i) $n1([expr ($i+1)%3]) 10Mb 10ms DropTail
    $ns duplex-link $n2($i) $n2([expr ($i+1)%3]) 10Mb 10ms DropTail
}

for {set i 0} {$i < 8} {incr i} {
	set udp($i) [new Agent/UDP]
    $ns attach-agent $n1([expr ($i*7)%$networkSize]) $udp($i)
    set null($i) [new Agent/Null]
    $ns attach-agent $n2([expr ($i*9)%$networkSize]) $null($i)
    $ns connect $udp($i) $null($i)
    $udp($i) set fid_ 3

    set cbr($i) [new Application/Traffic/CBR]
    $cbr($i) attach-agent $udp($i)
    $cbr($i) set type_ CBR
    $cbr($i) set packet_size_ [expr (255*$i)]
    $cbr($i) set rate_ 1mb
    $cbr($i) set random_ false

    set tcp($i) [new Agent/TCP]
    $tcp($i) set class_ 2
    $ns attach-agent $n2([expr ($i*3)%$networkSize]) $tcp($i)
    set sink($i) [new Agent/TCPSink]
    $ns attach-agent $n1([expr ($i*2+20)%$networkSize]) $sink($i)
    $ns connect $tcp($i) $sink($i)
    $tcp($i) set fid_ 1

    set ftp($i) [new Application/FTP]
    $ftp($i) attach-agent $tcp($i)
    $ftp($i) set type_ FTP

    set udp2($i) [new Agent/UDP]
    $ns attach-agent $n2([expr ($i*4)%$networkSize]) $udp2($i)
    set null2($i) [new Agent/Null]
    $ns attach-agent $n1([expr ($i*2)%$networkSize]) $null2($i)
    $ns connect $udp2($i) $null($i)
    $udp2($i) set fid_ 3

    set cbr2($i) [new Application/Traffic/CBR]
    $cbr2($i) attach-agent $udp2($i)
    $cbr2($i) set type_ CBR
    $cbr2($i) set packet_size_ [expr (255*$i)]
    $cbr2($i) set rate_ 1mb
    $cbr2($i) set random_ false

    set tcp1($i) [new Agent/TCP]
    $tcp1($i) set class_ 2
    $ns attach-agent $n1([expr ($i*3)%$networkSize]) $tcp1($i)
    set sink1($i) [new Agent/TCPSink]
    $ns attach-agent $n2([expr ($i*2+20)%$networkSize]) $sink1($i)
    $ns connect $tcp1($i) $sink1($i)
    $tcp1($i) set fid_ 1

    set ftp1($i) [new Application/FTP]
    $ftp1($i) attach-agent $tcp1($i)
    $ftp1($i) set type_ FTP
}

# use the distance vector routing protocol
$ns rtproto DV


for {set i 0} {$i < 8} {incr i} {
    $ns at 0.01 "$cbr($i) start"
    $ns at 0.01 "$ftp($i) start"
    $ns at 15.0 "$cbr($i) stop"
    $ns at 20.0 "$ftp($i) stop"
    $ns at 0.01 "$cbr2($i) start"
    $ns at 0.01 "$ftp1($i) start"
    $ns at 15.0 "$cbr2($i) stop"
    $ns at 20.0 "$ftp1($i) stop"

}

$ns rtmodel-at 6.3 down $n1(0) $R1
$ns rtmodel-at 6.35 up $n1(0) $R1

$ns rtmodel-at 6.4 down $R1 $R2
$ns rtmodel-at 8.0 up $R1 $R2

$ns rtmodel-at 6.2 down $R2 $R3
$ns rtmodel-at 8.2 up $R2 $R3

$ns rtmodel-at 7.8 down $R1 $R3
$ns rtmodel-at 13.0 up $R1 $R3

#Call the finish procedure after 5 seconds simulation time
$ns at 20.0 "finish"

#Run the simulation
$ns run


