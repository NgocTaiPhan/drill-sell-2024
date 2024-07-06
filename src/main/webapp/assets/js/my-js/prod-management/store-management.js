$(document).ready(function () {
    //==========================Khởi tạo DataTable bằng dữ liệu và load bằng ajax=====================================
    var table = $("#prod-mn").DataTable({
        layout: {
            topStart: null,
            bottomStart: null
        },
        "ajax": {
            "url": "load-all-prods",
            "dataSrc": "",
        },
        "columns": [
            {"data": "productId"},
            {"data": "productName"},
            {"data": "unitPrice"},
            {
                "data": null,
                "render": function (data, type, row) {

                    return ' <form id="update-form-1" onsubmit="updateQuantity(event, 1)">\n' +
                        '                            <input type="number" name="quantity" min="0" placeholder="Nhập số lượng mới" required>\n' +
                        '                            <button type="submit" class="btn btn-primary">Cập nhật</button>\n' +
                        '                        </form>';
                }
            }
        ]
    });
    // ------------------------------------Xóa sản phẩm------------------------------------------
    $("#prod-mn tbody").on('click', '#removeProd', function () {
        var data = table.row($(this).parents('tr')).data();
        var productId = data.productId;
        // Hiển thị hộp thoại confirm
        Swal.fire({
            title: "Cảnh báo",
            text: "Bạn có chắc muốn xóa sản phẩm này không?",
            icon: "warning",
            showCancelButton: true,
            confirmButtonColor: "#3085d6",
            cancelButtonColor: "#d33",
            confirmButtonText: "Xóa!",
            cancelButtonText: "Hủy"
        }).then((result) => {
            if (result.isConfirmed) {
                // Nếu chọn Ok để xóa sản phẩm, sẽ gọi đến servlet remove-prod để xử lý xóa sau đó gửi thông báo
                $.ajax({
                    type: "POST",
                    url: "remove-prod",
                    data: {productId: productId},
                    success: function (response) {
                        Swal.fire({
                            title: "Thành công!",
                            text: response,
                            icon: "success"
                        });
                        // Tải lại bảng dữ liệu
                        table.ajax.reload();
                    },
                    error: function (xhr, status, error) {
                        var errorMessage = xhr.responseText || "An error occurred: " + error;
                        Swal.fire({
                            title: "Lỗi!",
                            text: errorMessage,
                            icon: "error"
                        });
                    }
                });
            }
        })
    });

    //------------------------------------------Ẩn sản phẩm-------------------------------------------
    $("#prod-mn tbody").on('click', '#hideProd', function () {
        var data = table.row($(this).parents('tr')).data();
        var productId = data.productId;
        // Hiển thị thông báo ẩn sản phẩm
        Swal.fire({
            title: "Cảnh báo",
            text: "Bạn có chắc muốn ẩn sản phẩm này không?",
            icon: "warning",
            showCancelButton: true,
            confirmButtonColor: "#3085d6",
            cancelButtonColor: "#d33",
            confirmButtonText: "Ẩn!",
            cancelButtonText: "Hủy"
        }).then((result) => {
            if (result.isConfirmed) {
                // Nếu người dùng chọn "OK", gửi id sản phẩm để xử lý ẩn sản phẩm
                $.ajax({
                    type: "POST",
                    url: "hide-prod",
                    data: {productId: productId},
                    success: function (response) {
                        Swal.fire({
                            title: "Thành công!",
                            text: response,
                            icon: "success",
                            width: 500
                        });
                        // Tải lại bảng dữ liệu
                        table.ajax.reload();
                    },
                    error: function (xhr, status, error) {
                        var errorMessage = xhr.responseText || "An error occurred: " + error;
                        Swal.fire({
                            title: "Lỗi!",
                            text: errorMessage,
                            icon: "error",
                            width: 500
                        });
                    }
                });
            }
        })
    })
    // ----------------------------------------------Xử lý load chi tiết sản phẩm---------------------------------------
    $("#prod-mn tbody").on('click', '#detailProd', function () {
        var data = table.row($(this).parents('tr')).data();
        var productId = data.productId;
        // Hiển thị thông báo ẩn sản phẩm
        // Nếu người dùng chọn "OK", gửi id sản phẩm để xử lý ẩn sản phẩm
        $.ajax({
            type: "POST",
            url: "show-detail",
            data: {productId: productId},
            success: function (product) {
                $('#imageUrlInputU').val(product.image);
                $('#productNameU').val(product.productName);
                $('#nameProducerU').val(product.nameProducer);
                $('#unitPriceU').val(product.unitPrice);
                $('#describleU').val(product.describle);
                $('#specifionsU').val(product.specifions);
                document.querySelector('#modalDetailProd').style.display = "block";
                $('.loadProdsImg').attr('src', product.image);


            },
            error: function (xhr, status, error) {
                var errorMessage = xhr.responseText || "An error occurred: " + error;
                Swal.fire({
                    title: "Lỗi!",
                    text: errorMessage,
                    icon: "error",
                    width: 500
                });
            }
        });

    })
});



