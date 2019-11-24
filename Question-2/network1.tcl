#Create a simulator object
set ns [new Simulator]

#Open the nam trace file
set nf [open out.nam w]
$ns namtrace-all $nf

set tf [open net1.tr w]
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


set networkSize 50
for {set i 0} {$i < $networkSize} {incr i} {
    set n($i) [$ns node]
}


for {set i 0} {$i < $networkSize} {incr i} {
    $ns duplex-link $n($i) $n([expr ($i+1)%7]) 10Mb     10ms DropTail
}

for {set i 10} {$i < $networkSize} {$i + 5} {
    $ns duplex-link $n($i) $n([expr ($i+1)%$networkSize]) 10Mb     10ms DropTail
}


#Call the finish procedure after 5 seconds simulation time
$ns at 100.0 "finish"

#Run the simulation
$ns run


