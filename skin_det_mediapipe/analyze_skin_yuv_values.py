import numpy as np
import matplotlib.pyplot as plt
from mpl_toolkits.mplot3d import Axes3D


def analyze_yuv_values(skin_yuv_file='skin_yuv_values.txt', non_skin_yuv_file='non_skin_yuv_values.txt'):
    # Read YUV values from text files
    skin_yuv_values = np.loadtxt(skin_yuv_file, dtype=int)
    non_skin_yuv_values = np.loadtxt(non_skin_yuv_file, dtype=int)

    y_skin_values = skin_yuv_values[:, 0]
    u_skin_values = skin_yuv_values[:, 1]
    v_skin_values = skin_yuv_values[:, 2]

    y_non_skin_values = non_skin_yuv_values[:, 0]
    u_non_skin_values = non_skin_yuv_values[:, 1]
    v_non_skin_values = non_skin_yuv_values[:, 2]

    # Print mean and standard deviation of YUV values
    print("Skin YUV values:")
    print(f"Y - Mean: {np.mean(y_skin_values)}, Std: {np.std(y_skin_values)}")
    print(f"U - Mean: {np.mean(u_skin_values)}, Std: {np.std(u_skin_values)}")
    print(f"V - Mean: {np.mean(v_skin_values)}, Std: {np.std(v_skin_values)}")

    print("Non-Skin YUV values:")
    print(f"Y - Mean: {np.mean(y_non_skin_values)}, Std: {np.std(y_non_skin_values)}")
    print(f"U - Mean: {np.mean(u_non_skin_values)}, Std: {np.std(u_non_skin_values)}")
    print(f"V - Mean: {np.mean(v_non_skin_values)}, Std: {np.std(v_non_skin_values)}")

    # Plot histograms
    fig, ax = plt.subplots(2, 3, figsize=(18, 12))

    ax[0, 0].hist(y_skin_values, bins=255, color='gray')
    ax[0, 0].set_title('Skin Y channel values')
    ax[0, 1].hist(u_skin_values, bins=255, color='blue')
    ax[0, 1].set_title('Skin U channel values')
    ax[0, 2].hist(v_skin_values, bins=255, color='red')
    ax[0, 2].set_title('Skin V channel values')
    ax[0, 1].set_xlim(0, 255)
    ax[0, 0].set_xlim(0, 255)
    ax[0, 2].set_xlim(0, 255)

    ax[1, 0].hist(y_non_skin_values, bins=255, color='gray')
    ax[1, 0].set_title('Non-Skin Y channel values')
    ax[1, 1].hist(u_non_skin_values, bins=255, color='blue')
    ax[1, 1].set_title('Non-Skin U channel values')
    ax[1, 2].hist(v_non_skin_values, bins=255, color='red')
    ax[1, 2].set_title('Non-Skin V channel values')
    ax[1, 1].set_xlim(0, 255)
    ax[1, 0].set_xlim(0, 255)
    ax[1, 2].set_xlim(0, 255)

    plt.show()

    # Plot U-V relationships
    fig, ax = plt.subplots(1, 2, figsize=(12, 6))

    # Scatter plot with transparency and equal aspect ratio
    ax[0].scatter(v_skin_values, u_skin_values, color='blue', s=1, alpha=0.005)
    ax[0].set_title('Skin U-V values')
    ax[0].set_xlabel('V values')
    ax[0].set_ylabel('U values')
    ax[0].set_xlim(0, 255)
    ax[0].set_ylim(0, 255)
    ax[0].grid(True)  # Add grid to the first plot
    ax[0].set_aspect('equal', adjustable='box')  # Ensure equal aspect ratio

    ax[1].scatter(v_non_skin_values, u_non_skin_values, color='red', s=1, alpha=0.005)
    ax[1].set_title('Non-Skin U-V values')
    ax[1].set_xlabel('V values')
    ax[1].set_ylabel('U values')
    ax[1].set_xlim(0, 255)
    ax[1].set_ylim(0, 255)
    ax[1].grid(True)  # Add grid to the second plot
    ax[1].set_aspect('equal', adjustable='box')  # Ensure equal aspect ratio

    plt.show()

    # Plot 3D frequency plot
    fig = plt.figure(figsize=(12, 6))

    # Create 3D plot for skin values
    ax = fig.add_subplot(121, projection='3d')
    hist, xedges, yedges = np.histogram2d(u_skin_values, v_skin_values, bins=(50, 50), range=[[0, 255], [0, 255]])

    xpos, ypos = np.meshgrid(xedges[:-1] + 1.5, yedges[:-1] + 1.5, indexing="ij")
    xpos = xpos.ravel()
    ypos = ypos.ravel()
    zpos = 0

    dx = dy = 3
    dz = hist.ravel()

    ax.bar3d(xpos, ypos, zpos, dx, dy, dz, zsort='average', color='blue', alpha=0.7)
    ax.set_xlabel('U values')
    ax.set_ylabel('V values')
    ax.set_zlabel('Frequency')
    ax.set_title('3D Frequency Plot for Skin U-V values')
    ax.set_xlim(0, 255)
    ax.set_ylim(0, 255)

    # Create 3D plot for non-skin values
    ax = fig.add_subplot(122, projection='3d')
    hist, xedges, yedges = np.histogram2d(u_non_skin_values, v_non_skin_values, bins=(50, 50), range=[[0, 255], [0, 255]])

    xpos, ypos = np.meshgrid(xedges[:-1] + 1.5, yedges[:-1] + 1.5, indexing="ij")
    xpos = xpos.ravel()
    ypos = ypos.ravel()
    zpos = 0

    dx = dy = 3
    dz = hist.ravel()

    ax.bar3d(xpos, ypos, zpos, dx, dy, dz, zsort='average', color='red', alpha=0.7)
    ax.set_xlabel('U values')
    ax.set_ylabel('V values')
    ax.set_zlabel('Frequency')
    ax.set_title('3D Frequency Plot for Non-Skin U-V values')
    ax.set_xlim(0, 255)
    ax.set_ylim(0, 255)

    plt.show()


if __name__ == "__main__":
    analyze_yuv_values()
