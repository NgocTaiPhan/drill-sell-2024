function submitFormAngGetNotify(formId, urlServlet) {
    $(formId).submit(function (event) {
        event.preventDefault(); // Ngăn chặn hành vi gửi biểu mẫu mặc định
        console.log(formId.data)
        $.ajax({
            type: 'POST',
            url: urlServlet,
            data: $(this).serialize(),
            success: function (response) {
                // Hiển thị thông báo thành công
                Swal.fire({
                    title: "Thành công!",
                    text: response,
                    icon: "success"
                });

                $(formId)[0].reset();
            },
            error: function (xhr, status, error) {
                var errorMessage = xhr.responseText || "Đã xảy ra lỗi: " + error;
                Swal.fire({
                    title: "Lỗi!",
                    text: errorMessage,
                    icon: "error"
                });
            }
        });
    });
}

function submitFormAndRedirect(formId, urlServlet, url) {
    $(formId).submit(function (event) {
        event.preventDefault(); // Ngăn chặn hành vi gửi biểu mẫu mặc định
        console.log(formId.data)
        $.ajax({
            type: 'POST',
            url: urlServlet,
            data: $(this).serialize(),
            success: function (response) {
                var data = JSON.parse(response);
                swalWithBootstrapButtons.fire({
                    title: "Thành công",
                    text: data.message,
                    icon: "success",
                    showCancelButton: true,
                    confirmButtonText: "Trở về trang chủ",
                    cancelButtonText: "Chuyển đến trang đăng nhập",
                    reverseButtons: true
                }).then((result) => {
                    if (result.isConfirmed) {
                        window.location.href = url;
                    } else if (
                        /* Read more about handling dismissals below */
                        result.dismiss === Swal.DismissReason.cancel
                    ) {
                        window.location.href = data.url;
                    }
                });
            },
            error: function (xhr, status, error) {
                var errorMessage = xhr.responseText || "Đã xảy ra lỗi: " + error;
                Swal.fire({
                    title: "Lỗi!",
                    text: errorMessage,
                    icon: "error"
                });
            }
        });
    });

}

const swalWithBootstrapButtons = Swal.mixin({
    customClass: {
        confirmButton: "btn btn-success",
        cancelButton: "btn btn-danger"
    },
    buttonsStyling: false
});


