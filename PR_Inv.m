function B = PR_Inv(A)
	% Functia care calculeaza inversa matricii A folosind factorizari Gram-Schmidt
	% Se va inlocui aceasta linie cu descrierea algoritmului de inversare 
   [m,n] = size(A);
    Q = zeros(m,n);
    R = zeros(n,n);
    for i = [1:n]
        Q(:,i) = A(:,i);
        if (i != 1)
            R(1:i-1,i) = transpose(Q(:,i-1))*Q(:,i);
            Q(:,i) = Q(:,i) - Q(:,1:i-1)*R(1:i-1,i);
        endif;
        R(i,i) = norm(Q(:,i),2);
        Q(:,i) = Q(:,i)/R(i,i);
     endfor;
     %rezolvarea sistemelor si aflarea lui B, dupa ce am aflat Q si R
     B = [];
     D = eye(m);
     y = [];
    for i = [1:n]
    	y = D(:,i);
     	x = inv(R) * inv(Q) * y;
   		B = horzcat(B,x);
    endfor;
endfunction

