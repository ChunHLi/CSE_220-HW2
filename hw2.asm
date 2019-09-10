
##############################################################
# Homework #2
# name: Chun_Hung_Li
# sbuid: 110807126
##############################################################

#################################################################
# Student defined data section
#################################################################
.data
.align 2
	 newline: .asciiz "\n"
.align 2
	 seperate: .asciiz " "
.align 2
	 plus: .asciiz "+"
.align 2
	 minus: .asciiz "-"
.align 2
	 productConstant: .asciiz "1."
.align 2
	 xFactor: .asciiz " x "
.align 2
	 twoCarrot: .asciiz "2^"
#place all data declarations here

.text

##############################
# PART 1 FUNCTIONS
##############################

char2digit:
    #Define your code here
	############################################
	# DELETE THIS CODE. Only here to allow main program to run without fully implementing the function
	#li $v0, -200
	blt $a0, 48, errorC2D
	bgt $a0, 57, errorC2D
	addi $v0, $a0, -48
	j passC2D
	errorC2D:
		li $v0, -1
	passC2D:
	############################################
	jr $ra

memchar2digit:
    #Define your code here
	############################################
	# DELETE THIS CODE. Only here to allow main program to run without fully implementing the function
	#li $v0, -200
	lb $t0, 0($a0)
	blt $t0, 48, errorMC2D
	bgt $t0, 57, errorMC2D
	addi $v0, $t0, -48
	j passMC2D
	errorMC2D:
		li $v0, -1
	passMC2D:
	############################################
    jr $ra

fromExcessk:
    #Define your code here
	############################################
	# DELETE THIS CODE. Only here to allow main program to run without fully implementing the function
	#li $v0, -200
	#li $v1, -200
	bltz $a0, errorFEK
	blez $a1, errorFEK
	li $v0, 0
	sub $v1, $a0, $a1
	j passFEK
	errorFEK:
		li $v0, -1
		move $v1, $a0
	passFEK:
	############################################
    jr $ra

printNbitBinary:
    #Define your code here
	############################################
	# DELETE THIS CODE. Only here to allow main program to run without fully implementing the function
	#li $v0, -200
	ble $a1, $0, errorPNBB 
	bgt $a1, 32, errorPNBB
	move $t0, $a0
	move $t1, $a1
	li $t4, 32
	sub $t2, $t4, $t1
	li $v0, 1
	firstLoopPNBB:
		beqz $t2, secondLoopPNBB
		sll $t0, $t0, 1
		addi $t2, $t2, -1
		j firstLoopPNBB
	secondLoopPNBB:
		beqz $t1, passPNBB
		bltz $t0, negative
		li $t3, 0
		move $a0, $t3
		syscall
		j printed
		negative:
			li $t3, 1
			move $a0, $t3
			syscall
		printed:
		sll $t0, $t0, 1
		addi $t1, $t1, -1
		j secondLoopPNBB
	errorPNBB:
		li $v0, -1
	passPNBB:
	li $v0, 0
	############################################
    jr $ra

##############################
# PART 2 FUNCTIONS
##############################

