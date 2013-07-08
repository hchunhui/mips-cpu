	.data
	.align 2
data:
	.space	40
data_length:
	.space	4

strs:
	.word	_S0
	.word	_S1
	.word	_S2
	.word	_S3
	.word	_S4
_S0:	.asciiz "\n    Member "
_S1:	.asciiz " is "
_S2:	.asciiz "\nExecuting No."
_S3:	.asciiz " quicksort:\n  Before sorting:"
_S4:	.asciiz "\n  After sorting:"

	.text
	.align 2
	.globl main
printArray:
	addu	$s7, $0, $s8
	addiu	$s8, $sp, -8
	sw	$0, -4($s8)
_L2:
	lw	$t0, -4($s8)
	sll	$0, $0, 0
	lw	$t1, 40($gp)
	sll	$0, $0, 0
	slt	$v0, $t0, $t1
	beq	$v0, $0, _L3
	sll	$0, $0, 0
	lw	$a0, 44($gp)
	addiu	$v0, $0, 4
	syscall
	lw	$t2, -4($s8)
	sll	$0, $0, 0
	addu	$a0, $0, $t2
	addiu	$v0, $0, 1
	syscall
	lw	$a0, 48($gp)
	addiu	$v0, $0, 4
	syscall
	addu	$at, $0, $t2
	sll	$at, $at, 2
	addu	$at, $at, $gp
	lw	$a0, 0($at)
	sll	$0, $0, 0
	addiu	$v0, $0, 1
	syscall
	ori	$t9, $0, 1
	addu	$v0, $t2, $t9
	addu	$t2, $0, $v0
	sw	$t2, -4($s8)
_L4:
	beq	$0, $0, _L2
	sll	$0, $0, 0
_L3:
_L0:
	jr	$ra
	addu	$s8, $0, $s7
partition:
	addu	$s7, $0, $s8
	addiu	$s8, $sp, -8
	lw	$t3, 8($s8)
	sll	$0, $0, 0
	addu	$at, $0, $t3
	sll	$at, $at, 2
	addu	$at, $at, $gp
	lw	$v0, 0($at)
	sll	$0, $0, 0
	sw	$v0, -4($s8)
	sw	$t3, -8($s8)
	lw	$t4, 12($s8)
	sll	$0, $0, 0
	sw	$t4, -12($s8)
_L20:
	lw	$t5, -8($s8)
	sll	$0, $0, 0
	lw	$t6, -12($s8)
	sll	$0, $0, 0
	slt	$v0, $t5, $t6
	beq	$v0, $0, _L21
	sll	$0, $0, 0
_L26:
	lw	$t7, -8($s8)
	sll	$0, $0, 0
	lw	$t8, -12($s8)
	sll	$0, $0, 0
	slt	$v1, $t7, $t8
	beq	$v1, $0, _L29
	addu	$v0, $0, $0
	addu	$at, $0, $t8
	sll	$at, $at, 2
	addu	$at, $at, $gp
	lw	$v1, 0($at)
	sll	$0, $0, 0
	lw	$t0, -4($s8)
	sll	$0, $0, 0
	slt	$v1, $v1, $t0
	xori	$v1, $v1, 1
	beq	$v1, $0, _L29
	sll	$0, $0, 0
	xori	$v0, $v0, 1
_L29:
	beq	$v0, $0, _L27
	sll	$0, $0, 0
	lw	$t1, -12($s8)
	sll	$0, $0, 0
	ori	$t9, $0, 1
	subu	$v0, $t1, $t9
	addu	$t1, $0, $v0
	sw	$t1, -12($s8)
_L28:
	beq	$0, $0, _L26
	sll	$0, $0, 0
_L27:
	lw	$t2, -12($s8)
	sll	$0, $0, 0
	addu	$at, $0, $t2
	sll	$at, $at, 2
	addu	$at, $at, $gp
	lw	$v0, 0($at)
	sll	$0, $0, 0
	lw	$t3, -8($s8)
	sll	$0, $0, 0
	addu	$at, $0, $t3
	sll	$at, $at, 2
	addu	$at, $at, $gp
	sw	$v0, 0($at)
_L45:
	lw	$t4, -8($s8)
	sll	$0, $0, 0
	lw	$t5, -12($s8)
	sll	$0, $0, 0
	slt	$v1, $t4, $t5
	beq	$v1, $0, _L48
	addu	$v0, $0, $0
	addu	$at, $0, $t4
	sll	$at, $at, 2
	addu	$at, $at, $gp
	lw	$v1, 0($at)
	sll	$0, $0, 0
	lw	$t6, -4($s8)
	sll	$0, $0, 0
	slt	$v1, $t6, $v1
	xori	$v1, $v1, 1
	beq	$v1, $0, _L48
	sll	$0, $0, 0
	xori	$v0, $v0, 1
_L48:
	beq	$v0, $0, _L46
	sll	$0, $0, 0
	lw	$t0, -8($s8)
	sll	$0, $0, 0
	ori	$t9, $0, 1
	addu	$v0, $t0, $t9
	addu	$t0, $0, $v0
	sw	$t0, -8($s8)
_L47:
	beq	$0, $0, _L45
	sll	$0, $0, 0
_L46:
	lw	$t7, -8($s8)
	sll	$0, $0, 0
	addu	$at, $0, $t7
	sll	$at, $at, 2
	addu	$at, $at, $gp
	lw	$v0, 0($at)
	sll	$0, $0, 0
	lw	$t8, -12($s8)
	sll	$0, $0, 0
	addu	$at, $0, $t8
	sll	$at, $at, 2
	addu	$at, $at, $gp
	sw	$v0, 0($at)
