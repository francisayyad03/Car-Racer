###################################################################### 
# CSCB58 Summer 2022 Project 
# University of Toronto, Scarborough 
# 
# Student Name: Francis Ayayd, sudent Number: 1008091985, UTorID: ayyadfra
# 
# Bitmap Display Configuration: 
# - Unit width in pixels: 8 (update this as needed) 
# - Unit height in pixels: 8 (update this as needed) 
# - Display width in pixels: 256 (update this as needed) 
# - Display height in pixels: 256 (update this as needed) 
# - Base Address for Display: 0x10008000 
# 
# Basic features that were implemented successfully 
# - Basic feature a/b/c (choose the ones that apply)
	# all a b and c are applied
	 
# 
# Additional features that were implemented successfully 
# - Additional feature a/b/c (choose the ones that apply) 
	# all a b and c are applied
#  
# Link to the video demo 
# - Insert YouTube/MyMedia/other URL here and make sure the video is accessible 
# https://youtu.be/e18iq2j3fN4
# Any additional information that the TA needs to know: 
# - Write here, if any 
#  Enjoy :)
###################################################################### 

.data
	pos:	.word	18	
	enemyPos: .word 45, 1 56, 1, 124, 1
	speedE: .word 1
	lives: .word 3
	score: .word 0
	color: .word 0x0000ff

.text
addi $s5 $zero 0
main1:
	addi $k0, $zero, 0
	addi $s7 $zero 116
	addi $t9 $zero 0
	addi $sp $sp -4		
	la $t0 0xFF0000		
	sw $t0 0($sp)		
	jal drawLife	
	addi $sp $sp -4	

main: 
	la $t1, 0xFFFF00	
	la $t0, 0x10008000
	addi $t6, $t0, 60
	jal yellowLine
	addi $t6, $t0, 24
	la $t1, 0xffffff
	jal whiteLine
	addi $sp $sp -4		
	la $t1 color
	lw $t0 0($t1)		
	sw $t0 0($sp)		
	jal drawEnemy	
	li $v0, 32
	li $a0, 150		
	syscall	
	li $t9, 0xffff0000	
	lw $t8, 0($t9)
	beq $t8, 1, key
	jal updateE		
	addi $sp $sp -4		
	la $t0 0xFF0000		
	sw $t0 0($sp)		
	jal drawCar	
	li $v0, 32
	li $a0, 10		
	syscall		
	j main	
	
center2: 
	la $t2 pos
	li $s3 14
	sw $s3 0($t2)
	j center
center: 

	addi $sp $sp -4		
	la $t0 0x000000		
	sw $t0 0($sp)		
	jal drawCar	
	
	addi $sp $sp -4		
	la $t0 0x000000		
	sw $t0 0($sp)		
	jal drawEnemy	
		
	la $t0 pos		
	li $t1 16		
	sw $t1 0($t0)		
			
	la $t0 color	
		
	lw $t1 0($t0)
	beq $t1 0x00FF00 GR
	beq $t1 0x800080 PR
	
	li $t1 0x0000ff		
	sw $t1 0($t0)		

	la $t0 enemyPos	
	li $t1 3		
	sw $t1 4($t0)		
	sw $t1 16($t0)		
	sw $t1 20($t0)		
	li $t1 45		
	sw $t1 0($t0)		
	li $t1 26		
	sw $t1 8($t0)		
	li $t1 8		
	sw $t1 12($t0)		
	
	la $s4 lives
	lw $s6 0($s4)
	addi $s6 $s6 -1
	sw $s6 0($s4)
	
        addi $sp $sp -4		
	la $t9 0x000000	
	sw $t9 0($sp)		
			
	jal removeLife	
	
	la $t1, 0x000000	
	la $t0, 0x10008000
	addi $t6, $t0, 0
	j blackLine3
	blackLine3:
	addi $t5, $t0, 3596
	sw $t1, 0($t6)
	addi $t6, $t6, 128	
	bleu $t6,$t5, blackLine3
	
	la $t2 score
	li  $t1 0
	sw $t1 0($t2)
	
	addi $sp $sp -4		
	la $t0 0xFF0000		
	sw $t0 0($sp)		
	jal drawCar	
	addi $sp $sp -4		
	la $t0 0x0000ff		
	sw $t0 0($sp)		
	jal drawEnemy	
	
	j main
	