btof:
    #Define your code here
	############################################
	# DELETE THIS CODE. Only here to allow main program to run without fully implementing the function
	#li $v0, -200
	#li $v1, -200
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	addi $sp, $sp, -4
	sw $s0, 0($sp)
	addi $sp, $sp, -4
	sw $s1, 0($sp)
	addi $sp, $sp, -4
	sw $s2, 0($sp)
	addi $sp, $sp, -4
	sw $s3, 0($sp)
	addi $sp, $sp, -4
	sw $s7, 0($sp)
	move $s0, $a0
	move $s7, $a0
	lbu $t9, 0($s7)
	beq $t9, 45, specialNegative
	beq $t9, 43, specialPositive
	beq $t9, 78, checkNAN
	j normal
	specialNegative:
		addi $s7, $s7, 1
		lbu $t9, 0($s7)
		beq $t9, 73, checkNINF
		beq $t9, 48, checkNZERO
		j normal
		checkNINF:
			addi $s7, $s7, 1
			lbu $t9, 0($s7)
			beq $t9, 110, checkNINF2
			j errorBTOF
			checkNINF2:
				addi $s7, $s7, 1
				lbu $t9, 0($s7)
				beq $t9, 102, checkNINF3
				j errorBTOF
				checkNINF3:
					addi $s7, $s7, 1
					lbu $t9, 0($s7)
					ble $t9, 10, isNINF
					j errorBTOF
		checkNZERO:
			addi $s7, $s7, 1
			lbu $t9, 0($s7)
			beq $t9, 46, checkNZERO2
			j normal
			checkNZERO2:
				addi $s7, $s7, 1
				lbu $t9, 0($s7)
				beq $t9, 48, checkNZERO3
				j normal
				checkNZERO3:
					addi $s7, $s7, 1
					lbu $t9, 0($s7)
					ble $t9, 10, isNZERO
					j normal
	specialPositive:
		addi $s7, $s7, 1
		lbu $t9, 0($s7)
		beq $t9, 73, checkPINF
		beq $t9, 48, checkPZERO
		j normal
		checkPINF:
			addi $s7, $s7, 1
			lbu $t9, 0($s7)
			beq $t9, 110, checkPINF2
			j errorBTOF
			checkPINF2:
				addi $s7, $s7, 1
				lbu $t9, 0($s7)
				beq $t9, 102, checkPINF3
				j errorBTOF
				checkPINF3:
					addi $s7, $s7, 1
					lbu $t9, 0($s7)
					ble $t9, 10, isPINF
					j errorBTOF
		checkPZERO:
			addi $s7, $s7, 1
			lbu $t9, 0($s7)
			beq $t9, 46, checkPZERO2
			j normal
			checkPZERO2:
				addi $s7, $s7, 1
				lbu $t9, 0($s7)
				beq $t9, 48, checkPZERO3
				j normal
				checkPZERO3:
					addi $s7, $s7, 1
					lbu $t9, 0($s7)
					ble $t9, 10, isPZERO
					j normal
	checkNAN:
		addi $s7, $s7, 1
		lbu $t9, 0($s7)
		beq $t9, 97, checkNAN2
		j errorBTOF
		checkNAN2:
			addi $s7, $s7, 1
			lbu $t9, 0($s7)	
			beq $t9, 78, checkNAN3
			j errorBTOF
			checkNAN3:
				addi $s7, $s7, 1
				lbu $t9, 0($s7)	
				ble $t9, 10, isNAN
				j errorBTOF
	normal:
	lbu $t0, 0($s0)
	bne $t0, 45, checkPlus
		lui $s1, 0x8000
		addi $s0, $s0, 1
		j checkExponent
	checkPlus:
		bne $t0, 43, checkExponent
		addi $s0, $s0, 1
	checkExponent:
		li $t1, 1
		li $t2, 46
		removeStartingZeroes:
			move $a0, $s0
			jal memchar2digit
			bnez $v0, isOne
			j isZero
			isOne:
				beq $v0, $t1, countExponent
				lbu $t3, 0($s0)
				beq $t2, $t3, countNegaExponent
				j errorBTOF
			isZero:
				move $v0, $0
				addi $s0, $s0, 1
		j removeStartingZeroes
		countExponent:
			addi $a0, $a0, 1
			move $v0, $0
			jal memchar2digit
			lbu $t3, 0($a0)
			bne $t2, $t3, isValidExponent
			addi $t4, $t4, 127
			addi $t2, $t2 -44
			move $v0, $0
			j convertExponent
			isValidExponent:
				beqz $v0, validExponent
				beq $v0, $t1, validExponent
				j errorBTOF
			validExponent:
				addi $t4, $t4, 1
			j countExponent
		countNegaExponent:
			addi $a0, $a0, 1
			move $v0, $0
			jal memchar2digit
			bne $v0, $t1, isValidNegaExponent
			addi $t4, $t4, -1
			addi $t4, $t4, 127
			addi $t2, $t2 -44
			move $v0, $0
			j convertExponent
			isValidNegaExponent:
				beqz $v0, validNegaExponent
				j errorBTOF
			validNegaExponent:
				addi $t4, $t4, -1
			j countNegaExponent
		convertExponent:
			blez $t4, insertExponent
			srl $s2, $s2, 1
			div $t4, $t2
			mfhi $t5 #remainder
			mflo $t4 #quotient
			sll $t5, $t5, 30
			or $s2, $s2, $t5
			j convertExponent
		insertExponent:
			or $s1, $s1, $s2
			addi $t6, $t6, 23
		insertFraction:
			addi $s0, $s0, 1
			lbu $t9 0($s0)
			ble $t9, 10, finalizeBTOF
			beqz $t6, finalizeBTOF
			move $a0, $s0
			jal memchar2digit
			beqz $v0, insertZero
			beq $v0, $t1, insertOne
			beq $t9, 46, insertSkip
			j errorBTOF
			insertZero:
				li $t7, 0
				j insertRepeat
			insertOne:
				li $t7, 1
			insertRepeat:
				addi $t6, $t6, -1
				sll $s3, $s3, 1
			insertSkip:
				or $s3, $s3, $t7
				move $v0, $0
				move $t7, $0
			j insertFraction
		finalizeBTOF:
			li $v0, 0
			sllv $s3, $s3, $t6
			or $s1, $s1, $s3
			move $v1, $s1
			j passBTOF
	isNAN:
		lui $v1, 0x7FFF
		ori $v1, $v1, 0xFFFF
		j passBTOF
	isPINF:
		lui $v1, 0x7F80
		#ori $v0, $v0, 0x0000
		j passBTOF
	isNINF:
		lui $v1, 0xFF80
		#ori $v0, $v0, 0x0000
		j passBTOF
	isPZERO:
		lui $v1, 0x0000
		#ori $v0, $v0, 0x0000
		j passBTOF
	isNZERO:
		lui $v1, 0x8000
		#ori $v0, $v0, 0x0000
		j passBTOF
	errorBTOF:
		li $v0, -1
		li $v1, 1337
		j completeBTOF
	passBTOF:
		li $v0, 0
	completeBTOF:
		lw $s7, 0($sp)
		addi $sp, $sp, 4
		lw $s3, 0($sp)
		addi $sp, $sp, 4
		lw $s2, 0($sp)
		addi $sp, $sp, 4
		lw $s1, 0($sp)
		addi $sp, $sp, 4
		lw $s0, 0($sp)
		addi $sp, $sp, 4
		lw $ra, 0($sp)
		addi $sp, $sp, 4
	############################################
    jr $ra

