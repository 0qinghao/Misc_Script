import struct
import os
import sys


def find_longest_run(filename):
    with open(filename, 'rb') as f:
        data = f.read()
    bits = ''.join(format(byte, '08b') for byte in data)
    longest_run = 0
    current_run = 0
    last_bit = None
    longest_run_start = None
    current_run_start = None
    for i, bit in enumerate(bits):
        if bit == last_bit:
            current_run += 1
        else:
            if current_run > longest_run:
                longest_run = current_run
                longest_run_start = current_run_start
            current_run = 1
            current_run_start = i
            last_bit = bit
    if current_run > longest_run:
        longest_run = current_run
        longest_run_start = current_run_start
    return (longest_run_start, longest_run)


if __name__ == '__main__':
    # filename = './12_indoor_day_OnePeopleSitting_1920x1088_qp0.h265'  #627791292 57

    # for filename in os.listdir('.'):
    #     if filename.endswith('.h265'):

    filename = sys.argv[1]
    longest_run_start, longest_run_length = find_longest_run(filename)
    print(f'The longest run of consecutive bits in {filename} starts at {longest_run_start} and has length {longest_run_length}.')
