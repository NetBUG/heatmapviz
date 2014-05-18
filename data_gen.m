% d ata fmt
% 
% #first sample
% 1300557889 300 620 M
% 1300557889 110 111 F
% 
% #first sample
% 1300557890 320 597 M

function data_gen
    %filename = 'points_blacksquare.csv';
    %n = generate(filename, [120 300 100 0.1; 200 350 75 0.3; 400 10 150 0.2]);
    %fprintf(1, '%d users generated for %s', n, filename);
    filename = 'points_venus.csv';
    n = generate(filename, [400 120 100 0.2; 300 350 75 0.3; 310 370 150 0.2; 210 370 150 0.2]);
    fprintf(1, '%d users generated for %s\n', n, filename);

    filename = 'points_dali.csv';
    n = generate(filename, [300 43 100 0.5]);
    fprintf(1, '%d users generated for %s\n', n, filename);
    
    filename = 'points_pollock.csv';
    %n = generate(filename, [400 120 100 0.2; 300 350 75 0.3; 310 370 150 0.2; 210 370 150 0.2]);
    fprintf(1, '%d users generated for %s\n', n, filename);
    
end

function n = generate(filename, points)
    % ========== INPUTS =============
    % X Y sigma strength
    step_mean = 20;
    step_sigma = 10;
    max_x = 640;
    max_y = 480;
    timestamp_start = 1400429937;
    
    % =========== CODE ==============

    pds_x = [];
    pds_y = [];
    file_id = fopen(filename,'w');
    x = 350;
    y = 400;
    st = zeros(max_x, max_y);

    for i = 1:size(points, 1)
        pds_x = [pds_x makedist('Normal', points(i, 1), points(i, 3))];
        pds_y = [pds_y makedist('Normal', points(i, 2), points(i, 3))];
    end
    
    n = random('norm', 60, 20);
    for j = 1:n
        timestamp_start = timestamp_start + round(abs(random('norm', 300, 300)));
        for i = 1:abs(random('norm', 1200, 1500))
            % jumping
            step = abs(round(random('norm', step_mean, step_sigma)));
            step_p = exp(abs([log(getProb(x+step, y, pds_x, pds_y)) log(getProb(x, y+step, pds_x, pds_y)) log(getProb(x-step, y, pds_x, pds_y)) log(getProb(x, y-step, pds_x, pds_y))]));
            step_p = step_p / sum(step_p);
            [a, nr] = max(random('norm', step_p, [1 1 1 1]));
            switch (nr)
                case 1
                    if x + step > max_x
                        step = -step;
                    end
                    x = x + step;
                case 2
                    if y + step > max_y
                        step = -step;
                    end
                    y = y + step;
                case 3
                    if x - step < 1
                        step = -step;
                    end
                    x = x - step;
                case 4
                    if y - step < 1
                        step = -step;
                    end
                    y = y - step;
            end
            %fprintf(1, '%d %d %d \n', x, y, step);
            fprintf(file_id, '%d,%d,%d\n', timestamp_start, x, y);
            st(x, y) = st(x, y) + 1;
        end
    end
    imshow(st);
end


function val = getProb (x, y, pds_x, pds_y)
    val = 0;
    for i = 1:size(pds_x, 1)
        val = val + pdf(pds_x(i), x) * pdf(pds_y(i), y);
    end
end
