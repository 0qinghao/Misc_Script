import re
import pandas as pd
from pandas import ExcelWriter


def eth_data():
    with open("./eth_log.log", 'r') as log_file_handle:
        log_content = log_file_handle.read()

    pattern_timestamp = r'\[[\d:-]+\]'
    pattern_start_mark = pattern_timestamp + r'eth0\s+Link\sencap:.*'
    # awesome, [\d\D] [\s\S] [\w\W] ... match anything
    pattern_time = pattern_start_mark + r'[\d\D]*?\[(.*)\]'
    pattern_packets = pattern_start_mark + r'[\d\D]*?RX\spackets:(\d+)'
    pattern_errors = pattern_start_mark + r'[\d\D]*?errors:(\d+)'
    pattern_dropped = pattern_start_mark + r'[\d\D]*?dropped:(\d+)'
    pattern_overruns = pattern_start_mark + r'[\d\D]*?overruns:(\d+)'

    time_val = re.findall(pattern_time, log_content)
    packets_val = re.findall(pattern_packets, log_content)
    errors_val = re.findall(pattern_errors, log_content)
    dropped_val = re.findall(pattern_dropped, log_content)
    overruns_val = re.findall(pattern_overruns, log_content)

    df = pd.DataFrame({'time': time_val, 'packets': packets_val, 'errors': errors_val, 'dropped': dropped_val, 'overruns': overruns_val})
    df = df.astype({'packets': 'int', 'errors': 'int', 'dropped': 'int', 'overruns': 'int'})

    with ExcelWriter('eth_data.xlsx', engine='xlsxwriter') as writer:
        df.to_excel(writer, sheet_name='data', index=False)
        workbook = writer.book
        worksheet = writer.sheets['data']
        chart = workbook.add_chart({'type': 'line'})
        chart.add_series({
            'name': '=data!$B$1',
            'categories': '=data!$A$2:$A$' + str(len(time_val) + 1),
            'values': '=data!$B$2:$B$' + str(len(time_val) + 1),
        })
        chart.add_series({
            'name': '=data!$C$1',
            'categories': '=data!$A$2:$A$' + str(len(time_val) + 1),
            'values': '=data!$C$2:$C$' + str(len(time_val) + 1),
        })
        chart.add_series({
            'name': '=data!$D$1',
            'categories': '=data!$A$2:$A$' + str(len(time_val) + 1),
            'values': '=data!$D$2:$D$' + str(len(time_val) + 1),
        })
        chart.add_series({
            'name': '=data!$E$1',
            'categories': '=data!$A$2:$A$' + str(len(time_val) + 1),
            'values': '=data!$E$2:$E$' + str(len(time_val) + 1),
        })
        worksheet.insert_chart('G2', chart)


if __name__ == '__main__':
    eth_data()