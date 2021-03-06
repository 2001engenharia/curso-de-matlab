%%
%     Curso do canal ExataMenteS
%     Aula 76 - FFT2D
%     Se inscreva no canal e nos ajude a crescer <3
%     https://www.youtube.com/channel/UCZyFebN0_gF2yy5fhVhlXtA
%     Professor: Joao Pinheiro
%     Copyright https://github.com/joaomh
%%
A = imread('onion.png');
imshow(A);

% Convert to grayscale image
B = rgb2gray(A);

% Plot
figure(1),
imagesc(B);

% Compressed image
BComp = fft2(B);

% Sort by magnitude
BSort = sort(abs(BComp(:)));

for i = [.1 .05 .01 .002]
    
    % Find small indices and Threshold small indices
    Thresh = BSort(floor( (1-i)*length(BSort) ));
    ind = abs(BComp) > Thresh;
    
    Atlow = BComp.*ind;
    
    % Compressed image
    Alow = uint8(ifft2(Atlow));
    
    % Plot Reconstruction
    figure, imshow(Alow)
    
end

%%
% Vector of sine frequencies
SineFreq = linspace(.0001,.2,50);  % arbitrary units

% Phase
FinePhs = pi/2;

% Init
Limits  = [-100 100];
[x,y] = ndgrid(Limits(1):Limits(2),Limits(1):Limits(2));
Xp    = x*cos(FinePhs) + y*sin(FinePhs);
cLimit  = [0 1000];


% Plot the Space domain, amplitude and phase spectrum
figure(3), clf
colormap jet
subplot(121)
ImgHandle = imagesc(rand(length(x)));
axis square, axis off, axis xy
title('Space')
subplot(222)
AmpHandle = imagesc(rand(length(x)));
axis square, axis off, axis xy
set(gca,'xlim',[Limits(2)-30 Limits(2)+30],'ylim',[Limits(2)-30 Limits(2)+30],'clim',cLimit)
title('Amplitude')
subplot(224)
PhsHandle = imagesc(rand(length(x)));
axis square, axis off, axis xy
set(gca,'xlim',[Limits(2)-30 Limits(2)+30],'ylim',[Limits(2)-30 Limits(2)+30])
title('Phase')


% Loop over phases
for i = 1:length(SineFreq)
    
    % compute sine wave
    Image = sin( 2*pi*SineFreq(i)*Xp );
    
    % 2D FFT and extract power and phase spectra
    ImageX  = fftshift(fft2(Image));
    
    Power = abs(ImageX);
    Phase = angle(ImageX);
    
    % Update plots
    set(ImgHandle,'CData',Image);
    set(AmpHandle  ,'CData',Power);
    set(PhsHandle,'CData',Phase);
    colormap jet
    pause(.2)
end

%% Movie

% Vector of sine phases
FinePhs = linspace(0,pi,50);
SineFreq = .05; 


% Initializations
Limits  = [-100 100];
[x,y] = ndgrid(Limits(1):Limits(2),Limits(1):Limits(2));
cLimit  = [0 1000];

% Plot the Space domain, amplitude and phase spectrum
figure(4), clf
colormap jet
subplot(121)
ImgHandle = imagesc(rand(length(x)));
axis square, axis off, axis xy
title('Space')
subplot(222)
AmpHandle = imagesc(rand(length(x)));
axis square, axis off, axis xy
set(gca,'xlim',[Limits(2)-30 Limits(2)+30],'ylim',[Limits(2)-30 Limits(2)+30],'clim',cLimit)
title('Amplitude')
subplot(224)
PhsHandle = imagesc(rand(length(x)));
axis square, axis off, axis xy
set(gca,'xlim',[Limits(2)-30 Limits(2)+30],'ylim',[Limits(2)-30 Limits(2)+30])
title('Phase')


% Loop over phases
for i = 1:length(FinePhs)
    
    % x-coordinate values (based on rotating x and y)
    Xp = x*cos(FinePhs(i)) + y*sin(FinePhs(i));
    
    % compute 2D sine patch
    Image = sin( 2*pi*SineFreq*Xp );
    
    % 2D FFT and extract power and phase spectra
    ImageX  = fftshift(fft2(Image));
    Power = abs(ImageX);
    Phase = angle(ImageX);
    
    % update plots
    set(ImgHandle,'CData',Image);
    set(AmpHandle  ,'CData',Power);
    set(PhsHandle,'CData',Phase);
    colormap jet
    pause(.2)
end

%% Physical location
Limits  = [-100 100];
[x,y] = ndgrid(Limits(1):Limits(2),Limits(1):Limits(2));
Sigma = 20;  % Gaussian

Xcenter = linspace(-80,80,50); % Center locations

% Plot the Space domain, amplitude and phase spectrum
figure(5), clf
colormap jet
subplot(121)
ImgHandle = imagesc(rand(length(x)));
axis square, axis off, axis xy
title('Space')
subplot(222)
AmpHandle = imagesc(rand(length(x)));
axis square, axis off, axis xy
title('Amplitude')
set(gca,'clim',[0 200])
subplot(224)
PhsHandle = imagesc(rand(length(x)));
set(gca,'xlim',[Limits(2)-30 Limits(2)+30],'ylim',[Limits(2)-30 Limits(2)+30])
axis square, axis off, axis xy
title('Phase')


% Loop over locations
for i = 1:length(Xcenter)
    
    XX = x - Xcenter(i);
    YY = y - 20;
    
    gaus2d = exp(-(XX.^2 + YY.^2) ./ (2*Sigma^2));
    Image = zeros(size(gaus2d));
    Image(gaus2d>.9) = 1;
    
    % 2D FFT and extract power and phase spectra
    ImageX  = fftshift(fft2(Image));
    Power = abs(ImageX);
    Phase = angle(ImageX);
    
    % Update plots
    set(ImgHandle,'CData', Image);
    set(AmpHandle  ,'CData', Power);
    set(PhsHandle,'CData', Phase);
    colormap jet
    pause(.2)
end

