[y_src,u_src,v_src] = yuvRead("src250.yuv",1920,1088,1);
[y_fh,~,~] = yuvRead("fh250.yuv",1920,1088,1);
[y_mol,~,~] = yuvRead("mol250.yuv",1920,1088,1);

r=673;c=609;

cu_src = y_src(r:r+31,c:c+31);
cu_fh = y_fh(r:r+31,c:c+31);
cu_mol = y_mol(r:r+31,c:c+31);