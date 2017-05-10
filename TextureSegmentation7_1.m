clc;
clear;
%%%%%%%%%%%   Transfer figure to 1024*1024   %%%%%%%%%%
img1= imread('RetinaFD-L12.jpg');%RetinaFD-L12-1024.png
img1=imcrop(img1, [1700,1150,1023,1023]);  % [xmin ymin width height]
imgary1 = rgb2gray(img1);
% subplot(1,2,1);
% imshow(imgary1);
% title('Original 1024*1024 GrayImage L12');

img2 = imread('RetinaFD-R6.jpg');%RetinaFD-R6-1024.png
img2=imcrop(img2, [1950,1300,1023,1023]);  % [xmin ymin width height]
imgray2 = rgb2gray(img2);



% subplot(1,2,2);
% imshow(imgray2);
% title('Original 1024*1024 GrayImage R6');

%%%%%%%  Texture Segmentation to find disk and vissels  %%%%%%%% 
% Step 1: Create Texture Image----
% Use entropyfilt to create a texture image.
% The function entropyfilt returns an array where each output pixel contains the entropy value of 
% the 9-by-9 neighborhood around the corresponding pixel in the input image I. 
% Entropy is a statistical measure of randomness. 

 E = entropyfilt(img1);
%  Use mat2gray to rescale the texture image E so that its values are in the 
%  default range for a double image.
 Eim = mat2gray(E);
 imshow(Eim);

%  Step 3: Create Rough Mask for the Bottom Texture
% Threshold the rescaled image Eim to segment the textures. A threshold value of 0.8 is selected because it is 
% roughly the intensity value of pixels along the boundary between the textures.
 BW1 = im2bw(Eim, .8);

%  The segmented objects in the binary image BW1 are white. If you compare BW1 to I,
%  you notice the top texture is overly segmented (multiple white objects) and the bottom texture 
%  is segmented almost in its entirety. You can extract the bottom texture using bwareaopen.
 BWao = bwareaopen(BW1,2000);

imshow(BWao);

%  Use imclose to smooth the edges and to close any open holes in the object in BWao. A 9-by-9 neighborhood 
%  is selected because this neighborhood was also used by entropyfilt.
 
 nhood = true(9);
closeBWao = imclose(BWao,nhood);
imshow(closeBWao)
 


 %Use imfill to fill holes in the object in closeBWao.
 roughMask = imfill(closeBWao,'holes');
%  Step 4: Use Rough Mask to Segment the Top Texture
% Compare the binary image roughMask to the original image I. Notice the mask for the bottom texture 
% is not perfect because the mask does not extend to the bottom of the image. However, you can use 
% roughMask to segment the top texture.

 %Get raw image of the top texture using roughMask.
 I2 = img1;
 I2(roughMask) = 0;

 
%Use entropyfilt to calculate the texture image.
 E2 = entropyfilt(I2);
 E2im = mat2gray(E2);


 %Threshold E2im using graythresh.
 BW2 = im2bw(mat2gray(E2),graythresh(E2im));
 
%  If you compare BW2 to I, you notice there are two objects 
%  segmented in BW2. Use bwareaopen to get a mask for the top texture.
 mask2 = bwareaopen(BW2,1000);
 figure;
 imshow(mask2);

%  Step 5: Display Segmentation Results
% Use mask2 to extract the top and bottom texture from I.
 texture1 = img1;
 texture1(~mask2) = 0;
 texture2 = img1;
 texture2(mask2) = 0;

 %Outline the boundary between the two textures.
 boundary = bwperim(mask2);
 segmentResults = img1;
 segmentResults(boundary) = 255;
 
%Using Other Texture Filters in Segmentation
% Instead of entropyfilt, you can use stdfilt and rangefilt
% with other morphological functions to achieve similar segmentation results.
 S = stdfilt(img1,nhood);

 R = rangefilt(img1,ones(5));
 figure;
 imshow(R);
 title('Texture Segmentation On L12');
 
 %%%%%%%%   The same method used in image 2  %%%%%%%%
 E = entropyfilt(img2);
 Eim = mat2gray(E);
 BW1 = im2bw(Eim, .8);
 BWao = bwareaopen(BW1,2000);
 nhood = true(9);
 closeBWao = imclose(BWao,nhood);
 roughMask = imfill(closeBWao,'holes');
 I2 = img2;
 I2(roughMask) = 0;
 E2 = entropyfilt(I2);
 E2im = mat2gray(E2);
 BW2 = im2bw(E2im,graythresh(E2im));
 mask2 = bwareaopen(BW2,1000);
 texture1 = img2;
 texture1(~mask2) = 0;
 texture2 = img2;
 texture2(mask2) = 0;
 boundary = bwperim(mask2);
 segmentResults = img2;
 segmentResults(boundary) = 255;
 S = stdfilt(img2,nhood);
 R = rangefilt(img2,ones(5));
 figure;
 imshow(R);
 title('Textrue Segmentation Of R6');