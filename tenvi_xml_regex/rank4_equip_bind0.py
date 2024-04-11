import os

def process_xml_file(input_file, output_dir, log_file):
    # 尝试不同的编码方式打开文件
    encodings = ['utf-8', 'gbk', 'latin1']

    for encoding in encodings:
        try:
            with open(input_file, 'r', encoding=encoding) as file:
                content = file.read()
        except UnicodeDecodeError:
            continue

    # 查找rank="4"并修改bind属性为0
    if 'rank value="4"' in content and '<equip>' in content :
        print(f"处理 {input_file} 文件...")
        # 找到rank="4"后，找到其后的bind，并将其值修改为0
        index_rank = content.find('rank value="4"')
        index_bind = content.find('<bind', index_rank)
        index_end_tag = content.find('>', index_bind)

        # 修改bind属性值为0
        content = content[:index_bind] + '<bind value="0" />' + content[index_end_tag + 1:]

        # 保存修改后的XML文件
        output_file = os.path.join(output_dir, os.path.basename(input_file))
        with open(output_file, 'w') as f:
            f.write(content)

        # 记录修改过的文件
        with open(log_file, 'a') as log:
            log.write(f"Modified: {input_file}\n")

def main(input_folder, output_folder, log_file):
    # 创建输出文件夹
    os.makedirs(output_folder, exist_ok=True)

    # 遍历文件夹中的所有文件
    for item in os.listdir(input_folder):
        item_path = os.path.join(input_folder, item)

        # 检查是否为文件
        if os.path.isfile(item_path):
            # 检查文件名是否全为数字且是xml文件
            file_name, file_extension = os.path.splitext(item)
            if file_name.isdigit() and file_extension.lower() == '.xml':
                process_xml_file(item_path, output_folder, log_file)

if __name__ == "__main__":
    # input_folder = "./item"
    # output_folder = "./item_rank4_equip_bind0"
    input_folder = "./kr_item"
    output_folder = "./kr_item_rank4_equip_bind0"
    log_file = "./log.txt"

    main(input_folder, output_folder, log_file)
