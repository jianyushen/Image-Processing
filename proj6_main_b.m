close all;
I=imread('RetinaFD-L12-1024.png');
I=rgb2gray(I);
J=imread('RetinaFD-R6-1024.png');
J=rgb2gray(J);
subplot(2,2,1);
imshow(I);
subplot(2,2,2);
imshow(J);

section_size = 256;
section_num = 10;

offset = [0 1];
numlevel = 64;

subplot(2,2,3);
plot_lawsfeatures_statistics( I, section_size, section_num, offset, numlevel );

subplot(2,2,4);
plot_lawsfeatures_statistics( J, section_size, section_num, offset, numlevel );



