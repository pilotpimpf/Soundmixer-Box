from time import sleep
import hid
from pycaw.pycaw import AudioUtilities, ISimpleAudioVolume
import json
import os
import pystray
import PIL.Image
from sys import exit
import sys
import _thread
import os


def resource_path(relative_path):
    if getattr(sys, 'frozen', False):
        application_path = os.path.dirname(sys.executable)
    elif __file__:
        application_path = os.path.dirname(__file__)

    return os.path.join(application_path, relative_path)


class volumeregulator:
    def __init__(self) -> None:
        image = PIL.Image.open(resource_path("images/Soundmixer-Box-icon.png"))
        self.icon = pystray.Icon("Soundmixer-Box", image, menu=pystray.Menu(
            pystray.MenuItem("Config", self.openconfig),
            pystray.MenuItem("Close", self.stop)
        ))
        self.icon.run_detached()
        self.startup(first=True)

    def openconfig(self):
        os.startfile(resource_path("configurator.exe"))

    def stop(self):
        self.icon.stop()
        _thread.interrupt_main()

    def startup(self, first=False):

        try:
            config = json.load(
                open(resource_path(f"web/config.json"), "r"))
        except:
            json.dumps("""
{
    "applications": [
        {
            "name": "Spotify",
            "process": [
                "Spotify.exe"
            ]
        },
        {
            "name": "Chrome",
            "process": [
                "chrome.exe"
            ]
        },
        {
            "name": "Discord",
            "process": [
                "Discord.exe"
            ]
        },
        {
            "name": "Fortnite",
            "process": [
                "fortnite.exe"
            ]
        },
        {
            "name": "FlightSimulator",
            "process": [
                "FlightSimulator.exe"
            ]
        }
    ],
    "channels": {
        "1": {
            "app": "Spotify",
            "active": true
        },
        "2": {
            "app": "Chrome",
            "active": true
        },
        "3": {
            "app": "Discord",
            "active": true
        },
        "4": {
            "app": "FlightSimulator",
            "active": false
        }
    },
    "device": {
        "vendor_id": "9025",
        "product_id": "32822",
        "serial_number": "HIDNH"
    }
}
                """, open(resource_path(f"web/config_tmp.json", "w")))

            print("Created default config file")
            config = json.load(
                open(resource_path(f"web/config.json"), "r"))

        try:
            gamepad = hid.device()
            try:
                gamepad.open(int(config["device"]["vendor_id"]), int(config["device"]["product_id"]), config["device"]["serial_number"])
            except:
                print("try without serial number")
                gamepad.open(int(config["device"]["vendor_id"]),
                             int(config["device"]["product_id"]))
                print("No serial number used")
            gamepad.set_nonblocking(True)

            self.gamepad = gamepad
            self.config = config
            return
        except:
            print("Failed to open Device -exiting")
            if not first:
                exit()
            else:
                self.reconnect()

    def convert(self, n):
        if n >= 128:
            conv = n - 128
        else:
            conv = n + 128
        return round(conv*100 / 255)

    def assign_buttons(self, report, device="main"):
        if device == "main":
            buttons = {
                "x": self.convert(report[7]),
                "y": round(int('{0:08b}'.format(report[8])[2:], 2)*100 / 62 - 2),
                "z": self.convert(report[11]),
                "t": self.convert(report[21])
            }
        return buttons

    def setAudio(self, process, val):
        sessions = AudioUtilities.GetAllSessions()
        for session in sessions:
            if session.Process and session.Process.name() in process:
                volume = session._ctl.QueryInterface(ISimpleAudioVolume)
                volume.SetMasterVolume(val, None)

    def getAudio(self, process):
        sessions = AudioUtilities.GetAllSessions()
        for session in sessions:
            if session.Process and session.Process.name() in process:
                volume = session._ctl.QueryInterface(ISimpleAudioVolume)
                return round(volume.GetMasterVolume() * 100)
        return 100

    def run(self):
        lastX = self.getAudio(self.config["channels"]["1"]["process"])
        lastY = self.getAudio(self.config["channels"]["2"]["process"])
        lastZ = self.getAudio(self.config["channels"]["3"]["process"])
        lastT = self.getAudio(self.config["channels"]["4"]["process"])

        print(f'{self.config["channels"]["1"]["name"]}: {lastX}%  {self.config["channels"]["2"]["name"]}: {lastY}%  {self.config["channels"]["3"]["name"]}: {lastZ}%  {self.config["channels"]["4"]["name"]}: {lastT}%')

        while True:
            try:
                report = self.gamepad.read(64)
            except:
                break
            if report:
                buttons = self.assign_buttons(report)
                x = buttons['x']
                if abs(lastX - x) >= 2 and self.config['channels']['1']['active']:
                    if x >= 99:
                        x = 100
                    elif x <= 1:
                        x = 0
                    self.setAudio(self.config['channels']['1']['process'], round(x/100, 2))
                    lastX = x
                    print(f"Set {self.config['channels']['1']['name']} to {x}%")

                y = buttons['y']
                if abs(lastY - y) >= 3 and self.config['channels']['2']['active']:  # lower toleranze
                    if y >= 98:
                        y = 100  # lower toleranze
                    elif y <= 1:
                        y = 0
                    self.setAudio(self.config['channels']['2']['process'], round(y/100, 2))
                    lastY = y
                    print(f"Set {self.config['channels']['2']['name']} to {y}%")

                z = buttons['z']
                if abs(lastZ - z) >= 2 and self.config['channels']['3']['active']:
                    if z >= 99:
                        z = 100
                    elif z <= 1:
                        z = 0
                    self.setAudio(self.config['channels']['3']['process'], round(z/100, 2))
                    lastZ = z
                    print(f"Set {self.config['channels']['3']['name']} to {z}%")

                t = buttons['t']
                if abs(lastT - t) >= 2 and self.config['channels']['4']['active']:
                    if t >= 99:
                        t = 100
                    elif t <= 1:
                        t = 0
                    self.setAudio(self.config['channels']['4']['process'], round(t/100, 2))
                    lastT = t
                    print(f"Set {self.config['channels']['4']['name']} to {t}%")
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
