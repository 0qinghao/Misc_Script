import re
import pandas as pd
import sys


def print_usage():
    print("**** 使用 'git log --graph --stat --name-status > git_log.txt' 生成 git_log.txt ****")
    print("用法: python collect_git_log.py [gitlog_file]")
    print("  [gitlog_file] : 可选参数，指定要读取的gitlog文件名。默认使用'git_log.txt'")


def parse_gitlog(file_path):
    try:
        # 读取gitlog文件
        with open(file_path, 'r', encoding='utf-8') as file:
            gitlog_text = file.read()
    except FileNotFoundError:
        print(f"错误: 文件 '{file_path}' 找不到。")
        sys.exit(1)

    # 使用正则表达式提取所需信息
    commit_pattern = re.compile(r'\*+.*commit\s+([a-f0-9]+)')
    author_pattern = re.compile(r'Author:\s+(.+)\s<')
    date_pattern = re.compile(r'Date:\s+(.+)')
    merge_pattern = re.compile(r'Merge:')
    bracket_pattern = re.compile(r'(\[.*?\])\s*(\[.*?\])\s*(\[.*?\])\s*(.*)')
    file_pattern = re.compile(r'^[|\s]+([AMDR]\d*\s+.*)')  # 文件变动

    commits = []
    current_commit = None

    lines = gitlog_text.splitlines()

    for line in lines:
        if commit_match := commit_pattern.search(line):
            if current_commit:  # 如果当前有记录的commit，先保存
                commits.append(current_commit)
            current_commit = {'commit': commit_match.group(1), 'merge': 'No', 'author': None, 'date': None, 'project': None, 'trac_id': None, 'module': None, 'description': None, 'files_changed': []}
        elif author_match := author_pattern.search(line):
            current_commit['author'] = author_match.group(1)
        elif date_match := date_pattern.search(line):
            current_commit['date'] = date_match.group(1)
        elif merge_pattern.search(line):
            current_commit['merge'] = 'Yes'
        elif bracket_match := bracket_pattern.search(line):
            if current_commit['merge'] == 'Yes':
                current_commit['description'] = ''.join(bracket_match.groups())
            else:
                current_commit['project'] = bracket_match.group(1)
                current_commit['trac_id'] = bracket_match.group(2)
                current_commit['module'] = bracket_match.group(3)
                current_commit['description'] = bracket_match.group(4)
        elif file_match := file_pattern.search(line):
            current_commit['files_changed'].append(file_match.group(1).strip().replace('\t', ' '))

    # 添加最后一条记录
    if current_commit:
        commits.append(current_commit)

    # 转换为DataFrame，并将文件名列表转化为字符串
    df = pd.DataFrame(commits, columns=['commit', 'author', 'date', 'merge', 'project', 'trac_id', 'module', 'description', 'files_changed'])
    df['files_changed'] = df['files_changed'].apply(lambda x: '\n'.join(x))

    # 保存到Excel文件
    df.to_excel('gitlog_analysis.xlsx', index=False)
    print("信息已保存到gitlog_analysis.xlsx中")


def main():
    if len(sys.argv) > 2:
        print_usage()
        sys.exit(1)

    input_file = sys.argv[1] if len(sys.argv) == 2 else 'git_log.txt'
    parse_gitlog(input_file)


if __name__ == "__main__":
    main()
