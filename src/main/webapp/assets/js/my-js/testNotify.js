export function notifyNormal(mess, title, type) {
    Swal.fire({
        icon: type,
        title: title,
        text: mess,
        confirmButtonText: "Đóng",
    });
}

export function notifyWithoutButton(mess, title, type) {
    Swal.fire({
        icon: type,
        title: title,
        showConfirmButton: false,
        timer: 1500
    });
}