drawCar:
	lw $t0 0($sp)		
	addi $sp $sp 4		
	la $t1 0x10008000	
	addi $t2 $zero 32		
	sll $t3 $t2 5				
	lw $t2 pos	
	beq $t2 0 center2
	beq $t2 32 center2	
	add $t3 $t3 $t2		
	sll $t3 $t3 2		
	add $t3 $t3 $t1	
	addi $t3 $t3 -132	
	sw $t0 0($t3)			
	sw $t0 4($t3)
	sw $t0 -4($t3)		
	sw $t0 -128($t3)	
	sw $t0 -124($t3)		
	sw $t0 -132($t3)
	sw $t0 -256($t3)	
	sw $t0 -252($t3)		
	sw $t0 -260($t3)	
	addi $t3 $t3 132	
	jr $ra	
		
yellowLine:
	addi $t5, $t0, 3596
	sw $t1, 0($t6)
	addi $t6, $t6, 8
	sw $t1, 0($t6)	
	addi $t6, $t6, 120	
	bleu $t6,$t5, yellowLine
	jr $ra	
	
whiteLine:
	addi $t5, $t0, 3096
	sw $t1, 0($t6)
	addi $t6, $t6, 76
	sw $t1, 0($t6)	
	addi $t6, $t6, 180	
	bleu $t6,$t5, whiteLine
	jr $ra
		
drawEnemy:
	la $t1 0x10008000	
	la $t2 enemyPos	
	li $a1 0xFF0000	
	la $a3 color
	lw $a2 0($a3)		
	lw $t0 0($sp)		
	addi $sp $sp 4					
	lw $t5 4($t2)		
	sll $t4 $t5 5		
	lw $t5 0($t2)		
	add $t4 $t4 $t5	
	sll $t4 $t4 2		
	add $t3 $t4 $t1				
	add $a0 $zero $t3	
	addi $sp $sp -4		
	sw $ra 0($sp)	
	jal checkers	
	sw $t0 0($t3)		
	sw $t0 128($t3)	
	sw $t0 256($t3)							
	jal checkers		
	lw $t5 12($t2)		
	sll $t4 $t5 5		
	lw $t5 8($t2)		
	add $t4 $t4 $t5	
	sll $t4 $t4 2		
	add $t3 $t4 $t1			
	add $a0 $zero $t3			
	jal checkers			
	sw $t0 0($t3)		
	sw $t0 128($t3)	
	sw $t0 256($t3)
	add $a0 $zero $t3					
	jal checkers
	lw $t5 20($t2)		
	sll $t4 $t5 5		
	lw $t5 16($t2)		
	add $t4 $t4 $t5	
	sll $t4 $t4 2		
	add $t3 $t4 $t1					
	add $a0 $zero $t3		
	jal checkers
	sw $t0 0($t3)		
	sw $t0 128($t3)	
	sw $t0 256($t3)	
	add $a0 $zero $t3	
	jal checkers	
	lw $ra 0($sp)		
	addi $sp $sp 4	
	jr $ra			
	
key:
	lw $t7, 4($t9) 				
	beq $t7, 0x64, moveRight 	
	beq $t7, 0x73, speedDown	
	beq $t7, 0x61, moveLeft
	beq $t7, 0x77, speedUp
	jr $ra
moveRight:
	addi $s0, $zero 32
	addi $sp $sp -4			
	sw $ra 0($sp)			
	addi $sp $sp -4			
	la $t0 0X000000			
	sw $t0 0($sp)			
	jal drawCar			
	la $t0 pos			
	lw $t1 0($t0)			
	addi $t1 $t1 1			
	bgt $t1 $s0 update		
	sw $t1 0($t0)			
	lw $ra 0($sp)			
	addi $sp $sp 4			
	jr $ra	
	
