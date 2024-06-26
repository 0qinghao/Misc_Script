import numpy as np
import argparse


def generate_mosaic(unit_pix, img_w, img_h, rep_f):
    Y = np.zeros((img_h, img_w), dtype=np.uint8)
    U = np.zeros((img_h // 2, img_w // 2), dtype=np.uint8)
    V = np.zeros((img_h // 2, img_w // 2), dtype=np.uint8)

    for i in range(0, img_h, unit_pix):
        for j in range(0, img_w, unit_pix):
            oe_x = (j // unit_pix) % 2
            oe_y = (i // unit_pix) % 2
            if oe_x == oe_y:
                val_y = 255
                val_u = 128
                val_v = 128
            else:
                val_y = 0
                val_u = 128
                val_v = 128

            # Handle incomplete blocks at the edges
            y_end = min(i + unit_pix, img_h)
            x_end = min(j + unit_pix, img_w)
            Y[i:y_end, j:x_end] = val_y

            # Handle U and V values
            u_i_start, u_i_end = i // 2, y_end // 2
            v_j_start, v_j_end = j // 2, x_end // 2
            U[u_i_start:u_i_end, v_j_start:v_j_end] = val_u
            V[u_i_start:u_i_end, v_j_start:v_j_end] = val_v

    YUV = np.concatenate((Y.flatten(), U.flatten(), V.flatten()))

    with open('mosaic.yuv', 'wb') as fid:
        for _ in range(rep_f):
            fid.write(YUV)


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Generate a mosaic image and save as YUV file.")
    parser.add_argument("unit_pix", type=int, help="mosaic w/h size.")
    parser.add_argument("img_w", type=int, help="Width of the image.")
    parser.add_argument("img_h", type=int, help="Height of the image.")
    parser.add_argument("rep_f", type=int, help="Frames.")

    args = parser.parse_args()

    generate_mosaic(args.unit_pix, args.img_w, args.img_h, args.rep_f)
