clc;
clear;
%%%%%%%%%%%   Transfer figure to 1024*1024   %%%%%%%%%%
img1= imread('RetinaFD-L12.jpg');
img1=imcrop(img1, [1700,1150,1023,1023]);  % [xmin ymin width height]
imgray1 = rgb2gray(img1);



img2 = imread('RetinaFD-R6.jpg');%RetinaFD-R6-1024.png
img2=imcrop(img2, [1950,1300,1023,1023]);  
imgray2 = rgb2gray(img2);

subplot(2,1,1);
imshow(imgray1);
title('Original 1024*1024 GrayImage L12');

subplot(2,1,2);
imshow(imgray2);
title('Original 1024*1024 GrayImage R6');



I=imgray1;


J=imgray2;


section_size = 256;
section_num = 10;

offset = [0 1];
numlevel = 64;
figure;
subplot(2,1,1);
plot_lawsfeatures_statistics( I, section_size, section_num, offset, numlevel );

subplot(2,1,2);

plot_lawsfeatures_statistics( J, section_size, section_num, offset, numlevel );
 


