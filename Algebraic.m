function [R L] = Algebraic(nume, d)
	% Functia care calculeaza vectorul PageRank folosind varianta algebrica de calcul.
	% Intrari: 
	%	-> nume: numele fisierului in care se scrie;
	%	-> d: probabilitatea ca un anumit utilizator sa continue navigarea la o pagina urmatoare.
	% Iesiri:
	%	-> R: vectorul de PageRank-uri acordat pentru fiecare pagina.
fid = fopen(nume, "r");
if (fid == - 1)
	disp("Eroare");
endif;
N = fscanf(fid, "%d", 1);
Pr = zeros(N,1);
L = zeros(N,1);
M = zeros(N);
for i = 1:N
	fscanf(fid, "%d", 1); %citire in gol ca sa scap de numarul paginii
	n = fscanf(fid, "%d", 1); %cittesc numarul de vecini
	L(i) = n;
	j = 1;
	while( j <= n );
		x = fscanf(fid, "%d", 1);
		if (i != x)
		A(i,x) = 1; %numai daca nu am link la aceeasi pagina
		else 
		L(i)--; % ca sa elimin linkul catre sine
		endif;
		j ++;
	endwhile;
endfor;
fclose(fid);
%transform matricea M
K = diag(L);
K = inv(K);
A =  K * A;
M = transpose(A);
Pr_last = ones(N,1);
Pr = ones(N,1) ./ N;
A = eye(N) - (d * M);
A = PR_Inv(A);
while (Pr-Pr_last != 0)
	Pr_last = Pr;
	Pr = d * M * Pr + ((1-d)/N) * ones(N,1);
endwhile;
R = A * ((1-d)/N) * ones(N,1);
endfunction