function R = Iterative(nume, d, eps)
	% Functia care calculeaza matricea R folosind algoritmul iterativ.
	% Intrari:
	%	-> nume: numele fisierului din care se citeste;
	%	-> d: coeficentul d, adica probabilitatea ca un anumit navigator 
	%sa continue navigarea (0.85 in cele mai multe cazuri)
	%	-> eps: eruarea care apare in algoritm.
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
		L(i)--; % ca sa elimin linkul la sine
		endif;
		j ++;
	endwhile;
endfor;
%transform matricea M
K = diag(L);
K = inv(K);
A =  K * A;
M = transpose(A);
Pr_last = ones(N,1);
Pr = ones(N,1) ./ N;
while (abs(norm(Pr-Pr_last)) > eps)
	Pr_last = Pr;
	Pr = d * M * Pr + (1-d)/N * ones(N,1);
endwhile;
R = Pr_last;
endfunction