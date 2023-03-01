import sys
import os
import numpy as np

IMG_WIDTH = int(sys.argv[3])
IMG_HEIGHT = int(sys.argv[4])
IMG_SIZE = int(IMG_WIDTH * IMG_HEIGHT * 3 / 2)

Y_WIDTH = IMG_WIDTH
Y_HEIGHT = IMG_HEIGHT
Y_SIZE = int(Y_WIDTH * Y_HEIGHT)

U_V_WIDTH = int(IMG_WIDTH / 2)
U_V_HEIGHT = int(IMG_HEIGHT / 2)


def from_blk(yuv_data, frames):
    Y = np.zeros((frames, IMG_HEIGHT, IMG_WIDTH), dtype=np.uint8)
    U = np.zeros((frames, U_V_HEIGHT, U_V_WIDTH), dtype=np.uint8)
    V = np.zeros((frames, U_V_HEIGHT, U_V_WIDTH), dtype=np.uint8)

    for frame_idx in range(0, frames):
        blk_start_y = frame_idx * IMG_SIZE
        blk_start_uv = blk_start_y + Y_SIZE

        for y in range(0, Y_HEIGHT, 16):
            for x in range(0, Y_WIDTH, 16):
                Y[frame_idx, y:y + 8, x:x + 8] = yuv_data[blk_start_y:blk_start_y + 64].reshape(8, 8)
                blk_start_y += 64
                Y[frame_idx, y:y + 8, x + 8:x + 16] = yuv_data[blk_start_y:blk_start_y + 64].reshape(8, 8)
                blk_start_y += 64
                Y[frame_idx, y + 8:y + 16, x:x + 8] = yuv_data[blk_start_y:blk_start_y + 64].reshape(8, 8)
                blk_start_y += 64
                Y[frame_idx, y + 8:y + 16, x + 8:x + 16] = yuv_data[blk_start_y:blk_start_y + 64].reshape(8, 8)
                blk_start_y += 64
        for y in range(0, U_V_HEIGHT, 8):
            for x in range(0, U_V_WIDTH, 8):
                U[frame_idx, y:y + 8, x:x + 8] = yuv_data[blk_start_uv:blk_start_uv + 64].reshape(8, 8)
                blk_start_uv += 64
                V[frame_idx, y:y + 8, x:x + 8] = yuv_data[blk_start_uv:blk_start_uv + 64].reshape(8, 8)
                blk_start_uv += 64
    return Y, U, V


if __name__ == '__main__':
    yuv = sys.argv[1]
    frames = int(os.path.getsize(yuv) / IMG_SIZE)

    yuv_f = open(yuv, "rb")
    yuv_bytes = yuv_f.read()
    yuv_data = np.frombuffer(yuv_bytes, np.uint8)

    Y, U, V = from_blk(yuv_data, frames)

    yuv_out = np.zeros((frames, IMG_SIZE), dtype=np.uint8)
    for frame_idx in range(frames):
        yuv_out[frame_idx, :] = np.hstack((np.hstack((Y[frame_idx, :, :].flatten(), U[frame_idx, :, :].flatten())), V[frame_idx, :, :].flatten()))

    yuv_out.tofile(sys.argv[2])
