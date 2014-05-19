function [I, M] = make_heat_map(file_name)

M = csvread(file_name, 0, 1);

I = zeros(max(M(:, 1)), max(M(:, 2)));
for i = 1 : size(M(:, 2))
    I(M(i, 1), M(i, 2)) = I(M(i, 1), M(i, 2)) + 1;
end


