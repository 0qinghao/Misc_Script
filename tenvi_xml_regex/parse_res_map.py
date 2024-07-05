import os
import xml.etree.ElementTree as ET
import chardet

def detect_encoding(file_path):
    with open(file_path, 'rb') as f:
        rawdata = f.read()
    return chardet.detect(rawdata)['encoding']

def parse_field_xml(file_path):
    items = {}
    tree = ET.parse(file_path)
    root = tree.getroot()
    for s in root.findall('s'):
        key = s.get('key')
        value = s.get('value')
        items[key] = value
    return items

def parse_item_xml(file_path):
    items = {}
    tree = ET.parse(file_path)
    root = tree.getroot()
    for s in root.findall('s'):
        key = s.get('key')
        value = s.get('value')
        items[key] = value
    return items

def count_items_in_maps(folder_path, field_str, item_str):
    map_items = {}
    for filename in os.listdir(folder_path):
        if filename.startswith('dynamic') and filename.endswith('.xml'):
            map_id = filename.split('dynamic')[1].split('.')[0].split('_')[0]
            map_items[map_id] = {}
            input_encoding = detect_encoding(os.path.join(folder_path, filename))
            with open(os.path.join(folder_path, filename), 'r', encoding=input_encoding) as file:
                for line in file:
                    if '<item type="' in line:
                        item_type = line.split('type="')[1].split('"')[0]
                        if item_type in item_str:
                            item_name = item_str[item_type]
                            if item_name in map_items[map_id]:
                                map_items[map_id][item_name] += 1
                            else:
                                map_items[map_id][item_name] = 1
    return map_items

def save_results_to_file(map_items, field_items, item_items, output_file):
    with open(output_file, 'w', encoding='utf-8') as file:
        for map_id, items in map_items.items():
            if map_id in field_items:
                file.write(f"{field_items[map_id]}：\n")
                for item_id, count in items.items():
                    file.write(f"{item_id}\n")
                file.write(f"\n")
                
def main():
    field_xml_path = 'CN-126-xml/string/field.xml'
    item_xml_path = 'CN-126-xml/string/item.xml'
    folder_path = 'CN-126-xml/map'
    output_file = 'map_resource_parse.txt'

    field_string = parse_field_xml(field_xml_path)
    item_string = parse_item_xml(item_xml_path)
    map_items = count_items_in_maps(folder_path, field_string, item_string)

    save_results_to_file(map_items, field_string, item_string, output_file)
    print(f"结果已保存到文件: {output_file}")

if __name__ == "__main__":
    main()
