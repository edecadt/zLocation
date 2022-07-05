let showed = false;

window.addEventListener('message', (event) => {
    if (event.data.type === 'open' && !showed) {
        showed = true;
        document.querySelector(".main").style.display ="block";
    }

    if (event.data.type === 'close' && showed) {
        showed = false;
        document.querySelector(".main").style.display ="none";
    }
});

document.addEventListener('keyup', function (e) {
    if (e.keyCode == 27 && showed) {
        document.querySelector(".main").style.display ="none";
        fetch(`https://${GetParentResourceName()}/close`, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json; charset=UTF-8',
            },
            body: JSON.stringify({
            })
        }).then(resp => resp.json()).then(resp => console.log(resp));
        showed = false;
    }
})

document.addEventListener('click', function (event) {

	if (!event.target.matches('img')) return;

    if (event.target.matches('.bmx-img')) {
        fetch(`https://${GetParentResourceName()}/rentVeh`, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json; charset=UTF-8',
            },
            body: JSON.stringify({
                vehModel: 'bmx'
            })
        });
        return;
    }

    if (event.target.matches('.faggio-img')) {
        fetch(`https://${GetParentResourceName()}/rentVeh`, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json; charset=UTF-8',
            },
            body: JSON.stringify({
                vehModel: 'faggio'
            })
        });
        return;
    }

    if (event.target.matches('.blista-img')) {
        fetch(`https://${GetParentResourceName()}/rentVeh`, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json; charset=UTF-8',
            },
            body: JSON.stringify({
                vehModel: 'blista'
            })
        });
        return;
    }

	event.preventDefault();

}, false);