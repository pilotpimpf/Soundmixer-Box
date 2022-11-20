import eel

eel.init("web")



@eel.expose
def test_get():
    print("done")
    
@eel.expose
def test_send():
    return "hello"


# eel.start("js/index.js")
eel.start("html/index.html")
print("start")