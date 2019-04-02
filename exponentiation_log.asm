	.data
	.text
main:
	addi $v0, $zero, 5
	syscall
	
	move $a0, $v0

	addi $v0, $zero, 5
	syscall
	
	move $a1, $v0
	
	jal pot
	
	move $t0, $v0
	
	addi $v0, $zero, 1
	move $a0, $t0
	syscall
	
	addi $v0, $zero, 10
	syscall
pot:
	addi $sp, $sp, -12	#aloca espaco na pilha
	sw $a0, 0($sp)		#coloca primeiro argumento na pilha
	sw $a1, 4($sp)		#coloca segundo argumento na pilha
	sw $ra, 8($sp)		#coloca o endereco de retorno na pilha

	bltz $a1, retorna_zero
	
	beq $a1, $zero, retorna_um #verifica se o expoente eh 1
	
	addi $t0, $zero, 1
	beq $a1, $t0, retorna_a0
	
	#verifica se o expoente eh par
	addi $t0, $zero, 2
	div $a1, $t0		
	mfhi $t0		#coloca o resto da divisao por 2 em $t0
	beq $t0, $zero, continua_pot_div2 #se o expoente eh par, realizamos continua_pot_div2
	
	#continua_pot caso nenhuma dos branches acima tenha sido ativado
	addi $a1, $a1, -1	#decrementa o expoente 
	jal pot  		#faz uma chada a funcao com pot(a, b-1)

	mul $v0, $v0, $a0       #coloca em $v0 o produto entre o valor resultante da chamada e $a0 

	j end_pot		#vai para o fim da recursao

retorna_zero:
	addi $v0, $zero, 0	#$v0 = 0
	j end_pot		#vai para o fim da recursao
retorna_um:
	addi $v0, $zero, 1	#$v0 = 1
	j end_pot		#vai para o fim da recursao

retorna_a0:
	add $v0, $zero, $a0 	#$v0 = $a0
	j end_pot		#vai para o fim da recursao

continua_pot_div2:
	addi $t0, $zero, 2	
	div $a1, $t0		#divide $a1 por 2
	mflo $a1		#coloca o quociente da divisao em $a1

	jal pot 		#calcula pot(a, b/2)

	mul $v0,$v0,$v0		#$v0 = pot(a, b/2) * pot(a, b/2)

end_pot:
	lw $a0, 0($sp)
	lw $a1, 4($sp)
	lw $ra, 8($sp)
	addi $sp, $sp, 12

	jr $ra
