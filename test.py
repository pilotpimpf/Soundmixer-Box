import hid
import time

# for device in hid.enumerate(0x2341,0x8036):
#     #print(f"0x{device['vendor_id']:04x}:0x{device['product_id']:04x} {device['product_string']}")
#     print(device, type(device))

gamepad = hid.device()
#gamepad.open(0x2341,0x8036, 'HIDNH')
gamepad.open(0x2341,0x8036, 'HIDEG')
gamepad.set_nonblocking(True)

last = bin(0)

def convert_x(n):
    if n >= 128:
        conv = n - 128
    else:
        conv = n + 128
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
            "b01" : bool(report[1] & 0b00000001),
            "b02" : bool(report[1] & 0b00000010),
            "b03" : bool(report[1] & 0b00000100),
            "b04" : bool(report[1] & 0b00001000),
            "b05" : bool(report[1] & 0b00010000),
            "b06" : bool(report[1] & 0b00100000),
            "b07" : bool(report[1] & 0b01000000),
            "b08" : bool(report[1] & 0b10000000),
            "b09" : bool(report[2] & 0b00000001),
            "b10" : bool(report[2] & 0b00000010),
            "b11" : bool(report[2] & 0b00000100),
            "b12" : bool(report[2] & 0b00001000),
            "b13" : bool(report[2] & 0b00010000),
            "b14" : bool(report[2] & 0b00100000),
            "b15" : bool(report[2] & 0b01000000),
            "b16" : bool(report[2] & 0b10000000),
            "b17" : bool(report[2] & 0b00000001),
            "b18" : bool(report[3] & 0b00000010),
            "b19" : bool(report[3] & 0b00000100),
            "b20" : bool(report[3] & 0b00001000),
            "b21" : bool(report[3] & 0b00010000),
            "b22" : bool(report[3] & 0b00100000),
            "b23" : bool(report[3] & 0b01000000),
            "b24" : bool(report[3] & 0b10000000),
            "b25" : bool(report[4] & 0b00000001),
            "b26" : bool(report[4] & 0b00000010),
            "b27" : bool(report[4] & 0b00000100),
            "b28" : bool(report[4] & 0b00001000),
            "b29" : bool(report[4] & 0b00010000),
            "b30" : bool(report[4] & 0b00100000),
            "b31" : bool(report[4] & 0b01000000),
            "b32" : bool(report[4] & 0b10000000),
            "x": convert_x(report[7]),
            "y": round(int('{0:08b}'.format(report[8])[2:], 2)*100 / 62 - 2),
            "z": convert_z(report[11])
            }
        return buttons

# while True:
#     report = gamepad.read(64)
#     if report:
#         buttons = assign_buttons(report)
#         s = ""
#         for k, v in buttons.items():
#             s = s + f"{k}: {v} "
#         print(s)
#         #last = report[3]


while True:
    report = gamepad.read(64)
    if report:
        buttons = assign_buttons(report)
        s = ""
        for k, v in buttons.items():
            print(f"{k}: {v} ")
        print("")
        time.sleep(3)
        #last = report[3]

# while True:
#     report = gamepad.read(64)
#     if report:
#         print('{0:08b}'.format(report[1]))
#         #print(report)
#         #last = report[3]