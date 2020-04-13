%%
%     Curso do canal ExataMenteS
%     Aula 87 - Dados em uma Distribuicao Normal
%     Se inscreva no canal e nos ajude a crescer <3
%     https://www.youtube.com/channel/UCZyFebN0_gF2yy5fhVhlXtA
%     Professor: Joao Pinheiro
%     Copyright https://github.com/joaomh
%%

% Parameters of the Gaussian
Amp = 7;
sigma = 2;
centerX = 3;

x = -10:.1:10;

% Gaussian and add noise
Gaussian = Amp * exp( -(x-centerX).^2 / (2*sigma^2) );
noiseData = randn( size(Gaussian) )*.7;
Gaussian = Gaussian + noiseData;

% initialize:      Amp   sigma    center
initParmeters = [   2     3       6];

% Using our funciton to fit the data
funcHandle = @(initParms) fitData(initParms,x,Gaussian);

% Function minimization
[outParameters,SSe,exitflag,fmininfo] = fminsearch(funcHandle,initParmeters);

%% list center and peak starting value ranges
centerVec = linspace(-10,10,50);
ampVec = linspace(-10,10,50);

% initialize matrix of sum of squared errors
SSeMatrix  = zeros( length(centerVec),length(ampVec) );

% loop over parameter spaces
for i = 1:length(centerVec)
    for j = 1:length(ampVec)
        
        % Initial parameters and function
        initParmeters = [ ampVec(j) 2 centerVec(i) ];
        funcHandle = @(initParms) fitData(initParms,x,Gaussian);
        
        % Minimization
        [~, SSe] = fminsearch(funcHandle,initParmeters);
        
        % SSE matrix
        SSeMatrix(i,j) = SSe;
    end
end

% Image
figure(2), clf
contourf(ampVec,centerVec,SSeMatrix,40,'linecolor','none')
xlabel('Amplitudes'), ylabel('Centers')
colormap jet

