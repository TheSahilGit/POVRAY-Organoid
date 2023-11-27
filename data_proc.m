clear; clc; close all; 

xp = load('input_data/xptrack.out'); yp = load('input_data/yptrack.out'); 
zp = load('input_data/zptrack.out');
cellType = load("input_data/celltypetrack.out");




L =  5.5;
dt = 0.002;
nskip = 250;
delta = dt*nskip;
nhst =  5;
nloop = length(yp(:,1));
nsk = 3;
np0 = 0;
nrw = xp(1,2);
npt = xp(:,1);

cnt = 0;
for it = 2:1:length(yp(:,1))
    %for it = length(yp(:,1)):1:length(yp(:,1));
    cnt = cnt + 1;
    np = (xp(it,1));
    ista = nsk; iend = np+nsk-1-nrw;
    ncell(cnt,1) = iend-ista+1;
    
    clear rp0 rpCT coordnNu;

    rp0(:,1) = xp(it,ista:iend);
    rp0(:,2) = yp(it,ista:iend);
    rp0(:,3) = zp(it,ista:iend);
%    rp0(:,4) = cellType(it,ista:iend);
    rpCT(:,1) = cellType(it,ista:iend);

    %coordnNu(:,1) = coordn(1,2:coordn(1)+1);


    ista = np+nsk-nrw; iend = np+nsk-1;
    if iend>length(xp); iend = length(xp); end;
    ncell(cnt,2) = iend-ista+1;
    clear rm0;
    rm0(:,1) = xp(it,ista:iend);
    rm0(:,2) = yp(it,ista:iend);
    rm0(:,3) = zp(it,ista:iend);

    icount = 0;
    clear rmc0;
    for ip = ista:iend;
        if zp(it,ip) < 0;
            icount = icount+1;
            rmc0(icount,1) = xp(it,ip);
            rmc0(icount,2) = yp(it,ip);
            rmc0(icount,3) = zp(it,ip);
        end
    end
    ncell(cnt,3) = length(rmc0);
    %--
    rp00 = reshape(transpose(rp0),[1 length(rp0)*3]);
    rpCT00 = reshape(transpose(rpCT),[1 length(rpCT)]);   
    
    rm00 = reshape(transpose(rm0),[1 length(rm0)*3]);
    rmc00 = reshape(transpose(rmc0),[1 length(rmc0)*3]);
   
    dlmwrite(sprintf('processed_data/cell_3d%.4d.txt',cnt),rp00,',');
    
    dlmwrite(sprintf('processed_data/cellType_3d%.4d.txt',cnt),rpCT00,',');


 %   coordn = load(sprintf('../data/coord_number%.4d.out',cnt-1));
 %   dlmwrite(sprintf('datatxt/coord_number_%.4d.txt',cnt-1),coordn,',');
    
    cnt

%    dlmwrite(sprintf('processed_data/matrix_3d%.4d.txt',cnt),rm00,',');
%    dlmwrite(sprintf('processed_data/half_matrix_3d%.4d.txt',cnt),rmc00,',');
    

    %sprintf('test_3d%.4d',it)
    %dlmwrite('data_pov_ray/test_3d'%.4d'.txt',rp00,',');
end
ncell0 = reshape(transpose(ncell),[1 length(ncell)*3]);
dlmwrite('processed_data/ncell.txt',ncell0,',')
%save('ncell.txt','ncell','-ascii')
