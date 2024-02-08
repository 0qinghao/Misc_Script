import numpy as np
import cv2

def generate_constant_block(blkw, blkh, constant_value):
    # Generate a block of size blkw x blkh with constant values
    block = np.full((blkh, blkw), constant_value, dtype=np.uint8)
    return block

def generate_random_offset(blkw, blkh, P):
    # Generate random offset values based on P
    offset = np.random.randint(-P, P+1, size=(blkh, blkw), dtype=np.int8)
    return offset

def apply_offset_to_block(block, offset):
    # Apply offset to the block and clip to the valid range (0, 255)
    block_with_offset = np.clip(block + offset, 0, 255)
    return block_with_offset

def generate_random_blocks(w, h, blkw, blkh, num_blocks):
    # Generate a list of random blocks
    blocks = [generate_constant_block(blkw, blkh, np.random.randint(0, 256)) for _ in range(num_blocks)]
    return blocks

def generate_yuv_sequence(w, h, blkw, blkh, max_P, num_frames, num_blocks, output_filename):
    with open(output_filename, 'wb') as yuv_file:
        for frame in range(num_frames):
            # Randomly choose the discrete level (P) for each frame
            P = np.random.randint(0, max_P+1)

            # Generate random blocks
            blocks = generate_random_blocks(w, h, blkw, blkh, num_blocks)

            # Generate random offsets for each block
            offsets = [generate_random_offset(blkw, blkh, P) for _ in range(num_blocks)]

            # Create an empty Y component
            Y = np.zeros((h, w), dtype=np.uint8)
            U = np.zeros((h//2, w//2), dtype=np.uint8)
            V = np.zeros((h//2, w//2), dtype=np.uint8)

            # Apply random blocks with offsets to the Y component
            for i in range(0, h, blkh):
                for j in range(0, w, blkw):
                    index_base = np.random.randint(0, num_blocks)
                    index_offset = np.random.randint(0, num_blocks)
                    block = apply_offset_to_block(blocks[index_base], offsets[index_offset])
                    Y[i:i+blkh, j:j+blkw] = block

            for i in range(0, h//2, blkh):
                for j in range(0, w//2, blkw):
                    index_base = np.random.randint(0, num_blocks)
                    index_offset = np.random.randint(0, num_blocks)
                    block = apply_offset_to_block(blocks[index_base], offsets[index_offset])
                    U[i:i+blkh, j:j+blkw] = block
                    index_base = np.random.randint(0, num_blocks)
                    index_offset = np.random.randint(0, num_blocks)
                    block = apply_offset_to_block(blocks[index_base], offsets[index_offset])
                    V[i:i+blkh, j:j+blkw] = block

            # Save Y, U, V components to the YUV file
            yuv_frame = np.concatenate((Y.reshape(-1), U.reshape(-1), V.reshape(-1)))
            yuv_frame = yuv_frame.astype(np.uint8)
            yuv_frame.tofile(yuv_file)

def main():
    # Image size
    w = 128
    h = 128

    # Block size
    blkw = 64
    blkh = 64

    # Maximum discrete level (adjust as needed)
    max_P = 120

    # Number of frames to generate
    num_frames = 10000

    # Number of different blocks to generate for each frame, 基底库数量
    num_blocks = 20

    # Output YUV filename
    output_filename = "output.yuv"

    # Generate Y, U, V components separately for multiple frames
    generate_yuv_sequence(w, h, blkw, blkh, max_P, num_frames, num_blocks, output_filename)

if __name__ == "__main__":
    main()
