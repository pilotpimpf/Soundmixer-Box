async function start_stop(btn) {
    console.log("did");
    // eel.test_get();
    let msg = await eel.test_send()();
    btn.innerHTML = msg;
    console.log(msg);
}

function test(ele) {
    ele.innerHTML = "test"
    console.log(ele);
}

async function startup() {

    let conf = await (await (fetch("../config.json"))).json()

    let s = "";
    for (const i of conf.applications) {
        s += `<option value='${i.name}'> ${i.name} </option>\n`
    }

    document.getElementById("app_listbox").innerHTML = s

    let channels = Array.from(document.getElementsByClassName("channel_select"))
    channels.forEach((c) => {
        c.innerHTML = s;
    });

    let i = 0;
    for (const key in conf.channels) {
        channels[i].value = conf.channels[key]
        i +=1;
    }
}
startup();


async function deleteapp() {
    // apps = document.getElementById("app_listbox")
    // console.log(apps);

    var selected = [];
    for (var option of document.getElementById('app_listbox').options) {
      if (option.selected) {
        selected.push(option.value);
      }
    }

    console.log(selected);
}