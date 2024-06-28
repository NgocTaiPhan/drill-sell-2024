$(document).ready(function (event) {
    $('#formAddProd').submit(function (event) {
        event.preventDefault();
        $.ajax({
            type: 'POST',
            url: "add-prod",
            data: $(this).serialize(),
            success: function (response) {
                Swal.fire({
                    title: "Thành công!",
                    text: response,
                    icon: "success"
                });
            },
            error: function (xhr, status, error) {
                var errorMessage = xhr.responseText || "An error occurred: " + error;
                Swal.fire({
                    title: "Lỗi!",
                    text: errorMessage,
                    icon: "error"
                });
            }


        })
    })
});








