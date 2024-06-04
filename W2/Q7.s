# Prints every third number from 24 to 42.

main:


loop:
loop_init:
# x = $t0
	li	$t0, 24
loop_condition:
	bge	$t0, 42, loop_end

loop_body:
	li	$v0, 1
	move	$a0, $t0
	syscall

	li	$v0, 11
	li	$a0, '\n'
	syscall

loop_increment:
	addi	$t0, 3

	b	loop_condition
loop_end:

epilogue:
	li	$v0, 0
	jr	$ra