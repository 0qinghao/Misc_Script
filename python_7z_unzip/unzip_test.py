import subprocess

# 定义7-Zip的路径，如果在PATH中，可以直接使用"7z"
seven_zip_path = r'C:\Program Files\7-Zip\7z.exe'  # 替换为你的7-Zip安装路径

# 要解压的tar.gz文件路径
tar_gz_file_path = r'C:\Users\rin.lin\AppData\Local\anaconda3\Lib\site-packages\dateutil\zoneinfo\dateutil-zoneinfo.tar.gz'  # 替换为你的tar.gz文件路径

# 解压目标文件夹路径
extracted_folder_path = r'C:\Users\rin.lin\Misc_Script\python_7z_unzip\unzip_result'  # 替换为你想要解压到的目标文件夹路径

# 先执行gzip解压缩
gzip_command = [seven_zip_path, 'e', tar_gz_file_path, f'-o{extracted_folder_path}', '-y']
try:
    subprocess.run(gzip_command, check=True)
except subprocess.CalledProcessError as e:
    print(f"解压gzip文件 {tar_gz_file_path} 失败。错误信息: {e}")
    exit(1)

# 构建7-Zip tar解压缩命令
tar_file_path = extracted_folder_path + '\\' + tar_gz_file_path.split('\\')[-1].replace('.tar.gz', '.tar')
tar_command = [seven_zip_path, 'x', tar_file_path, '-o' + extracted_folder_path, '-y']

# 执行tar解压缩
try:
    subprocess.run(tar_command, check=True)
    print(f"文件 {tar_gz_file_path} 已成功解压到 {extracted_folder_path}")
except subprocess.CalledProcessError as e:
    print(f"解压tar文件 {tar_file_path} 失败。错误信息: {e}")
