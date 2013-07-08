	.data
	.align 2
heap:
	.space	44
heap_length:
	.space	4
heapSize:
	.space	4

strs:
	.word	_S0
	.word	_S1
	.word	_S2
	.word	_S3
	.word	_S4
	.word	_S5
_S0:	.asciiz "\t"
_S1:	.asciiz "\n"
_S2:	.asciiz "Before the sort\n"
_S3:	.asciiz "==================\n"
_S4:	.asciiz "After the sort\n"
_S5:	.asciiz "==================\n"

	.text
	.align 2
	.globl main
swap:
	addu	$s7, $0, $s8
	addiu	$s8, $sp, -8
	lw	$t0, 8($s8)
	sll	$0, $0, 0
	addu	$at, $0, $t0
	sll	$at, $at, 2
	addu	$at, $at, $gp
	lw	$v0, 0($at)
	sll	$0, $0, 0
	sw	$v0, -4($s8)
	lw	$t1, 12($s8)
	sll	$0, $0, 0
	addu	$at, $0, $t1
	sll	$at, $at, 2
	addu	$at, $at, $gp
	lw	$v0, 0($at)
	sll	$0, $0, 0
	addu	$at, $0, $t0
	sll	$at, $at, 2
	addu	$at, $at, $gp
	sw	$v0, 0($at)
	lw	$t2, -4($s8)
	sll	$0, $0, 0
	addu	$at, $0, $t1
	sll	$at, $at, 2
	addu	$at, $at, $gp
	sw	$t2, 0($at)
_L0:
	jr	$ra
	addu	$s8, $0, $s7
maxHeap:
	sw	$ra, -4($sp)
	sw	$s8, -8($sp)
	addiu	$s8, $sp, -8
	addiu	$sp, $sp, -24
	lw	$t3, 8($s8)
	sll	$0, $0, 0
	sll	$v0, $t3, 1
	sw	$v0, -4($s8)
	sll	$v1, $t3, 1
	ori	$t9, $0, 1
	addu	$v0, $v1, $t9
	sw	$v0, -8($s8)
	sw	$t3, -12($s8)
	sw	$0, -16($s8)
	lw	$t4, -4($s8)
	sll	$0, $0, 0
	lw	$t5, 48($gp)
	sll	$0, $0, 0
	slt	$v1, $t5, $t4
	xori	$v1, $v1, 1
	beq	$v1, $0, _L21
	addu	$v0, $0, $0
	addu	$at, $0, $t4
	sll	$at, $at, 2
	addu	$at, $at, $gp
	lw	$v1, 0($at)
	sll	$0, $0, 0
	addu	$at, $0, $t3
	sll	$at, $at, 2
	addu	$at, $at, $gp
	lw	$t9, 0($at)
	sll	$0, $0, 0
	slt	$v1, $t9, $v1
	beq	$v1, $0, _L21
	sll	$0, $0, 0
	xori	$v0, $v0, 1
_L21:
	beq	$v0, $0, _L19
	sll	$0, $0, 0
	lw	$t6, -4($s8)
	sll	$0, $0, 0
	addu	$t7, $0, $t6
	sw	$t7, -12($s8)
	beq	$0, $0, _L20
	sll	$0, $0, 0
_L19:
	lw	$t8, 8($s8)
	sll	$0, $0, 0
	addu	$t0, $0, $t8
	sw	$t0, -12($s8)
_L20:
	lw	$t1, -8($s8)
	sll	$0, $0, 0
	lw	$t2, 48($gp)
	sll	$0, $0, 0
	slt	$v1, $t2, $t1
	xori	$v1, $v1, 1
	beq	$v1, $0, _L36
	addu	$v0, $0, $0
	addu	$at, $0, $t1
	sll	$at, $at, 2
	addu	$at, $at, $gp
	lw	$v1, 0($at)
	sll	$0, $0, 0
	lw	$t3, -12($s8)
	sll	$0, $0, 0
	addu	$at, $0, $t3
	sll	$at, $at, 2
	addu	$at, $at, $gp
	lw	$t9, 0($at)
	sll	$0, $0, 0
	slt	$v1, $t9, $v1
	beq	$v1, $0, _L36
	sll	$0, $0, 0
	xori	$v0, $v0, 1
_L36:
	beq	$v0, $0, _L34
	sll	$0, $0, 0
	lw	$t4, -8($s8)
	sll	$0, $0, 0
	addu	$t5, $0, $t4
	sw	$t5, -12($s8)
	beq	$0, $0, _L35
	sll	$0, $0, 0
