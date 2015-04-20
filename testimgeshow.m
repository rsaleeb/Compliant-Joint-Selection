

X1 = imread('LSN.png');
X2 = imread('LCF.png');
%# Load a sample image
% image(X1);        %# Plot the image
% hold on
% subimage(X2);
subplot(1,2,1), subimage(X1)
title('LSN')
axis off
subplot(1,2,2), subimage(X2)
title('LCF')
axis off