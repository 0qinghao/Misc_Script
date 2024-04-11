import os
import re

def process_xml_file(input_file, output_dir, log_file):
    # 创建一个空列表，用于保存修改后的行
    modified_lines = []

    # 尝试不同的编码方式打开文件
    encodings = ['utf-8', 'gbk', 'latin1']

    for encoding in encodings:
        try:
            with open(input_file, 'r', encoding=encoding) as file:
                lines = file.readlines()
                break
        except UnicodeDecodeError:
            continue

    # 为每一行检查条件并修改
    for line in lines:
        if 'bind="' in line:
            # 提取 sn_val
            sn_val = line.split('sn="')[1].split('"')[0]
            # 检查是否存在对应的 XML 文件
            if os.path.exists(f"./kr_item/{sn_val}.xml"):
                # 打开 XML 文件，检查是否有符合条件的内容
                with open(f"./kr_item/{sn_val}.xml", 'r') as xml_file:
                    xml_content = xml_file.read()
                    if 'rank value="4"' in xml_content and '<equip>' in xml_content:
                        index_bind = line.find('bind')
                        index_end_tag = line.find(' ', index_bind)
                        # 修改bind属性值为0
                        line = line[:index_bind] + 'bind="1" ' + line[index_end_tag + 1:]
        modified_lines.append(line)

    output_file = os.path.join(output_folder, os.path.basename(input_file))
    with open(output_file, 'w', encoding=encoding) as f:
        f.writelines(modified_lines)

def main(input_folder, output_folder, log_file):
    # 创建输出文件夹
    os.makedirs(output_folder, exist_ok=True)

    # 遍历文件夹中的所有文件
    for item in os.listdir(input_folder):
        item_path = os.path.join(input_folder, item)

        # 检查是否为文件
        if os.path.isfile(item_path):
            file_name, file_extension = os.path.splitext(item)
            if not re.search(r'\d', file_name) and file_extension.lower() == '.xml':
                process_xml_file(item_path, output_folder, log_file)

if __name__ == "__main__":
    # input_folder = "./item"
    # output_folder = "./item_alphabet_rank4_equip_bind1"
    input_folder = "./kr_item"
    output_folder = "./kr_item_alphabet_rank4_equip_bind1"
    log_file = "./log.txt"

    main(input_folder, output_folder, log_file)
