#esse procedimento retona um endereco de vetor de tamanho 10 e nao
#imprime algum valor na tela. O retorno da funcao eh colocado no vetor passado no argumento 1
#@argumentos :
	#$a0: numero que indica qual a tabuada a ser retornada
	#$a1: vetor no qual  a tabuada sera colocada
#@retorno:
	#$a1: endereco para o inicio do vetor que contem a tabuada

#eh necessario criar um vetor na main
tabuada:
	addi $sp, $sp, -12	#aloca espaco na pilha
	sw $a0, 0($sp)		#guarda o primeiro argumento
	sw $a1, 4($sp)		#guarda o primeiro argumento
	sw $ra, 8($sp)		#guarda o endereço de retorno	

	addi $t0, $zero, 0	#cria um iterador para um loop (it = 0,1,2,..,10,11)
	addi $t1, $zero, 11	#cria um limite para o loop 

loop:	beq  $t0, $t1, end_loop #para o loop se val($t0) == 11
	mul  $t2, $a0, $t0	#guarda o valor da multiplicação em $t2
	
	sw $t2, 0($a1)		#guarda o valor da multiplicação no vetor

	addi $a1, $a1, 1        #incrementa a posição do vetor indicado por $a1
	addi $t0, $zero, 1	#incrementa o iterador do loop

	j loop

end_loop:
	
	lw $a0, 0($sp)		#recupera o valor original do primeiro argumento
	lw $a1, 4($sp)		#recupera o valor original do segundo argumento
	lw $ra,8($sp)		#recupera o valor original do endereco de retorno
	addi $sp, $sp, 12	#desaloca espaco da pilha

	jr ra
