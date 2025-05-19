//Cerinta 0

.data

	mLines: .space 4
	nCols: .space 4
	p: .space 4
	x: .space 4
	y: .space 4
	k: .space 4
	i: .space 4
	j: .space 4
	l: .space 4
	sum: .space 4
	matrix: .space 1600
	matrix2: .space 1600
	formatPrintf: .asciz "%d "
	endl: .asciz "\n"
	formatScanf: .asciz "%d"
	
.text

.global main

main:

	push $mLines
	push $formatScanf
	call scanf
	addl $8, %esp
	
	incl mLines
	
	push $nCols
	push $formatScanf
	call scanf
	addl $8, %esp
	
	incl nCols
	
	push $p
	push $formatScanf
	call scanf
	addl $8, %esp
	
	mov $0, %ecx
	lea matrix, %edi
	lea matrix2, %esi
	
et_p:

	cmp p, %ecx
	je citire_k
	
	push %ecx
	
	push $x
	push $formatScanf
	call scanf
	addl $8, %esp
	
	push $y
	push $formatScanf
	call scanf
	addl $8, %esp
	
	pop %ecx
	
	incl x
	incl y
	
	mov x, %eax
	mull nCols
	addl y, %eax
	
	movl $1, (%edi, %eax, 4)
	incl %ecx
	jmp et_p
	
citire_k:	

	push $k
	push $formatScanf
	call scanf
	addl $8, %esp
	
	movl $0, l
	
et_k:
	
	mov l, %ecx
	cmp %ecx, k
	je et_cont
			
et_cont1:

	movl $1, i
	movl $1, j
	incl l
	movl $0, sum
		
for_lines1:

	mov i, %ecx
	cmp %ecx, mLines
	je et_switch
	
	movl $1, j
	
for_col1:	
	
	mov j, %ecx
	cmp nCols, %ecx
	je et_cont_for_lines1
	
	//aici se scrie cod
	
	//operatii
	
	movl $0, %ebx
	
	//stanga sus
	decl i
	decl j
	
	movl i, %eax
	mull nCols
	addl j, %eax
	addl (%edi, %eax, 4), %ebx
	
	//mijloc sus
	incl j
	
	movl i, %eax
	mull nCols
	addl j, %eax
	addl (%edi, %eax, 4), %ebx
	
	//dreapta sus
	incl j
	
	movl i, %eax
	mull nCols
	addl j, %eax
	addl (%edi, %eax, 4), %ebx
	
	//dreapta mijloc
	incl i
	
	movl i, %eax
	mull nCols
	addl j, %eax
	addl (%edi, %eax, 4), %ebx
	
	//stanga mijloc
	subl $2, j
	
	movl i, %eax
	mull nCols
	addl j, %eax
	addl (%edi, %eax, 4), %ebx
	
	//stanga jos
	incl i
	
	movl i, %eax
	mull nCols
	addl j, %eax
	addl (%edi, %eax, 4), %ebx
	
	//mijloc jos
	incl j
	
	movl i, %eax
	mull nCols
	addl j, %eax
	addl (%edi, %eax, 4), %ebx
	
	//dreapta jos
	incl j
	
	movl i, %eax
	mull nCols
	addl j, %eax
	addl (%edi, %eax, 4), %ebx
	
	decl i
	decl j

	//operatii
	
	//operatii1
	
//et_el_curent:
	
	movl %ebx, sum
	
	movl i, %eax
	mull nCols
	addl j, %eax
	movl (%edi, %eax, 4), %ebx
	movl $0, (%esi, %eax, 4)
	
	cmp $0, %ebx
	je et_is0
	jg et_is1
	
//0 sau 1
et_is0:
	
	movl $3, %ecx
	cmp %ecx, sum
	je et_cond4
	jg et_cond5
	jl et_cond5
	
et_is1:
	
	movl $2, %ecx
	cmp %ecx, sum
	je et_cond2
	jl et_cond1
	jg et_cond2


//conditii

et_cond1:
//1. Subpopulare. Fiecare celula (care este in viata in generatia curenta) cu mai putin de doi
//vecini in viata, moare in generatia urmatoare.
	
	movl $0, (%esi, %eax, 4)

	jmp et_cont_for_col

et_cond2:
//2. Continuitate celule vii. Fiecare celula (care este in viata in generatia curenta), cu doi sau
//trei vecini in viata, va exista si in generatia urmatoare.
	
	movl $3, %ecx
	cmp %ecx, sum
	jg et_cond3

	movl $1, (%esi, %eax, 4)	
	
	jmp et_cont_for_col

et_cond3:
//3. Ultrapopulare. Fiecare celula (care este in viata in generatia curenta), care are mai mult de
//trei vecini in viata, moare in generatia urmatoare.

	movl $0, (%esi, %eax, 4)

	jmp et_cont_for_col

et_cond4:
//4. Creare. O celula moarta care are exact trei vecini in viata, va fi creata in generatia urmatoare.

	movl $1, (%esi, %eax, 4)

	jmp et_cont_for_col

et_cond5:
//5. Continuitate celule moarte. Orice alta celula moarta, care nu se incadreaza in regula de
//creare, ramane o celula moarta.

	movl $0, (%esi, %eax, 4)
	
	jmp et_cont_for_col

//conditii
	
	//operatii1
et_cont_for_col:

	incl j
	jmp for_col1
	
et_cont_for_lines1:
	
	incl i
	jmp for_lines1
	
//schimbarea matricei

et_switch:

	//lea
	jmp et_cont0

//schimbarea matricei

//a 2 a parte

et_cont0:

	movl $1, i
	movl $1, j
		
for_lines0:

	mov i, %ecx
	cmp %ecx, mLines
	je et_k
	
	movl $1, j
	
for_col0:	
	
	mov j, %ecx
	cmp nCols, %ecx
	je et_cont_for_lines0
	
	//aici se scrie cod
	//afisare:
	
	movl i, %eax
	mull nCols
	addl j, %eax
	movl (%esi, %eax, 4), %ebx
	movl %ebx, (%edi, %eax, 4)
	
	//operatii
	
	//operatii

	incl j
	jmp for_col0
	
et_cont_for_lines0:
	
	incl i
	jmp for_lines0


//a 2 a parte


//a 3 a parte
et_cont:

	movl $1, i
	movl $1, j
		
for_lines:

	mov i, %ecx
	cmp %ecx, mLines
	je et_exit
	
	movl $1, j
	
for_col:	
	
	mov j, %ecx
	cmp nCols, %ecx
	je et_cont_for_lines
	
	//aici se scrie cod
	//afisare:
	
	movl i, %eax
	mull nCols
	addl j, %eax
	movl (%edi, %eax, 4), %ebx
	
	//operatii
	
	//operatii
	
	//afisare
	
	push %ebx
	push $formatPrintf
	call printf
	addl $8, %esp
	
	//afisare
	incl j
	jmp for_col
	
et_cont_for_lines:
	
	push $endl
	call printf
	addl $4, %esp
	
	incl i
	jmp for_lines

//a 3 a parte	
et_exit:

	push $endl
	call printf
	addl $4, %esp
	
	push $0
	call fflush
	addl $4, %esp	
	
	movl $1, %eax
	movl $0, %ebx
	int $0x80
	
	
	
	

