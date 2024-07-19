const swalWithBootstrapButtons = Swal.mixin({
    customClass: {
        confirmButton: "btn btn-primary",
        cancelButton: "btn btn-danger"
    },
    buttonsStyling: false
});

const Toast = Swal.mixin({
    toast: true,
    position: "top-end",
    showConfirmButton: false,
    timer: 2000,
    timerProgressBar: true,
    didOpen: (toast) => {
        toast.onmouseenter = Swal.stopTimer;
        toast.onmouseleave = Swal.resumeTimer;
    }
});
function normalNotify(type, message) {
    Swal.fire({
        text: message,
        icon: type
    })
}

function errorNotify(message) {
    Swal.fire({
        title: "Lỗi!",
        text: message,
        icon: "error"
    });
}

function checkButton(namePage, pageUrl) {
    const buttonValue = {};
    if (pageUrl === null || pageUrl === "" || pageUrl === 'home.jsp') {
        Object.assign(buttonValue, {
            showConfirm: false,
            text: "OK"
        });
    } else {
        Object.assign(buttonValue, {
            showConfirm: true,
            text: namePage
        });
    }
    return buttonValue;
}


function notifyAndRedirect(type, message, namePage, pageUrl) {
    const buttonValue = checkButton(namePage, pageUrl);
    swalWithBootstrapButtons.fire({
        text: message,
        icon: type,
        showCancelButton: buttonValue.showConfirm,
        confirmButtonText: buttonValue.text,
        cancelButtonText: 'Hủy',
        reverseButtons: true
    }).then((result) => {
        if (pageUrl === null || pageUrl === '') {

        } else if (result.isConfirmed) {
            window.location.href = pageUrl;
        }
    });
}
