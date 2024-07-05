import numpy as np
from scipy.optimize import minimize
from sklearn.metrics import roc_auc_score
from tqdm import tqdm  # 引入 tqdm 库


# 读取皮肤区域和非皮肤区域的YUV数据
def read_yuv_data(filename):
    with open(filename, 'r') as file:
        lines = file.readlines()
    data = []
    for line in lines:
        values = list(map(int, line.strip().split()))
        data.append(values)
    return np.array(data)


# 文件路径
skin_file = 'skin_yuv_values.txt'
non_skin_file = 'non_skin_yuv_values.txt'

# 读取数据
skin_data = read_yuv_data(skin_file)
non_skin_data = read_yuv_data(non_skin_file)

# # 初始参数
# initial_a = 1.0  # a 的初始值

# # 计算目标值（均值）
# t_skin = np.mean([u + v for u, v in skin_data[:, 1:]])
# t_non_skin = np.mean([u + v for u, v in non_skin_data[:, 1:]])

# # 损失函数
# def loss(a):
#     skin_loss = np.sum((skin_data[:, 1] + a * skin_data[:, 2] - t_skin)**2)
#     non_skin_loss = np.sum((non_skin_data[:, 1] + a * non_skin_data[:, 2] - t_non_skin)**2)
#     return skin_loss + non_skin_loss

# # 使用 scipy.optimize.minimize 进行优化
# result = minimize(loss, initial_a, method='BFGS')

# # 最优参数
# a_opt = result.x[0]

a_opt = 0.6

# 网格搜索参数范围
U_skin = skin_data[:, 1]
V_skin = skin_data[:, 2]
U_non_skin = non_skin_data[:, 1]
V_non_skin = non_skin_data[:, 2]

# 网格搜索范围
L1_range = np.linspace(np.min(U_skin), np.max(U_skin), 10)
H1_range = np.linspace(np.min(U_skin), np.max(U_skin), 10)
L2_range = np.linspace(np.min(V_skin), np.max(V_skin), 10)
H2_range = np.linspace(np.min(V_skin), np.max(V_skin), 10)
L3_range = np.linspace(np.min(U_skin + a_opt * V_skin), np.max(U_skin + a_opt * V_skin), 10)
H3_range = np.linspace(np.min(U_skin + a_opt * V_skin), np.max(U_skin + a_opt * V_skin), 10)


# 计算AUC-ROC
def compute_auc(L1, H1, L2, H2, L3, H3, a):
    # 皮肤区域
    skin_conditions = (U_skin > L1) & (U_skin < H1) & (V_skin > L2) & (V_skin < H2)
    skin_scores = U_skin + a * V_skin
    skin_predictions = (skin_conditions & (skin_scores > L3) & (skin_scores < H3)).astype(int)

    # 非皮肤区域
    non_skin_conditions = (U_non_skin > L1) & (U_non_skin < H1) & (V_non_skin > L2) & (V_non_skin < H2)
    non_skin_scores = U_non_skin + a * V_non_skin
    non_skin_predictions = (non_skin_conditions & (non_skin_scores > L3) & (non_skin_scores < H3)).astype(int)

    # 合并预测结果
    y_true = np.concatenate([np.ones(len(skin_data)), np.zeros(len(non_skin_data))])
    y_scores = np.concatenate([skin_predictions, non_skin_predictions])

    return roc_auc_score(y_true, y_scores)


# 搜索最优参数组合
best_auc = -np.inf
best_params = (None, None, None, None, None, None)

# 包裹循环以显示进度条
total_iterations = len(L1_range) * len(H1_range) * len(L2_range) * len(H2_range) * len(L3_range) * len(H3_range)
with tqdm(total=total_iterations) as pbar:
    for L1 in L1_range:
        for H1 in H1_range:
            if L1 >= H1:
                pbar.update(len(L2_range) * len(H2_range) * len(L3_range) * len(H3_range))
                continue
            for L2 in L2_range:
                for H2 in H2_range:
                    if L2 >= H2:
                        pbar.update(len(L3_range) * len(H3_range))
                        continue
                    for L3 in L3_range:
                        for H3 in H3_range:
                            if L3 >= H3:
                                pbar.update(1)
                                continue
                            auc = compute_auc(L1, H1, L2, H2, L3, H3, a_opt)
                            if auc > best_auc:
                                best_auc = auc
                                best_params = (L1, H1, L2, H2, L3, H3)
                            pbar.update(1)

L1_opt, H1_opt, L2_opt, H2_opt, L3_opt, H3_opt = best_params

print("最优参数：")
print("a =", a_opt)
print("L1 =", L1_opt)
print("H1 =", H1_opt)
print("L2 =", L2_opt)
print("H2 =", H2_opt)
print("L3 =", L3_opt)
print("H3 =", H3_opt)
print("最佳 AUC =", best_auc)