print_parts:
    #Define your code here
	############################################
	# DELETE THIS CODE. Only here to allow main program to run without fully implementing the function
	#li $v0, -200
	
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	addi $sp, $sp, -4
	sw $s0, 0($sp)
	addi $sp, $sp, -4
	sw $s1, 0($sp)
	addi $sp, $sp, -4
	sw $s2, 0($sp)
	addi $sp, $sp, -4
	sw $s3, 0($sp)
	addi $sp, $sp, -4
	sw $s4, 0($sp)
	addi $sp, $sp, -4
	sw $s5, 0($sp)

	move $t0, $0
	move $t1, $0
	move $t2, $0
	move $t3, $0
	move $t4, $0
	move $s0, $0
	
	lui $s0, 0x7FFF
	ori $s0, $s0, 0xFFFF
	beq $a0, $s0, startPrintParts
	move $s0, $0
	lui $s0, 0x7F80
	beq $a0, $s0, startPrintParts
	move $s0, $0
	lui $s0, 0x8F80
	beq $a0, $s0, startPrintParts
	move $s0, $0
	beq $a0, $s0, startPrintParts
	lui $s0, 0x8000
	beq $a0, $s0, startPrintParts
	move $s0, $0

	startPrintParts:
	move $s0, $a0   		# store IEEE-754 value
	srl $s1, $s0, 31		# remove exponent and fraction then store sign	#00000000000000000000000000000001
	srl $s2, $s0, 23		# remove fraction
	sll $s2, $s2, 24		# remove sign and store exponent				#11111111000000000000000000000000
	sll $s3, $s0, 9			# remove sign and exponent						#11111111111111111111111000000000
	move $s4, $0
	move $s5, $0
	
	prepConvertExponentToDecimal:
		li $t2, 2
		li $t3, 8
	convertExponentToDecimal:
		beqz $t3, prepConvertFractionToDecimal
		srl $t0, $s2, 31
		mult $s4, $t2
		mflo $s4
		add $s4, $s4, $t0
		sll $s2, $s2, 1
		addi $t3, $t3, -1
		j convertExponentToDecimal
	prepConvertFractionToDecimal:
		li $t3, 23
	convertFractionToDecimal:
		beqz $t3, printConvertedParts
		srl $t0, $s3, 31
		mult $s5, $t2
		mflo $s5
		add $s5, $s5, $t0
		sll $s3, $s3, 1
		addi $t3, $t3, -1
		j convertFractionToDecimal
	
	printConvertedParts:
		la $t4, newline
		li $v0, 1
		move $a0, $s1
		syscall
		li $v0, 4
		la $a0, seperate
		syscall
		beqz $s1, printPLUS
		j printMINUS
		printPLUS:
			la $a0, plus
			j printSIGN
		printMINUS:
			la $a0, minus
		printSIGN:
		syscall
		move $a0, $t4
		syscall
		move $a0, $s4
		li $a1, 8
		jal printNbitBinary
		li $v0, 4
		la $a0, seperate
		syscall
		li $v0, 1
		move $a0, $s4
		syscall
		li $v0, 4
		la $a0, newline
		syscall
		move $a0, $s5
		li $a1, 23
		jal printNbitBinary
		li $v0, 4
		la $a0, seperate
		syscall
		li $v0, 1
		move $a0, $s5
		syscall
		
	lw $s5, 0($sp)
	addi $sp, $sp, 4
	lw $s4, 0($sp)
	addi $sp, $sp, 4
	lw $s3, 0($sp)
	addi $sp, $sp, 4
	lw $s2, 0($sp)
	addi $sp, $sp, 4
	lw $s1, 0($sp)
	addi $sp, $sp, 4
	lw $s0, 0($sp)
	addi $sp, $sp, 4
	lw $ra, 0($sp)
	addi $sp, $sp, 4
	############################################
    jr $ra

