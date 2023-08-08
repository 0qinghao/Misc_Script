import pandas as pd
from openpyxl import load_workbook
import matplotlib.pyplot as plt

# 读取 Excel 文件
df = pd.read_excel('./example.xlsx')

# 筛选数据
# df = df[(df[2] == 7) & (df[1] == 1)]

# 将 Pandas 数据框写入 Excel 文件
# book = load_workbook('example.xlsx')
# writer = pd.ExcelWriter('example.xlsx', engine='openpyxl')
# writer.book = book
# writer.sheets = dict((ws.title, ws) for ws in book.worksheets)
# df.to_excel(writer, sheet_name='Sheet1', index=False)
# writer.save()

# 绘制折线图
plt.plot(df[8])

# 添加图表标题和标签
plt.title('Framerate')
plt.xlabel('Index')
plt.ylabel('Framerate')

# 显示图表
plt.savefig('framerate.png')