_L34:
_L35:
	lw	$t6, -12($s8)
	sll	$0, $0, 0
	lw	$t7, 8($s8)
	sll	$0, $0, 0
	xor	$v0, $t6, $t7
	sltu	$v0, $0, $v0
	beq	$v0, $0, _L47
	sll	$0, $0, 0
	sw	$v1, -4($sp)
	sw	$t9, -8($sp)
	addiu	$sp, $sp, -8
	lw	$t0, -12($s8)
	sll	$0, $0, 0
	sw	$t0, -4($sp)
	lw	$t8, 8($s8)
	sll	$0, $0, 0
	sw	$t8, -8($sp)
	addiu	$sp, $sp, -8
	jal	swap
	sll	$0, $0, 0
	addiu	$sp, $sp, 8
	lw	$t9, 0($sp)
	addiu	$sp, $sp, 8
	lw	$v1, -4($sp)
	sll	$0, $0, 0
	addu	$v0, $0, $v0
	sw	$v1, -4($sp)
	sw	$t9, -8($sp)
	addiu	$sp, $sp, -8
	lw	$t1, -12($s8)
	sll	$0, $0, 0
	sw	$t1, -4($sp)
	addiu	$sp, $sp, -4
	jal	maxHeap
	sll	$0, $0, 0
	addiu	$sp, $sp, 4
	lw	$t9, 0($sp)
	addiu	$sp, $sp, 8
	lw	$v1, -4($sp)
	sll	$0, $0, 0
	addu	$v0, $0, $v0
	beq	$0, $0, _L48
	sll	$0, $0, 0
_L47:
_L48:
_L10:
	lw	$ra, 4($s8)
	lw	$s8, 0($s8)
	jr	$ra
	addiu	$sp, $sp, 24
buildMaxHeap:
	sw	$ra, -4($sp)
	sw	$s8, -8($sp)
	addiu	$s8, $sp, -8
	addiu	$sp, $sp, -12
	sw	$0, -4($s8)
	lw	$t2, 48($gp)
	sll	$0, $0, 0
	sra	$v0, $t2, 1
	addu	$t3, $0, $v0
	sw	$t3, -4($s8)
_L62:
	lw	$t4, -4($s8)
	sll	$0, $0, 0
	ori	$t9, $0, 1
	slt	$v0, $t4, $t9
	xori	$v0, $v0, 1
	beq	$v0, $0, _L63
	sll	$0, $0, 0
	sw	$v1, -4($sp)
	sw	$t9, -8($sp)
	addiu	$sp, $sp, -8
	lw	$t5, -4($s8)
	sll	$0, $0, 0
	sw	$t5, -4($sp)
	addiu	$sp, $sp, -4
	jal	maxHeap
	sll	$0, $0, 0
	addiu	$sp, $sp, 4
	lw	$t9, 0($sp)
	addiu	$sp, $sp, 8
	lw	$v1, -4($sp)
	sll	$0, $0, 0
	addu	$v0, $0, $v0
	lw	$t6, -4($s8)
	sll	$0, $0, 0
	ori	$t9, $0, 1
	subu	$v0, $t6, $t9
	addu	$t6, $0, $v0
	sw	$t6, -4($s8)
_L64:
	beq	$0, $0, _L62
	sll	$0, $0, 0
_L63:
_L57:
	lw	$ra, 4($s8)
	lw	$s8, 0($s8)
	jr	$ra
	addiu	$sp, $sp, 12
sort:
	sw	$ra, -4($sp)
	sw	$s8, -8($sp)
	addiu	$s8, $sp, -8
	addiu	$sp, $sp, -12
	sw	$0, -4($s8)
	sw	$v1, -4($sp)
	sw	$t9, -8($sp)
	addiu	$sp, $sp, -8
	addiu	$sp, $sp, 0
	jal	buildMaxHeap
	sll	$0, $0, 0
	addiu	$sp, $sp, 0
	lw	$t9, 0($sp)
	addiu	$sp, $sp, 8
	lw	$v1, -4($sp)
	sll	$0, $0, 0
	addu	$v0, $0, $v0
	lw	$t7, 48($gp)
	sll	$0, $0, 0
	addu	$t0, $0, $t7
	sw	$t0, -4($s8)
_L79:
	lw	$t8, -4($s8)
	sll	$0, $0, 0
	ori	$t9, $0, 2
	slt	$v0, $t8, $t9
	xori	$v0, $v0, 1
	beq	$v0, $0, _L80
	sll	$0, $0, 0
	sw	$v1, -4($sp)
	sw	$t9, -8($sp)
	addiu	$sp, $sp, -8
	lw	$t1, -4($s8)
	sll	$0, $0, 0
	sw	$t1, -4($sp)
	ori	$v1, $0, 1
	sw	$v1, -8($sp)
	addiu	$sp, $sp, -8
	jal	swap
	sll	$0, $0, 0
	addiu	$sp, $sp, 8
	lw	$t9, 0($sp)
	addiu	$sp, $sp, 8
	lw	$v1, -4($sp)
	sll	$0, $0, 0
	addu	$v0, $0, $v0
	lw	$t2, 48($gp)
	sll	$0, $0, 0
	ori	$t9, $0, 1
	subu	$v0, $t2, $t9
	addu	$t2, $0, $v0
	sw	$v1, -4($sp)
	sw	$t9, -8($sp)
	addiu	$sp, $sp, -8
	ori	$v1, $0, 1
	sw	$v1, -4($sp)
	addiu	$sp, $sp, -4
	sw	$t2, 48($gp)
	jal	maxHeap
	sll	$0, $0, 0
	addiu	$sp, $sp, 4
	lw	$t9, 0($sp)
	addiu	$sp, $sp, 8
	lw	$v1, -4($sp)
	sll	$0, $0, 0
	addu	$v0, $0, $v0
	lw	$t3, -4($s8)
	sll	$0, $0, 0
	ori	$t9, $0, 1
	subu	$v0, $t3, $t9
	addu	$t3, $0, $v0
	sw	$t3, -4($s8)
