import os
import re

def has_chinese_characters(text):
    # 使用正则表达式检查是否包含中文字符
    return bool(re.search('[\u4e00-\u9fff]', text))

def process_files_in_folder(folder_path):
    # 获取文件夹中的所有文件
    files = os.listdir(folder_path)
    
    # 筛选出XML文件
    xml_files = [file for file in files if file.endswith('.xml.error')]
    
    # 循环处理每个XML文件
    for xml_file in xml_files:
        process_single_xml(os.path.join(folder_path, xml_file))

def process_single_xml(file_path):
    # 读取包含更多信息的文件
    with open('国服道具名字原版.xml', 'r', encoding='utf-8') as info_file:
        info_lines = info_file.readlines()

    # 创建一个字典，用于存储itemCode和对应的信息
    info_dict = {}
    for line in info_lines:
        if line.strip():  # 确保行不为空
            key_start = line.find('key="') + len('key="')
            key_end = line.find('"', key_start)
            value_start = line.find('value="') + len('value="')
            value_end = line.find('"', value_start)
            item_code = line[key_start:key_end].lstrip('0')  # 去除开头多余的0
            item_info = line[value_start:value_end]
            info_dict[item_code] = item_info

    # 处理XML文件，添加注释
    with open(file_path, 'r', encoding='utf-8') as input_file:
        input_lines = input_file.readlines()

    output_lines = []
    for line in input_lines:
        if line.strip():  # 确保行不为空
            code_start = line.find('itemCode="') + len('itemCode="')
            code_end = line.find('"', code_start)
            item_code = line[code_start:code_end].lstrip('0')  # 去除开头多余的0
            # 检查当前行是否已经存在注释
            if '<!--' in line:
                # 获取注释内容
                comment_start = line.find('<!--')
                comment_end = line.find('-->')
                existing_comment = line[comment_start:comment_end+3]
                # 如果注释中包含中文字符，先删除
                if has_chinese_characters(existing_comment):
                    line = line.replace(existing_comment, '')

            if item_code in info_dict:
                line = line.rstrip() + f' <!-- {info_dict[item_code]} -->\n'
        output_lines.append(line)

    # 将处理后的内容写入原文件
    with open(file_path, 'w', encoding='utf-8') as output_file:
        output_file.writelines(output_lines)

    print(f"文件 '{file_path}' 已处理完成。")

# 要处理的文件夹路径
folder_path = './add_comment_2DropTable/'
# folder_path = './add_comment_DropTable/'
# folder_path = './add_comment_boss/'

# 处理文件夹内的所有XML文件
process_files_in_folder(folder_path)