moveLeft:
	addi $sp $sp -4			
	sw $ra 0($sp)		
	addi $sp $sp -4			
	la $t0 0x000000			
	sw $t0 0($sp)			
	jal drawCar			
	la $t0 pos			
	lw $t1 0($t0)			
	addi $t1 $t1 -1		
	blt $t1 $zero update		
	sw $t1 0($t0)			
	lw $ra 0($sp)			
	addi $sp $sp 4			
	jr $ra	
	
speedUp:
	addi $k1, $zero, 3
	beq $k0, $k1, maxLevel
	la $t0 speedE
	lw $t9 0($t0)
	addi $s3, $t9, 1
	sw $s3 0($t0)
	addi $k0, $k0, 1
	j updateE
	
maxLevel: 
	la $t0 speedE
	lw $t9 0($t0)
	addi $s3, $t9, 0
	sw $s3 0($t0)
	j updateE

minLevel : 
	j updateE
		
speedDown:
	la $t0 speedE
	lw $t9 0($t0)
	ble $t9, 2 minLevel
	addi $s3, $t9, -1
	sw $s3 0($t0)
	addi $k0, $k0, -1
	j updateE

update: 
	la $t0 0xFF0000
	addi $sp $sp -4
	sw $t0 0($sp)
	jal drawCar
	j main	

updateE:	
	la $t0 0x000000		
	addi $sp $sp -4			
	sw $ra 0($sp)				
	addi $sp $sp -4				
	sw $t0 0($sp)			
	jal drawEnemy
	la $t0 enemyPos	
	la $t4, speedE
	addi $s0 $zero 32			
	jal updateE1		
	jal updateE2		
	jal updateE3		
	j updatedE
	
updateE1:			
	lw $t1 4($t0)	
	lw $t5 0($t4)
	add $t1 $t1 $s2			
	addi $t1 $t1 1		
	bgt $t1 $s0 resetE1	
	sw $t1 4($t0)			
	jr $ra
	
updateE2:	
	lw $t1 12($t0)	
	lw $t5 0($t4)
	add $t1 $t1 $s2			
	addi $t1 $t1 2			
	bgt $t1 $s0 resetE2	
	sw $t1 12($t0)			
	jr $ra
	
updateE3:		
	lw $t1 20($t0)
	lw $t5 0($t4)
	add $t1 $t1 $s2				
	addi $t1 $t1 1		
	bgt $t1 $s0 resetE3	
	sw $t1 20($t0)			
	jr $ra
	
resetE1:		
	li $t1 0
	sw $t1 4($t0)	
	addi $sp $sp -4		
	sw $ra 0($sp)			
	li $v0 42			
	li $a0 0
	li $a1 25
	syscall
	add $t4 $zero $a0
	addi $t4 $t4 1
	sw $t4 0($t0)	
	addi $s4 $zero 0	
	la $t0 0xaa6c39		
	sw $t0 0($sp)		
	jal drawScore	
	lw $ra 0($sp)		
	addi $sp $sp 4	
	lw $t3 0($t2)
	addi $t3 $t3 1
	sw $t3 0($t2)
	la $t0 color
	li $t1 0x0000ff
	sw $t1 0($t0)			
	jr $ra	
	
resetE2:		
	li $t1 0
	sw $t1 12($t0)	
	addi $sp $sp -4		
	sw $ra 0($sp)		
	li $v0, 42			
	li $a0, 0
	li $a1, 25
	syscall
	add $t4 $zero $a0
	addi $t4 $t4 2
	sw $t4 8($t0)	
	addi $s4 $zero 0	
	la $t0 0xaa6c39		
	sw $t0 0($sp)		
	jal drawScore	
	lw $ra 0($sp)		
	addi $sp $sp 4
	lw $t3 0($t2)
	addi $t3 $t3 1
	sw $t3 0($t2)	
	jr $ra
			
		
