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
    timer: 3000,
    timerProgressBar: true,
    didOpen: (toast) => {
        toast.onmouseenter = Swal.stopTimer;
        toast.onmouseleave = Swal.resumeTimer;
    }
});

function successNotify(message) {
    Swal.fire({
        title: "Thành công!",
        text: message,
        icon: "success"
    });
}

function errorNotify(message) {
    Swal.fire({
        title: "Lỗi!",
        text: message,
        icon: "error"
    });
}

function successNotifyAndRedirect(message, namePage, pageUrl) {
    swalWithBootstrapButtons.fire({
        title: "Thành công",
        text: message,
        icon: "success",
        showCancelButton: true,
        confirmButtonText: namePage,
        cancelButtonText: "Hủy",
        reverseButtons: true
    }).then((result) => {
        if (result.isConfirmed) {
            window.location.href = pageUrl;
        } else if (result.dismiss === Swal.DismissReason.cancel) {
            // Xử lý khi người dùng huỷ bỏ
            // window.location.href = 'home.jsp';
        }
    });
}

function notifyRedirect(message, namePage, pageUrl) {
    swalWithBootstrapButtons.fire({
        title: message,
        showCancelButton: true,
        cancelButtonText: "Hủy",
        confirmButtonText: namePage,
        reverseButtons: true
    }).then((result) => {
        if (result.isConfirmed) {
            window.location.href = pageUrl;
        } else {
            // Xử lý khi người dùng huỷ bỏ
            // window.location.href = 'home.jsp';
        }
    });
}
