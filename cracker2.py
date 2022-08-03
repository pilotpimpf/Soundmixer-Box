import hid
import time

# for device in hid.enumerate():
#     print(f"0x{device['vendor_id']:04x}:0x{device['product_id']:04x} {device['product_string']}")

gamepad = hid.device()
gamepad.open(0x2341,0x8036)
gamepad.set_nonblocking(True)

last = bin(0)

def convert_x(n):
    if n >= 128:
        conv = n - 128
    else:
        conv =  n + 128
    return round(conv*100 / 255)

def convert_z(n):
    if n >= 128:
        conv = n - 127
    else:
        conv = n + 129
    conv -= 84
    return round(conv*100 / 86)

def assign_buttons(report, device = "main"):
        if device == "main":
            buttons = {
            "x" : convert_x(report[7]),
            "y" : round(int('{0:08b}'.format(report[8])[2:], 2)*100 / 62 -2),
            "z" : f"{convert_z(report[11])} ({report[11]})"
            }
        return buttons


while True:
    report = gamepad.read(64)
    if report:
        buttons = assign_buttons(report)
        s = ""
        for k, v in buttons.items():
            s += f"{k}: {v} "
        print(s)
