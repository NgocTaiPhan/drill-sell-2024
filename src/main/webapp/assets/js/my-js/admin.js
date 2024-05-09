let toolbar = document.createElement('div');
toolbar.innerHTML = '<b></b>';
let addProdBtn = document.createElement('div')
// Tạo nút thêm sản phẩm để khi nhấp vào sẽ xuất hiện cửa sổ pop-up
addProdBtn.innerHTML = ' <button type="button" class="btn btn-primary btn-lg" data-toggle="modal" data-target="#add-product">Thêm sản phẩm </button>'
$(document).ready(function () {


    // Viết các hàm tạo datamodel

    // Áp dụng datatable cho bảng Quản lý người dùng và Lịch sử đơn hàng với trên và dưới của bảng là 1 thẻ div rỗng
    new DataTable('#user-mn,#order-history-table', {
        layout: {
            topStart: toolbar,
            bottomStart: toolbar
        }
    });
    // Áp dụng datatable cho bảng Quản lý sản phẩm với top là nút Thêm sản phẩm
    new DataTable('#prod-mn', {
        layout: {
            topStart: addProdBtn,
            bottomStart: toolbar
        }
    });

});
