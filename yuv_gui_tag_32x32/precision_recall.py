# 读取标签数据
with open('coordinates.txt', 'r') as f:
    ground_truth = [line.strip() for line in f.readlines()]

# 读取检测结果数据
with open('yuview.csv', 'r') as f:
    detection_results = f.readlines()

# 筛选以 "" 结尾的检测结果，并保留去除尾部的数据
end_mark = '32;32;14;1'
filtered_results = []
for result in detection_results:
    stripped_result = result.strip()
    if stripped_result.endswith(end_mark):
        filtered_results.append(stripped_result[:-(1 + len(end_mark))])

# 计算真正例（True Positives）
true_positives = 0
for result in filtered_results:
    if result in ground_truth:
        true_positives += 1

# 计算假正例（False Positives）
false_positives = len(filtered_results) - true_positives

# 计算假负例（False Negatives）
false_negatives = len(ground_truth) - true_positives

# 计算精度（Precision）
precision = true_positives / (true_positives + false_positives) if (true_positives + false_positives) > 0 else 0

# 计算召回率（Recall）
recall = true_positives / (true_positives + false_negatives) if (true_positives + false_negatives) > 0 else 0

print("Precision:", precision)
print("Recall:", recall)
