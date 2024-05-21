
let toolbar = document.createElement('div');
toolbar.innerHTML = '<b></b>';
// Tạo nút thêm sản phẩm để khi nhấp vào sẽ xuất hiện cửa sổ pop-up
$(document).ready(function () {


    // Viết các hàm tạo datamodel


    // Áp dụng datatable cho bảng Quản lý sản phẩm với top là nút Thêm sản phẩm
    new DataTable('#prod-mn', {
        layout: {
            topStart: toolbar,
            bottomStart: toolbar
        }
    });

});

// Lấy các phần tử
const modal = document.getElementById("myModal");
const btn = document.getElementById("openModalBtn");
const span = document.getElementsByClassName("close-btn")[0];

// Khi nút được click, mở modal
btn.onclick = function () {
    modal.style.display = "block";
}

// Khi nút đóng (x) được click, đóng modal
span.onclick = function () {
    modal.style.display = "none";
}

// Khi click bên ngoài modal, đóng modal
window.onclick = function (event) {
    if (event.target === modal) {
        modal.style.display = "none";
    }
}
