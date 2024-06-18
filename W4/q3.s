# $a0 = &array[0]
# $a1 = 12
# $ra = main

# stack = main, 
max:
	# $a0 = array
	# $a1 = length
	# what do we need to push (remember to mirror in epilogue)
	push	$ra
	push	$s0
max_body: 
#     $t0 = first_element = array[0];
	lw	$s0, array

max_body_if:
	bne	$a1, 1, max_body_else

	move	$v0, $s0
	b	max_epilogue
	li	$t0, 1

max_body_else:
        # $t1 = max_so_far = max(&array[1], length - 1);
	addi	$a0, 4
	addi	$a1, -1
	jal	max

	move	$t1, $v0
max_body_else_if:
	ble	$s0, $t1, max_body_else_if_end

	move	$t1, $s0
max_body_else_if_end:
	move	$v0, $t1

	b	max_epilogue
max_body_if_end:

max_epilogue:
	# what do we need to pop
	pop	$s0
	pop	$ra
	jr	$ra

    .data
array:  .word 1, 2, 3, 4
	.word 3, 4, 5, 6
	.word 5, 6, 7, 8