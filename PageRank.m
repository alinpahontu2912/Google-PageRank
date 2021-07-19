function [R1 R2] = PageRank(nume, d, eps)
	% Calculeaza indicii PageRank pentru cele 3 cerinte
	% Scrie fisierul de iesire nume.out 
	R1 = Iterative(nume, d, eps);
	[R2 L2] = Algebraic(nume, d);
	fid = fopen(nume, 'r');
	if ( fid == -1 )
		disp("Eroare");
	endif;
	fseek(fid, - 10 , 'eof');
	val1 = fscanf(fid, "%f", 1);
	val2 = fscanf(fid, "%f", 1);
	fclose(fid);
	nume2 = strcat(nume, ".out");
	f = fopen(nume2, 'w');
	if ( f == -1 )
		disp("Eroare");
	endif;
	N = size(R1, 1);
	fprintf(f, "%f\n\n", N);
	for i = 1:N
	fprintf(f,"%f\n", R1(i));
	endfor;
	fprintf(f,"\n");
	for i = 1:N
	fprintf(f,"%f\n", R2(i));
	endfor;
	fprintf(f,"\n");
	PR1	= R2;
	cast(PR1, "double");
	%aux pastreaza ordinea paginilor ordonate simplu, strict dupa ranking
	aux = zeros(N,1);
	aux(1:N) = 1:N;
	%ordonez dupa rank
	for i = 1:N-1
		for j = i+1:N
			if ( PR1(i) < PR1(j) )
				elem = PR1(j);
				PR1(j) = PR1(i);
				PR1(i) = elem;
				elem2 = aux(j);
				aux(j) = aux(i);
				aux(i) = elem2;
			endif;
		endfor;
	endfor;
	%verific site-ul cu prioritate mai mare
	%ordonez acum si aux, in functie de numarul de linkuri
	for i = 1:N
			if (PR1(i) ==  PR1(N - 1) & (L2(i) > L2(N - i + 1)) )
				elem2 = aux(N - 1);
				aux(N - 1) = aux(i);
				aux(i) = elem2;		
			endif;	
	endfor;
	for i = 1:N
		fprintf(f, "%d %d %f\n", i, aux(i), Apartenenta(PR1(i), val1, val2));
	endfor;
	fclose(f);
endfunction