.data
	msgm: .asciiz "Digite um número: "
.text 

	li $t1, 1


	li $v0, 4       	#Imprime a mensagem
	la $a0, msgm
	syscall
	
	li $v0, 5		#Lê o número do input
	syscall


	la $a0, 0($v0)  	#Salva o número lido em $a0
	jal FAT         	#Executa a função fatorial

	move $a0, $v0   	#move o valor de retorna da função para $a0

	li $v0, 1		#Imprime o resultado do fatorial
	add $a0, $a0, $zero
	syscall

	li $v0, 10		#Termina o programa
	syscall

FAT:
	slt $t0, $a0, $t1
	beq $t0, $zero, ELSE
	move $v0, $t1
	jr $ra
ELSE:
	sub $sp, $sp, 8
	sw $ra, 4($sp)
	sw $a0, 0($sp)
	
	sub $a0, $a0, 1
	jal FAT
	
	lw $a0, 0($sp)
	lw $ra, 4($sp)
	addi $sp, $sp, 8
	
	mult $a0, $v0
	mflo $v0
	jr $ra
				