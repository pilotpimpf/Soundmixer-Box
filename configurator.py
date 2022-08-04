import hid
import configparser

config = configparser.ConfigParser()
try:
    config.read("config.ini")
except:
    with open("config.ini", "w") as f:
        f.write("""
            [device]
            vendor_id = 9025
            product_id = 32822

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

    config.read("config.ini")


def finddevice():
    devices = hid.enumerate()

    for n, device in enumerate(devices):
        print(
            f"{n}) 0x{device['vendor_id']:04x}:0x{device['product_id']:04x} {device['product_string']} {device['serial_number']}")

    device = devices[int(input())]

    try:
        gamepad = hid.device()
        try:
            gamepad.open(device['vendor_id'],
                         device['product_id'], device['serial_number'])
            device_array = [device['vendor_id'],
                            device['product_id'], device['serial_number']]
        except:
            gamepad.open(device['vendor_id'], device['product_id'])
            device_array = [device['vendor_id'], device['product_id']]
            print("No serial number used")
        gamepad.set_nonblocking(True)
    except:
        print("Failed to open Device")

    while True:
        report = gamepad.read(64)
        if report:
            print(report)
            print(device_array)
            break

    if input("Store device? (y): ") == "y":
        config['device']['vendor_id'] = str(device_array[0])
        config['device']['product_id'] = str(device_array[1])
        if len(device_array) == 3:
            config['device']['serial_number'] = str(device_array[2])

        with open("config.ini", "w") as cf:
            config.write(cf)


def listAssignment():
    for sec in config:
        if sec.isdigit():
            if "," in config.get(sec, "process"):
                print(sec, config.get(sec, "name"), config.get(sec, "process"))
            else:
                print(sec, config.get(sec, "name"))


def swapAssignment():
    listAssignment()
    print()
    swap = input("First to swap: "), input("Second to swap: ")
    first = dict(config.items(swap[0]))
    second = dict(config.items(swap[1]))

    config[swap[0]] = second
    config[swap[1]] = first

    config.write(open("config.ini", "w"))

    print()
    listAssignment()
    print("Saved")


def editAissignment():
    listAssignment()
    print()

    item = input("Choose item to edit: ")

    new = {
        'name': input("Name: "),
        'process': input("Process: ")
    }

    config[item] = new
    config.write(open("config.ini", "w"))

    print("\nSaved")


def addGame():
    for sec in config:
        if sec.isdigit():
            if config.get(sec, "name") == "Game":
                games = config.get(sec, "process")
                games += "," + input("Process of game: ")
                config.set(sec, "process", games)
                config.write(open("config.ini", "w"))
                print("\nSaved")
                return
    print("No game item found")


def main():
    print("1) List assignment\n2) Swap assignment\n3) Edit item\n4) Add game\n5) Find device")
    
    inp = int(input("\nChoose number (0 to exit): "))

    if inp == 1: listAssignment()
    elif inp == 2: swapAssignment()
    elif inp == 3: editAissignment()
    elif inp == 4: addGame()
    elif inp == 5: finddevice()
    else: exit()

if __name__ == "__main__":
    main()