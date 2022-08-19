from time import sleep
import hid
from pycaw.pycaw import AudioUtilities, ISimpleAudioVolume
import configparser
import os

class volumeregulator:
    def __init__(self) -> None:
        self.startup()

    def startup(self):
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
            
            self.gamepad = gamepad
            self.config = config
            return
        except:
            print("Failed to open Device")
            exit()
        
    def convert(self,n):
        if n >= 128:
            conv = n - 128
        else:
            conv = n + 128
        return round(conv*100 / 255)

    def assign_buttons(self, report, device="main"):
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
                "x": self.convert(report[7]),
                "y": round(int('{0:08b}'.format(report[8])[2:], 2)*100 / 62 - 2),
                "z": self.convert(report[11]),
            }
        return buttons

    def setAudio(self,process, val):
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

    def getAudio(self,process):
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

    def run(self):
        lastX = self.getAudio(self.config.get("1", "process"))
        lastY = self.getAudio(self.config.get("2", "process"))
        lastZ = self.getAudio(self.config.get("3", "process"))
        lastT = self.getAudio(self.config.get("4", "process"))

        print(f'{self.config.get("1", "name")}: {lastX}%  {self.config.get("2", "name")}: {lastY}%  {self.config.get("3", "name")}: {lastZ}%  {self.config.get("4", "name")}: {lastT}%')
        
        while True:
            try:
                report = self.gamepad.read(64)
            except:
                break
            if report:
                buttons = self.assign_buttons(report)
                x = buttons['x']
                if abs(lastX -x) >= 2:
                    if x >= 99: x = 100
                    elif x <= 1: x= 0
                    self.setAudio(self.config.get('1', 'process'), round(x/100, 2))
                    lastX = x
                    print(f"Set {self.config.get('1', 'name')} to {x}%")

                y = buttons ['y']
                if abs(lastY -y) >= 3: #lower toleranze
                    if y >= 98: y = 100 #lower toleranze
                    elif y <= 1: y= 0
                    self.setAudio(self.config.get('2', 'process'), round(y/100, 2))
                    lastY = y
                    print(f"Set {self.config.get('2', 'name')} to {y}%")

                z = buttons['z']
                if abs(lastZ -z) >= 2:
                    if z >= 99: z = 100
                    elif z <= 1: z= 0
                    self.setAudio(self.config.get('3', 'process'), round(z/100, 2))
                    lastZ = z
                    print(f"Set {self.config.get('3', 'name')} to {z}%")

            sleep(0.01)
        self.reconnect()

    def reconnect(self):
        while True:
            try:
                self.startup()
                break
            except: 
                sleep(1)
        self.run()

if __name__ == "__main__":       
    volumeregulator().run()
