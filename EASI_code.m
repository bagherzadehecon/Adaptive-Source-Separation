%% loading
s1 = imread('n01806143_7550.JPEG');
s2 = imread('n01855672_3562.JPEG');
figure(1)
subplot(1,2,1)
imshow(s1);
title 's_1'
subplot(1,2,2)
imshow(s2);
title 's_2'
%% mixing
x1 =0.8*s1 + 0.2*s2;
x2 =0.2*s1 + 0.8*s2;

s1=im2double(s1) ;

s2=im2double(s2) ;

x1=im2double(x1) ;
%x1=rgb2gray(x1) ;

x2=im2double(x2) ;
%x2=rgb2gray(x2) ;

figure(2)
subplot(1,2,1)
imshow(x1);
title 'x_1'
subplot(1,2,2)
imshow(x2);
title 'x_2'

%% computing the separated signals for RGB images
y1 = zeros(500,500,3);
y2 = zeros(500,500,3);

x1_R = x1(:,:,1);
x2_R = x2(:,:,1);
x1_G = x1(:,:,2);
x2_G = x2(:,:,2);
x1_B = x1(:,:,3);
x2_B = x2(:,:,3);

%% source separation (EASI) with g = diag(y*y').*y


[s1_seperated_R , s2_seperated_R ] = EASI_me_2D ( x1_R , x2_R ,100) ;
[s1_seperated_G , s2_seperated_G ] = EASI_me_2D ( x1_G , x2_G ,100) ;
[s1_seperated_B , s2_seperated_B ] = EASI_me_2D ( x1_B , x2_B ,100) ;


y1(:,:,1) = reshape( s1_seperated_R , [500,500] );
y1(:,:,2) = reshape( s1_seperated_G , [500,500] );
y1(:,:,3) = reshape( s1_seperated_B , [500,500] );

y2(:,:,1) = reshape( s2_seperated_R , [500,500] );
y2(:,:,2) = reshape( s2_seperated_G , [500,500] );
y2(:,:,3) = reshape( s2_seperated_B , [500,500] );


figure(3)
subplot(1,2,1)
imshow(y1);
title 's1 seperated'
subplot(1,2,2)
imshow(y2);
title 's2 seperated'

%% SNR y ( g = diag(y*y').*y )
SNR_y1 = 10 * log10(mean(s1(:).^2)./mean((s1(:)-y1(:)).^2));
SNR_y2 = 10 * log10(mean(s2(:).^2)./mean((s2(:)-y2(:)).^2));

% snr y1 = 17.468
% snr y2 = 18.389

%% source separation (EASI) with g2 = y ./  log(diag(y_y))
SNR_y1_2 = zeros(50,1);
SNR_y2_2 = zeros(50,1);

for j = 50

y1_2 = zeros(500,500,3);
y2_2 = zeros(500,500,3);

[s1_seperated_R_2 , s2_seperated_R_2 ] = EASI_me_g2 ( x1_R , x2_R ,j) ;
[s1_seperated_G_2 , s2_seperated_G_2 ] = EASI_me_g2 ( x1_G , x2_G ,j) ;
[s1_seperated_B_2 , s2_seperated_B_2 ] = EASI_me_g2 ( x1_B , x2_B ,j) ;


y1_2(:,:,1) = reshape( s1_seperated_R_2 , [500,500] );
y1_2(:,:,2) = reshape( s1_seperated_G_2 , [500,500] );
y1_2(:,:,3) = reshape( s1_seperated_B_2 , [500,500] );

y2_2(:,:,1) = reshape( s2_seperated_R_2 , [500,500] );
y2_2(:,:,2) = reshape( s2_seperated_G_2 , [500,500] );
y2_2(:,:,3) = reshape( s2_seperated_B_2 , [500,500] );

SNR_y1_2(j) = 10 * log10(mean(s1(:).^2)./mean((s1(:)-y1_2(:)).^2));
SNR_y2_2(j) = 10 * log10(mean(s2(:).^2)./mean((s2(:)-y2_2(:)).^2));

end

% figure(4)
% subplot(1,2,1)
% stem(SNR_y1_2)
% title 'SNR Y1'
% subplot(1,2,2)
% stem(SNR_y2_2)
% title 'SNR Y2'

figure(5)
subplot(1,2,1)
imshow(y1_2);
title 's1 seperated'
subplot(1,2,2)
imshow(y2_2);
title 's2 seperated'


%% source separation (EASI) with g3 = - y ./  diag(y_y)
SNR_y1_3 = zeros(300,1);
SNR_y2_3 = zeros(300,1);

for j = 300

y1_3 = zeros(500,500,3);
y2_3 = zeros(500,500,3);

[s1_seperated_R_3 , s2_seperated_R_3 ] = EASI_me_g3 ( x1_R , x2_R ,j) ;
[s1_seperated_G_3 , s2_seperated_G_3 ] = EASI_me_g3 ( x1_G , x2_G ,j) ;
[s1_seperated_B_3 , s2_seperated_B_3 ] = EASI_me_g3 ( x1_B , x2_B ,j) ;


y1_3(:,:,1) = reshape( s1_seperated_R_3 , [500,500] );
y1_3(:,:,2) = reshape( s1_seperated_G_3 , [500,500] );
y1_3(:,:,3) = reshape( s1_seperated_B_3 , [500,500] );

y2_3(:,:,1) = reshape( s2_seperated_R_3 , [500,500] );
y2_3(:,:,2) = reshape( s2_seperated_G_3 , [500,500] );
y2_3(:,:,3) = reshape( s2_seperated_B_3 , [500,500] );

SNR_y1_3(j) = 10 * log10(mean(s2(:).^2)./mean((s2(:)-y1_3(:)).^2));
SNR_y2_3(j) = 10 * log10(mean(s1(:).^2)./mean((s1(:)-y2_3(:)).^2));

end

% figure(4)
% subplot(1,2,1)
% stem(SNR_y1_3)
% title 'SNR Y1'
% subplot(1,2,2)
% stem(SNR_y2_3)
% title 'SNR Y2'

figure(5)
subplot(1,2,1)
imshow(y1_3);
title 's1 seperated'
subplot(1,2,2)
imshow(y2_3);
title 's2 seperated'