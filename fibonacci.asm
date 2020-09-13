addi $t1, $zero, 1          #$t1 recebe 1

li $a0, 6
jal FIBO                    #calcula fibonacci de 6

move $a0, $v0
li $v0, 1
syscall                     #imprime o resultado

j EXIT

FIBO: 
      slt $t2, $t1, $a0     #verifica se n <= 1
      bne $t2, $zero, ELSE  #pula pro ELSE se n>1 
      move $v0, $a0
      jr $ra                #retorna para o chamador
      
ELSE: 
      addi $sp, $sp, -12    #ajusta a pilha para receber 3 itens
      sw $ra, 8($sp),       #salva o endereço de retorno
      sw $a0, 4($sp),       #guarda n na pilha
      
      addi $a0, $a0, -1     #n=n-1
      jal FIBO
      lw $a0, 4($sp)        #restaura o n
      sw $v0, 0($sp)        #$s1 recebe o retorno do fibo(n-1)
      
      addi $a0, $a0, -2     #n=n-2
      jal FIBO
      lw $t0, 0($sp)
      add $v0, $v0, $t0     #$v0=fibo(n-1) + fibo(n-2)
      
      lw $ra, 8($sp)        #restaura o $ra
      add $sp, $sp, 12      #ajusta a pilha para eliminar 3 itens
      jr $ra                #retorna para o chamador

EXIT: