import eel
import json 
import hid

eel.init("web")



@eel.expose
def test_get():
    print("done")
    
@eel.expose
def test_send():
    return "hello"


@eel.expose
def deleteapp(apps):
    conf = json.load(open("web/config_tmp.json", "r"))
    conf["applications"] = [x for x in conf["applications"] if not x["name"] in apps]

    for c in conf["channels"].values():
        if c["app"] in apps:
            c["app"] = None
            c["active"] = False
    json.dump(conf, open("web/config_tmp.json", "w"))

    return True


@eel.expose
def restore_config():
    conf = json.load(open("web/config.json", "r"))
    json.dump(conf, open("web/config_tmp.json", "w"))
    return True

@eel.expose
def addapp(app):
    conf = json.load(open("web/config_tmp.json", "r"))

    conf["applications"].append({
        "name":app[0],
        "process":app[1]
    })

    json.dump(conf, open("web/config_tmp.json", "w"))

@eel.expose
def renameapp(app):
    conf = json.load(open("web/config_tmp.json", "r"))

    for a in conf["applications"]:
        if a["process"] == app[1]: 
            oldname = a["name"]
            a["name"] = app[0]
            break

    for c in conf["channels"].values():
        if c["app"] == oldname:
            c["app"] = app[0]

    json.dump(conf, open("web/config_tmp.json", "w"))

@eel.expose
def toggleactive(channel, mode):
    conf = json.load(open("web/config_tmp.json", "r"))

    conf["channels"][channel]["active"] = mode

    json.dump(conf, open("web/config_tmp.json", "w"))

@eel.expose
def saveAll():
    conf = json.load(open("web/config_tmp.json", "r"))
    json.dump(conf, open("web/config.json", "w"))
    return True

@eel.expose
def changeassignment(channel, name):
    conf = json.load(open("web/config_tmp.json", "r"))

    conf["channels"][channel]["name"] = name

    for i in conf["applications"]:
        if i["name"] == name:
            process = i["process"]
            break
    conf["channels"][channel]["process"] = process


    json.dump(conf, open("web/config_tmp.json", "w"))

@eel.expose
def getdevice_list():
    devices = hid.enumerate()

    dev_list = []
    for device in devices:
            dev_list.append(f"{device['product_string']} {device['serial_number']} 0x{device['vendor_id']:04x}:0x{device['product_id']:04x}")
    return dev_list

@eel.expose
def setDevice(d):
    conf = json.load(open("web/config_tmp.json", "r"))
    devices = hid.enumerate()
    device = devices[int(d)]

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

    conf['device']['vendor_id'] = str(device_array[0])
    conf['device']['product_id'] = str(device_array[1])
    if len(device_array) == 3:
        conf['device']['serial_number'] = str(device_array[2])
    
    json.dump(conf, open("web/config_tmp.json", "w"))

eel.start("html/index.html", size=(600,600))