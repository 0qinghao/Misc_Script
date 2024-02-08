import binascii

def binary_to_hex_text(input_file_path, output_file_path):
    with open(input_file_path, 'rb') as binary_file, open(output_file_path, 'w') as hex_file:
        while True:
            # 读取16字节的二进制数据
            binary_data = binary_file.read(16)
            
            # 如果没有数据了，退出循环
            if not binary_data:
                break
            
            # 将二进制数据转换为十六进制文本，不添加空格
            # hex_text = binascii.hexlify(binary_data).decode('utf-8')
            hex_text = binascii.hexlify(binary_data[::-1]).decode('utf-8')

            
            # 写入十六进制文本到输出文件，每行16个字节
            hex_file.write(hex_text + '\n')

# 例子
input_file = '264bs.bin'
output_file = 'output_hex.txt'
binary_to_hex_text(input_file, output_file)