resetE3:
	li $t1 0
	sw $t1 20($t0)			
	addi $sp $sp -4		
	sw $ra 0($sp)		
	li $v0, 42			
	li $a0, 0
	li $a1, 25
	syscall
	add $t4 $zero $a0
	addi $t4 $t4 1
	sw $t4 16($t0)	
	addi $s4 $zero 0	
	la $t0 0xaa6c39	
	sw $t0 0($sp)		
	jal drawScore	
	lw $ra 0($sp)		
	addi $sp $sp 4		
	la $t2 score
	lw $t3 0($t2)
	addi $t3 $t3 1
	sw $t3 0($t2)	
	jr $ra
	
drawLife: 
	lw $t0 0($sp)
	addi $sp $sp 4
	la $t4 0x10008000
	sw $t0 116($t4)
	sw $t0 120($t4)
	sw $t0 124($t4)
	jr $ra
	
removeLife: 
	lw $t0 0($sp)
	addi $sp $sp 4
	la $t4 0x10008000
	add $s6 $t4 $s7
	sw $t0 0($s6)
	addi $s7 $s7 4
	la $t0 lives
	lw $t1 0($t0)
	beqz $t1 ending
	jr $ra

restartGame: 
	addi $sp $sp -4		
	la $t0 0x000000		
	sw $t0 0($sp)		
	jal drawEnemy	
	la $t0 pos		
	li $t1 16		
	sw $t1 0($t0)		
	la $t0 speedE	
	li $t1 1		
	sw $t1 0($t0)		
	la $t0 enemyPos	
	li $t1 3		
	sw $t1 4($t0)		
	sw $t1 16($t0)		
	sw $t1 20($t0)		
	li $t1 45		
	sw $t1 0($t0)		
	li $t1 26		
	sw $t1 8($t0)		
	li $t1 8
	sw $t1 12($t0)		
	la $t0 lives		
	li $t1 3		
	sw $t1 0($t0)		
	la $t0 score		
	li $t1 0		
	sw $t1 0($t0)		
	addi $sp $sp -4	
	la $t0 0xFF0000		
	sw $t0 0($sp)	
	jal drawLife
	addi $sp $sp -4		
	la $t1 color
	lw $t0 0($t1)		
	sw $t0 0($sp)		
	jal drawEnemy	
	j main1
	
ending:
	addi $sp $sp -4		
	la $t0 0x000000		
	sw $t0 0($sp)		
	jal drawCar	
	addi $sp $sp -4		
	la $t0 0x000000		
	sw $t0 0($sp)		
	jal drawEnemy	
	la $t1, 0x000000	
	la $t0, 0x10008000
	addi $t6, $t0, 60
	j blackLine
	blackLine:
	addi $t5, $t0, 3596
	sw $t1, 0($t6)
	addi $t6, $t6, 8
	sw $t1, 0($t6)	
	addi $t6, $t6, 120	
	bleu $t6,$t5, blackLine
	la $t1, 0x000000
	la $t0, 0x10008000
	addi $t6, $t0, 24
	j whiteLine2
	whiteLine2:
	addi $t5, $t0, 3596
	sw $t1, 0($t6)
	addi $t6, $t6, 76
	sw $t1, 0($t6)	
	addi $t6, $t6, 180	
	bleu $t6,$t5, whiteLine2
	addi $sp $sp -4		
	la $t0 0x000000		
	sw $t0 0($sp)		
	jal drawLife	
	la $t1, 0x000000	
	la $t0, 0x10008000
	addi $t6, $t0, 0
	j blackLine7
	blackLine7:
	addi $t5, $t0, 3596
	sw $t1, 0($t6)
	addi $t6, $t6, 128	
	bleu $t6,$t5, blackLine7
	j wait

drawScore: 
	lw $t0 0($sp)
	addi $sp $sp 4
	la $t4 0x10008000
	la $t2 score
	lw $t3 0($t2)
	sll $t5 $t3 8
	add $t5 $t5 $t4
	sw $t0 ($t5)
	beq $t3 10 nextLevel
	beq $t3 2 greenE
	beq $t3 8 purpleE
	jr $ra
	
nextLevel: 
	jal ending2
	
