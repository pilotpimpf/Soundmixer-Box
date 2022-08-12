from time import sleep
import hid
from pycaw.pycaw import AudioUtilities, ISimpleAudioVolume
import configparser
import os

def startup():
    dirname = os.path.dirname(__file__)
    config = configparser.ConfigParser()

    try:
        config.read(f"{dirname}/config.ini")
    except:
        with open(f"{dirname}/config.ini", "w") as f:
            f.write("""
                [device]
                vendor_id = 9025
                product_id = 32823

                [1]
                name = Spotify
                process = Spotify.exe

                [2]
                name = Discord
                process = Discord.exe

                [3]
                name = Game
                process = fornite.exe,SuperHexagon.exe

                [4]
                name = Chrome
                process = chrome.exe
            """)
        
        print("Created default config file")

        config.read(f"{dirname}/config.ini")


    try:
        gamepad = hid.device()
        try:
            gamepad.open(int(config.get("device", "vendor_id")), int(config.get("device", "product_id")), config.get("device", "serial_number"))
        except:
            gamepad.open(int(config.get("device", "vendor_id")), int(config.get("device", "product_id")))
            print("No serial number used")
        gamepad.set_nonblocking(True)

        return config, gamepad
    except:
        print("Failed to open Device")
        exit()
    

def convert(n):
    if n >= 128:
        conv = n - 128
    else:
        conv = n + 128
    return round(conv*100 / 255)

def assign_buttons(report, device="main"):
    if device == "main":
        buttons = {
            # "b01": bool(report[1] & 0b00000001),
            # "b02": bool(report[1] & 0b00000010),
            # "b03": bool(report[1] & 0b00000100),
            # "b04": bool(report[1] & 0b00001000),
            # "b05": bool(report[1] & 0b00010000),
            # "b06": bool(report[1] & 0b00100000),
            # "b07": bool(report[1] & 0b01000000),
            # "b08": bool(report[1] & 0b10000000),
            # "b09": bool(report[2] & 0b00000001),
            # "b10": bool(report[2] & 0b00000010),
            # "b11": bool(report[2] & 0b00000100),
            # "b12": bool(report[2] & 0b00001000),
            # "b13": bool(report[2] & 0b00010000),
            # "b14": bool(report[2] & 0b00100000),
            # "b15": bool(report[2] & 0b01000000),
            # "b16": bool(report[2] & 0b10000000),
            # "b17": bool(report[2] & 0b00000001),
            # "b18": bool(report[3] & 0b00000010),
            # "b19": bool(report[3] & 0b00000100),
            # "b20": bool(report[3] & 0b00001000),
            # "b21": bool(report[3] & 0b00010000),
            # "b22": bool(report[3] & 0b00100000),
            # "b23": bool(report[3] & 0b01000000),
            # "b24": bool(report[3] & 0b10000000),
            # "b25": bool(report[4] & 0b00000001),
            # "b26": bool(report[4] & 0b00000010),
            # "b27": bool(report[4] & 0b00000100),
            # "b28": bool(report[4] & 0b00001000),
            # "b29": bool(report[4] & 0b00010000),
            # "b30": bool(report[4] & 0b00100000),
            # "b31": bool(report[4] & 0b01000000),
            # "b32": bool(report[4] & 0b10000000),
            "x": convert(report[7]),
            "y": round(int('{0:08b}'.format(report[8])[2:], 2)*100 / 62 - 2),
            "z": convert(report[11]),
            "t": convert(report[21])
        }
    return buttons


def setAudio(process, val):
    if "," in process:
        sessions = AudioUtilities.GetAllSessions()
        processes = process.split(",")
        for session in sessions:
            if session.Process and session.Process.name() in processes:
                volume = session._ctl.QueryInterface(ISimpleAudioVolume)
                volume.SetMasterVolume(val, None)       
    else:
        sessions = AudioUtilities.GetAllSessions()
        for session in sessions:
            if session.Process and session.Process.name() == process:
                volume = session._ctl.QueryInterface(ISimpleAudioVolume)
                volume.SetMasterVolume(val, None)

def getAudio(process):
    sessions = AudioUtilities.GetAllSessions()
    if "," in process:
        processes = process.split(",")
        for session in sessions:
            if session.Process and session.Process.name() in processes:
                volume = session._ctl.QueryInterface(ISimpleAudioVolume)
                return round(volume.GetMasterVolume() * 100)
    else:
        for session in sessions:
            if session.Process and session.Process.name() == process:
                volume = session._ctl.QueryInterface(ISimpleAudioVolume)
                return round(volume.GetMasterVolume() * 100)
    return 100

def main(config, gamepad):
    lastX = getAudio(config.get("1", "process"))
    lastY = getAudio(config.get("2", "process"))
    lastZ = getAudio(config.get("3", "process"))
    lastT = getAudio(config.get("4", "process"))

    print(f'{config.get("1", "name")}: {lastX}%  {config.get("2", "name")}: {lastY}%  {config.get("3", "name")}: {lastZ}%  {config.get("4", "name")}: {lastT}%')
    
    while True:
        try:
            report = gamepad.read(64)
        except:
            break
        if report:
            buttons = assign_buttons(report)
            x = buttons['x']
            if abs(lastX -x) >= 2:
                if x >= 99: x = 100
                elif x <= 1: x= 0
                setAudio(config.get('1', 'process'), round(x/100, 2))
                lastX = x
                print(f"Set {config.get('1', 'name')} to {x}%")

            y = buttons ['y']
            if abs(lastY -y) >= 2:
                if y >= 99: y = 100
                elif y <= 1: y= 0
                setAudio(config.get('2', 'process'), round(y/100, 2))
                lastY = y
                print(f"Set {config.get('2', 'name')} to {y}%")

            z = buttons['z']
            if abs(lastZ -z) >= 2:
                if z >= 99: z = 100
                elif z <= 1: z= 0
                setAudio(config.get('3', 'process'), round(z/100, 2))
                lastZ = z
                print(f"Set {config.get('3', 'name')} to {z}%")

            t = buttons['t']
            if abs(lastT -t) >= 2:
                if t >= 99: t = 100
                elif t <= 1: t= 0
                setAudio(config.get('4', 'process'), round(t/100, 2))
                lastT = t
                print(f"Set {config.get('4', 'name')} to {t}%")
        sleep(0.01)
    reconnect()

def reconnect():
    while True:
        try:
            config, gamepad = startup()
            break
        except: 
            sleep(1)
    main(config, gamepad)
    


config, gamepad = startup()

main(config, gamepad)