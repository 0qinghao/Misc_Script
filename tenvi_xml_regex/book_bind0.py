import re
import os

# 读取info.xml文件
# with open('./国服道具名字原版.xml', 'r', encoding='utf-8') as file:
with open('./韩服道具.xml', 'r', encoding='utf-8') as file:
    lines = file.readlines()

# 使用正则表达式提取包含"合成书"的行并提取出key
keys = []
for line in lines:
    match = re.search(r'<s key="(\d+)" value=".*合成书.*" />', line)
    if match:
        keys.append(match.group(1))

def process_xml_file(input_file, output_dir, log_file):
    with open(input_file, 'r') as f:
        content = f.read()

        index_bind = content.find('<bind')
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

# 根据提取的key打开相应的key.xml文件进行处理
for key in keys:
    # key_file = f'./item/{key}.xml'  # 假设key.xml文件的命名格式是key.xml
    key_file = f'./kr_item/{key}.xml'  # 假设key.xml文件的命名格式是key.xml
    # 在这里添加你需要的处理逻辑，比如打开key.xml文件、处理等等
    print(f"处理 {key_file} 文件...")
    process_xml_file(key_file, "kr_item_book_bind0", "log.txt")