// main.js

$(document).ready(function () {
    // Khởi tạo DataTable
    var table = $("#repo-mn").DataTable({
        layout: {
            topStart: null,
            bottomStart: null
        },
        ajax: {
            url: "show-repo",
            dataSrc: ""
        },
        columns: [
            {data: "productId"},
            {data: "productName"},
            {data: "importDate"},
            {data: "importPrice"},
            {data: "importQuantity"},
            {
                data: null,
                render: function (data, type, row) {
                    var quantityInputId = 'quantity-' + row.productId;
                    return '<input type="number" id="' + quantityInputId + '" class="form-custom" name="quantity" placeholder="Số lượng cộng mới">'
                        + '<button class="btn btn-primary update-btn" '
                        + 'data-product-id="' + row.productId + '">Cập nhật</button>';
                }
            }
        ]
    });

    // Xử lý sự kiện click của nút "Cập nhật"
    $('#repo-mn').on('click', '.update-btn', function () {
        var productId = $(this).data('product-id');
        var quantity = $('#quantity-' + productId).val();

        // Gọi hàm callServlet từ file callServlet.js
        callServlet('update-quantity', [
            {name: 'productId', dataValue: productId},
            {name: 'quantity', dataValue: quantity}
        ], function onSuccess(response) {
            Toast.fire({
                icon: response.type,
                title: response.message,
            });

            // Reload DataTable sau khi thành công
            table.ajax.reload();
        }, function onError(xhr, status, error) {
            errorNotify("Xảy ra lỗi trong quá trình xử lý!");
            console.log(xhr);
        });
    });
});
