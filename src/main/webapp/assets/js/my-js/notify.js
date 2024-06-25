var valueNotify = document.getElementById("notify").getAttribute('value');


function errorRegister(mess) {
    Swal.fire({
        icon: "error",
        title: "Đăng kí thất bại",
        text: mess,
        confirmButtonText: "Đóng",
    });
    // alert(mess)
    // <%session.removeAttribute("notify");%>

}

function errorLogin(mess) {
    Swal.fire({
        icon: "error",
        title: "Đăng nhập thất bại",
        text: mess,
        confirmButtonText: "Đóng",
    });
    // <%session.removeAttribute("notify");%>
}
function errorLock(mess) {
    Swal.fire({
        icon: "error",
        title: "Đăng nhập thất bại",
        text: mess,
        confirmButtonText: "Đóng",
    });
    // <%session.removeAttribute("notify");%>
}



switch (valueNotify) {

    // ---------------------------------Thông báo của phần đăng kí--------------------------------------
    case "null-fullname":
        errorRegister("Hãy điền họ và tên");
        break;

    case "null-birthday":
        errorRegister("Hãy nhập ngày sinh");
        break;


    case "null-address":
        errorRegister("Hãy chọn địa chỉ");
        break;
    case "null-quan":
        errorRegister("Hãy chọn địa chỉ");
        break;
    case "null-phuong":
        errorRegister("Hãy chọn địa chỉ");
        break;

    case "null-phone":
        errorRegister("Hãy nhập số điện thoại");
        break;

    case "null-email":
        errorRegister("Hãy nhập địa chỉ email");
        break;

    case "null-username":
        errorRegister("Hãy nhập tên đăng nhập");
        break;

    case "null-pass":
        errorRegister("Hãy nhập mật khẩu");
        break;

    case "null-cfpass":
        errorRegister("Hãy nhập để xác nhận lại mật khẩu");
        break;

    case "null-agree":
        errorRegister("Hãy đồng ý với điều khoản của chúng tôi.");
        break;

    case "not-enough-18":
        errorRegister("Người dùng chưa đủ 18 tuổi.");
        break;

    case "invalid-phone":
        errorRegister("Số điện thoại không hợp lệ");
        break;

    case "invalid-email":
        errorRegister("Email không hợp lệ");
        break;
    case "email-exists":
        errorRegister("Địa chỉ email đã tồn tại");
        break;
    case "invalid-username":
        errorRegister("Tên đăng nhập không hợp lệ");
        break;
    case "invalid-pass":
        errorRegister("Mật khẩu phải từ 8 kí tự, bao gồm chữ hoa, chữ thường và số")
        break;

    case "pass-not-match":
        errorRegister("Mật khẩu không khớp");
        break;
    case "duplicate-acc":
        errorRegister("Tên đăng nhập đã tồn tại");
        break;
    case"register-success":
        Swal.fire({
            icon: "success",
            title: "Đăng kí thành công",
            text: "Hãy xác nhận email và đăng nhập!",
            confirmButtonText: "Đóng",
        }).then((result) => {
            // <%session.removeAttribute("notify");%>
            window.location.href = "login.jsp";
        });
    // ---------------------------------Thông báo của phần đăng kí--------------------------------------
    // ---------------------------------Thông báo của phần ĐĂNG NHẬP--------------------------------------
    case"admin-logged":
        Swal.fire({
            icon: "success",
            title: "Đăng nhập với quyền quản trị",
            text: "Chào mừng",
            confirmButtonText: "Đóng",
        }).then((result) => {
            // <%session.removeAttribute("notify");%>
            window.location.href = "home.jsp";
        });

    case"user-logged":
        Swal.fire({
            icon: "success",
            title: "Đăng nhập thành công",
            text: "Chào mừng",
            confirmButtonText: "Đóng",
        }).then((result) => {
            // <%session.removeAttribute("notify");%>
            window.location.href = "home.jsp";
        });
    case "null-user-login":
        errorLogin("Hãy nhập tên đăng nhập và mật khẩu!")
        break;
    case "not-found-user":
        errorLogin("Không tìm thấy tài khoản!")
        break;
// ---------------------------------Thông báo của phần ĐĂNG NHẬP--------------------------------------
    case "add-prod-success":
        Swal.fire({
            icon: "success",
            title: "Thành công",
            text: "Thêm sản phẩm thành công",
            confirmButtonText: "OK",
        }).then((result) => {
            // <%session.removeAttribute("notify");%>
            window.location.href = "products-management.jsp";
        });
    case"hide-success":
        Swal.fire({
            icon: "success",
            title: "Ẩn thành công",
            text: "Sản phẩm đã được ẩn",
            confirmButtonText: "Đóng"
        });
    case"remove-success":
        Swal.fire({
            icon: "success",
            title: "Xóa thành công",
            text: "Sản phẩm đã được xóa",
            confirmButtonText: "Đóng"
        });
    case"add-cart-success":
        Swal.fire({
            icon: "success",
            title: "Thành công",
            text: "Sản phẩm đã được thêm vào giỏ hàng",
            confirmButtonText: "Đóng"
        });


    default:


    // break;


}

function checkLoginAndRedirect(logged, url) {

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
        window.location.href = url;
    }
}

function checkLogin(logged) {

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
    }
}


