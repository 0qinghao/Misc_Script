import pyautogui
import tkinter as tk
from tkinter import simpledialog, messagebox
from io import BytesIO


class ScreenCaptureApp:

    def __init__(self, root):
        self.root = root
        self.root.title("屏幕实时捕获")
        self.root.attributes("-topmost", True)  # 置顶
        self.root.overrideredirect(True)  # 无边框

        self.offset_x = 0
        self.offset_y = 0
        self.root.bind("<Button-1>", self.start_drag)
        self.root.bind("<B1-Motion>", self.drag)

        # 监听鼠标滚轮事件
        self.root.bind("<MouseWheel>", self.resize)

        # 获取捕获区域，如果用户未输入，默认的区域
        self.capture_region = self.get_capture_region_dialog() or (900, 600, 300, 180)
        self.root.geometry(f"{self.capture_region[2]}x{self.capture_region[3]}")

        self.label = tk.Label(self.root)
        self.label.pack()

        # 屏幕截图的原始大小
        self.screenshot_width = self.capture_region[2]
        self.screenshot_height = self.capture_region[3]

        self.transparency = 1.0  # 初始透明度
        self.update_screenshot()

        # 监听键盘事件
        self.root.bind("<KeyPress>", self.key_press)
        self.root.bind("<Down>", self.decrease_transparency)
        self.root.bind("<Up>", self.increase_transparency)

    def start_drag(self, event):
        self.offset_x = event.x
        self.offset_y = event.y

    def drag(self, event):
        x = self.root.winfo_pointerx() - self.offset_x
        y = self.root.winfo_pointery() - self.offset_y
        self.root.geometry("+{}+{}".format(x, y))

    # 调整窗口大小
    def resize(self, event):
        if event.delta > 0:
            self.root.geometry(f"{self.root.winfo_width() + 10}x{self.root.winfo_height() + 10}")
        elif event.delta < 0:
            self.root.geometry(f"{self.root.winfo_width() - 10}x{self.root.winfo_height() - 10}")

    # 更新屏幕截图
    def update_screenshot(self):
        # 捕获屏幕区域
        screenshot = pyautogui.screenshot(region=self.capture_region)
        # 计算缩放比例
        scale_x = self.root.winfo_width() / self.screenshot_width
        scale_y = self.root.winfo_height() / self.screenshot_height
        screenshot = screenshot.resize((int(self.screenshot_width * scale_x), int(self.screenshot_height * scale_y)))

        with BytesIO() as output:
            screenshot.save(output, format='PNG')
            data = output.getvalue()
        photo = tk.PhotoImage(data=data)
        self.label.config(image=photo)
        self.label.image = photo

        # 设置窗口透明度
        self.root.attributes("-alpha", self.transparency)

        # 更新一次屏幕截图
        self.root.after(1, self.update_screenshot)

    # 获取捕获区域
    def get_capture_region_dialog(self):
        # 弹出窗口请求用户输入捕获区域
        region_str = simpledialog.askstring("捕获区域", "请输入捕获区域，格式为：左 上 宽 高\n示例：100 100 400 300")
        if region_str:
            try:
                region = tuple(map(int, region_str.split()))
                return region
            except ValueError:
                messagebox.showerror("错误", "输入格式错误，请重新输入！")
                return self.get_capture_region_dialog()

    # 键盘事件处理
    def key_press(self, event):
        if event.char == 'q':
            self.root.quit()

    # 透明度递减
    def decrease_transparency(self, event):
        self.transparency -= 0.1
        if self.transparency < 0.1:
            self.transparency = 0.1

    # 透明度递增
    def increase_transparency(self, event):
        self.transparency += 0.1
        if self.transparency > 1.0:
            self.transparency = 1.0


def main():
    root = tk.Tk()
    app = ScreenCaptureApp(root)
    root.mainloop()


if __name__ == "__main__":
    main()
