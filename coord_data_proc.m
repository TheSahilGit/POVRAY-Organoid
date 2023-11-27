clear; clc; close all;

%xp = load('../xptrack.out');


for t=1:105

    s = sprintf('%04d', t-1);
    file_path = ['input_data/coordn_data/coord_number', s, '.out'];

    coordn = load(file_path);

    num = coordn(:,1)';
    cellno = length(num);

    file_path2 = ['processed_data/coordn_data_proc/num_time_', s, '.txt'];
    dlmwrite(file_path2, num, ',');
    for jj = 1:cellno
        inn = coordn(jj,2:num(jj)+1);

        s = sprintf('%04d', t-1);
        s2 = sprintf('%04d', jj);
        file_path1 = ['processed_data/coordn_data_proc/inn_time_', s,'_cell_',s2, '.txt'];
        %
        dlmwrite(file_path1, inn, ',');
    end

end
