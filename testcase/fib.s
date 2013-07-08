	.data
	.align 2
res:
	.space	4

strs:

	.text
	.align 2
	.globl main
fib:
	sw	$ra, -4($sp)
	sw	$s8, -8($sp)
	addiu	$s8, $sp, -8
	addiu	$sp, $sp, -16
	lw	$t0, 8($s8)
	sll	$0, $0, 0
	xor	$v0, $t0, $0
	sltiu	$v0, $v0, 1
	beq	$v0, $0, _L1
	sll	$0, $0, 0
	ori	$v0, $0, 1
	beq	$0, $0, _L0
	addu	$v0, $0, $v0
	beq	$0, $0, _L2
	sll	$0, $0, 0
_L1:
_L2:
	lw	$t1, 8($s8)
	sll	$0, $0, 0
	ori	$t9, $0, 1
	xor	$v0, $t1, $t9
	sltiu	$v0, $v0, 1
	beq	$v0, $0, _L7
	sll	$0, $0, 0
	ori	$v0, $0, 1
	beq	$0, $0, _L0
	addu	$v0, $0, $v0
	beq	$0, $0, _L8
	sll	$0, $0, 0
_L7:
_L8:
	sw	$v1, -4($sp)
	sw	$t9, -8($sp)
	addiu	$sp, $sp, -8
	lw	$t2, 8($s8)
	sll	$0, $0, 0
	ori	$t9, $0, 1
	subu	$v1, $t2, $t9
	sw	$v1, -4($sp)
	addiu	$sp, $sp, -4
	jal	fib
	sll	$0, $0, 0
	addiu	$sp, $sp, 4
	lw	$t9, 0($sp)
	addiu	$sp, $sp, 8
	lw	$v1, -4($sp)
	sll	$0, $0, 0
	addu	$v1, $0, $v0
	sw	$v1, -4($sp)
	sw	$t9, -8($sp)
	addiu	$sp, $sp, -8
	lw	$t3, 8($s8)
	sll	$0, $0, 0
	ori	$t9, $0, 2
	subu	$v1, $t3, $t9
	sw	$v1, -4($sp)
	addiu	$sp, $sp, -4
	jal	fib
	sll	$0, $0, 0
	addiu	$sp, $sp, 4
	lw	$t9, 0($sp)
	addiu	$sp, $sp, 8
	lw	$v1, -4($sp)
	sll	$0, $0, 0
	addu	$t9, $0, $v0
	addu	$v0, $v1, $t9
	beq	$0, $0, _L0
	addu	$v0, $0, $v0
_L0:
	lw	$ra, 4($s8)
	lw	$s8, 0($s8)
	jr	$ra
	addiu	$sp, $sp, 16
main:
	sw	$ra, -4($sp)
	sw	$s8, -8($sp)
	addiu	$s8, $sp, -8
	addiu	$sp, $sp, -8
	lui	$gp, 4096
	sw	$v1, -4($sp)
	sw	$t9, -8($sp)
	addiu	$sp, $sp, -8
	ori	$v1, $0, 7
	sw	$v1, -4($sp)
	addiu	$sp, $sp, -4
	jal	fib
	sll	$0, $0, 0
	addiu	$sp, $sp, 4
	lw	$t9, 0($sp)
	addiu	$sp, $sp, 8
	lw	$v1, -4($sp)
	sll	$0, $0, 0
	addu	$v0, $0, $v0
	addu	$t4, $0, $v0
	sw	$t4, 0($gp)
_L22:
	lw	$ra, 4($s8)
	lw	$s8, 0($s8)
	jr	$ra
	addiu	$sp, $sp, 8
