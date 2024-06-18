# char flag[6][8] = flag
# max_rows = 6
# max_col = 8
# &flag[0][0] = &flag
# &flag[0][7] = &flag + 7
# &flag[1][0] = &flag + 8
# &flag[1][7] = &flag + 8 + 7
# &flag[2][5] = &flag + 8 + 8 + 5 = &flag + 8 * 2 +  5
# &flag[row][col] = &flag + max_col * row + col

.data
flag:	.byte '#', '#', '#', '#', '#', '.', '.', '#', '#', '#', '#', '#'
	.byte '#', '#', '#', '#', '#', '.', '.', '#', '#', '#', '#', '#'
	.byte '.', '.', '.', '.', '.', '.', '.', '.', '.', '.', '.', '.'
	.byte '.', '.', '.', '.', '.', '.', '.', '.', '.', '.', '.', '.'
	.byte '#', '#', '#', '#', '#', '.', '.', '#', '#', '#', '#', '#'
	.byte '#', '#', '#', '#', '#', '.', '.', '#', '#', '#', '#', '#'

.text
# CONSTANTS
FLAG_ROWS = 6
FLAG_COLS = 12

main:

main_prologue:
	# set up your function
	# everything you push
main_body:
main_loop_rows_init:
	# $t0 = row, $t1 = col
	li	$t0, 0		# int row = 0;

main_loop_rows_cond:
	bge	$t0, FLAG_ROWS, main_loop_rows_end 

main_loop_cols_init:
	li	$t1, 0		# int col = 0;

main_loop_cols:
	bge	$t1, FLAG_COLS, main_loop_cols_end

	# &flag[row][col] = &flag + max_col * row + col
	# la	$t2, flag		# $t2 = &flag
	# mul	$t3, FLAG_COLS, $t0	# $t3 = max_col * row
	# add	$t3, $t3, $t1		# $t3 = max_col * row + col
	# add	$t3, $t3, $t2		# $t3 = &flag[row][col] = &flag + max_col * row + col
	# lb	$a0, ($t3)	

	mul	$t3, FLAG_COLS, $t0	# $t3 = max_col * row
	add	$t3, $t3, $t1		# $t3 = max_col * row + col
	lb	$a0, flag($t3)		# $t3 = &flag[row][col] = &flag + max_col * row + col

	# printf("%c", flag[row][col]);
		
	li	$v0, 11
	syscall

	addi	$t1, 1
	b	main_loop_cols

main_loop_cols_end:
	li	$a0, '\n'
	li	$v0, 11
	syscall

	addi	$t0, 1
	b	main_loop_rows_cond
main_loop_rows_end:

main_epilogue:
	# everything you pop
	li	$v0, 0
	jr	$ra