_L22:
	beq	$0, $0, _L20
	sll	$0, $0, 0
_L21:
	lw	$t1, -4($s8)
	sll	$0, $0, 0
	lw	$t2, -8($s8)
	sll	$0, $0, 0
	addu	$at, $0, $t2
	sll	$at, $at, 2
	addu	$at, $at, $gp
	sw	$t1, 0($at)
	addu	$v0, $0, $t2
	beq	$0, $0, _L15
	addu	$v0, $0, $t2
_L15:
	jr	$ra
	addu	$s8, $0, $s7
qsort:
	sw	$ra, -4($sp)
	sw	$s8, -8($sp)
	addiu	$s8, $sp, -8
	addiu	$sp, $sp, -12
	lw	$t3, 8($s8)
	sll	$0, $0, 0
	lw	$t4, 12($s8)
	sll	$0, $0, 0
	slt	$v0, $t3, $t4
	xori	$v0, $v0, 1
	beq	$v0, $0, _L69
	sll	$0, $0, 0
	beq	$0, $0, _L68
	addu	$v0, $0, $0
	beq	$0, $0, _L70
	sll	$0, $0, 0
_L69:
_L70:
	sw	$v1, -4($sp)
	sw	$t9, -8($sp)
	addiu	$sp, $sp, -8
	lw	$t5, 12($s8)
	sll	$0, $0, 0
	sw	$t5, -4($sp)
	lw	$t6, 8($s8)
	sll	$0, $0, 0
	sw	$t6, -8($sp)
	addiu	$sp, $sp, -8
	jal	partition
	sll	$0, $0, 0
	addiu	$sp, $sp, 8
	lw	$t9, 0($sp)
	addiu	$sp, $sp, 8
	lw	$v1, -4($sp)
	sll	$0, $0, 0
	addu	$v0, $0, $v0
	addu	$t0, $0, $v0
	sw	$v1, -4($sp)
	sw	$t9, -8($sp)
	addiu	$sp, $sp, -8
	ori	$t9, $0, 1
	subu	$v1, $t0, $t9
	sw	$v1, -4($sp)
	lw	$t7, 8($s8)
	sll	$0, $0, 0
	sw	$t7, -8($sp)
	addiu	$sp, $sp, -8
	sw	$t0, -4($s8)
	jal	qsort
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
	lw	$t8, 12($s8)
	sll	$0, $0, 0
	sw	$t8, -4($sp)
	lw	$t1, -4($s8)
	sll	$0, $0, 0
	ori	$t9, $0, 1
	addu	$v1, $t1, $t9
	sw	$v1, -8($sp)
	addiu	$sp, $sp, -8
	jal	qsort
	sll	$0, $0, 0
	addiu	$sp, $sp, 8
	lw	$t9, 0($sp)
	addiu	$sp, $sp, 8
	lw	$v1, -4($sp)
	sll	$0, $0, 0
	addu	$v0, $0, $v0
_L68:
	lw	$ra, 4($s8)
	lw	$s8, 0($s8)
	jr	$ra
	addiu	$sp, $sp, 12
main:
	sw	$ra, -4($sp)
	sw	$s8, -8($sp)
	addiu	$s8, $sp, -8
	addiu	$sp, $sp, -8
	lui	$gp, 4096
	ori	$v0, $0, 123
	sw	$v0, 0($gp)
	ori	$v0, $0, 52
	sw	$v0, 4($gp)
	ori	$v0, $0, 8
	sw	$v0, 8($gp)
	ori	$v0, $0, 74
	sw	$v0, 12($gp)
	ori	$v0, $0, 62
	sw	$v0, 16($gp)
	ori	$v0, $0, 74
	sw	$v0, 20($gp)
	ori	$v0, $0, 55
	sw	$v0, 24($gp)
	ori	$v0, $0, 44
	sw	$v0, 28($gp)
	ori	$v0, $0, 74
	sw	$v0, 32($gp)
	ori	$v0, $0, 80
	sw	$v0, 36($gp)
	ori	$v0, $0, 10
	sw	$v0, 40($gp)
	lw	$a0, 52($gp)
	addiu	$v0, $0, 4
	syscall
	lw	$a0, 56($gp)
	addiu	$v0, $0, 4
	syscall
	sw	$v1, -4($sp)
	sw	$t9, -8($sp)
	addiu	$sp, $sp, -8
	addiu	$sp, $sp, 0
	jal	printArray
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
	lw	$t2, 40($gp)
	sll	$0, $0, 0
	ori	$t9, $0, 1
	subu	$v1, $t2, $t9
	sw	$v1, -4($sp)
	sw	$0, -8($sp)
	addiu	$sp, $sp, -8
	jal	qsort
	sll	$0, $0, 0
	addiu	$sp, $sp, 8
	lw	$t9, 0($sp)
	addiu	$sp, $sp, 8
	lw	$v1, -4($sp)
	sll	$0, $0, 0
	addu	$v0, $0, $v0
	lw	$a0, 60($gp)
	addiu	$v0, $0, 4
	syscall
	sw	$v1, -4($sp)
	sw	$t9, -8($sp)
	addiu	$sp, $sp, -8
	addiu	$sp, $sp, 0
	jal	printArray
	sll	$0, $0, 0
	addiu	$sp, $sp, 0
	lw	$t9, 0($sp)
	addiu	$sp, $sp, 8
	lw	$v1, -4($sp)
	sll	$0, $0, 0
	addu	$v0, $0, $v0
_L88:
	lw	$ra, 4($s8)
	lw	$s8, 0($s8)
	jr	$ra
	addiu	$sp, $sp, 8
