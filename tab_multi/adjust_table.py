
def multiply_numbers_in_string(input_string, n):
    lines = input_string.strip().split('\n')
    multiplied_lines = []
    
    for line in lines:
        numbers = line.split(',')
        multiplied_numbers = []
        for number in numbers:
            if number.strip():
                multiplied_number = int(int(number.strip()) * n)
                multiplied_numbers.append(f"{multiplied_number:>3}")
        multiplied_lines.append(','.join(multiplied_numbers))
    
    return '\n'.join(multiplied_lines)

# 输入字符串
input_string = """
 120, 120, 120, 120, 120, 120,
 120, 120, 120, 120, 120, 120,
 120, 120, 120, 120, 120, 120,
 120, 120, 120, 120, 120, 120,
 120, 120, 120, 130, 140, 150,
 160, 180, 200, 220, 240, 260,
 280, 300, 320, 340, 360, 380,
 400, 420, 440, 460, 480, 500,
 512, 512, 512, 512
"""

# 扩大倍数
n = 63

# 执行函数
output_string = multiply_numbers_in_string(input_string, n)
print(output_string)
