
file_name1 = 'F:\Skoltech\Arts\points_dali.csv';
[I1, M1] = make_heat_map(file_name1);

figure(1)
imagesc(I1)

figure(2)
imshow(I1)

% % % % % % % % % % % % % % % % % % % 
M = M3;
x = M(:, 1);
y = M(:, 2); 
r = 100;    % 100,200,500
[n, c] = hist3([x y], [r, r]);  
h = imagesc(c{1},c{2},n);
set(gcf, 'Position', [100 100 740 480]) 
title('Black square')
set(gca,'xtick',[])
set(gca,'xticklabel',[])
set(gca,'ytick',[])
set(gca,'yticklabel',[])
colorbar
saveas(h, 'F:\Skoltech\Arts\dali.png','png');
% % % % % % % % % % % % % % % % % % % 

surf(c{1},c{2},n,'linestyle','none')


file_name2 = 'F:\Skoltech\Arts\points_venus.csv';
[I2, M2] = make_heat_map(file_name2);

file_name3 = 'F:\Skoltech\Arts\points_blacksquare.csv';
[I3, M3] = make_heat_map(file_name3);
