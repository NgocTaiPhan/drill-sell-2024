$(document).ready(function () {
    // Biến lưu trữ thông tin về tỉnh, quận/huyện và phường/xã
    var provinces = {};
    var districts = {};
    var wards = {};

    // Lấy danh sách tỉnh thành từ API và điền vào dropdown tỉnh
    $.getJSON('https://esgoo.net/api-tinhthanh/1/0.htm', function (data_tinh) {
        if (data_tinh.error == 0) {
            $.each(data_tinh.data, function (key_tinh, val_tinh) {
                provinces[val_tinh.full_name] = val_tinh.id; // Lưu tên của tỉnh
                $("#tinh").append('<option value="' + val_tinh.full_name + '">' + val_tinh.full_name + '</option>');
            });
        }
    });

    // Xử lý sự kiện khi người dùng chọn tỉnh
    $("#tinh").change(function () {
        var ten_tinh = $(this).val(); // Lấy tên của tỉnh từ dropdown

        // Xóa các lựa chọn cũ của quận/huyện và phường/xã
        $("#quan").html('<option value="0">Chọn Quận Huyện</option>');
        $("#phuong").html('<option value="0">Chọn Phường Xã</option>');

        // Lấy danh sách quận/huyện từ API và điền vào dropdown quận/huyện
        $.getJSON('https://esgoo.net/api-tinhthanh/2/' + provinces[ten_tinh] + '.htm', function (data_quan) {
            if (data_quan.error == 0) {
                $.each(data_quan.data, function (key_quan, val_quan) {
                    districts[val_quan.full_name] = val_quan.id; // Lưu tên của quận/huyện
                    $("#quan").append('<option value="' + val_quan.full_name + '">' + val_quan.full_name + '</option>');
                });
            }
        });
    });

    // Xử lý sự kiện khi người dùng chọn quận/huyện
    $("#quan").change(function () {
        var ten_quan = $(this).val(); // Lấy tên của quận/huyện từ dropdown

        // Xóa các lựa chọn cũ của phường/xã
        $("#phuong").html('<option value="0">Chọn Phường Xã</option>');

        // Lấy danh sách phường/xã từ API và điền vào dropdown phường/xã
        $.getJSON('https://esgoo.net/api-tinhthanh/3/' + districts[ten_quan] + '.htm', function (data_phuong) {
            if (data_phuong.error == 0) {
                $.each(data_phuong.data, function (key_phuong, val_phuong) {
                    wards[val_phuong.full_name] = val_phuong.id; // Lưu tên của phường/xã
                    $("#phuong").append('<option value="' + val_phuong.full_name + '">' + val_phuong.full_name + '</option>');
                });
            }
        });
    });
});
