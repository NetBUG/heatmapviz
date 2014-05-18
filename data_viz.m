M = csvread('points_blacksquare.csv', 0, 1);
I = zeros(max(M(:, 1)), max(M(:, 2)));
for i = 1:size(M(:, 2))
    I(M(i, 1), M(i, 2)) = I(M(i, 1), M(i, 2)) + 1;
end
%h= plot(M, M,'.');
%set(h, 'Markersize','1');
G = fspecial('gaussian',[15 15],2);
%# Filter it
Ig = imfilter(I,G,'same');
imshow(Ig);