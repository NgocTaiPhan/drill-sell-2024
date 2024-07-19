function checkLogin(logged, pageUrl) {
    if (!logged) {
        Swal.fire({
            title: "Bạn chưa đăng nhập",
            icon: "warning",
            showCancelButton: true,
            confirmButtonText: "Đăng nhập",
            cancelButtonText: `Để sau`
        }).then((result) => {
            //Bấm vào nút Đăng nhập lúc thông báo sẽ chuyển đến trang Đăng nhập
            if (result.isConfirmed) {
                window.location.href = 'login.jsp';
            }
        });
    } else {
        window.location.href = pageUrl;
    }
}
