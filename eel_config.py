import eel
import json 

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

eel.start("html/index.html", size=(600,700))