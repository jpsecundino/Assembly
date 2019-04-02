soma_inteiros:			#retorna o valor $v0 = $a0 + $a1
	addi $sp, $sp, -12	#aloca espaco na pilha
	sw $a0, 0($sp)		#guarda o primeiro argumento
	sw $a1, 4($sp)		#guarda o segundo argumento
	sw $ra, 8($sp)		#guarda o endereço de retorno

	add $v0, $a0, $a1	#realiza a soma

	lw $a0, 0($sp)		#recupera o valor original de $a0
	lw $a1, 4($sp)		#recupera o valor original de $a1
	lw $ra, 8($sp)		#recupera o valor original de $ra
	addi $sp, $sp, 12	#desaloca o espaço utilizado na pilha

	jr $ra 			#retorna para o endereco contido em $ra
