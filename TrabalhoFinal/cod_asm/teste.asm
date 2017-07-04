####################################################################################################################################
#	Programa para testar todas as intrucoes 						   #	
#	obs.: O nome da instrucao testada vem apos a palavra "teste". Ex.: testeADD - testa a instrucao ADD			   #	
####################################################################################################################################

.data
	valor1: .word 27
	valor2: .word 46

.text
	
	lw $t1,valor1
	lw $t2,valor2
	
testeADDI:	

	addi $t3,$t1,-10
	addi $t3,$t1,0xFFFFFFFF
	
testeANDI:

	andi $t3,$t1,0x0000FFFF
	
testeORI:
	
	ori $t4,$t2, 0x0F0F0F0F
	
testeSLTI:
	
	slti $t3,$t2, 50
	slti $t3,$t2, 10

testeXORI:

	xori $t3,$t1,0xFFFFFFF
	
testeADD:
	
	add $t4,$t1,$t2

testeSUB:

	sub $t3,$t1,$t2

testeAND:
	
	and $t4,$t1,$t2

testeOR:

	or $t3,$t1,$t2

testeNOR:

	nor $t4,$t1,$t2
	
testeSLT:

	slt $t3,$t1,$t2		# $t2 deve ir para 1
	slt $t4,$t1,$t2		# $t3 deve ficar em 0

testeSLL:

	sll $t1,$t1,5

testeSRL:
	
	srl $t2,$a1,5

testeSRA:

	sra $t2,$a2,5

testeXOR:
	
	xor $t1,$a1,$a2

testeBEQ:
	
	beq $t1,$t2,testeBEQ
	beq $t1,$t1,testeBEQout
	
testeBEQout:

testeJ:
	
	j saida

saida:
