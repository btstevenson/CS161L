lw    $2,   128   	# make sure to load this at 128 and 128/4 = 32

nop
nop

add   $3,   $2,   $2

nop
nop

sw    $3,   132

nop
nop

sub   $4,   $3,   $2
addi  $5,   $3,   12

nop
nop

and   $6,   $5,   $3

nop
nop

or    $7,   $6,   $2
nor   $8,   $6,   $2
slt   $6,   $5,   $4

beq   $0,   $0,   -32

