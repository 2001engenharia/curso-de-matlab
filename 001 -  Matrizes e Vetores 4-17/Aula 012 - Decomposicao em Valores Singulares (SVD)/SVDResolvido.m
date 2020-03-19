%%
%     Curso do canal ExataMenteS
%     Aula 12 - Decomposi��o em Valores Singulares (SVD)
%     Se inscreva no canal e nos ajude a crescer <3
%     Vamos melhorar o Brasil atr�ves da tecnologia :)
%%
% Definindo a Matriz
m = 13;
n = 10;

% Escolhando o rank (Posto Matricial) desejado
r = 5;

% Matriz de numeros aleatorios
A = round( 13*randn(m,n) );

% Matriz SVD
[U,S,V] = svd( A );

% Reeconstrua a Matriz Original
B = U * S * V';
A - B

% Utilizando os primeiros "r"
A2 = U(:,1:r) * S(1:r,1:r) * V(:,1:r)';

% Verifique o rank e o size
rank( A2 )
size( A2 )

% Imagem da Matriz Original
figure(1), clf
tam = [ -1 1 ] * norm(A) / 10; % Eu dividi por 10 apenas para aumentar a satura��o das cores
subplot(131)
imagesc(A);
set(gca,'xtick',[],'ytick',[],'clim',tam)
axis image
title([ 'Matriz Original, rank =' num2str(rank(A)) ]) % num2str converte um Numero para uma String
                                                      % A gente declarou r como um numero mas
                                                      % no Plot da imagem ele tem que ser um character
                                                                      
% Imagem da Matriz Reduzida
subplot(132)
imagesc(A2)
set(gca,'xtick',[],'ytick',[],'clim',tam)
axis image
title([ 'Matriz Reduzida, rank =' num2str(rank(A2)) ])

% Erro entre as duas Matrizes
subplot(133)
imagesc(A-A2)
set(gca,'xtick',[],'ytick',[],'clim',tam)
axis image
title('Erro entre as duas Matrizes')

%%
