clc;
clear;
%%%%%%%%%%%   Transfer figure to 1024*1024   %%%%%%%%%%
img1= imread('RetinaFD-L12.jpg');%RetinaFD-L12-1024.png
img1=imcrop(img1, [1700,1150,1023,1023]);  % [xmin ymin width height]
imgary1 = rgb2gray(img1);


img2 = imread('RetinaFD-R6.jpg');%RetinaFD-R6-1024.png
img2=imcrop(img2, [1950,1300,1023,1023]);  % [xmin ymin width height]
imgray2 = rgb2gray(img2);

subplot(2,3,1);
imshow(imgary1);
title('Original 1024*1024 GrayImage L12');

subplot(2,3,4);
imshow(imgray2);
title('Original 1024*1024 GrayImage R6');

%%%%%%%%% Gabor Method  %%%%%%%%%
%%%%%%   Set parameters of GaborMethod  %%%%%%
bw      = 1;        gamma   = 0.5;
psi     = [0 pi/10];
lambda  = 8;        theta   = 0;
N       = 8;

%%%%%% Modify Image %%%%%%
Image= im2double(img1);
Image(:,:,2:3) = [];          
Image_out = zeros(size(Image,1), size(Image,2), N);

%%%%%% Use GaborMethod %%%%%%
for n=1:N
    Gabor=GaborMethod(bw,gamma,psi(1),lambda,theta)...
        + 1i * GaborMethod(bw,gamma,psi(2),lambda,theta);
    Image_out(:,:,n) = imfilter(Image, Gabor, 'symmetric');
    theta = theta + 10*pi/N;
    
end
%%%%%%%% Image after using GaborMethod %%%%%%%
Image_Output = sum(abs(Image_out).^2, 3).^0.5;
Image_Output = Image_Output./max(Image_Output(:));
subplot(2,3,3)                                               
imshow(Image_Output);
title('Normalized Gabor output');