ending2: 
	addi $sp $sp -4		
	la $t0 0x000000		
	sw $t0 0($sp)		
	jal drawCar	
	addi $sp $sp -4		
	la $t0 0x000000		
	sw $t0 0($sp)		
	jal drawEnemy	
	la $t1, 0x000000	
	la $t0, 0x10008000
	addi $t6, $t0, 60
	j blackLine4
	blackLine4:
	addi $t5, $t0, 3596
	sw $t1, 0($t6)
	addi $t6, $t6, 8
	sw $t1, 0($t6)	
	addi $t6, $t6, 120	
	bleu $t6,$t5, blackLine4
	la $t1, 0x000000
	la $t0, 0x10008000
	addi $t6, $t0, 24
	j whiteLine3
	whiteLine3:
	addi $t5, $t0, 3596
	sw $t1, 0($t6)
	addi $t6, $t6, 76
	sw $t1, 0($t6)	
	addi $t6, $t6, 180	
	bleu $t6,$t5, whiteLine3
	addi $sp $sp -4		
	la $t0 0x000000		
	sw $t0 0($sp)		
	jal drawLife	
	la $t1, 0x000000	
	la $t0, 0x10008000
	addi $t6, $t0, 0
	j blackLine6
	blackLine6:
	addi $t5, $t0, 3596
	sw $t1, 0($t6)
	addi $t6, $t6, 128	
	bleu $t6,$t5, blackLine6

	j restart2
	
restart2:
	addi $sp $sp -4		
	la $t0 0x000000		
	sw $t0 0($sp)		
	jal drawCar	
	addi $sp $sp -4		
	la $t0 0x000000		
	sw $t0 0($sp)		
	jal drawEnemy	
	la $t0 pos		
	li $t1 16		
	sw $t1 0($t0)		
	la $t0 speedE		
	li $t1 3		
	sw $t1 0($t0)		
	la $t0 enemyPos	
	li $t1 3		
	sw $t1 4($t0)		
	sw $t1 16($t0)		
	sw $t1 20($t0)		
	li $t1 45		
	sw $t1 0($t0)		
	li $t1 26		
	sw $t1 8($t0)		
	li $t1 8		
	sw $t1 12($t0)		
	la $t0 lives		
	li $t1 3		
	sw $t1 0($t0)		
	la $t0 score		
	li $t1 0		
	sw $t1 0($t0)		
	addi $sp $sp -4	
	la $t0 0xFF0000		
	sw $t0 0($sp)	
	jal drawLife
	addi $sp $sp -4		
	la $t0 0xFF0000		
	sw $t0 0($sp)		
	jal drawCar	
	addi $sp $sp -4		
	la $t1 color
	lw $t0 0($t1)			
	sw $t0 0($sp)		
	jal drawEnemy	

	j main1
	
greenE: 
	la $t0 color
	li $t1 0x00FF00
	sw $t1 0($t0)
	jr $ra
	
purpleE: 
	la $t0 color
	li $t1 0x800080
	sw $t1 0($t0)
	jr $ra
	
GR: 
	la $t0 speedE
	li $t1 1
	sw $t1 0($t0)
	la $t0 color
	li $t1 0x0000ff
	sw $t1 0($t0)
	jr $ra
	
PR: 
	la $t0 speedE
	li $t1 4
	sw $t1 0($t0)
	la $t0 color
	li $t1 0x0000ff
	sw $t1 0($t0)
	jr $ra
	

updatedE:
 	addi $sp $sp -4			
	la $t1 color
	lw $t2 0($t1)			
	sw $t0 0($sp)			
	jal drawEnemy			
	lw $ra 0($sp)			
	addi $sp $sp 4			
	jr $ra
	
checkers:	
	lw $t7 0($a0)		
	beq $t7 $a1 collide	
	jr $ra	
collide:		
	addi $sp $sp 4	
	j center	
	jr $ra	
	
wait:
	li $t9 0xffff0000			
	lw $t8 0($t9)
	beq $t8 1 pressedKey
	j wait
	
pressedKey:	
	lw $t7, 4($t9) 				
	beq $t7 0x71 restartGame
	j wait