_L81:
	beq	$0, $0, _L79
	sll	$0, $0, 0
_L80:
_L74:
	lw	$ra, 4($s8)
	lw	$s8, 0($s8)
	jr	$ra
	addiu	$sp, $sp, 12
printHeap:
	addu	$s7, $0, $s8
	addiu	$s8, $sp, -8
	ori	$v0, $0, 1
	sw	$v0, -4($s8)
_L100:
	lw	$t4, -4($s8)
	sll	$0, $0, 0
	lw	$t5, 44($gp)
	sll	$0, $0, 0
	slt	$v0, $t4, $t5
	beq	$v0, $0, _L101
	sll	$0, $0, 0
	lw	$t6, -4($s8)
	sll	$0, $0, 0
	addu	$at, $0, $t6
	sll	$at, $at, 2
	addu	$at, $at, $gp
	lw	$a0, 0($at)
	sll	$0, $0, 0
	addiu	$v0, $0, 1
	syscall
	lw	$a0, 52($gp)
	addiu	$v0, $0, 4
	syscall
	ori	$t9, $0, 1
	addu	$v0, $t6, $t9
	addu	$t6, $0, $v0
	sw	$t6, -4($s8)
_L102:
	beq	$0, $0, _L100
	sll	$0, $0, 0
_L101:
	lw	$a0, 56($gp)
	addiu	$v0, $0, 4
	syscall
_L98:
	jr	$ra
	addu	$s8, $0, $s7
main:
	sw	$ra, -4($sp)
	sw	$s8, -8($sp)
	addiu	$s8, $sp, -8
	addiu	$sp, $sp, -8
	lui	$gp, 4096
	sw	$0, 0($gp)
	ori	$v0, $0, 91
	sw	$v0, 4($gp)
	ori	$v0, $0, 48
	sw	$v0, 8($gp)
	ori	$v0, $0, 1
	sw	$v0, 12($gp)
	ori	$v0, $0, 80
	sw	$v0, 16($gp)
	ori	$v0, $0, 28
	sw	$v0, 20($gp)
	ori	$v0, $0, 22
	sw	$v0, 24($gp)
	ori	$v0, $0, 15
	sw	$v0, 28($gp)
	ori	$v0, $0, 88
	sw	$v0, 32($gp)
	ori	$v0, $0, 59
	sw	$v0, 36($gp)
	ori	$v0, $0, 5
	sw	$v0, 40($gp)
	ori	$v0, $0, 11
	sw	$v0, 44($gp)
	lw	$t0, 44($gp)
	sll	$0, $0, 0
	ori	$t9, $0, 1
	subu	$v0, $t0, $t9
	sw	$v0, 48($gp)
	lw	$a0, 60($gp)
	addiu	$v0, $0, 4
	syscall
	lw	$a0, 64($gp)
	addiu	$v0, $0, 4
	syscall
	sw	$v1, -4($sp)
	sw	$t9, -8($sp)
	addiu	$sp, $sp, -8
	addiu	$sp, $sp, 0
	jal	printHeap
	sll	$0, $0, 0
	addiu	$sp, $sp, 0
	lw	$t9, 0($sp)
	addiu	$sp, $sp, 8
	lw	$v1, -4($sp)
	sll	$0, $0, 0
	addu	$v0, $0, $v0
	sw	$v1, -4($sp)
	sw	$t9, -8($sp)
	addiu	$sp, $sp, -8
	addiu	$sp, $sp, 0
	jal	sort
	sll	$0, $0, 0
	addiu	$sp, $sp, 0
	lw	$t9, 0($sp)
	addiu	$sp, $sp, 8
	lw	$v1, -4($sp)
	sll	$0, $0, 0
	addu	$v0, $0, $v0
	lw	$a0, 68($gp)
	addiu	$v0, $0, 4
	syscall
	lw	$a0, 72($gp)
	addiu	$v0, $0, 4
	syscall
	sw	$v1, -4($sp)
	sw	$t9, -8($sp)
	addiu	$sp, $sp, -8
	addiu	$sp, $sp, 0
	jal	printHeap
	sll	$0, $0, 0
	addiu	$sp, $sp, 0
	lw	$t9, 0($sp)
	addiu	$sp, $sp, 8
	lw	$v1, -4($sp)
	sll	$0, $0, 0
	addu	$v0, $0, $v0
_L112:
	lw	$ra, 4($s8)
	lw	$s8, 0($s8)
	jr	$ra
	addiu	$sp, $sp, 8
