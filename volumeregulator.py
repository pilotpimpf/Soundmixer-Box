from time import sleep
import hid
from pycaw.pycaw import AudioUtilities, ISimpleAudioVolume

gamepad0 = hid.device()
gamepad0.open(0x2341,0x8036, 'HIDNH')
gamepad0.set_nonblocking(True)

gamepad1 = hid.device()
gamepad1.open(0x2341,0x8036, 'HIDEG')
gamepad1.set_nonblocking(True)

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

def assign_buttons(report, device="main"):
    if device == "main":
        buttons = {
            "b01": bool(report[1] & 0b00000001),
            "b02": bool(report[1] & 0b00000010),
            "b03": bool(report[1] & 0b00000100),
            "b04": bool(report[1] & 0b00001000),
            "b05": bool(report[1] & 0b00010000),
            "b06": bool(report[1] & 0b00100000),
            "b07": bool(report[1] & 0b01000000),
            "b08": bool(report[1] & 0b10000000),
            "b09": bool(report[2] & 0b00000001),
            "b10": bool(report[2] & 0b00000010),
            "b11": bool(report[2] & 0b00000100),
            "b12": bool(report[2] & 0b00001000),
            "b13": bool(report[2] & 0b00010000),
            "b14": bool(report[2] & 0b00100000),
            "b15": bool(report[2] & 0b01000000),
            "b16": bool(report[2] & 0b10000000),
            "b17": bool(report[2] & 0b00000001),
            "b18": bool(report[3] & 0b00000010),
            "b19": bool(report[3] & 0b00000100),
            "b20": bool(report[3] & 0b00001000),
            "b21": bool(report[3] & 0b00010000),
            "b22": bool(report[3] & 0b00100000),
            "b23": bool(report[3] & 0b01000000),
            "b24": bool(report[3] & 0b10000000),
            "b25": bool(report[4] & 0b00000001),
            "b26": bool(report[4] & 0b00000010),
            "b27": bool(report[4] & 0b00000100),
            "b28": bool(report[4] & 0b00001000),
            "b29": bool(report[4] & 0b00010000),
            "b30": bool(report[4] & 0b00100000),
            "b31": bool(report[4] & 0b01000000),
            "b32": bool(report[4] & 0b10000000),
            "x": convert_x(report[7]),
            "y": round(int('{0:08b}'.format(report[8])[2:], 2)*100 / 62 - 2),
            "z": convert_z(report[11])
        }
    return buttons


def setAudio(process, val):
    if val == "game": return
    sessions = AudioUtilities.GetAllSessions()
    for session in sessions:
        if session.Process and session.Process.name() == process:
            volume = session._ctl.QueryInterface(ISimpleAudioVolume)
            volume.SetMasterVolume(val, None)

def getAudio(process):
    sessions = AudioUtilities.GetAllSessions()
    for session in sessions:
        if session.Process and session.Process.name() == process:
            volume = session._ctl.QueryInterface(ISimpleAudioVolume)
            return round(volume.GetMasterVolume() * 100)
    return 100

lastX = getAudio("Spotify.exe")
lastY = getAudio("chrome.exe")
lastZ = getAudio("")

print(f"Spotify: {lastX}%  Chrome: {lastY}%  None: {lastZ}%")

while True:
    report0 = gamepad0.read(64)
    report1 = gamepad1.read(64)
    if report0 and report1:
        buttons0 = assign_buttons(report0)
        buttons1 = assign_buttons(report1)
        if buttons1["b11"]:
            x = buttons0["x"]
            if abs(lastX -x) >= 2:
                if x >= 98: x = 100
                elif x <= 1: x= 0
                setAudio("Spotify.exe", round(x/100, 2))
                lastX = x
                print(f"Set Spotify to {x}%")

            y = buttons0 ["y"]
            if abs(lastY -y) >= 2:
                if y >= 98: y = 100
                elif y <= 1: y= 0
                setAudio("Discord.exe", round(y/100, 2))
                lastY = y
                print(f"Set Discord to {y}%")

            z = buttons0["z"]
            if abs(lastZ -z) >= 2:
                if z >= 98: z = 100
                elif z <= 1: z= 0
                setAudio("game", round(z/100, 2))
                lastZ = z
                print(f"Set Game to {z}%")
        else:
            x = buttons0["x"]
            if abs(lastX -x) >= 2:
                if x >= 98: x = 100
                elif x <= 1: x= 0
                setAudio("Spotify.exe", round(x/100, 2))
                lastX = x
                print(f"Set Spotify to {x}%")

            y = buttons0["y"]
            if abs(lastY -y) >= 2:
                if y >= 98: y = 100
                elif y <= 1: y= 0
                setAudio("Discord.exe", round(y/100, 2))
                lastY = y
                print(f"Set Discord to {y}%")

            z = buttons0["z"]
            if abs(lastZ -z) >= 2:
                if z >= 98: z = 100
                elif z <= 1: z= 0
                setAudio("chrome.exe", round(z/100, 2))
                lastZ = z
                print(f"Set Chrome to {z}%")
    sleep(0.01)