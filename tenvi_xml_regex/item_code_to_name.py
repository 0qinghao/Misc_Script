import os
import re


def has_chinese_characters(text):
    # 使用正则表达式检查是否包含中文字符
    return bool(re.search('[\u4e00-\u9fff]', text))


def generate_dict(map_file):
    # 读取包含更多信息的文件
    # with open('国服道具名字原版.xml', 'r', encoding='utf-8') as info_file:
    with open(map_file, 'r', encoding='utf-8') as info_file:
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
            # item_code = line[key_start:key_end]
            item_info = line[value_start:value_end]
            info_dict[item_code] = item_info
    return info_dict


def process_files_in_folder(folder_path, info_dict, out_folder_path):
    # 获取文件夹中的所有文件
    files = os.listdir(folder_path)

    # 筛选出XML文件
    xml_files = [file for file in files if file.endswith('.xml')]

    # 循环处理每个XML文件
    for xml_file in xml_files:
        process_single_xml(os.path.join(folder_path, xml_file), info_dict, os.path.join(out_folder_path, xml_file))


# def process_single_xml(file_path, info_dict):
#     # 自动检测原始文件编码
#     # input_encoding = detect_encoding(file_path)

#     # 读取原始文件内容
#     with open(file_path, 'r', encoding='utf-8') as f:
#         original_content = f.read()

#     npc_code = os.path.splitext(os.path.basename(file_path))[0]
#     npc_code = npc_code.lstrip('0')

#     if npc_code in info_dict:
#         content_to_insert = f"<!-- {info_dict[npc_code]} -->"
#         # 在内容开头插入指定的内容
#         modified_content = content_to_insert + '\n' + original_content
#         # 写入修改后的内容到输出文件
#         out_file = "./out_dir/" + os.path.basename(file_path)
#         with open(out_file, 'w', encoding='utf-8') as f:
#             f.write(modified_content)

#     print(f"文件 '{file_path}' 已处理完成。")


def process_single_xml(file_path, info_dict, out_file_path):
    # 处理XML文件，添加注释
    with open(file_path, 'r', encoding='utf-8') as input_file:
        input_lines = input_file.readlines()
    output_lines = []
    for line in input_lines:
        if line.strip():  # 确保行不为空
            code_start = line.find('itemCode="') + len('itemCode="')
            if (code_start > len('itemCode="')):
                code_end = line.find('"', code_start)
                item_code = line[code_start:code_end].lstrip('0')
                replace_old_str = line[code_start - len('itemCode="'):code_end + 1]

                if item_code in info_dict:
                    # line = line.rstrip() + f' <!-- {info_dict[item_code]} -->\n'
                    replace_new_str = 'itemCode="' + info_dict[item_code] + '"'
                    line = line.replace(replace_old_str, replace_new_str)
                else:
                    print(f"item code not found, {file_path}-{item_code}")
        output_lines.append(line)
    # 将处理后的内容写入原文件
    with open(out_file_path, 'w', encoding='utf-8') as output_file:
        output_file.writelines(output_lines)
    # print(f"文件 '{file_path}' 已处理完成。")


# 要处理的文件夹路径
folder_path = './src_DropTable/'
out_folder_path = './DropTable_itemcode_to_name/'
# 生成字典的文件
map_file = './src_道具.xml'

info_dict = generate_dict(map_file)
# 处理文件夹内的所有XML文件
process_files_in_folder(folder_path, info_dict, out_folder_path)
