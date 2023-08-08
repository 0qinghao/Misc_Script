import re
import pandas as pd
import io


class FileWithPrevLine:

    def __init__(self, file):
        self.file = file
        self.prev_line = None
        self.curr_line = None

    def readline_keep_prev(self):
        if self.curr_line:
            self.prev_line = self.curr_line
        self.curr_line = self.file.readline()
        return self.curr_line


with open("./2023_06_30_16_40_21_192.168.1.140.log", 'r') as f:
    fwp = FileWithPrevLine(f)
    print(fwp.readline_keep_prev())
    # print(f.readline())

# with open("./2023_06_30_16_40_21_192.168.1.140.log", 'r') as log_file_handle:
#     log_content = log_file_handle.read()

# pattern_timestamp = r'\[[\d:]+\]'
# pattern_chn_play_info_1_mark = pattern_timestamp + r'-+CHN\s+PLAY\s+INFO\s+1-+'
# pattern_chn_play_info_1_title = pattern_timestamp + r'(?:\s+[a-zA-Z]+){12,}'
# pattern_chn_play_info_1_body = r'(?:%s(?:\s+[\dNY]+){12,}\n)+' % pattern_timestamp
# pattern_chn_play_info_1_full = pattern_chn_play_info_1_mark + r'\n(' + pattern_chn_play_info_1_title + r'\n' + pattern_chn_play_info_1_body + r')'

# chn_play_info_1_str = re.findall(pattern_chn_play_info_1_full, log_content)

# lst = []
# for d in chn_play_info_1_str:
#     rows = d.strip().split('\n')
#     rows = [r.split() for r in rows]
#     lst.extend(rows)
# writer = pd.ExcelWriter('example.xlsx', engine='openpyxl')
# df = pd.DataFrame(lst)
# df.to_excel(writer, index=False)
# writer.close()
