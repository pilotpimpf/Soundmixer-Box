async function start_stop(btn) {
    console.log("did");
    // eel.test_get();
    let msg = await eel.test_send()();
    btn.innerHTML = msg;
    console.log(msg);
}
async function update() {
    let conf = await (await (fetch("../config_tmp.json"))).json()

    let s = "";
    for (const i of conf.applications) {
        s += `<option value='${i.name}'> ${i.name} </option>\n`
    }

    document.getElementById("app_listbox").innerHTML = s

    let channels = Array.from(document.getElementsByClassName("channel_select"))
    channels.forEach((c) => {
        c.innerHTML = s;
    });

    let channels_active =  Array.from(document.getElementsByClassName("canncel-activ-btn"))
    
    let i = 0;
    for (const key in conf.channels) {
        channels[i].value = conf.channels[key].name
        if (conf.channels[key].active){
            channels_active[i].innerHTML = "ACTIVE"
        }
        else{
            channels_active[i].innerHTML = "OFF"
        }

        i += 1;
    }

    document.getElementById("device_name").innerHTML = `${conf.device.vendor_id}:${conf.device.product_id} ${conf.device.serial_number}`
}

async function startup() {
    await eel.restore_config()();
    update();
}
startup();


async function deleteapp() {
    var selected = [];
    for (var option of document.getElementById('app_listbox').options) {
        if (option.selected) {
            selected.push(option.value);
        }
    }

    console.log(selected);
    if (await eel.deleteapp(selected)) {
        update();
    }
}

async function cancel() {
    await eel.restore_config();
    update()
}

async function addgroup(inp) {
    let conf = await (await (fetch("../config_tmp.json"))).json()
    groupapp_names = []
    for (var option of document.getElementById('app_listbox').options) {
        if (option.selected) {
            groupapp_names.push(option.value);
        }
    }

    groupapps = []
    for ( let i of conf.applications) {
        if (groupapp_names.includes(i.name)){
            groupapps.push(i.process[0])
        }
    }
    
    console.log(groupapps);
    var modal = document.getElementById("myModal");
    var p = document.getElementById("modalpapp");
    let nameinp = document.getElementById("nameinp");
    var span = document.getElementsByClassName("close")[0];
    var btn = document.getElementById("savename");

    s = "Name for "
    for (const app of groupapps) {
        s += app + " "
    }
    p.innerHTML = s;
    nameinp.value = "My Group"

    async function sendnewgroup(){
        console.log(nameinp.value);
        await eel.addapp([nameinp.value, groupapps])()
        update();
        canceladdapp();
    }
    btn.onclick=sendnewgroup;
    modal.style.display = "block";

    function canceladdapp(){
        modal.style.display = "none";
        inp.type = "text";
        inp.type = "file";
    }
    span.onclick = canceladdapp;
    window.onclick = function (event) {
        if (event.target == modal) {
           canceladdapp();
        }
    }
}

async function addapp(inp) {
    appfile = inp.files[0].name;

    var modal = document.getElementById("myModal");
    var p = document.getElementById("modalpapp");
    let nameinp = document.getElementById("nameinp");
    var span = document.getElementsByClassName("close")[0];
    var btn = document.getElementById("savename");

    p.innerHTML = "Name for " + appfile;
    nameinp.value = appfile.substr(0, appfile.indexOf('.'));

    async function sendnewapp(){
        console.log(nameinp.value);
        await eel.addapp([nameinp.value, [appfile]])()
        update();
        canceladdapp();
    }
    btn.onclick=sendnewapp;
    modal.style.display = "block";

    function canceladdapp(){
        modal.style.display = "none";
        inp.type = "text";
        inp.type = "file";
    }
    span.onclick = canceladdapp;
    window.onclick = function (event) {
        if (event.target == modal) {
           canceladdapp();
        }
    }
}

async function renameapp() {
    let conf = await (await (fetch("../config_tmp.json"))).json()
    let name = document.getElementById('app_listbox').value
    for ( let i of conf.applications) {
        if (i.name == name){
            var process = i.process;
        }
    }

    console.log(process);
    var modal = document.getElementById("myModal");
    var p = document.getElementById("modalpapp");
    let nameinp = document.getElementById("nameinp");
    var span = document.getElementsByClassName("close")[0];
    var btn = document.getElementById("savename");

    s = "New name for "
    for (const app of process) {
        s += app + " "
    }

    p.innerHTML = s;
    nameinp.value = name;

    async function sendrename(){
        console.log(nameinp.value);
        await eel.renameapp([nameinp.value, process])()
        update();
        cancelrename();
    }
    btn.onclick=sendrename;
    modal.style.display = "block";

    function cancelrename(){
        modal.style.display = "none";
        inp.type = "text";
        inp.type = "file";
    }
    span.onclick = cancelrename;
    window.onclick = function (event) {
        if (event.target == modal) {
           cancelrename();
        }
    }
}

async function toggleactive(btn){
    if (btn.innerHTML == "ACTIVE") {
        var mode = false;
        var txt = "OFF";
    }
    else{
        var mode = true;
        var txt = "ACTIVE"
    }
    console.log(btn.getAttribute("channel"));
    await eel.toggleactive(btn.getAttribute("channel"), mode)()
    btn.innerHTML = txt;
}

async function changeassignment(sel){
    let channel = sel.id.replace("channel","")
    await eel.changeassignment(channel, sel.value)();
}

async function detectDevice(){
    let conf = await (await (fetch("../config_tmp.json"))).json()

    let devices = await eel.getdevice_list()()

    console.log(devices);

    var modal = document.getElementById("myModal");
    var p = document.getElementById("modalpapp");
    let nameinp = document.getElementById("nameinp");
    let device_box = document.getElementById("device_listbox");
    var span = document.getElementsByClassName("close")[0];
    var btn = document.getElementById("savename");

    nameinp.style.display = "none"

    let s = "";
    let i = 0;
    for (const dev of devices) {
        s += `<option value='${i}'> ${dev} </option>\n`
        i += 1
    }


    device_box.innerHTML = s;
    device_box.style.display = "block"
    p.innerHTML = "Select device (Arduino)";

    async function sendDevice(){
        console.log(device_box.value);
        await eel.setDevice(device_box.value)()
        update();
        cancelDetect();
    }
    btn.onclick=sendDevice;
    modal.style.display = "block";

    function cancelDetect(){
        modal.style.display = "none";
        device_box.style.display = "none";
        nameinp.style.display = "inline-block"
        inp.type = "text";
        inp.type = "file";
    }
    span.onclick = cancelDetect;
    window.onclick = function (event) {
        if (event.target == modal) {
           cancelDetect();
        }
    }
}

async function saveAll(){
    await eel.saveAll()();
    update();
}