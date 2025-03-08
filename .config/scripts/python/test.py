import tkinter as tk
from tkinter import ttk

class HyprIdleSettings(tk.Tk):
    def __init__(self):
        super().__init__()
        self.title("HyprIdle Settings")
        self.geometry("300x700")
        self.resizable(False, False)

        # Title
        ttk.Label(self, text="HyprIdle Settings").pack(side="top", pady=10)

        settings_frame = tk.Frame(self)
        settings_frame.pack(side="top", pady=10)

        

        button_frame = tk.Frame(self)
        button_frame.pack(side="bottom", pady=10)

        # Save Button
        cancel_button = ttk.Button(button_frame, text="Cancel", command=self.cancel_settings)
        cancel_button.pack(side="left", padx=10)

        apply_button = ttk.Button(button_frame, text="Apply", command=self.apply_settings)
        apply_button.pack(side="left", padx=10)

        ok_button = ttk.Button(button_frame, text="Save", command=self.ok_settings)
        ok_button.pack(side="left", padx=10)

    def cancel_settings(self):
        print("Clicked")

    def apply_settings(self):
        print("Clicked")

    def ok_settings(self):
        print("Clicked")

if __name__ == "__main__":
    app = HyprIdleSettings()
    app.mainloop()