print_binary_product:
    #Define your code here
	############################################
	# DELETE THIS CODE. Only here to allow main program to run without fully implementing the function
	#li $v0, -200
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	addi $sp, $sp, -4
	sw $s0, 0($sp)
	addi $sp, $sp, -4
	sw $s1, 0($sp)
	addi $sp, $sp, -4
	sw $s2, 0($sp)
	addi $sp, $sp, -4
	sw $s3, 0($sp)
	addi $sp, $sp, -4
	sw $s4, 0($sp)
	addi $sp, $sp, -4
	sw $s5, 0($sp)

	move $t0, $0
	move $t1, $0
	move $t2, $0
	move $t3, $0
	move $t4, $0
	move $s0, $0
	
	lui $s0, 0x7FFF
	ori $s0, $s0, 0xFFFF
	beq $a0, $s0, isSpecial
	move $s0, $0
	lui $s0, 0x7F80
	beq $a0, $s0, isSpecial
	move $s0, $0
	lui $s0, 0x8F80
	beq $a0, $s0, isSpecial
	move $s0, $0
	beq $a0, $s0, isSpecial
	lui $s0, 0x8000
	beq $a0, $s0, isSpecial
	
	move $s0, $a0   		# store IEEE-754 value
	srl $s1, $s0, 31		# remove exponent and fraction then store sign	#00000000000000000000000000000001
	srl $s2, $s0, 23		# remove fraction
	sll $s2, $s2, 24		# remove sign and store exponent				#11111111000000000000000000000000
	sll $s3, $s0, 9			# remove sign and exponent						#11111111111111111111111000000000
	move $s4, $0
	move $s5, $0
	
	prepScientificConvertExponentToDecimal:
		li $t2, 2
		li $t3, 8
	scientificallyConvertExponentToDecimal:
		beqz $t3, prepScientificConvertFractionToDecimal
		srl $t0, $s2, 31
		mult $s4, $t2
		mflo $s4
		add $s4, $s4, $t0
		sll $s2, $s2, 1
		addi $t3, $t3, -1
		j scientificallyConvertExponentToDecimal
	prepScientificConvertFractionToDecimal:
		li $t3, 23
	scientificallyConvertFractionToDecimal:
		beqz $t3, scientificallyPrintConvertedParts
		srl $t0, $s3, 31
		mult $s5, $t2
		mflo $s5
		add $s5, $s5, $t0
		sll $s3, $s3, 1
		addi $t3, $t3, -1
		j scientificallyConvertFractionToDecimal
		
	scientificallyPrintConvertedParts:
		li $v0, 4
		beqz $s1, printPLUSscientifically
		j printMINUSscientifically
		printPLUSscientifically:
			la $a0, plus
			j printSIGNscientifically
		printMINUSscientifically:
			la $a0, minus
		printSIGNscientifically:
		syscall
		la $a0, productConstant
		syscall
		move $a0, $s5
		li $a1, 23
		jal printNbitBinary
		li $v0, 4
		la $a0, xFactor
		syscall
		la $a0, twoCarrot
		syscall
		move $a0, $s4
		li $a1, 127
		jal fromExcessk
		li $v0, 1
		move $a0, $v1
		syscall
		j isScientificallyNormal
	isSpecial:
		li $v0, 0
	isScientificallyNormal:
	lw $s5, 0($sp)
	addi $sp, $sp, 4
	lw $s4, 0($sp)
	addi $sp, $sp, 4
	lw $s3, 0($sp)
	addi $sp, $sp, 4
	lw $s2, 0($sp)
	addi $sp, $sp, 4
	lw $s1, 0($sp)
	addi $sp, $sp, 4
	lw $s0, 0($sp)
	addi $sp, $sp, 4
	lw $ra, 0($sp)
	addi $sp, $sp, 4
	############################################
    jr $ra