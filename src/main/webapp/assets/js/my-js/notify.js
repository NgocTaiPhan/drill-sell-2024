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

function submitFormAndRedirect(formId, urlServlet) {
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
                    confirmButtonText: data.namePage,
                    cancelButtonText: "Hủy",
                    reverseButtons: true
                }).then((result) => {
                    if (result.isConfirmed) {
                        window.location.href = data.urlPage;
                    } else if (
                        result.dismiss === Swal.DismissReason.cancel
                    ) {
                        // window.location.href ='home.jsp';
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

function callServletAndRedirect(servletUrl, pageUrl) {
    $.ajax({
        type: 'GET',
        url: servletUrl,
        success: function () {
            // Khi thành công, chuyển hướng đến trang chỉ định
            window.location.href = pageUrl;
        },
        error: function (xhr, status, error) {
            // Khi gặp lỗi, hiển thị thông báo lỗi
            var errorMessage = xhr.responseText || "Đã xảy ra lỗi: " + error;
            var data;
            try {
                data = JSON.parse(xhr.responseText);
            } catch (e) {
                data = {
                    message: errorMessage,
                    namePage: "OK",
                    pageUrl: "home.jsp"
                };
            }

            swalWithBootstrapButtons.fire({
                title: data.message,
                showCancelButton: true,
                cancelButtonText: "Hủy",
                confirmButtonText: data.namePage,
                reverseButtons: true
            }).then((result) => {
                if (result.isConfirmed) {
                    window.location.href = data.pageUrl;
                } else
                    // if (result.dismiss === Swal.DismissReason.cancel)
                {
                    // window.location.href = 'home.jsp';
                }
            });
        }
    });
}

function callServlet(servletUrl, productId) {
    $.ajax({
        type: 'POST',
        url: servletUrl,
        data: {productId: productId},
        success: function (response) {
            // Hiển thị thông báo thành công
            Toast.fire({
                icon: "success",
                title: response,
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
}

function checkToast() {


}
const swalWithBootstrapButtons = Swal.mixin({
    customClass: {
        confirmButton: "btn btn-primary ",
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


