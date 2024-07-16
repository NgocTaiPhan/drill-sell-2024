CREATE
DATABASE drill_Sell;
 USE
Drill_Sell;

CREATE TABLE product_categorys
(
    id           INT PRIMARY KEY,
    nameCategory VARCHAR(200)
)


ALTER TABLE products
    ADD FULLTEXT(productName);


CREATE TABLE products
(
    productId     INT PRIMARY KEY AUTO_INCREMENT,
    image         VARCHAR(300),
    productName   VARCHAR(200),
    unitPrice DOUBLE,
    categoryId    INT,
    nameProducer  VARCHAR(200),
    describle     VARCHAR(3000),
    specifions    VARCHAR(1000),
    productStatus TINYINT(1) DEFAULT 0,
-- Trạng thái của sản phẩm : 0 -Bình thường, 1 - Đã xóa, 2 - Ẩn
    FOREIGN KEY (categoryId) REFERENCES product_categorys (id)

)

ALTER TABLE users
    ADD COLUMN locked_until DATETIME;
users

CREATE TABLE users
(
    id               INT AUTO_INCREMENT PRIMARY KEY,
    fullname         VARCHAR(100) NOT NULL,
    address          VARCHAR(200),
    phone            VARCHAR(10),
    email            VARCHAR(100) NOT NULL UNIQUE,
    username         VARCHAR(100) NOT NULL UNIQUE,
    passwords        VARCHAR(100) NOT NULL,
    sex              TINYINT(1) DEFAULT 0,
    yearOfBirth      DATE,
    verificationCode VARCHAR(6),
    roleUser         TINYINT(1) DEFAULT 0, -- Quyền người dùng : 0 - user, 1 - admin
    userStatus       TINYINT(1) DEFAULT 0  -- Trạng thái của tài khoản: 0 - Đã xác thực(Bình thường), 1 - Đã xóa, 2 - Ẩn, 3 - Khóa, 4 - Chưa xác thực

);
ALTER TABLE users DROP COLUMN verificationCode;

CREATE TABLE repo
(
    repoId         INT PRIMARY KEY,
    userId         INT,
    productId      INT,
    categoryId     INT,
    importDate     TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    importPrice DOUBLE,
    price DOUBLE,
    importQuantity INT,
    FOREIGN KEY (userId) REFERENCES users (id),
    FOREIGN KEY (productId) REFERENCES products (productId),
    FOREIGN KEY (categoryId) REFERENCES product_categorys (id)
)


CREATE TABLE cart
(
    cartId    INT AUTO_INCREMENT PRIMARY KEY,
    userId    INT,
    productId INT,
    quantity  INT,
    createArt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updateArt TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (productId) REFERENCES products (productId),
    FOREIGN KEY (userId) REFERENCES users (id)
)



CREATE TABLE log
(
    id           INT AUTO_INCREMENT PRIMARY KEY,
    userId       INT,
    ip           VARCHAR(300),
    timeLogin    TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    statuss      VARCHAR(400),
    levels       VARCHAR(100),
    valuess      VARCHAR(400),
    previousInfo VARCHAR(400)
)



CREATE TABLE orders(
                       orderId INT AUTO_INCREMENT PRIMARY KEY,
                       userId INT,
                       stauss VARCHAR(300),
                       nameCustomer VARCHAR(100),
                       address VARCHAR(100),
                       phone VARCHAR(10),
                       shippingFee DECIMAL(10, 2),
                       expectedDate DATE,
                       timeOrder TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                       FOREIGN KEY (userId) REFERENCES users(id)
)



CREATE TABLE orderItem(
                          idItem INT AUTO_INCREMENT PRIMARY KEY,
                          orderId INT,
                          quantity INT,
                          productId INT,
                          FOREIGN KEY (productId) REFERENCES products(productId),
                          FOREIGN KEY (orderId) REFERENCES orders(orderId)
)

-- Bảng đánh gía sản phẩm
CREATE TABLE reviews
(
    reviewId   INT PRIMARY KEY AUTO_INCREMENT,
    userId     INT,
    productId  INT,                                             -- Một sản phẩm có nhiều đánh giá
    rating     TINYINT NOT NULL CHECK (rating BETWEEN 1 AND 5), -- Số sao đánh giá từ 1 đến 5
    dateReview TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    mess       VARCHAR(1000),
    FOREIGN KEY (userId) REFERENCES users (id),
    FOREIGN KEY (productId) REFERENCES products (productId)
);


-- SELECT COUNT(orders.orderId) AS SLDH, SUM(orderitem.quantity) AS countQuantityProduct, 
--        SUM(products.unitPrice * orderitem.quantity) AS sumTotalDay
-- FROM orders 
-- JOIN orderitem ON orders.orderId = orderitem.orderId
-- JOIN products ON orderitem.productId = products.productId
-- WHERE orders.stauss NOT IN ( 'Đã hủy', 'Đã hoàn trả') AND DATE(orderitem.timeOrder) = CURDATE();
-- 
-- 
-- SELECT SUM(orderitem.quantity) AS countQuantity, 
--        SUM(products.unitPrice * orderitem.quantity) AS sumTotalDay
-- FROM orders 
-- JOIN orderitem ON orders.orderId = orderitem.orderId
-- JOIN products ON orderitem.productId = products.productId
-- WHERE orders.stauss = 'Đã giao hàng' 
--   AND DATE(orderitem.timeOrder) = CURDATE();

-- SELECT 
--     YEAR(orderitem.timeOrder) AS year,
--     MONTH(orderitem.timeOrder) AS month,
--     SUM(orderitem.quantity) AS countQuantity, 
--     SUM(products.unitPrice * orderitem.quantity) AS sumTotal
-- FROM 
--     orders 
-- JOIN 
--     orderitem ON orders.orderId = orderitem.orderId
-- JOIN 
--     products ON orderitem.productId = products.productId
-- WHERE 
--     orders.stauss = 'Đã giao hàng'
-- GROUP BY 
--     YEAR(orderitem.timeOrder), 
--     MONTH(orderitem.timeOrder)
-- ORDER BY 
--     YEAR(orderitem.timeOrder), 
--     MONTH(orderitem.timeOrder);


-- Mật khẩu : Admin12345

INSERT INTO users (fullname, address, phone, email, username, passwords, sex, yearOfBirth, verificationCode, userStatus,
                   roleUser)
VALUES ('Phan Ngọc Tài', 'Long An', '0234567890', 'tai@gmail.com', 'tai',
        'gSLLoSuJeqVUa6+Qtsgsn2Rvl2s1VQM8vF4LctT3pbw=', 1, '1990-01-01', 'verification123', 0, 0);
INSERT INTO users (fullname, address, phone, email, username, passwords, sex, yearOfBirth, verificationCode, userStatus,
                   roleUser)
VALUES ("Huỳnh Thị Mai Phương", 'Đắk Nông', '0876543210', 'phuong@gmail.com', 'phuong',
        'gSLLoSuJeqVUa6+Qtsgsn2Rvl2s1VQM8vF4LctT3pbw=', 0, '1992-05-15', 'verification456', 0, 0);
INSERT INTO users (fullname, address, phone, email, username, passwords, sex, yearOfBirth, verificationCode, userStatus,
                   roleUser)
VALUES ("Phạm Thị Ngọc Hòa", 'Bình Định', '0876543210', 'hoa@gmail.com', 'hoa',
        'gSLLoSuJeqVUa6+Qtsgsn2Rvl2s1VQM8vF4LctT3pbw=', 0, '1992-05-15', 'verification456', 0, 0);
INSERT INTO users (fullname, address, phone, email, username, passwords, sex, yearOfBirth, verificationCode, userStatus,
                   roleUser)
VALUES ("Admin", 'Việt Nam', '0876543210', 'admin@gmail.com', 'admin', 'gSLLoSuJeqVUa6+Qtsgsn2Rvl2s1VQM8vF4LctT3pbw=',
        0, '1992-05-15', 'verification456', 0, 1);



INSERT INTO product_categorys(id, nameCategory)
VALUES (01, 'Máy khoan pin');
INSERT INTO product_categorys(id, nameCategory)
VALUES (02, 'Máy khoan bê tông, Máy khoan búa');
INSERT INTO product_categorys(id, nameCategory)
VALUES (03, 'Máy khoan động lực');
INSERT INTO product_categorys(id, nameCategory)
VALUES (04, 'Máy khoan cầm tay gia đình');
INSERT INTO product_categorys(id, nameCategory)
VALUES (05, 'Máy khoan mini');


-- phụ kiện loại máy khoan
INSERT INTO product_categorys(id, nameCategory)
VALUES (06, 'Pin máy khoan');
INSERT INTO product_categorys(id, nameCategory)
VALUES (07, 'Sạc pin máy khoan');
INSERT INTO product_categorys(id, nameCategory)
VALUES (08, 'Mũi khoan');


-- bosh
INSERT INTO products (productId, image, productName, unitPrice, categoryId, nameProducer, describle, specifions)
VALUES (01, 'https://s.meta.com.vn/img/thumb.ashx/300x300x95/Data/image/2019/05/26/may-khoan-bosch-gbm-320.jpg',
        'Máy khoan Bosch GBM 320', 699.000, 04, "Bosh", "Đặc điểm nổi bật của sản phẩm
Công suất 320W giúp khoan dễ dàng trên các chất liệu gỗ và thép.

Chức năng đảo chiều mũi khoan linh hoạt.

Động cơ chổi than mạnh mẽ, khoan được trên nhiều vật liệu khác nhau.

Thiết kế nhiều khe tản nhiệt giúp làm mát động cơ.Đánh giá máy khoan Bosch GBM 320
Bosch GBM 320 là dòng máy khoan cầm tay gia đình đến từ thương hiệu Bosch nổi tiếng của Đức, được sản xuất tại Trung Quốc. Sản phẩm sở hữu công suất lên tới 320W cùng tốc độ không tải 4.200 vòng/phút, giúp bạn dễ dàng thực hiện công việc khoan lắp trong gia đình hoặc các công việc của thợ sửa chữa, xây dựng… Cấu tạo từ các chất liệu cao cấp
Giống như các model máy khoan Bosch khác, GBM 320 cũng được chế tạo từ các chất liệu cao cấp, chống va đập tốt. Máy có lớp vỏ ngoài bọc nhựa cao cấp, có thể chịu được lực tác động mạnh và có khả năng cách điện giúp sử dụng an toàn hơn.

Công suất 320W, có thể khoan trên nhiều vật liệu khác nhau
Với công suất 320W cùng tốc độ không tải lên đến 4.200 vòng/phút, máy khoan Bosch GBM 320 hoạt động rất mạnh mẽ và hiệu quả, giúp bạn có thể khoan trên các bề mặt chất liệu như gỗ, thép... một cách dễ dàng, với đường kính đầu cặp tối đa là 6.5mm. Khả năng hoạt động của dòng máy này trên các chất liệu như sau:

Đường kính khoan tối đa trên gỗ là 13 mm.

Đường kính khoan tối đa trên thép là 6,5 mm.
Cò máy điều chỉnh tốc độ vô cấp
Cò máy khoan Bosch GBM 320 được tích hợp dưới tay cầm, giúp bạn điều chỉnh tốc độ khoan theo ý muốn thuận tiện hơn. Đặc biệt, cò máy có độ đàn hồi cao nên bạn chỉ cần bấm nhẹ để sử dụng, không hề gây đau hay mỏi tay. Nhờ đó, máy khoan Bosch GBM 320 sẽ giúp bạn hoàn thành công việc nhanh chóng.
", "Loại máyDùng điện,
Tốc độ không tải0 - 4.200 vòng/phút,
Đường kính đầu cặp 6,5mm,
Lõi mô tơ Dây đồng,
Mô tơ chổi than,
Công suất 320W,
Nguồn điện áp220V - 240V / 50Hz - 60Hz,
Đường kính khoan thép 6,5mm,
Đường kính khoan gỗ 13mm,
Kích thước Rông x Dài x Cao (55mm x 160mm x 175mm),
Trọng lượng sản phẩm1kg,
Sản xuất tại Trung Quốc,
Xuất xứ thương hiệuĐức,
Bảo hành 6 tháng");
INSERT INTO products (productId, image, productName, unitPrice, categoryId, nameProducer, describle, specifions)
VALUES (02, 'https://s.meta.com.vn/Data/image/2023/02/16/may-khoan-xoay-bosch-gbm-400-06011c10k0-1.jpg',
        'Máy khoan xoay Bosch GBM 400 (06011C10K0)', 799.000, 04, "bosh", "Ưu điểm nổi bật của máy khoan xoay Bosch GBM 400 (06011C10K0)
Bosch GBM 400 (06011C10K0) có công suất 400W, sử dụng cắm điện trực tiếp để vận hành sẽ là trợ thủ đắc lực để thực hiện các công việc khoan bắt vít trên bề mặt gỗ, kim loại hoặc nhựa.
Máy khoan cầm tay có tốc độ không tải đạt 0 - 2.800 vòng/phút giúp khoan vật liệu nhanh chóng và dễ dàng.
Kiểu dáng máy khoan nhỏ gọn
Máy khoan Bosch có vỏ nhựa cao cấp, chống va đập tốt, cách điện an toàn, đảm bảo an toàn khi sử dụng. Máy khoan điện chỉ nặng 1.3kg nên cầm thao tác vô cùng nhẹ nhàng. 
Khoan vật liệu hiệu quả
Máy khoan dùng đầu cặp không khóa với đường kính 10mm, cho khả năng làm việc như sau:

Khả năng khoan tối đa thép: 10mm
Khả năng khoan tối đa nhôm: 13mm
Khả năng khoan tối đa gỗ: 20mm
Lưu ý:

Quý khách vui lòng tải ứng dụng Bosch BeConnected để xác minh nguồn gốc sản phẩm ngay trên điện thoại, cũng như tra cứu thông số kỹ thuật, thời gian bảo hành, tìm kiếm trung tâm bảo hành,... của từng sản phẩm theo thời gian thực.
Hình ảnh sản phẩm chỉ có tính chất minh họa, chi tiết sản phẩm, màu sắc có thể thay đổi tùy theo sản phẩm thực tế.
",
        "Loại máy Dùng điện,
        Tốc độ không tải 0 - 2.800 vòng/phút,
        Đường kính đầu cặp 10mm,
        Mô tơ chổi than,
        Công suất 400W,
        Đường kính khoan thép 10mm,
        Đường kính khoan gỗ 20mm,
        Đường kính khoan nhôm 13mm,
        Kích thước Dài x cao x rộng (240mm x 195mm x 65mm),
        Trọng lượng sản phẩm1,3kg,
        Sản xuất tại Trung Quốc,
        Xuất xứ thương hiệuĐức,
        Bảo hành 6 tháng");


-- huynhdai
INSERT INTO products (productId, image, productName, unitPrice, categoryId, nameProducer, describle, specifions)
VALUES (07, 'https://s.meta.com.vn/Data/image/2019/05/11/may-khoan-dien-hyundai-hkd106-g.png',
        'Máy khoan điện Hyundai HKD106', 546.000, 04, "huynhdai", "Tính năng nổi bật của máy khoan điện Hyundai HKD106
Hyundai HKD106 là dòng máy khoan cầm tay gia đình siêu nhỏ gọn với trọng lượng chỉ nặng 1kg giúp bạn khoan vật liệu dễ dàng. Thuận tiện khi khoan trên cao hoặc ở những nơi chật hẹp. 

Trên thân máy khoan thiết kế nhiều khe ra gió giúp tản nhiệt cho mô tơ được tốt nhất để đảm bảo máy khoan Hyundai làm việc bền bỉ hơn. 
Máy khoan điện Hyundai HKD106 dùng nguồn điện áp 1 pha 220V/50Hz, tốc độ không tải tối đa 4.200 vòng/phút cùng công suất mạnh mẽ 320W giúp khoan gỗ, khoan thép hiệu quả.

Đường kính mũi khoan 6.5mm, đường kính khoan gỗ 15mm, đường kính khoan thép là 6.5mm. Máy khoan có chức năng đảo chiều, bạn chỉ cần trang bị đầu vít phù hợp là có thể thực hiện chức năng bắt vít nhanh chóng. 

Nút công tắc bố trí ở ngay dưới tay cầm tiện cho việc thao tác. Lực bóp nhẹ, đàn hồi cao. Ngoài ra máy khoan còn trang bị thêm nút giữ khóa cò máy để có thể khoan liên tục mà không phải bấm cò máy liên tục. 

Lưu ý: Hình ảnh sản phẩm chỉ có tính chất minh họa, chi tiết sản phẩm, màu sắc có thể thay đổi tùy theo sản phẩm thực tế.
",
        "Loại máy Dùng điện,
        Tốc độ không tải0 - 4.200 vòng/phút,
        Đường kính đầu cặp 6,5mm,
        Lõi mô tơ Dây đồng,
        Mô tơ chổi than,
        Công suất320W,
        Nguồn điện áp220V/50Hz,
        Đường kính khoan thép 6,5mm,
        Đường kính khoan gỗ 15mm,
        Trọng lượng sản phẩm1kg,
        Sản xuất tại Trung Quốc,
        Xuất xứ thương hiệu Hàn Quốc,
        Bảo hành 6 tháng");
INSERT INTO products (productId, image, productName, unitPrice, categoryId, nameProducer, describle, specifions)
VALUES (08, 'https://s.meta.com.vn/Data/image/2017/05/18/may-khoan-dien-hkd161.jpg',
        'Máy khoan khuấy sơn Hyundai HKD161', 1110.000, 04, "huynhdai", "Máy khoan khuấy sơn Hyundai HKD161 giúp công việc khoan thép, tường, gỗ trở nên dễ dàng
Máy khoan Hyundai HKD161 đầy mạnh mẽ với công suất 800W giúp công việc khoan tường, gỗ của các anh thợ lành nghề trở nên dễ dàng hơn bao giờ hết. Bên cạnh đó, Hyundai HKD161 còn có thể đáp ứng làm việc được với cả vật liệu cứng như kim loại thép.

Đường kính mũi khoan gỗ: 30mm
Đường kính mũi khoan thép: 16mm
Máy khoan điện Hyundai HKD161 đem lại sự tiện dụng cho người dùng với tay cầm chắc chắn, bổ sung thêm tay cầm phụ giúp đường khoan của bạn trở nên đẹp, sắc bén hơn. Máy khoan cầm tay có thiết nhỏ gọn chỉ với 3,2kg giúp bạn làm việc ở những khu vực trên cao, đòi hỏi phức tạp. Thiết kế bền bỉ, cứng cáp chính là điểm cộng của dòng máy khoan cầm tay này. Vật liệu nhựa cứng dẻo có khả năng chống va đập hiệu quả, chịu lực tốt. Máy khoan điện Hyundai HKD161 sử dụng từ việc lấy điện lưới trực tiếp 220V - 50Hz, dây điện dài vô cùng hữu ích cho người dùng khi di chuyển.

Lưu ý: Hình ảnh sản phẩm chỉ có tính chất minh họa, chi tiết sản phẩm, màu sắc có thể thay đổi tùy theo sản phẩm thực tế.",
        "Loại máy Dùng điện,
       Tốc độ không tải0 - 650 vòng/phút,
       Lõi mô tơ Dây đồng,
        Mô tơ chổi than,
       Công suất 800W,
       Nguồn điện áp220V/50Hz,
       Đường kính khoan thép16mm,
       Đường kính khoan gỗ50mm,
       Trọng lượng sản phẩm1,7kg,
       Trọng lượng bao bì3,8kg,
       Sản xuất tại Trung Quốc,
       Xuất xứ thương hiệu Hàn Quốc,
       Bảo hành 6 tháng");


-- Classic
INSERT INTO products (productId, image, productName, unitPrice, categoryId, nameProducer, describle, specifions)
VALUES (11, 'https://s.meta.com.vn/Data/image/2020/03/18/may-khoan-classic-cla-2245.jpg', 'Máy khoan Classic CLA 2245',
        586.000, 04, "Classic", "Máy khoan Classic CLA 2245 dùng khoan gỗ, khoan thép và khoan nhôm
Máy khoan cầm tay có thiết kế nhỏ gọn với trọng lượng máy là 1.4kg, trọng lượng cả hộp là 1.7kg. Classic CLA 2245 thiết kế đặc biệt hơn là trên thân máy có thước căn chỉnh để khoan góc 90 độ.Phạm vi khoan của máy khoan Classic CLA 2245 là:

Khoan nhôm với đường kính: 10mm
Khoan gỗ với đường kính: 25mm
Khoan thép với đường kính: 10mm
Máy khoan có công suất mạnh mẽ 450W, tốc độ không tải đạt 0 - 3.200 vòng/phút. Máy cho phép điều chỉnh tốc độ khoan ở 6 mức giúp phù hợp với nhiều vật liệu khoan khác nhau. Classic CLA-2245 có thể chuyển đổi chế độ dễ dàng từ khoan thường sang khoan tường. Đầu kẹp mũi khoan từ 1.5mm đến 10mm. Với thước đo độ sâu đi kèm giúp bạn tính toán lỗ khoan chuẩn xác 100%.  Ngoài chức năng khoan, máy khoan Classic CLA 2245 còn hỗ trợ tính năng đảo chiều. Chỉ cần lắp đặt đầu vặn vít vào là bạn có thể bắt vít trên gỗ, thép hay nhôm dễ dàng. Đây là chiếc máy khoan lý tưởng dùng cho gia đình, thợ làm thạch cao, phù hợp với dân DIY, bắn đinh gỗ...", "Mô tơ chổi than,
Tốc độ không tải0 - 3.200 vòng/phút,
Công suất450W,
Đường kính mũi khoan10mm,
Nguồn điện áp220V/50Hz,
Trọng lượng sản phẩm1,4kg,
Trọng lượng bao bì1,7kg,
Xuất xứ thương hiệuViệt Nam,
Sản xuất tạiTrung Quốc,
Bảo hành4 tháng,
Chất liệu vỏ máyNhựa cao cấp,
Màu sắcXanh");


-- gomes
INSERT INTO products (productId, image, productName, unitPrice, categoryId, nameProducer, describle, specifions)
VALUES (14, 'https://s.meta.com.vn/Data/image/2019/05/15/may-khoan-sat-gomes-gb-5513-450w-10mm.jpg',
        'Máy khoan sắt Gomes GB-5513 450W 10mm', 425.000, 04, "gomes", "Máy khoan sắt Gomes GB-5513 giúp khoan kim loại với đường kính 10mm nhanh chóng
Gomes GB-5513 mặc dù có thiết kế nhỏ gọn nhưng công suất khá mạnh mẽ 450W giúp khoan sắt, khoan thép cực kỳ đơn giản, đường kính lỗ khoan là 10mm.  

Máy khoan sắt Gomes GB-5513 có tính năng đảo chiều giúp bạn tháo các mũi khoan bị kẹt ra dễ dàng. Tính năng thay đổi tốc độ giúp bạn có thể lựa chọn được tốc độ khoan phù hợp với vật liệu khoan nhằm mang lại hiệu quả cao hơn trong công việc. Bên cạnh đó, máy khoan động lực Gomes GB-5513 còn thiết kế thêm nút giữ duy trì thao tác khoan. Khi muốn khoan liên tục, bạn chỉ cần nhấn nút tròn màu đen ở gần tay cầm là được. Tính năng này giúp bạn không phải nhấn cò máy liên tục. 

Lớp vỏ màu cam được làm bằng nhựa cao cấp cho độ bền cao, cầm không bị nóng tay khi làm việc. Máy khoan thép Gomes GB-5513 sử dụng loại đầu cặp dễ dàng tháo lắp mũi khoan. 

Lưu ý: Hình ảnh sản phẩm chỉ có tính chất minh họa, chi tiết sản phẩm, màu sắc có thể thay đổi tùy theo sản phẩm thực tế.", "Loại máy Dùng điện,
Tốc độ không tải0 - 2.800 vòng/phút,
Mô tơ chổi than,
Công suất 450W,
Nguồn điện áp 220V/50Hz,
Đường kính khoan thép 10mm,
Đường kính khoan gỗ 25mm,
Sản xuất tại Trung Quốc,
Xuất xứ thương hiệu Trung Quốc,
Bảo hành 3 tháng");


-- Tolsen
INSERT INTO products (productId, image, productName, unitPrice, categoryId, nameProducer, describle, specifions)
VALUES (16, 'https://s.meta.com.vn/Data/image/2021/12/02/may-khoan-tolsen-79503.jpg', 'Máy khoan Tolsen 79503',
        1080.000, 04, "Tolsen", "Máy khoan Tolsen 79503 hỗ trợ chức năng bắt vít
Nếu bạn đang có nhu cầu tìm kiếm một chiếc máy khoan điện cầm tay có chức năng vừa khoan, vừa bắt vít thì máy khoan Tolsen 79503 sẽ đáp ứng được nhu cầu đó của bạn. Máy khoan Tolsen có đường kính khoan thép là 13mm. Đường kính khoan gỗ là 25mm. Đầu cặp có đường kính 13mm, trang bị đầu cặp tự động (Auto Lock) giúp điều chỉnh độ rộng hẹp dễ dàng nên phù hợp với mọi kích cỡ mũi khoan và mũi vít khác nhau.

Máy khoan Tolsen 79503 hoạt động mạnh mẽ với công suất 850W, chỉnh tốc độ không tải ở nhiều mức bằng núm vặn xoay. Khi muốn vặn hay mở ốc vít chỉ cần nhấn vào nút đảo chiều thì mọi công việc của bạn sẽ được hoàn thành nhanh chóng. 

Máy đi kèm tay cầm phụ và thước đo độ sâu, động cơ làm việc bền bỉ, ít xảy ra tình trạng nóng máy khi làm việc lâu. 

Lưu ý: Hình ảnh sản phẩm chỉ có tính chất minh họa, chi tiết sản phẩm, màu sắc có thể thay đổi tùy theo sản phẩm thực tế.", "Loại máy Dùng điện,
Tốc độ không tải 0 - 2.900 vòng/phút,
Đường kính đầu cặp 13mm,
Lõi mô tơ Dây đồng,
Mô tơ chổi than,
Công suất 850W,
Nguồn điện áp 220V/50Hz,
Đường kính khoan thép 13mm,
Đường kính khoan gỗ 25mm,
Đường kính khoan nhôm 25mm,
Đường kính mũi khoan tường 16mm,
Đường kính khoan sắt 13mm,
Kích thướcCao x Rộng (20,5cm x 29,5cm),
Trọng lượng sản phẩm 1,2kg,
Sản xuất tại Trung Quốc,
Xuất xứ thương hiệu Trung Quốc,
Bảo hành 6 tháng");

-- oshima
INSERT INTO products (productId, image, productName, unitPrice, categoryId, nameProducer, describle, specifions)
VALUES (18, 'https://s.meta.com.vn/data/image/2017/01/18/may-khoan-OSHIMA-K600-tay-cam.jpg', 'Máy khoan OSHIMA K600',
        829.000, 04, "oshima", "Máy khoan OSHIMA K600 có chổi than bền lâu:
Máy khoan OSHIMA K600 có gam màu đỏ mạnh mẽ, hoạt động với công suất 600W, có thể khoan nhiều bề mặt khác nhau sẽ mang đến sự thuận tiện tối đa cho bạn. Bên cạnh đó, máy cũng được thiết kế với độ an toàn tối đa với tay cầm phụ và báng cầm mềm giúp bạn yên tâm hơn khi thao tác.Máy khoan OSHIMA K600 có tay cao su, kết cấu máy chắc chắn đảm bảo độ ổn định trong suốt quá trình sử dụng. OSHIMA K600 có trọng lượng chỉ 1.8kg giúp người dùng thao tác trong một thời gian dài mà không lo mỏi tay. Vỏ máy khoan được làm bằng nhựa dày giúp cách điện và cách nhiệt hiệu quả. Dưới đuôi máy có nhiều khe tản nhiệt nên mang lại tuổi thọ dài lâu cho sản phẩm.Cò máy khoan được bố trí ngay dưới tay cầm, có nút giữ cò tự động mang đến nhiều tiện ích khi dùng.Lưu ý: Hình ảnh sản phẩm chỉ có tính chất minh họa, chi tiết sản phẩm, màu sắc có thể thay đổi tùy theo sản phẩm thực tế.", "Loại máy Dùng điện,
Tốc độ không tải 0 - 2.800 vòng/phút,
Mô tơ chổi than,
Công suất 600W,
Nguồn điện áp 220V - 240V / 50Hz - 60Hz,
Đường kính mũi khoan 10mm,
Trọng lượng sản phẩm 1,8kg,
Sản xuất tại Trung Quốc,
Xuất xứ thương hiệu Việt Nam,
Bảo hành 3 tháng");


-- máy khoan pin
-- bosh
INSERT INTO products (productId, image, productName, unitPrice, categoryId, nameProducer, describle, specifions)
VALUES (19, 'https://s.meta.com.vn/Data/image/2023/04/10/may-khoan-pin-bosch-gsb-120-li-06019g81l1.jpg',
        'Máy khoan pin Bosch GSB 120-LI (06019G81L1/06019G81K5, 1 pin, 1 sạc)', 1790.000, 01, "bosh", "Đặc điểm nổi bật của sản phẩm
Máy đi kèm 1 pin 12V 2.0Ah và 1 sạc.

Có khả năng khoan, vặn vít mạnh mẽ trên nhiều chất liệu như tường, gỗ, thép... với đường kính đầu cặp tối đa 10mm.

Sử dụng động cơ chổi than mạnh mẽ.

Tích hợp 2 cấp độ điều chỉnh tốc độ khoan, 20 mức độ vặn vít.

Trang bị 3 tính năng khoan ra, khoan vô, khóa trên cùng 1 nút điều khiển.

Kích thước nhỏ gọn, trọng lượng chỉ 1,1kg giúp bạn dễ sử dụng ngay cả những vị trí hẹp và khó khăn nhất.

Tích hợp đèn LED tiện lợi, hệ thống bảo vệ pin điện tử ECP an toàn.Đánh giá máy khoan pin Bosch GSB 120-LI (06019G81L1/06019G81K5, 1 pin, 1 sạc)
Bosch GSB 120 LI là dòng máy khoan pin cầm tay đến từ thương hiệu Bosch nổi tiếng của Đức. Sản phẩm nổi bật với thiết kế nhỏ gọn, công suất lớn cùng 3 chế độ khoan hữu ích là khoan thường, bắt vít và chế độ búa, giúp bạn dễ dàng khoan trên nhiều chất liệu khác nhau một cách nhanh chóng, mạnh mẽ. Đặc biệt, máy khoan Bosch GSB 120 LI sẽ đi kèm 1 pin 12V 2.0Ah giúp máy hoạt động được lâu hơn và đạt hiệu suất tốt hơn.Cấu tạo từ các chất liệu cao cấp, đi kèm đầy đủ phụ kiện
Giống như các thiết bị máy khoan Bosch khác, máy khoan pin GSB 120-LI cũng được làm từ các chất liệu cao cấp, cứng cáp và bền bỉ. Thân máy bằng cao su chống trơn trượt, có khả năng cách điện 2 lớp, đạt tiêu chuẩn cách điện, cách nhiệt, đảm bảo an toàn cho người dùng trong quá trình sử dụng.

Bộ sản phẩm bao gồm: 1 khoan pin 12V, 1 pin 12V 2.0Ah, 1 đế sạc, 1 vali đựng bằng nhựa.Lưu ý:

Quý khách vui lòng tải ứng dụng Bosch BeConnected để xác minh nguồn gốc sản phẩm ngay trên điện thoại, cũng như tra cứu thông số kỹ thuật, thời gian bảo hành, tìm kiếm trung tâm bảo hành,... của từng sản phẩm theo thời gian thực.
Hình ảnh sản phẩm chỉ có tính chất minh họa, chi tiết sản phẩm, màu sắc có thể thay đổi tùy theo sản phẩm thực tế.", "Loại máy Dùng pin,
Dung lượng pin 2Ah,
Lõi mô tơ Dây đồng,
Mô tơ chổi than,
Lực siết/mở vít 14Nm, 30Nm,
Điện thế pin 12V,
Loại Pin Lithium-ion,
Tốc độ không tải 0 - 400 vòng/phút, 1.500 vòng/phút,
Tốc độ đập 22.500 lần/phút,
Đường kính khoan gỗ 20mm,
Đường kính khoan thép 10mm,
Đường kính đầu cặp 0,8mm - 10mm,
Đường kính khoan khối xây nề8mm,
Cỡ vít tối đa 8mm,
Trọng lượng sản phẩm 1,1kg,
Xuất xứ thương hiệu Đức,
Sản xuất tại Malaysia,
Bảo hành 12 tháng");
INSERT INTO products (productId, image, productName, unitPrice, categoryId, nameProducer, describle, specifions)
VALUES (20, 'https://s.meta.com.vn/Data/image/2021/11/26/may-khoan-van-vit-dung-pin-bosch-gsr-180-li.jpg',
        'Máy khoan vặn vít dùng pin Bosch GSR 180-LI - 06019F81K1', 3190.000, 01, "bosh", "Máy khoan vặn vít dùng pin Bosch GSR 180-Li sử dụng pin sạc 18V
Máy khoan pin Bosch GSR 180-Li được thừa kế và cải tiến mạnh mẽ hơn từ những tính năng của dòng máy khoan bắt vít GSR 1800 Li nên có lực momen xoắn lớn giúp bắt vít nhanh hơn. Bosch GSR 180-Li có trọng lượng 1,6kg nên cầm nắm rất nhẹ tay, thao tác dễ dàng, giúp bạn có thể làm việc ở những khu vực chật hẹp cũng rất thoải mái. Máy khoan vặn vít dùng pin Bosch GSR 180-Li sử dụng hệ thống pin Lithium-ion với điện thế pin 18V có tuổi thọ bền lâu, không bị chai pin, sạc nhanh đầy, cho thời gian làm việc lâu hơn. Ngoài ra, máy khoan Bosch GSR 180-Li còn được trang bị cơ chế bảo vệ pin điện tử nhằm tránh quá tải trong trường hợp kéo quá dòng, quá nhiệt. Khi pin hết điện, máy tự tắt nhờ vào thiết bị bảo vệ mạch. Lưu ý:

Quý khách vui lòng tải ứng dụng Bosch BeConnected để xác minh nguồn gốc sản phẩm ngay trên điện thoại, cũng như tra cứu thông số kỹ thuật, thời gian bảo hành, tìm kiếm trung tâm bảo hành,... của từng sản phẩm theo thời gian thực.
Hình ảnh sản phẩm chỉ có tính chất minh họa, chi tiết sản phẩm, màu sắc có thể thay đổi tùy theo sản phẩm thực tế. ", "Loại máy Dùng pin,
Dung lượng pin 1.5Ah,
Lõi mô tơ Dây đồng,
Mô tơ chổi than,
Lực siết/mở vít 21Nm, 54Nm,
Điện thế pin 18V,
Thời gian sạc pin 60 phút,
Đèn chiếu sáng Đèn Led,
Loại Pin Lithium-ion,
Tốc độ không tải 0 - 500 vòng/phút, 0 - 1.900 vòng/phút,
Đường kính khoan gỗ 35mm,
Đường kính khoan thép 10mm,
Đường kính đầu cặp 1,5mm - 13mm,
Cỡ vít tối đa 10mm,
Kích thước Cao x Dày (22,5cm x 19,8cm),
Trọng lượng sản phẩm 1,6kg,
Xuất xứ thương hiệu Đức,
Sản xuất tại Máy và pin (Malaysia), Sạc (Trung Quốc),
Bảo hành 12 tháng");


-- dekawal
INSERT INTO products (productId, image, productName, unitPrice, categoryId, nameProducer, describle, specifions)
VALUES (29, 'https://s.meta.com.vn/Data/image/2022/01/27/may-khoan-pin-dong-luc-dewalt-dcd996n-kr-1.jpg',
        'Máy khoan pin động lực Dewalt DCD996N-KR (Không pin và sạc)', 2980.000, 01, "dekawal", "Máy khoan pin động lực Dewalt DCD996N-KR sử dụng đầu kẹp tự động 1.5 - 13mm
Máy khoan pin động lực đa năng cho phép bạn sử dụng khoan tường, khoan gỗ hoặc bắt vít... Máy khoan Dewalt có khả năng đáp ứng nhu cầu sử dụng trong bất kỳ công việc nào trong gia đình.

Dewalt DCD996N-KR KHÔNG gồm pin và sạc, Quý khách tham khảo mua thêm (nếu cần):

Pin Dewalt DCB184 18V 5.0Ah
Bộ sạc Dewalt DCB115-KR. Với thiết kế nhỏ gọn, động cơ không chổi than giúp bạn thực hiện nhanh chóng công việc ở những vị trí trên cao hoặc góc nhỏ hẹp.Hiệu điện thế pin 18V giúp bạn thực hiện khoan đục trên các vật liệu khác nhau như gỗ, kim loại, bê tông... Sử dụng công nghệ pin XR Li-Ion dễ dàng sạc lại khi pin cạn.
Máy khoan pin động lực Dewalt DCD996N-KR có mô men xoắn cực đại 95 Nm giúp khoan nhanh, mạnh, chính xác. Giúp thực hiện công việc một cách nhanh chóng, cho sản phẩm chất lượng cao.

Tốc độ đập tối đa 38,250 lần/phút giúp bạn khoan tường hoặc bắt vít nhanh hơn, tiết kiệm sức lao động.
Máy khoan động lực DCD996N-KR có khả năng khoan:

Khoan tường 16mm.
Khoan gỗ 40mm.
Khoan sắt 16mm.
Ngoài ra, máy còn trang bị thêm tay cầm phụ bọc cao su giúp người dùng thoải mái trong quá trình sử dụng, chống rung lắc.

Chế độ bảo hành:

3 năm cho thân máy
1 năm cho pin sạc
Lưu ý: Hình ảnh sản phẩm chỉ có tính chất minh họa, chi tiết sản phẩm, màu sắc có thể thay đổi tùy theo sản phẩm thực tế.
",
        "Loại máy Dùng pin,
        Lõi mô tơ Dây đồng,
        Mô tơ từ (Cảm ứng),
        Lực siết/mở vít 95Nm, 66Nm,
        Điện thế pin 18V,
        Đèn chiếu sáng Đèn Led,
        Loại Pin Li-ion,
        Tốc độ không tải 0 - 500 vòng/phút, 1.500 vòng/phút, 2.250 vòng/phút,
        Tốc độ đập 0 - 8.600 lần/phút, 25.500 lần/phút, 38.250 lần/phút,
        Đường kính khoan gỗ 40mm,
        Đường kính khoan thép 16mm,
        Đường kính đầu cặp 1,5mm - 13mm,
        Đường kính mũi khoan tường 13mm,
        Trọng lượng sản phẩmChưa pin (1,6kg),
        Xuất xứ thương hiệu Mỹ,
        Sản xuất tại Trung Quốc,
        Bảo hành 3 năm");
INSERT INTO products (productId, image, productName, unitPrice, categoryId, nameProducer, describle, specifions)
VALUES (30, 'https://s.meta.com.vn/Data/image/2022/08/30/may-khoan-dong-luc-pin-60v-dewalt-dcd996t1-g.jpg',
        'Máy khoan động lực pin 60V DeWalt DCD996T1', 7180.000, 01, "dekawal", "Ưu điểm nổi bật của máy khoan động lực pin 60V DeWalt DCD996T1
Máy khoan pin cầm tay DeWalt DCD996T1 đi kèm pin Flexvolt 60V-6Ah, sạc nhanh, túi đựng vải giúp cho bạn bảo quản toàn bộ phụ kiện gọn gàng, tránh thất lạc.
Máy khoan pin DCD996T1 có 3 chức năng: Búa, khoan và bắt vít, cho khả năng làm việc như sau:

Đường kính khoan tối đa trên gỗ 40mm
Đường kính khoan tối đa trên tường 16mm
Đường kính khoan tối đa trên thép 16mm
Máy khoan pin Dewalt thiết kế nhỏ gọn, dễ dàng cầm thao tác. 

Vỏ máy thiết kế hấp thụ rung động giúp giảm độ rung tốt cho tay cầm. Máy khoan DeWalt DCD996T1 dùng mô tơ không chổi than cho độ bền cao, không phải thay than. 

Tay cầm được bọc cao su giúp cầm nắm thoải mái khi vận hành. Máy dùng được pin Li-ion 20V - 60V. 

Kích thước đầu kẹp là 1,5mm - 13mm, trang bị lực siết 95Nm giúp mở/siết vít nhanh chóng. Máy khoan dùng pin có 3 tốc độ để lựa chọn:

Tốc độ không tải: 0-500/1.500/2.250 vòng/phút
Tốc độ đập: 0 - 8.600/25.500/38.250 lần/phút
Lưu ý: Hình ảnh sản phẩm chỉ có tính chất minh họa, chi tiết sản phẩm, màu sắc có thể thay đổi tùy theo sản phẩm thực tế.
", "Loại máy Dùng pin,
Dung lượng pin 6Ah,
Lõi mô tơ Dây đồng,
Mô tơ từ (Cảm ứng),
Lực siết/mở vít 95Nm,
Điện thế pin 60V,
Loại Pin Li-ion,
Tốc độ không tải 0 - 500 vòng/phút, 1.500 vòng/phút, 2.250 vòng/phút,
Tốc độ đập 0 - 8.600 lần/phút, 25.500 vòng/phút, 38.250 lần/phút,
Đường kính khoan gỗ 40mm,
Đường kính khoan thép 16mm,
Đường kính đầu cặp 1,5mm - 13mm,
Đường kính mũi khoan tường 16mm,
Xuất xứ thương hiệu Mỹ,
Sản xuất tại Trung Quốc,
Bảo hành 3 năm");

-- huynhdai
INSERT INTO products (productId, image, productName, unitPrice, categoryId, nameProducer, describle, specifions)
VALUES (34, 'https://s.meta.com.vn/Data/image/2021/02/03/may-khoan-bua-chay-pin-20v-hyundai-hkbp2013bm-g2.jpg',
        'Máy khoan búa chạy pin 20V Hyundai HKBP2013BM', 2430.000, 01, "huynhdai", "Ưu điểm nổi bật của máy khoan búa chạy pin 20V Hyundai HKBP2013BM
Hyundai HKBP2013BM dùng mô tơ không chổi than siêu bền, chạy ổn định, độ ồn thấp, công suất khỏe hơn, không cần thay thế chổi than. Máy khoan dùng pin có điện thế pin 20V, người dùng có thể chọn mua theo dung lượng 2Ah hoặc 4Ah. 
Phụ kiện đi kèm theo máy khoan HKBP2013BM gồm:

2 pin 
1 bộ sạc nhanh
1 móc treo
Hộp đựng nhựa

Máy khoan dùng pin Hyundai HKBP2013BM có chế độ búa giúp khoan được cả tường, gỗ và thép. Khả năng làm việc của máy khoan Hyundai như sau:

Đầu cặp mũi khoan: 13mm
Khả năng khoan thép: 13mm
Khả năng khoan bê tông: 13mm
Khả năng khoan gỗ: 38mm
Máy khoan vặn vít dùng pin có lực siết tối đa 55Nm giúp bắt vít cực khỏe. Với bộ sạc nhanh bạn có thể sạc pin Li-ion 4Ah chỉ mất 2 giờ đồng hồ. Khi đèn báo chuyển sang màu xanh là pin đã được sạc đầy. 

Máy khoan búa chạy pin có trọng lượng thân máy chỉ nặng 1.2kg, pin nặng khoảng 600g (pin 4Ah) cầm thao tác làm việc vô cùng thoải mái. Máy khoan Hyundai có thiết kế chắc chắn, đẹp, điều chỉnh được tốc độ ở 2 cấp từ 0 - 2.000 vòng/phút.

Máy khoan pin có 3 chế độ: Bắt vít, khoan thường và khoan búa bằng cách vặn vòng xoay để tùy chọn chế độ. Máy khoan dùng pin có chế độ đảo chiều tiện lợi. Tốc độ đập từ 0 - 30.000 lần/phút.

Máy thiết kế rất đặc biệt, có cảm biến trong môi trường tối sẽ tự động bật đèn pin giúp làm việc không bị ảnh hưởng, khoan lỗ hay bắt vít chính xác. 

Vỏ máy được làm từ nhựa cao cấp, tay cầm bọc cao su cầm chống trượt hiệu quả. Pin cung cấp điện năng khỏe giúp máy làm việc hết công suất, cho lực khoan rất khỏe. 
Lưu ý: Hình ảnh sản phẩm chỉ có tính chất minh họa, chi tiết sản phẩm, màu sắc có thể thay đổi tùy theo sản phẩm thực tế.
", "Loại máy Dùng pin,
Dung lượng pin 2Ah, 4Ah,
Lõi mô tơ Dây đồng,
Mô tơ từ (Cảm ứng),
Lực siết/mở vít 55Nm,
Điện thế pin 20V,
Thời gian sạc pin 1 giờ,
Đèn chiếu sáng Đèn Led,
Tốc độ không tải 0 - 2.000 vòng/phút, 0 - 450 vòng/phút,
Tốc độ đập 0 - 30.000 lần/phút, 0 - 6.750 lần/phút,
Đường kính khoan gỗ 38mm,
Đường kính khoan thép 13mm,
Đường kính đầu cặp 13mm,
Đường kính mũi khoan tường 13mm,
Trọng lượng sản phẩm 1,6kg,
Kích thước đóng gói Dài x Rộng x Cao (31,5cm x 10cm x 27,5cm),
Trọng lượng bao bì 2,6kg,
Xuất xứ thương hiệu Hàn Quốc,
Sản xuất tại Trung Quốc,
Bảo hành 6 tháng");

-- Milwaukee
INSERT INTO products (productId, image, productName, unitPrice, categoryId, nameProducer, describle, specifions)
VALUES (37, 'https://s.meta.com.vn/Data/image/2019/09/06/than-may-khoan-dong-luc-milwaukee-m12-fpd-0-g.jpg',
        'Thân máy khoan động lực Milwaukee M12 FPD-0 (Không pin và sạc)', 3730.000, 01, "Milwaukee", "Ưu điểm của thân máy khoan động lực Milwaukee M12 FPD-0
Milwaukee M12 FPD-0 là dòng máy khoan pin có chức năng khoan và bắt vít. Máy khoan Milwaukee sử dụng pin sạc Li-ion, điện thế 12V. Kiểu dáng máy khoan nhỏ gọn, chỉ nặng 1.5kg cầm thao tác rất nhẹ nhàng.

Sản phẩm chưa bao gồm pin, sạc.

Quý khách có thể đặt mua Pin và sạc phù hợp dưới đây:

Pin 12V 2.0Ah Milwaukee M12B2
Pin 12V 6.0Ah Milwaukee M12B6
Pin 12V 4.0Ah Milwaukee M12B4
Sạc nhanh Pin Milwaukee 12V, 18V M12-18FC
Sạc pin 12V Milwaukee C12C ", "Loại máy Dùng pin,
Lõi mô tơ Dây đồng,
Mô tơ từ (Cảm ứng),
Lực siết/mở vít 44Nm,
Điện thế pin 12V,
Đèn chiếu sáng Đèn Led,
Loại Pin Lithium-ion,
Tốc độ không tải 0 - 450 vòng/phút, 0 - 1.700 vòng/phút,
Tốc độ đập 0 - 25.500 lần/phút, 0 - 6.750 lần/phút,
Đường kính khoan gỗ 43mm,
Đường kính đầu cặp 1,5mm - 13mm,
Đường kính khoan sắt 13mm,
Đường kính mũi khoan tường 13mm,
Đường kính khoan gạch 13mm,
Chiều dài máy 16,8cm,
Trọng lượng sản phẩm 1,5kg,
Xuất xứ thương hiệu Mỹ,
Sản xuất tại Trung Quốc,
Bảo hành 12 tháng");

INSERT INTO products (productId, image, productName, unitPrice, categoryId, nameProducer, describle, specifions)
VALUES (38, 'https://s.meta.com.vn/Data/image/2023/05/30/may-khoan-dong-luc-dung-pin-milwaukee-m18-fpd3-0x-6.jpg',
        'Máy khoan động lực dùng pin 18V Milwaukee M18 FPD3-0X (Chưa pin và sạc)', 5410.000, 01, "Milwaukee", "Ưu điểm nổi bật của máy khoan động lực dùng pin 18V Milwaukee M18 FPD3-0X
Sử dụng mô tơ không chổi than
Milwaukee M18 FPD3-0X được ứng dụng công nghệ FUEL độc quyền của Milwaukee với động cơ không chổi than cho độ bền cao. 
Máy khoan dùng pin Li-ion với điện thế 18V, cho hiệu quả làm việc cao, không bị hạn chế về không gian làm việc. Việc không cần sử dụng nguồn điện trực tiếp nên không cần kéo theo dây điện vướng víu chính là ưu điểm của M18 FPD3.

Về thiết kế
Máy khoan động lực dùng pin Milwaukee M18 FPD3-0X có thiết kế nhỏ gọn với chiều dài chỉ 175mm, dễ dàng tiếp cận trong không gian chật hẹp. M18 FPD3-0X được tích hợp thêm đèn LED dễ dàng làm việc trong điều kiện thiếu sáng. Máy khoan còn M18 FPD3 còn có móc treo làm bằng kim loại dễ dàng di chuyển máy khi làm việc ở trên cao. 

Mâm cặp đầu mũi khoan có đường kính 13mm, được làm hoàn toàn bằng kim loại với răng cacbua giúp gia tăng tối đa độ bền, độ bám và khả năng giữ mũi khoan.Chế độ điều khiển Auto-Stop tăng tính an toàn khi làm việc 
Máy khoan được trang bị chế độ điều khiển Auto-Stop giúp nâng cao độ an toàn cho người dùng. Auto-Stop sẽ kiểm soát hoạt động của thiết bị, tránh tình trạng quay quá mức gây ảnh hưởng thiết bị.  

Lưu ý: Hình ảnh sản phẩm chỉ có tính chất minh họa, chi tiết sản phẩm, màu sắc có thể thay đổi tùy theo sản phẩm thực tế.
", "Loại máy Dùng pin,
Mô tơ từ (Cảm ứng),
Lực siết/mở vít 175Nm,
Điện thế pin 18V,
Loại Pin Lithium-ion,
Tốc độ không tải 0 - 500 vòng/phút, 2.100 vòng/phút,
Tốc độ đập 0 - 7.800 lần/phút, 30.000 lần/phút,
Đường kính khoan gỗ 89mm,
Đường kính đầu cặp 13mm,
Đường kính khoan sắt 13mm,
Đường kính mũi khoan tường 16mm,
Trọng lượng sản phẩm 2,5kg,
Xuất xứ thương hiệu Mỹ,
Sản xuất tại Trung Quốc,
Bảo hành 12 tháng");

-- Tolsen
INSERT INTO products (productId, image, productName, unitPrice, categoryId, nameProducer, describle, specifions)
VALUES (42, 'https://s.meta.com.vn/Data/image/2022/09/15/tolsen-87240-1.jpg',
        'Bộ 2 máy khoan pin và máy vặn bu lông pin Tolsen 87240 20V', 2990.000, 01, "Tolsen",
        "Giới thiệu bộ 2 máy khoan pin và máy vặn bu lông pin Tolsen 87240 20V
        Thiết kế tiện dụng

        Bộ 2 máy khoan pin và máy vặn bu lông Tolsen 87240 được thiết kế dùng pin tiện lợi giúp người dùng có thể làm việc ở nhiều nơi mà không bị phụ thuộc vào nguồn điện, không vướng víu. Bộ hai sản phẩm đều sở hữu thiết kế nhỏ gọn, dạng cầm tay, nổi bật với hai màu đặc trưng của thương hiệu Tolsen là vàng và đen.

        Với khả năng khoan và siết bu lông mạnh mẽ, bộ sản phẩm Tolsen 87240 hỗ trợ giải quyết nhiều công việc khác nhau.

        Hai máy đều được làm từ các chất liệu có độ bền cao như nhựa, kim loại đảm bảo độ bền, khả năng chống chịu va đập và nhiệt tốt.

        Hai máy sử dụng động cơ chổi than cho khả năng hoạt động êm ái, mạnh mẽ. Mâm cặp không chìa bằng kim loại giúp tháo mũi khoan nhanh hơn.

        Đèn báo pin và đèn chiếu sáng hỗ trợ làm việc tại không gian thiếu sáng. Tính năng vượt trội

        Bộ máy khoan Tolsen hỗ trợ nhiều công việc khác nhau như khoan gỗ, thép, vặn ốc vít,...

        Bộ sản phẩm có tốc không tải 1.500 vòng/phút và 2.500 vòng/phút đi cùng lực xoắn cho vít cứng/mềm là 35 Nm và 330 Nm đảm bảo hiệu suất làm việc cao.

        Bên cạnh đó, 2 máy còn sở hữu tốc độ đập khá lớn, khoảng 3000 lần/phút mạnh mẽ.Bộ máy khoan pin và vặn bu lông Tolsen 87240 trang bị chế độ đảo chiều kết hợp với vòng điều chỉnh lực xoắn cho khả năng làm việc linh hoạt hơn.

        Máy còn có thể tự động khóa trục chính và điều khiển tốc độ điện tử.

        Lưu ý: Hình ảnh sản phẩm chỉ có tính chất minh họa, chi tiết sản phẩm, màu sắc có thể thay đổi tùy theo sản phẩm thực tế.", "Loại máy Dùng pin,
Lõi mô tơ Dây đồng,
Mô tơ chổi than,
Lực siết/mở vít 35Nm, 330 Nm,
Điện thế pin 20V,
Đèn chiếu sáng Có,
Tốc độ đập 0 - 3.000 lần/phút,
Đường kính khoan gỗ 25mm,
Đường kính khoan thép 10mm,
Cỡ vít tối đa 10mm, 12.7mm,
Kích thước 22cm x 35cm x 15.5cm,
Trọng lượng sản phẩm 5,5kg
Xuất xứ thương hiệu Trung Quốc,
Sản xuất tại Trung Quốc,
Bảo hành 6 tháng");
INSERT INTO products (productId, image, productName, unitPrice, categoryId, nameProducer, describle, specifions)
VALUES (43, 'https://s.meta.com.vn/Data/image/2018/12/18/may-khoan-van-vit-dung-pin-tolsen-79013-500.jpg',
        'Máy khoan vặn vít dùng pin Tolsen 79013', 960000, 01, "Tolsen", "Máy khoan vặn vít dùng pin Tolsen 79013 thiết kế chắc chắn, đảm bảo độ bền
Máy khoan vặn vít dùng pin Tolsen 79013 có kiểu dáng hình khẩu súng tiện dụng với tay cầm lớn, cho bạn thoải mái cầm nắm và thao tác khi lắp đặt, sửa chữa với máy.
Tolsen 79013 có phần thân máy có các đường vân nổi, giúp hạn chế khả năng trơn trượt, giảm thiểu nguy hiểm trong quá trình sử dụng.
Máy khoan sử dụng các mối nối kim loại chắc chắn bằng thép không gỉ, bảo đảm độ bền.

Thiết kế lực mô-men xoắn lớn, cho gia tốc vận hành được đẩy lên tối đa, sản phẩm giúp việc vặn một chiếc đinh, vít vào tường trở nên dễ dàng, nhanh chóng lại không tốn công sức.

Máy vặn vít sử dụng nguồn năng lượng Li-ion 10,8V 1300mAh có khả năng sạc điện nhanh chóng, trọng lượng nhẹ, không có dây điện gây vướng víu, không gây trở ngại khi vận hành.

Lưu ý: Hình ảnh sản phẩm chỉ có tính chất minh họa, chi tiết sản phẩm, màu sắc có thể thay đổi tùy theo sản phẩm thực tế.
", "
Loại máy Dùng pin,
Dung lượng pin 1.3Ah,
Lõi mô tơ Dây đồng,
Mô tơ chổi than,
Lực siết/mở vít 15Nm,
Điện thế pin 10,8V,
Thời gian sạc pin 3 - 5 giờ,
Đèn chiếu sáng Đèn Led,
Loại Pin Li-ion,
Tốc độ không tải 0 - 550 vòng/phút,
Xuất xứ thương hiệu Trung Quốc,
Sản xuất tại Trung Quốc,
Bảo hành 6 tháng
");


-- Classic
INSERT INTO products (productId, image, productName, unitPrice, categoryId, nameProducer, describle, specifions)
VALUES (46, 'https://s.meta.com.vn/Data/image/2020/05/19/may-khoan-pin-classic-cla-20va-1.jpg',
        'Máy khoan pin Classic CLA-20VA', 1310.000, 01, "Classic",
        "
        Ưu điểm vượt trội của máy khoan pin Classic CLA-20VA
        Máy khoan có 2 chức năng
        Classic CLA-20VA dùng để khoan và bắt vít trên gỗ và thép. Khi muốn thực hiện chức năng bắt vít bạn hãy nhấn vào nút đảo chiều, máy sẽ bắt những con vít nhanh chóng.
        Cấu trúc máy chắc chắn
        Vỏ máy khoan pin được làm từ nhựa siêu bền, khó nứt vỡ, chống nóng khi cầm nắm.
        Đầu cặp Auto Lock 10mm làm từ kim loại bền bỉ, chịu va đập tốt, dễ chỉnh kích thước.
        Động cơ mạnh mẽ
        Máy khoan Classic CLA-20VA sử dụng loại pin 20V cho khả năng khoan và bắt vít mạnh mẽ, nhanh chóng. Tốc độ không tải đạt mức tối đa 650 vòng/phút.

        Sản phẩm điều chỉnh lực siết mở ốc vít bằng tay dễ dàng. Máy khoan dùng pin có thể khoan thép với đường kính tối đa là 10mm.
        Ứng dụng rộng rãi
        Máy khoan pin Classic CLA-20VA thích hợp sử dụng cho gia đình, người làm mộc, người làm nghề cơ khí, xây dựng, thợ điện nước...
        Lưu ý: Hình ảnh sản phẩm chỉ có tính chất minh họa, chi tiết sản phẩm, màu sắc có thể thay đổi tùy theo sản phẩm thực tế.
        ", "
Loại máy Dùng pin,
Dung lượng pin 1.5Ah,
Mô tơ chổi than,
Điện thế pin 20V,
Đèn chiếu sáng Đèn Led,
Loại Pin Li-ion,
Tốc độ không tải 0 - 650 vòng/phút,
Đường kính khoan thép 10mm,
Đường kính mũi khoan 10mm,
Xuất xứ thương hiệu Nhật Bản,
Sản xuất tại Trung Quốc,
Bảo hành 4 tháng
");


-- Oshima
INSERT INTO products (productId, image, productName, unitPrice, categoryId, nameProducer, describle, specifions)
VALUES (49, 'https://s.meta.com.vn/Data/image/2020/03/18/may-khoan-pin-oshima-kp12-td-12v.jpg',
        'Máy khoan pin Oshima KP12 TD 12V', 889.000, 01, "Oshima", "Máy khoan pin Oshima KP12 TD kèm đầy đủ phụ kiện
Máy khoan Oshima KP12 TD sử dụng pin trụ điện thế 12V, dung lượng pin là 1.5Ah, khi sạc đầy trong vòng 120 phút có thể sử dụng liên tục từ 30 - 45 phút. Máy khoan pin có thiết kế nhỏ gọn với trọng lượng máy là 1.2kg nên cầm làm việc rất nhẹ nhàng, dễ thao tác và di chuyển.
Máy khoan có 2 chức năng: bắt vít và khoan gỗ, khoan thép. Khả năng khoan của máy như sau:

Đường kính khoan tối đa trên gỗ là 20mm
Đường kính khoan tối đa trên thép là 8mm
Máy khoan vặn vít sử dụng cỡ vít tối đa là 10mm. Máy có mô men xoắn tối đa là 26 Nm giúp bắt vít vào vật liệu cực nhanh. Chức năng đảo chiều để bạn có thể mở vít ra dễ dàng.Máy cho phép chỉnh tốc độ ở hai mức: Mức thấp từ 0 - 600 vòng/phút, mức cao từ 0 - 1.300 vòng/phút giúp khoan và bắt vít nhanh hơn. 

Lưu ý: Hình ảnh sản phẩm chỉ có tính chất minh họa, chi tiết sản phẩm, màu sắc có thể thay đổi tùy theo sản phẩm thực tế.", "
Loại máy Dùng pin,
Dung lượng pin 1.5Ah,
Mô tơ chổi than,
Lực siết/mở vít 22Nm,
Điện thế pin 12V,
Thời gian sạc pin 2 giờ,
Đèn chiếu sáng Đèn Led,
Tốc độ không tải 0 - 600 vòng/phút, 0 - 1.300 vòng/phút,
Đường kính khoan gỗ 20mm,
Đường kính khoan thép 8mm,
Cỡ vít tối đa 10mm,
Thời gian sử dụng 30 - 45 phút,
Trọng lượng sản phẩm 1,2kg,
Xuất xứ thương hiệu Việt Nam,
Sản xuất tại Trung Quốc,
Bảo hành 6 tháng
");
INSERT INTO products (productId, image, productName, unitPrice, categoryId, nameProducer, describle, specifions)
VALUES (50, 'https://s.meta.com.vn/Data/image/2019/08/10/may-khoan-pin-oshima-kp12-ld-12v.jpg',
        'Máy khoan pin Oshima KP12 LD 12V', 859.000, 01, "Oshima", "
Máy khoan pin Oshima KP12 LD sử dụng được liên tục 45 phút
Máy khoan pin có cỡ vít tối đa là 10mm, sử dụng đầu cặp Auto Lock giúp người dùng lắp ráp mũi khoan và mũi vít dễ dàng. Khả năng khoan vật liệu của máy khoan như sau:

Đường kính khoan tối đa trên gỗ: 20mm
Đường kính khoan tối đa trên thép: 8mm
Máy khoan dùng pin Oshima KP12 L sử dụng đầu vít quay đồng tâm và motor dây đồng chất lượng cao cho khả năng làm việc bền bỉ và ổn định. Phần vỏ máy làm bằng nhựa chịu nhiệt, chống va đập. Trọng lượng máy siêu nhỏ gọn chỉ nặng 1.2kg cho thao tác làm việc đơn giản, cầm nắm 1 tay cũng có thể khoan và bắt vít dễ dàng. 
Lưu ý: Hình ảnh sản phẩm chỉ có tính chất minh họa, chi tiết sản phẩm, màu sắc có thể thay đổi tùy theo sản phẩm thực tế.
", "
Loại máy Dùng pin,
Dung lượng pin 1.5Ah,
Mô tơ chổi than,
Lõi mô tơ Dây đồng,
Lực siết/mở vít 22Nm,
Điện thế pin 12V,
Thời gian sạc pin 2 giờ,
Đèn chiếu sáng Đèn Led,
Tốc độ không tải 0 - 600 vòng/phút, 0 - 1.300 vòng/phút,
Đường kính khoan gỗ 20mm,
Đường kính khoan thép 8mm,
Cỡ vít tối đa 10mm,
Thời gian sử dụng 30 - 45 phút,
Trọng lượng sản phẩm 1,2kg,
Xuất xứ thương hiệu Việt Nam,
Sản xuất tại Trung Quốc,
Bảo hành 6 tháng
");


-- Gomes
INSERT INTO products (productId, image, productName, unitPrice, categoryId, nameProducer, describle, specifions)
VALUES (53, 'https://s.meta.com.vn/Data/image/2020/08/25/may-khoan-pin-gomes-gb-12cd-6.jpg',
        'Máy khoan pin Gomes GB-12CD', 758.000, 01, "Gomes", "
Vì sao máy khoan pin Gomes GB-12CD rất được tin dùng?
Máy khoan Gomes GB-12CD đi kèm đầy đủ phụ kiện: 2 pin 12V 1.3Ah, sạc pin, hộp đựng nhựa. 
Pin có thời gian sạc đầy khoảng 2.5 giờ, trong quá trình sử dụng người dùng có thể thay luân phiên 2 cục pin để sử dụng, giúp làm việc được liên tục trong thời gian dài. 
Máy khoan dùng pin có đường kính mũi khoan là 10mm, pin Li-ion phóng điện khỏe. 
Máy có 2 mức tốc độ để lựa chọn: Mức thấp từ 0 - 350 vòng/phút, mức cao từ 0 - 1300 vòng/phút sẽ hỗ trợ khoan vật liệu nhanh chóng. 
Máy khoan pin 12V GB-12CD là model mới nhất của thương hiệu Gomes, có tích hợp đèn LED để chiếu sáng tốt cho khu vực làm việc bị thiếu ánh sáng. 
Mô tơ được làm mát bằng gió giúp chạy bền bỉ hơn, độ bền động cơ cao hơn.
Máy khoan pin Gomes GB-12CD được tích hợp tính năng đảo chiều, có 18 bước điều chỉnh lực vít bằng tay. Mô men xoắn cực đại là 22Nm sẽ hỗ trợ bắt vít trên gỗ, thép nhanh. 
Máy khoan vặn vít dùng pin thiết kế công tắc bóp dễ sử dụng. Đầu cặp tự động dễ thay đổi mũi khoan, mũi vít. 
Thân máy nhỏ gọn, chắc chắn, được bọc nhựa chống va đập. Với tầm giá này và khả năng hoạt động tốt trên gỗ, thép, máy khoan Gomes GB-12CD có thể là một lựa chọn đáng để bạn xem xét. 

Lưu ý: Hình ảnh sản phẩm chỉ có tính chất minh họa, chi tiết sản phẩm, màu sắc có thể thay đổi tùy theo sản phẩm thực tế.
", "
Loại máy Dùng pin,
Dung lượng pin 1.3Ah,
Mô tơ chổi than,
Lõi mô tơDây đồng,
Lực siết/mở vít 22Nm,
Điện thế pin 12V,
Thời gian sạc pin 2,5 giờ,
Đèn chiếu sáng Đèn Led,
Loại Pin Lithium-ion,
Tốc độ không tải 0 - 350 vòng/phút, 0 - 1.300 vòng/phút,
Đường kính mũi khoan 10mm,
Xuất xứ thương hiệu Trung Quốc,
Sản xuất tại Trung Quốc,
Bảo hành 3 tháng
");



-- Máy khoan bê tông, Máy khoan búa
-- Bosh
INSERT INTO products (productId, image, productName, unitPrice, categoryId, nameProducer, describle, specifions)
VALUES (55, 'https://s.meta.com.vn/Data/image/2022/02/10/may-khoan-bua-bosch-gbh-2-28-dv-1.jpg',
        'Máy khoan búa Bosch GBH 2-28 DV', 4700.000, 02, "Bosh", "
Máy khoan búa Bosch GBH 2-28 DFV tích hợp 3 chức năng trong 1
Máy khoan búa Bosch GBH 2-28 DFV là một trong những dụng cụ mạnh mẽ nhất thuộc dòng máy khoan và đục bê tông. Máy nổi bật với những ưu điểm:

Mô-tơ 820W mạnh mẽ để tăng hiệu suất tối ưu
Công nghệ kiểm soát rung Active Vibration Control hoạt động để sử dụng thoải mái và không mỏi
Hộp số vỏ kim loại chắc chắn đảm bảo độ bền và độ an toàn
Máy khoan đục phá bê tông hoạt động với công suất 820W đầy nội lực, có khả năng khoan, phá đục bê tông với tốc độ lên đến 5.100 lần/phút cùng lực đập 3.2J, mang lại hiệu quả công việc cực lớn. 
Chưa hết, máy khoan búa Bosch GBH 2-28 DFV còn được trang bị công nghệ chống rung, giúp người dùng làm việc thoải mái và không gây mỏi tay khi khoan. Ngoài ra, máy khoan có tay cầm phụ với thước đo độ sâu và báng cầm mềm giúp người dùng thao tác thuận tiện.

Những tính năng nổi bật nhất ở máy khoan búa Bosch GBH 2-28 DFV
Máy GBH 2-28 DFV hoạt động bền bỉ được cải tiến với nhiều tính năng vượt trội:

Sức phá mạnh mẽ và tuổi thọ lâu dài (hơn 25% so với các máy khoan búa khác cùng hiệu suất)
Bên cạnh đó, thì độ rung thấp hơn 27% nhờ kích hoạt chức năng chống rung
Vòng đệm bi để ngăn ngừa đứt cáp
Tấm chải xoay đảm bảo công suất ngang bằng khi quay lùi và tiến
Khớp ly hợp an toàn bảo vệ người dùng và máy
Chức năng đảo chiều cho phép tháo các mũi khoan bị kẹt
Kiểm soát liên tục tốc độ biến đổi .Khả năng khoan trên nhiều vật liệu
Máy khoan búa Bosch có các đầu cặp thay, giúp thay đổi nhanh chóng khi khoan động lực bê tông và khoan không động lực trên gỗ và kim loại. Máy có khả năng khoan nhiều vật liệu với:

Đường kính khoan bê tông, mũi khoan búa: 4 - 28mm
Đường kính khoan tối đa trên tường gạch, máy cắt lõi: 68mm
Đường kính khoan tối đa trên kim loại: 13mm
Làm việc tối ưu trên bê tông, các mũi khoan búa: 8 - 16mm
Đường kính khoan bê tông với các dao cắt lõi: 68mm
Đường kính khoan tối đa trên gỗ: 30mm
",
        "
        Loại máy Dùng điện,
        Công suất 820W,
        Nguồn điện áp 220V/50Hz - 60Hz,
        Tốc độ không tải 0 - 1.300 vòng/phút,
        Tốc độ đập 0 - 5.100 lần/phút,
        Lõi mô tơ Dây đồng,
        Mô tơ chổi than,
        Chức năng Đục bê tông, Khoan bê tông,
        Lực đập 3,2J,
        Loại đầu gài SDS-Plus
        Đường kính khoan bê tông 4mm - 28mm,
        Đường kính khoan gỗ 30mm,
        Đường kính khoan thép 13mm,
        Trọng lượng sản phẩm 3,9kg,
        Kích thước 21cm x 40cm x 8cm,
        Kích thước đóng gói 36cm x 43cm x 10cm,
        Trọng lượng bao bì 5,3kg,
        Xuất xứ thương hiệu Đức,
        Sản xuất tại Trung Quốc,
        Bảo hành 12 tháng
        ");

INSERT INTO products (productId, image, productName, unitPrice, categoryId, nameProducer, describle, specifions)
VALUES (58, 'https://s.meta.com.vn/Data/image/2021/06/01/may-khoan-bua-bosch-gbh-220-1.jpg',
        'Máy khoan búa Bosch GBH 220 (06112A60K0)', 2780.000, 02, "Bosh", "
Đánh giá những điểm nổi bật của máy khoan búa Bosch GBH 2-20RE
Thiết kế rắn chắc, chịu được lực va đập lớn
Có 2 chế độ: khoan thường, khoan búa để đáp ứng mọi nhu cầu khoan đục trong gia đình hay chuyên nghiệp
Được trang bị tay cầm phụ, hỗ trợ chống rung lắc
Máy khoan búa Bosch GBH 2-20RE tại META.vn có tem bảo hành và chống hàng giả chính hãng. Máy khoan búa Bosch GBH 2-20RE giúp đáp ứng mọi nhu cầu khoan đục từ đơn giản đến chuyên nghiệp
Thiết kế rắn chắc, cho hiệu quả tối ưu
Máy khoan Bosch GBH 2-20RE có thân máy chắc chắn, đảm bảo độ ổn định và độ bền tối ưu. Tổng chiều dài 325mm và trọng lượng 2.3kg giúp thao tác không bị vướng víu và không bị mỏi tay. Máy khoan sử dụng đầu cặp mũi SDS-plus cho khả năng truyền lực tối ưu, cơ cấu điều khiển tốc độ điện tử còn giúp khoan lái chính xác hơn cùng chức năng đảo chiều để bạn có thể vặn vít thuận tiện. Khả năng khoan hiệu quả trên mọi bề mặt
Bosch GBH 2-20RE được trang bị mô tơ công suất 600W mạnh mẽ đáp ứng mọi nhu cầu của bạn khi cần khoan trên các bề mặt khác nhau. Ngoài ra, máy khoan búa cũng được trang bị má đỡ đấm sau khi khoan với đầu nối chuôi 3 vấu và các mũi khoan chuôi thẳng để khoan gỗ và thép nhanh chóng và an toàn. Đặc biệt, máy khoan búa Bosch cũng có thể dễ dàng vận hành tiến, lùi theo nhu cầu tạo sự tiện dụng tối đa cho bạn. Ưu điểm của máy khoan búa Bosch GBH 2-20RE so với các máy khoan khác anh em khó có thể bỏ qua
Máy khoan búa Bosch GBH 2-20RE có thể vận hành tiến/lùi.
Có nút khóa để duy trì thao tác khoan.
Báng cầm mềm để thao tác tiện lợi và không mỏi.
Kiểm soát tốc độ biến đổi vô cấp có khả năng điều chỉnh tốc độ theo nhu cầu một cách dễ dàng.
Ly hợp an toàn để bảo vệ tốt hơn cho người sử dụng và công cụ trong trường hợp kẹt mũi khoan.
Tay cầm phụ với thước đo độ sâu và báng cầm mềm giúp thao tác thuận tiện và thoải mái hơn.
Má đỡ đấm sau khi khoan với đầu nối chuôi 3 vấu và các mũi khoan chuôi thẳng để khoan gỗ và thép.
", "
Loại máy Dùng điện,
Mô tơ chổi than,
Lõi mô tơ Dây đồng,
Tốc độ đập 0 - 4.400 lần/phút,
Công suất 600W,
Tốc độ không tải 0 - 1.400 vòng/phút,
Đường kính khoan gỗ 30mm,
Đường kính khoan bê tông 4mm - 20mm,
Đường kính khoan thép 13mm,
Đường kính mũi khoan tường 68mm,
Lực đập 0J - 1,7J,
Nguồn điện áp 220V - 240V / 50Hz - 60Hz,
Kích thước 21cm x 31cm x 5cm,
Trọng lượng sản phẩm 2,3kg,
Xuất xứ thương hiệu Đức,
Sản xuất tại Trung Quốc,
Bảo hành 6 tháng,
Loại đầu gài SDS-Plus,
Chức năng Đục bê tông, Khoan bê tông,
");


-- DeWalt

INSERT INTO products (productId, image, productName, unitPrice, categoryId, nameProducer, describle, specifions)
VALUES (62, 'https://s.meta.com.vn/data/image/2018/09/24/may-khoan-bua-dewalt-d25032k-710w.jpg',
        'Máy khoan búa Dewalt D25032K', 2580.000, 02, "DeWalt", "Máy khoan búa Dewalt D25032K có tay cầm phụ giúp khoan lỗ chính xác
Dewalt D25032K sử dụng đầu SDS Plus sẽ hỗ trợ bạn tháo lắp mũi khoan bê tông nhanh chóng. Máy khoan bê tông làm việc bền bỉ với công suất 710W. Tốc độ không tải từ 0 - 1.550 vòng/phút sẽ hỗ trợ người dùng khoan bê tông hiệu quả hơn. 
Máy khoan búa Dewalt có núm vặn xoay để chỉnh 2 chế độ: khoan thường, khoan búa. Tính năng đảo chiều sẽ giúp bạn rút mũi khoan ra dễ dàng. 
Máy khoan có đường kính khoan bê tông tối đa là 22mm. Tay cầm phụ có thể xoay 360 độ. Với tay cầm phụ sẽ giúp bạn cầm máy an toàn hơn khi khoan. Ngoài ra tay cầm phụ còn giúp bạn điều khiển mũi khoan đi đúng hướng, lỗ khoan vừa đẹp lại có độ sâu như ý muốn. Khi vận hành máy khoan sẽ phát ra tiếng ồn không quá lớn. Lực đập 2J, vỏ máy làm từ nhựa cho độ bền cao. Cò máy có độ đàn hồi tốt bấm cực kỳ êm ái. 

Lưu ý: Hình ảnh sản phẩm chỉ có tính chất minh họa, chi tiết sản phẩm, màu sắc có thể thay đổi tùy theo sản phẩm thực tế.
", "
Tốc độ đập 0 - 5.680 lần/phút,
Công suất 710W,
Tốc độ không tải 0 - 1.550 vòng/phút,
Đường kính khoan bê tông 22mm,
Lực đập 2J,
Trọng lượng sản phẩm 2,5kg,
Xuất xứ thương hiệu Mỹ,
Sản xuất tại Trung Quốc,
Bảo hành 3 năm,
Chất liệu vỏ máy Nhựa cao cấp,
Độ ồn 100,1 dB(A),
Loại đầu gài SDS-Plus
");


-- Milwaukee
INSERT INTO products (productId, image, productName, unitPrice, categoryId, nameProducer, describle, specifions)
VALUES (65, 'https://s.meta.com.vn/Data/image/2022/04/16/may-khoan-bua-dung-pin-18v-milwaukee-m18-fhx-0x0-1.jpg',
        'Thân máy khoan búa dùng pin 18V Milwaukee M18 FHX-0X0 (chưa pin sạc)', 8070.000, 02, "Milwaukee", "
Giới thiệu thân máy khoan búa dùng pin 18V Milwaukee M18 FHX-0X0
Máy khoan búa dùng pin Milwaukee M18 FHX-0X0 được tích hợp 3 chế độ khoan, khoan búa và đục đáp ứng đa dạng nhu cầu sử dụng của bạn.

Máy được sản xuất và ứng dụng công nghệ Mỹ đảm bảo độ bền và chất lượng vượt trội. Thiết kế cầm tay gọn gàng với trọng lượng chỉ 3.4kg. Vỏ máy được làm từ vật liệu cao cấp có độ bền cao, khả năng chịu lực, chịu nhiệt tốt.

Báng cầm thiết kế thon dài cùng tay cầm phụ chống trơn trượt, cho bạn cảm giác cầm nắm chắc chắn và thoải mái khi làm việc. 

Thiết bị hoạt động với công suất lớn, đường kính mũi khoan 26mm nên có thể sử dụng được trên nhiều vật liệu khác nhau như bê tông, gỗ, tường. Lực đập là 2.7J.

Máy khoan búa Milwaukee M18 FHX-0X0 có tốc độ không tải 1.330 vòng/phút, tốc độ đập 4.800 lần/phút giúp tăng hiệu hiệu suất lao động, tiết kiệm thời gian đáng kể.

Thiết bị có ứng dụng công nghệ Fuel. Chức năng Autostop đảm bảo an toàn lao động khi vận hành. 

Chú ý: Máy không gồm pin sạc. 

Lưu ý: Hình ảnh sản phẩm chỉ có tính chất minh họa, chi tiết sản phẩm, màu sắc có thể thay đổi tùy theo sản phẩm thực tế.
", "
Loại máy Dùng pin,
Tốc độ không tải 1.330 vòng/phút,
Tốc độ đập 0 - 4.800 lần/phút,
Lõi mô tơ Dây đồng,
Mô tơ từ (Cảm ứng),
Lực đập 2,7J,
Đường kính khoan bê tông 26mm,
Điện thế pin 18V,
Trọng lượng sản phẩm 3,4kg,
Xuất xứ thương hiệu Mỹ,
Sản xuất tại Trung Quốc,
Bảo hành 12 tháng
");
INSERT INTO products (productId, image, productName, unitPrice, categoryId, nameProducer, describle, specifions)
VALUES (66, 'https://s.meta.com.vn/Data/image/2019/09/18/may-khoan-bua-milwaukee-m18-chpx-502c-g.jpg',
        'Máy khoan búa Milwaukee M18 CHPX-502C', 16160.000, 02, "Milwaukee", "
Máy khoan búa Milwaukee M18 CHPX-502C kèm sẵn 2 pin 18V 5Ah và sạc. 
Milwaukee là thương hiệu công cụ dụng cụ nổi tiếng của Mỹ chuyên sản xuất máy khoan dùng công nghệ pin sạc nên có tính tiện lợi cao: dễ di chuyển, sử dụng đảm bản an toàn. Máy khoan búa Milwaukee có thể khoan trên nhiều chất liệu như: khoan sắt, khoan bê tông, khoan gỗ. Khả năng khoan của máy như sau:

Đường kính khoan bê tông: 28mm
Đường kính khoan sắt: 13mm
Đường kính khoan gỗ: 30mm
Máy khoan bê tông dùng pin Lithium-ion 18V 5Ah cho khả năng làm việc ổn định và lâu dài. Lực đập là 4.5J, tốc độ đập tối đa 5.000 vòng/phút sẽ giúp bạn khoan bê tông nhanh chóng, tiết kiệm thời gian và công sức cho người dùng.

Máy khoan có tay cầm phụ xoay 360 độ giúp chống rung tốt, đi kèm thêm thước đo độ sâu giúp khoan lỗ được chính xác. Đầu máy có trang bị đèn Led để có thể khoan ở những góc tối dễ dàng. 
Lưu ý: Hình ảnh sản phẩm chỉ có tính chất minh họa, chi tiết sản phẩm, màu sắc có thể thay đổi tùy theo sản phẩm thực tế.
", "
Loại máy Dùng pin,
Tốc độ không tải 0 - 1.350 vòng/phút,
Tốc độ đập 0 - 5.000 lần/phút,
Lõi mô tơ Dây đồng,
Mô tơ từ (Cảm ứng),
Chức năng Đục bê tông, Khoan bê tông,
Lực đập 4.5J,
Đường kính khoan bê tông 28mm,
Đường kính khoan gỗ 30mm,
Đường kính khoan sắt 13mm,
Điện thế pin 18V,
Dung lượng pin 5Ah,
Loại Pin Lithium-ion,
Chiều dài máy 349mm,
Trọng lượng sản phẩm Tính cả pin (4,6kg),
Xuất xứ thương hiệu Mỹ,
Sản xuất tại Trung Quốc,
Bảo hành 12 tháng
");


-- Tolsen
INSERT INTO products (productId, image, productName, unitPrice, categoryId, nameProducer, describle, specifions)
VALUES (69, 'https://s.meta.com.vn/Data/image/2020/11/05/may-khoan-be-tong-tolsen-79513-1.jpg',
        'Máy khoan bê tông Tolsen 79513', 2230.000, 02, "Tolsen", "
Máy khoan bê tông Tolsen 79513 có khả năng khoan bê tông, khoan thép, khoan gỗ
Máy khoan bê tông Tolsen 79513 sử dụng 3 chức năng bao gồm khoan, khoan búa, đục. Bạn có thể sử dụng máy trên các chất liệu khác nhau tùy thuộc vào nhu cầu sử dụng. Khả năng khoan trên bê tông, gỗ, thép thì độ sâu sẽ khác nhau:

Khả năng khoan thép: 13mm.
Khả năng khoan bê tông: 32mm.
Khả năng khoan gỗ tối đa: 42mm.
Máy khoan bê tông 79513 thích hợp sử dụng cho nhu cầu tại gia đình. Tolsen 79513 sử dụng loại đầu cặp SDS plus dễ dàng thay đổi mũi khoan theo nhu cầu sử dụng.

Máy khoan bê tông

Máy khoan Tolsen có khả năng khoan bê tông, khoan thép, khoan gỗ

Máy khoan búa Tolsen hoạt động với công suất 1.500W cho lực đập mạnh mẽ 5.5J giúp bạn thực hiện công việc nhanh chóng, không tốn sức.

Lưu ý: Hình ảnh sản phẩm chỉ có tính chất minh họa, chi tiết sản phẩm, màu sắc có thể thay đổi tùy theo sản phẩm thực tế.Máy khoan búa Tolsen hoạt động với công suất 1.500W cho lực đập mạnh mẽ 5.5J giúp bạn thực hiện công việc nhanh chóng, không tốn sức.

Lưu ý: Hình ảnh sản phẩm chỉ có tính chất minh họa, chi tiết sản phẩm, màu sắc có thể thay đổi tùy theo sản phẩm thực tế.
", "
Loại máy Dùng điện,
Công suất 1.500W,
Nguồn điện áp 220V/50Hz,
Tốc độ đập 4.100 lần/phút,
Chức năng Đục bê tông, Khoan bê tông,
Lực đập 5.5J,
Loại đầu gài SDS-Plus,
Đường kính khoan bê tông 32mm,
Đường kính khoan gỗ 42mm,
Đường kính khoan thép 13mm,
Xuất xứ thương hiệu Trung Quốc,
Sản xuất tại Trung Quốc,
Bảo hành 6 tháng
");
INSERT INTO products (productId, image, productName, unitPrice, categoryId, nameProducer, describle, specifions)
VALUES (70, 'https://s.meta.com.vn/Data/image/2019/05/15/may-khoan-bua-tolsen-79511.jpg', 'Máy khoan búa Tolsen 79511',
        1940.000, 02, "Tolsen", "Máy khoan búa Tolsen 79511 có khả năng khoan trên các chất liệu bê tông, thép, gỗ
Máy khoan búa Tolsen 79511 có khả năng khoan bê tông, khoan thép và khoan gỗ. Trên thân máy trạng bị núm vặn chuyển đổi chế độ khoan, búa, đục phù hợp với công việc.
Khả năng khoan sâu sẽ khác nhau tùy vào từng chất liệu:

Tối đa bằng thép: 13mm.
Tối đa trong bê tông: 26mm
Tối đa trong gỗ: 30 mm
Máy khoan bê tông Tolsen 79511 hoạt động với công suất đầu vào 800W cho tốc độ không tải 1.100 vòng/phút. Lực tác động 3,0J giúp khoan nhanh chóng, tiết kiệm thời gian và sức lao động.

Máy khoan búa 79511 sử dụng loại đầu cặp SDS PLUS dễ dàng thay thế các loại đầu mũi khoan. 

Phụ kiện đi kèm máy khoan búa Tolsen 79511:
2 mũi khoan đục.
3 mũi khoan búa.
1 tay cầm phụ.
Bàn chải carbon 1 cặp.
Thước đo độ sâu 1 cái.
Lưu ý: Hình ảnh sản phẩm chỉ có tính chất minh họa, chi tiết sản phẩm, màu sắc có thể thay đổi tùy theo sản phẩm thực tế.
", "
Loại máy Dùng điện,
Công suất Đầu vào (800W),
Nguồn điện áp 220V - 240V / 50Hz,
Tốc độ không tải 1.100 vòng/phút,
Tốc độ đập 0 - 4.000 lần/phút,
Mô tơ chổi than,
Chức năng Đục bê tông, Khoan bê tông,
Lực đập 3,0J,
Loại đầu gài SDS-Plus,
Đường kính khoan bê tông 26mm,
Đường kính khoan gỗ 30mm,
Đường kính khoan thép 13mm,
Đường kính đầu cặp 13mm,
Kích thước 21cm x 37cm x 37cm,
Xuất xứ thương hiệu Trung Quốc,
Sản xuất tại Trung Quốc
Bảo hành 6 tháng
");


-- Classic
INSERT INTO products (productId, image, productName, unitPrice, categoryId, nameProducer, describle, specifions)
VALUES (72, 'https://s.meta.com.vn/Data/image/2020/01/08/may-khoan-be-tong-classic-cla-5425-g.jpg',
        'Máy khoan bê tông Classic CLA 5425', 1300.000, 02, "Classic", "
Ưu điểm nổi bật của máy khoan bê tông Classic CLA-5425
Classic CLA-5425 là sự kết hợp hoàn hảo của 2 chức năng: Khoan và đục bê tông. Máy khoan bê tông Classic 5425 được sản xuất trên dây chuyền công nghệ và tiêu chuẩn kỹ thuật của Nhật Bản, vận hành với công suất 1.010W giúp khoan và đục bê tông rất hiệu quả và mạnh mẽ.   Tay cầm chính có báng mềm, thiết kế chống trơn trượt giúp bạn cầm nắm chắc chắn, đảm bảo điều khiển đường mũi khoan đi đúng hướng. Máy khoan có thể điều chỉnh nhiều chế độ khoan, độ rung thấp không gây cảm giác mỏi tay và cho những mũi khoan đẹp, chính xác. Máy với khả năng cách nhiệt, cách điện cao, mang đến sự an toàn tuyệt đối cho người dùng.
", "
Loại máy Dùng điện,
Công suất 1.010W,
Nguồn điện áp 220V - 240V / 50Hz - 60Hz,
Tốc độ không tải 880 vòng/phút,
Lõi mô tơ Dây đồng,
Mô tơ chổi than,
Chức năng Đục bê tông, Khoan bê tông,
Đường kính khoan bê tông 26mm,
Trọng lượng sản phẩm 5kg,
Kích thước 26cm x 36cm x 9cm,
Xuất xứ thương hiệu Việt Nam,
Sản xuất tại Trung Quốc,
Bảo hành 3 tháng,
");


-- Sasuke
INSERT INTO products (productId, image, productName, unitPrice, categoryId, nameProducer, describle, specifions)
VALUES (75, 'https://s.meta.com.vn/Data/image/2023/08/07/may-khoan-3-chuc-nang-sasuke-ssk-1126-1.jpg',
        'Máy khoan 3 chức năng Sasuke SSK-1126', 900.000, 02, "Sasuke", "Ưu điểm nổi bật của máy khoan 3 chức năng Sasuke SSK-1126
Sasuke SSK-1126 gồm 3 chức năng: Búa, khoan thường và khoan bê tông. 
Máy khoan búa kèm 3 mũi khoan, 2 mũi đục, hỗ trợ khoan bê tông, đục tường gạch hiệu quả. 
Máy khoan 3 chức năng Sasuke SSK-1126 dùng điện 1 pha, công suất 1050W cùng tốc độ 900 vòng/phút giúp khoan vật liệu rất nhanh. 
Máy khoan bê tông Sasuke có chức năng đảo chiều rút mũi khoan ra khỏi lỗ dễ dàng.
Vỏ máy bằng nhựa cao cấp, kèm tay cầm phụ giảm rung, hộp đựng nhựa có quai xách di chuyển.
Máy sử dụng cò bóp đàn hồi cao, có nút khóa duy trì thao tác khoan liên tục. ", "
Loại máy Dùng điện,
Công suất 1.050W,
Nguồn điện áp 220V - 240V / 50Hz - 60Hz,
Tốc độ không tải 0 - 900 vòng/phút,
Chức năng Đục bê tông, Khoan bê tông,
Đường kính khoan bê tông 26mm,
Xuất xứ thương hiệu Việt Nam,
Sản xuất tại Trung Quốc,
Bảo hành 6 tháng
");


-- Huynhdai
INSERT INTO products (productId, image, productName, unitPrice, categoryId, nameProducer, describle, specifions)
VALUES (77, 'https://s.meta.com.vn/Data/image/2020/10/22/may-khoan-da-nang-hyundai-hdn2-26-01-g2.jpg',
        'Máy khoan đa năng Hyundai HDN2-26', 1670.000, 02, "Huynhdai", "Ưu điểm nổi bật của máy khoan Hyundai HDN2-26
Máy khoan 3 chức năng
Hyundai HDN2-26 là dòng máy khoan 3 chức năng: Khoan thường/khoan búa/đục sẽ đáp ứng nhu cầu sử dụng cho công trình, thợ làm điện nước, thợ xây dựng và gia đình...

Thông số máy khoan mạnh mẽ
Máy khoan bê tông vận hành với công suất 800W. 
Máy khoan sử dụng nguồn điện 220V - 240V.
Trọng lượng máy khoan nặng 3.3kg, trọng lượng cả hộp và phụ kiện là 5.6kg. 
Đường kính mũi khoan là 26mm, sử dụng được đầu chuyển là 13mm (mua thêm). 
Tốc độ không tải đạt 11.000 vòng/phút.
Lực đập 3.2J.
Tốc độ đập: 0 - 4.700 lần/phút.
Hàng chất lượng
Máy khoan Hyundai HDN2-26 cầm rất đầm tay, được đánh giá cao về chất lượng với lõi mô tơ dây đồng cực kỳ bền bỉ. 
Vỏ máy làm từ nhựa cao cấp, cách nhiệt, cách điện, chịu va đập tốt. 
Máy sử dụng mô tơ chổi than, có nút đảo chiều, nút duy trì thao tác khoan.
Trên thân máy có tem chống hàng giả và thương hiệu Hyundai. 
", "
Loại máy Dùng điện,
Công suất 800W,
Nguồn điện áp 220V/50Hz,
Tốc độ không tải 0 - 3.200 vòng/phút,
Tốc độ đập 0 - 4.700 lần/phút,
Lõi mô tơ Dây đồng,
Mô tơ chổi than,
Chức năng Đục bê tông, Khoan bê tông,
Lực đập 3,2J,
Loại đầu gài SDS-Plus,
Đường kính khoan bê tông 26mm,
Đường kính khoan gỗ 30mm,
Đường kính khoan thép 13mm,
Trọng lượng sản phẩm 3,3kg,
Kích thước Dài x Sâu x Cao (37cm x 8cm x 21cm),
Kích thước đóng gói Dài x Rộng x Cao (41cm x 12cm x 29cm),
Trọng lượng bao bì 5,6kg,
Xuất xứ thương hiệu Hàn Quốc,
Sản xuất tại Trung Quốc,
Bảo hành 6 tháng
");
INSERT INTO products (productId, image, productName, unitPrice, categoryId, nameProducer, describle, specifions)
VALUES (78, 'https://s.meta.com.vn/Data/image/2019/05/18/may-khoan-duc-hyundai-hdk26.jpg',
        'Máy khoan đục Hyundai HDK26', 1310.000, 02, "Huynhdai", "
Máy khoan đục Hyundai HDK26 giúp khoan, đục bê tông hiệu quả
Hyundai HDK26 có 2 chức năng: khoan bê tông, đục bê tông với đường kính mũi khoan 13mm, đường kính mũi đục 26mm. Máy khoan bê tông Hyundai có khả năng chịu nhiệt tốt, độ rắn chắc tối ưu, không bị biến dạng khi chịu lực tác động mạnh. Máy khoan đục bê tông Hyundai có công suất 1.050W mạnh mẽ giúp giải quyết công việc nhanh hơn và hiệu quả hơn. Ngoài ra, máy khoan còn trang bị tay nắm phụ giúp người dùng cố định và giữ cân bằng máy một cách dễ dàng, chắc chắn khi đang thao tác.

Máy khoan búa sử dụng mô tơ chổi than dễ thay thế. Cò máy tích hợp ngay ở tay cầm cho thao tác nhấn thuận tiện hơn rất nhiều. 

Lực đập lên tới 4.5J, tốc độ đập nhanh 4.000 lần/phút giúp đục tường, đục bê tông hiệu quả. Trọng lượng máy nhẹ dễ mang theo, thao tác làm việc sẽ trở nên đơn giản hơn. 

Lưu ý: Hình ảnh sản phẩm chỉ có tính chất minh họa, chi tiết sản phẩm, màu sắc có thể thay đổi tùy theo sản phẩm thực tế.
", "
Loại máy Dùng điện,
Công suất 1.050W,
Nguồn điện áp 220V/50Hz,
Tốc độ không tải 0 - 1.000 vòng/phút,
Tốc độ đập 0 - 4.000 lần/phút,
Lõi mô tơ Dây đồng,
Mô tơ chổi than,
Chức năng Đục bê tông, Khoan bê tông,
Lực đập 4.5J,
Đường kính mũi khoan 13mm,
Đường kính mũi đục 26mm,
Trọng lượng sản phẩm 4,5kg,
Trọng lượng bao bì 6,8kg,
Xuất xứ thương hiệu Hàn Quốc,
Sản xuất tại Trung Quốc,
Bảo hành 6 tháng
");


-- Oshima
INSERT INTO products (productId, image, productName, unitPrice, categoryId, nameProducer, describle, specifions)
VALUES (80, 'https://s.meta.com.vn/Data/image/2019/06/18/may-khoan-duc-oshima-3-chuc-nang-k3cn-28.jpg',
        'Máy khoan đục Oshima 3 chức năng K3CN-28', 1430.000, 02, "Oshima", "
Máy khoan đục Oshima 3 chức năng K3CN-28 có khả năng khoan bê tông sâu 28mm, khoan thép 13mm và 300mm trên chất liệu gỗ
Máy khoan đục Oshima 3 chức năng có khả năng khoan, búa, đục cho phép sử dụng trên các chất liệu khác nhau. Máy khoan K3CN-28 có khả năng khoan sâu 28mm trên bê tông, 13mm trên chất liệu thép và 30mm trên chất liệu gỗ.
Máy hoạt động mạnh mẽ với công suất 850W cho tốc độ khoan cực mạnh, khả năng khoan đục lên đến 4.000 lần/phút. Giúp tiết kiệm thời gian và công sức lao động, nâng cao hiệu quả công việc.Máy khoan búa K3CN-28 trang bị 1 mũi đục nhọn, 1 mũi đục lưỡi ngang và 1 chổi than giúp bạn linh động sử dụng máy trong nhiều công việc khác nhau.
Máy khoan Oshima sử dụng chất liệu cao cấp, nhỏ gọn, đi kèm hộp nhựa bảo vệ có khả năng chịu va đập và trầy xước tốt. Cò máy và công tắc được trang bị ngay phần tay cầm giúp bạn dễ dàng thao tác, điều chỉnh máy.
", "
Loại máy Dùng điện,
Công suất 850W,
Nguồn điện áp 220V/50Hz,
Tốc độ không tải 0 - 1.100 vòng/phút,
Tốc độ đập 0 - 4.000 lần/phút,
Mô tơ chổi than,
Chức năng Đục bê tông, Khoan bê tông,
Đường kính khoan bê tông 28mm,
Đường kính khoan gỗ 30mm,
Đường kính khoan thép 13mm,
Trọng lượng sản phẩm 2,9kg,
Xuất xứ thương hiệu Việt Nam,
Sản xuất tại Trung Quốc,
Bảo hành 6 tháng
");


-- Gomes
INSERT INTO products (productId, image, productName, unitPrice, categoryId, nameProducer, describle, specifions)
VALUES (83, 'https://s.meta.com.vn/Data/image/2022/01/27/may-khoan-be-tong-gomes-gb-2603sre.jpg',
        'Máy khoan bê tông Gomes GB-2603', 1170.000, 02, "Gomes", "
Máy khoan búa Gomes GB-2603 có đường kính khoan bê tông tới 26mm
Máy khoan bê tông Gomes GB-2603 là sản phẩm hữu ích của mọi gia đình hay những thợ sửa chữa chuyên nghiệp. Máy khoan búa Gomes GB-2603 thiết kế núm vặn gần đầu máy giúp bạn điều chỉnh tới 3 chế độ khoan: khoan, khoan búa và búa, đáp ứng được nhiều mục đích sử dụng khác nhau của người dùng. 
Vỏ ngoài của máy khoan được làm bằng nhựa cao cấp với gam màu cam phối với màu đen thật nổi bật. Kiểu dáng máy khoan búa mạnh mẽ, cò máy khoan được bố trí ngay gần tay cầm tiện hơn cho quá trình thao tác. Máy khoan bê tông Gomes GB-2603 đi kèm 3 mũi khoan số 6, số 8, số 10 và 2 mũi đục: 1 nhọn, 1 dẹt, giúp bạn không chỉ khoan gỗ, khoan bê tông, khoan sắt mà còn đục những tảng vữa trên tường dễ dàng. 
", "
Loại máy Dùng điện,
Công suất 800W,
Nguồn điện áp 220V/50Hz,
Tốc độ không tải 0 - 1.300 vòng/phút,
Tốc độ đập 0 - 4.400 lần/phút,
Lõi mô tơ Dây đồng,
Mô tơ chổi than,
Chức năng Khoan bê tông, Đục bê tông,
Đường kính khoan bê tông 26mm,
Đường kính mũi khoan 4 - 26mm,
Trọng lượng sản phẩm 2,5kg,
Xuất xứ thương hiệu Trung Quốc,
Sản xuất tại Trung Quốc,
Bảo hành 3 tháng
");
INSERT INTO products (productId, image, productName, unitPrice, categoryId, nameProducer, describle, specifions)
VALUES (84, 'https://s.meta.com.vn/Data/image/2019/12/27/may-khoan-duc-be-tong-gomes-gb-5502-g.jpg',
        'Máy khoan đục bê tông Gomes GB-5502', 1080.000, 02, "Gomes", "
Gomes GB-5502 giúp khoan bê tông với đường kính tối đa 26mm. 
Gomes GB-5502 là chiếc máy khoan bê tông mạnh mẽ, hoạt động với công suất 1010W kết hợp với tốc độ đập từ 0 - 4.300 lần/phút sẽ giúp khoan bê tông hiệu quả hơn, với đường kính bê tông là 26mm. 

Tốc độ của máy khoan khi chạy thử không tải đạt mức 800 vòng/phút sẽ hỗ trợ bạn khoan hay đục bê tông diễn ra nhanh chóng, hoàn thành công việc hiệu quả. Tính năng nổi bật của máy khoan đục bê tông Gomes GB-5502
Máy khoan bê tông Gomes cung cấp lực khoan rất lớn và khỏe nhưng vẫn mang lại cảm giác chắc chắn, êm tay trong suốt quá trình sử dụng vì với thiết kế tối ưu đã giảm thiểu tối đa sự rung lắc trong quá trình thao tác.

Sản phẩm có tính ứng dụng cao trong các ngành công nghiệp, xây dựng, sửa chữa, cơ khí... có thể kết hợp với các mũi khoan chuyên dụng để bạn thực hiện các công việc khoan bê tông, khoan tường một cách dễ dàng, nhanh chóng.

Thân máy được làm từ kim loại sẽ đảm bảo độ cứng chắc, chống va đập tốt khi khoan bê tông. Tay cầm thiết kế với độ ma sát cao, cách điện an toàn giúp người dùng yên tâm làm việc và mang lại cảm giác thoải mái nhất khi thao tác. 

Máy khoan Gomes GB-5502 sử dụng nguồn điện áp 220V/50Hz, khởi động êm, điều khiển tốc độ bằng điện tử hiện đại và tiện lợi, là một dụng cụ khoan tuyệt vời giúp bạn tiết kiệm sức lực tối ưu.

Máy khoan bê tông thiết kế cò súng có độ đàn hồi, bấm nhẹ, không gây đau tay hay mỏi tay khi phải làm việc lâu. 

Lưu ý: Hình ảnh sản phẩm chỉ có tính chất minh họa, chi tiết sản phẩm, màu sắc có thể thay đổi tùy theo sản phẩm thực tế.
", "
Loại máy Dùng điện,
Công suất 1.010W,
Nguồn điện áp 220V/50Hz,
Tốc độ không tải 0 - 800 vòng/phút,
Tốc độ đập 0 - 4.300 lần/phút,
Lõi mô tơ Dây đồng,
Mô tơ chổi than,
Chức năng Đục bê tông, Khoan bê tông,
Đường kính khoan bê tông 26mm,
Đường kính mũi đục 17mm,
Trọng lượng sản phẩm 10kg,
Xuất xứ thương hiệu Trung Quốc,
Sản xuất tại Trung Quốc,
Bảo hành 3 tháng
");



-- máy khoan động lực
-- bosh
INSERT INTO products (productId, image, productName, unitPrice, categoryId, nameProducer, describle, specifions)
VALUES (85, 'https://s.meta.com.vn/Data/image/2018/08/20/bo-may-khoan-bosch-gsb-550-freedom-500.jpg',
        'Bộ máy khoan Bosch GSB 550 Freedom Set 550W và 90 chi tiết-06011A15K1', 1250.000, 03, "bosh", "
Đánh giá bộ máy khoan Bosch GSB 550 Freedom Set và 90 chi tiết
Máy khoan Bosch GSB 550 Freedom đi kèm 90 chi tiết đều là các dụng cụ cần thiết cho công việc sửa chữa như mũi khoan gỗ, mũi khoan tường, mũi khoan kim loại, các đầu đinh, vít, ốc... giúp bạn thực hiện công việc một cách dễ dàng. Tính năng nổi bật bộ set máy khoan động lực Bosch GSB 550 Freedom:
Máy khoan hoạt động với công suất mô tơ mạnh mẽ 550W, tốc độ không tải là 2.800 vòng/phút, tốc độ đập là 41.800 lần/phút giúp khoan gỗ, khoan sắt và khoan tường vô cùng hiệu quả. Khả năng khoan vật liệu: khoan tường với đường kính 13mm, khoan gỗ với đường kính 25mm và khoan sắt thép với đường kính 10mm. Máy khoan GSB 550 còn có chức năng chuyển đổi giữa chế độ khoan động lực và khoan bằng công tắc, khả năng điều khiển tốc độ điện tử, khả năng xoay đảo chiều giúp vặn vít dễ dàng, đem lại sự thuận tiện trong công việc.", "Loại máy Dùng điện,
Tốc độ không tải 2.800 vòng/phút,
Đường kính đầu cặp 13mm,
Lõi mô tơ Dây đồng,
Mô tơ chổi than,
Công suất 550W,
Nguồn điện áp 220V/50Hz,
Tốc độ đập 41.800 lần/phút,
Đường kính khoan gỗ 25mm,
Đường kính khoan sắt 10mm,
Đường kính mũi khoan tường 13mm,
Trọng lượng sản phẩm 1,8kg,
Sản xuất tại Trung Quốc,
Xuất xứ thương hiệu Đức,
Bảo hành 6 tháng");
INSERT INTO products (productId, image, productName, unitPrice, categoryId, nameProducer, describle, specifions)
VALUES (86, 'https://s.meta.com.vn/Data/image/2020/02/19/may-khoan-dong-luc-bosch-gsb-550-re-bo-set.jpg',
        'Máy khoan động lực Bosch GSB 550 - 06011A15K7 (Bộ Set 100 món)', 1320.000, 03, "bosh", "Máy khoan động lực Bosch GSB 550 - 06011A15K7 (Bộ Set 100 món) gồm những phụ kiện gì?
1 máy khoan cầm tay Bosch GSB 550 công suất 550W
1 hộp nhựa
5 mũi khoan với đường kính 4mm / 5mm / 6mm / 8mm / 10mm
1 búa
1 thước cuộn
10 đầu vít pa-ke với các đầu khe khác nhau
1 đầu nối (gắn kết đầu vít pa-ke vào máy khoan)
1 thước thủy
1 mỏ lết
1 đầu nối mở khóa từ tính
1 dao rọc giấy
1 kìm điện
1 thước đo độ sâu
1 tay cầm phụ chống rung
5 mũi khoan sắt thép 2mm / 3mm / 4mm / 5mm / 6 mm
7 đầu điếu mở khóa 4mm / 5mm / 6mm / 7mm / 8mm / 9mm / 10mm
30 ốc vít
30 tắc kê nhựa",
        "
        Loại máy Dùng điện,
        Tốc độ không tải 2.800 vòng/phút,
        Đường kính đầu cặp 13mm,
        Lõi mô tơ Dây đồng,
        Mô tơ chổi than,
        Công suất 550W,
        Nguồn điện áp 220V/50Hz,
        Tốc độ đập 41.800 lần/phút,
        Đường kính khoan thép 10mm,
        Đường kính khoan gỗ 25mm,
        Đường kính khoan bê tông 13mm,
        Trọng lượng sản phẩm 1,8kg,
        Kích thước đóng gói 450mm x 380mm x 150mm,
        Sản xuất tại Trung Quốc,
        Xuất xứ thương hiệu Đức,
        Bảo hành 12 tháng
        ");


-- DeWalt
INSERT INTO products (productId, image, productName, unitPrice, categoryId, nameProducer, describle, specifions)
VALUES (90, 'https://s.meta.com.vn/Data/image/2022/01/27/may-khoan-pin-dong-luc-dewalt-dcd996n-kr-1.jpg',
        'Máy khoan pin động lực Dewalt DCD996N-KR (Không pin và sạc)', 2980.000, 03, "DeWalt", "Máy khoan pin động lực Dewalt DCD996N-KR sử dụng đầu kẹp tự động 1.5 - 13mm
Máy khoan pin động lực đa năng cho phép bạn sử dụng khoan tường, khoan gỗ hoặc bắt vít... Máy khoan Dewalt có khả năng đáp ứng nhu cầu sử dụng trong bất kỳ công việc nào trong gia đình.

Dewalt DCD996N-KR KHÔNG gồm pin và sạc, Quý khách tham khảo mua thêm (nếu cần):

Pin Dewalt DCB184 18V 5.0Ah
Bộ sạc Dewalt DCB115-KR. Với thiết kế nhỏ gọn, động cơ không chổi than giúp bạn thực hiện nhanh chóng công việc ở những vị trí trên cao hoặc góc nhỏ hẹp.Hiệu điện thế pin 18V giúp bạn thực hiện khoan đục trên các vật liệu khác nhau như gỗ, kim loại, bê tông... Sử dụng công nghệ pin XR Li-Ion dễ dàng sạc lại khi pin cạn.",
        "Loại máy Dùng pin,
        Mô tơ từ (Cảm ứng),
        Lõi mô tơ Dây đồng,
        Lực siết/mở vít 95Nm, 66Nm,
        Điện thế pin 18V,
        Đèn chiếu sáng Đèn Led,
        Loại Pin Li-ion,
        Tốc độ đập 0 - 8.600 lần/phút, 25.500 lần/phút, 38.250 lần/phút,
        Tốc độ không tải 0 - 500 vòng/phút, 1.500 vòng/phút, 2.250 vòng/phút,
        Đường kính khoan gỗ 40mm,
        Đường kính khoan thép 16mm,
        Đường kính đầu cặp 1,5mm - 13mm,
        Đường kính mũi khoan tường 13mm,
        Trọng lượng sản phẩm Chưa pin (1,6kg),
        Xuất xứ thương hiệu Mỹ,
        Sản xuất tại Trung Quốc,
        Bảo hành 3 năm");
INSERT INTO products (productId, image, productName, unitPrice, categoryId, nameProducer, describle, specifions)
VALUES (91, 'https://s.meta.com.vn/Data/image/2019/05/11/may-khoan-dewalt-dwd014.jpg', 'Máy khoan DeWalt DWD014',
        1070.000, 03, "DeWalt", "Máy khoan DeWalt DWD014 có chất lượng vượt trội
Máy khoan DeWalt DWD014 có công suất 550W và tốc độ không tải lên đến 2.800 vòng/phút giống như máy khoan Bosch GSB 550, đảm bảo hoạt động rất mạnh mẽ và hiệu quả, giúp bạn có thể khoan trên vật liệu sắt một cách dễ dàng. Với thiết kế cò súng có độ đàn hồi, bấm nhẹ, không gây đau hay mỏi tay, máy khoan DeWalt DWD014 chắc chắn sẽ làm bạn hài lòng. DeWalt DWD014 được làm bằng chất liệu cao cấp, sở hữu độ bền tối ưu, chịu nhiệt tốt và chống ăn mòn nên bạn hoàn toàn có thể yên tâm sử dụng sản phẩm trong một thời gian dài. Ngoài ra, sản phẩm đã qua xử lý nhiệt chống gỉ sét, đảm bảo mũi khoan luôn sáng bóng lâu dài cho dù sản phẩm dù tiếp xúc thường xuyên với điều kiện ẩm ướt hay bất kì thời tiết khắc nghiệt nào.",
        "Tốc độ không tải 0 - 2.800 vòng/phút,
        Công suất 550W,
        Đường kính khoan gỗ 25mm,
        Đường kính khoan sắt 10mm,
        Trọng lượng sản phẩm 1,3kg,
        Xuất xứ thương hiệu Mỹ,
        Sản xuất tại Trung Quốc,
        Bảo hành 3 năm,
        Kích cỡ đầu kẹp 1mm - 10mm");


-- Milwaukee
INSERT INTO products (productId, image, productName, unitPrice, categoryId, nameProducer, describle, specifions)
VALUES (95, 'https://s.meta.com.vn/Data/image/2019/09/06/than-may-khoan-dong-luc-milwaukee-m12-fpd-0-g.jpg',
        'Thân máy khoan động lực Milwaukee M12 FPD-0 (Không pin và sạc)', 3730.000, 03, "Milwaukee", "Ưu điểm của thân máy khoan động lực Milwaukee M12 FPD-0
Milwaukee M12 FPD-0 là dòng máy khoan pin có chức năng khoan và bắt vít. Máy khoan Milwaukee sử dụng pin sạc Li-ion, điện thế 12V. Kiểu dáng máy khoan nhỏ gọn, chỉ nặng 1.5kg cầm thao tác rất nhẹ nhàng.

Sản phẩm chưa bao gồm pin, sạc.

Quý khách có thể đặt mua Pin và sạc phù hợp dưới đây:

Pin 12V 2.0Ah Milwaukee M12B2
Pin 12V 6.0Ah Milwaukee M12B6
Pin 12V 4.0Ah Milwaukee M12B4
Sạc nhanh Pin Milwaukee 12V, 18V M12-18FC
Sạc pin 12V Milwaukee C12C. Đỉnh máy khoan động lực Milwaukee M12 FPD-0 có trang bị nút điều chỉnh tốc độ ở 2 mức:

Mức 1 từ 0 - 450 vòng/phút
Mức 2 từ 0 - 1.700 vòng/phút. 
Máy khoan động lực dùng pin Milwaukee M12 FPD-0 cung cấp khả năng khoan vật liệu như sau:

Đường kính khoan tường: 13m
Đường kính khoan gỗ: 43mm
Đường kính khoan sắt: 13m
Tốc độ đập đạt 25.500 lần/phút cùng lực mô men xoắn tối đa 44Nm giúp khoan bắt vít hiệu quả. ",
        "
        Loại máy Dùng pin,
        Lõi mô tơ Dây đồng,
        Mô tơ từ (Cảm ứng),
        Lực siết/mở vít 44Nm,
        Điện thế pin 12V,
        Đèn chiếu sáng Đèn Led,
        Loại Pin Lithium-ion,
        Tốc độ không tải 0 - 450 vòng/phút, 0 - 1.700 vòng/phút,
        Tốc độ đập 0 - 25.500 lần/phút, 0 - 6.750 lần/phút,
        Đường kính khoan gỗ 43mm,
        Đường kính đầu cặp 1,5mm - 13mm,
        Đường kính khoan sắt 13mm,
        Đường kính mũi khoan tường 13mm,
        Đường kính khoan gạch 13mm,
        Chiều dài máy 16,8cm,
        Trọng lượng sản phẩm 1,5kg,
        Xuất xứ thương hiệu Mỹ,
        Sản xuất tại Trung Quốc,
        Bảo hành 12 tháng
        ");
INSERT INTO products (productId, image, productName, unitPrice, categoryId, nameProducer, describle, specifions)
VALUES (96, 'https://s.meta.com.vn/Data/image/2019/09/16/may-khoan-dong-luc-milwaukee-m18-fpd2-502c.jpg',
        'Máy khoan động lực Milwaukee M18 FPD2-502C', 10460.000, 03, "Milwaukee", "Điểm mạnh của máy khoan động lực Milwaukee M18 FPD2-502C
Tích hợp 3 chức năng kết hợp tiện lợi: khoan tường (động lực), khoan gỗ (khoan thường), vặn vít, đáp ứng hầu hết công việc của bạn
Thương hiệu Milwaukee đến từ Mỹ nổi tiếng với các dòng Power Tools công suất cao
Chạy bằng động cơ không chổi than, giúp kéo dài tuổi thọ máy, thời gian hoạt động tăng cao và tiết kiệm năng lượng
Thiết kế gọn nhẹ nhưng vẫn đảm bảo được khả năng mạnh mẽ của sản phẩm
Tay cầm bọc cao su giúp người dùng thoải mái trong quá trình sử dụng
Đầu kẹp kim loại giúp sức mạnh và độ bền hoạt động được tăng lên nhiều hơn
Dung lượng pin khủng lên đến 5Ah cho thời gian sử dụng lâu dài. Đa năng, tích hợp 3 trong 1
Máy khoan pin Milwaukee M18 FPD2-502C được tích hợp 3 chức năng kết hợp tiện lợi: Khoan tường (động lực), khoan gỗ (khoan thường), vặn vít, đáp ứng hầu hết tất cả các công việc của anh em. Như vậy, chỉ cần sở hữu 1 sản phẩm như thế này là anh em có thể yên tâm sử dụng trong mọi công việc rồi.

Thiết kế chắc chắn, motor không chổi than bền bỉ
Máy khoan động lực Milwaukee có thiết kế chắc chắn với tay cầm chống trơn trượt giúp mọi thao tác trở nên đơn giản hơn, đem lại hiệu quả cao trong công việc. Ưu điểm của máy là motor không chổi than, chạy khỏe, bền, êm hơn dòng motor chổi than.

Tốc độ không tải lớn
Milwaukee M18 FPD2-502C có 2 tốc độ không tải: 0 - 550/2.000 vòng/phút, tốc độ đập: 32.000 lần/phút. Đầu kẹp tự động bằng kim loại: 1.5 - 13mm dễ dàng tùy chỉnh, cho khả năng khoan tường (16mm), gỗ (89mm), sắt (13mm). 

Dung lượng pin khủng
Như anh em cũng đã biết, để đánh giá 1 máy khoan pin có tốt hay không thì còn tùy thuộc vào loại pin và dung lượng pin. Máy khoan động lực Milwaukee M18 FPD2-502C sử dụng pin Lithium-lion đời mới nhất kết hợp với dung lượng pin lớn lên đến 5Ah cho máy chạy khỏe, lâu, sạc nhanh, tăng hiệu quả công việc.", "Loại máy Dùng pin,
Dung lượng pin 5Ah,
Lõi mô tơ Dây đồng,
Mô tơ từ (Cảm ứng),
Lực siết/mở vít Tối đa (135Nm),
Điện thế pin 18V,
Loại Pin Lithium-ion,
Tốc độ không tảiTốc độ cao (0 - 2.000 vòng/phút), Tốc độ thấp (0 - 550 vòng/phút),
Tốc độ đập 32.000 lần/phút,
Đường kính khoan gỗ 89mm,
Đường kính khoan thép 16mm,
Đường kính đầu cặp 1,5mm - 13mm,
Đường kính khoan sắt 13mm,
Đường kính mũi khoan tường 16mm,
Trọng lượng sản phẩm 1,45kg,
Xuất xứ thương hiệu Mỹ,
Sản xuất tại Trung Quốc,
Bảo hành 12 tháng");

INSERT INTO products (productId, image, productName, unitPrice, categoryId, nameProducer, describle, specifions)
VALUES (99, 'https://s.meta.com.vn/Data/image/2019/05/15/may-khoan-tolsen-79502.jpg', 'Máy khoan Tolsen 79502', 940.000,
        03, "Tolsen", "Máy khoan Tolsen 79502 khả năng khoan tối đa thép: 13mm, khoan bê tông 13mm, khoan gỗ 25mm
Máy khoan Tolsen 79502 có 2 chức năng là khoan và búa. Máy khoan bê tông 79502 sử dụng nguồn điện áp 220 - 240V/ 50 - 60Hz có thể dùng ở mọi vị trí chỉ cần đủ nguồn điện. Máy sử dụng đầu kẹp đường kính 13mm, bạn có thể linh hoạt thay thế sử dụng phù hợp với nhu cầu.

Máy khoan Tolsen 79502 với tốc độ tải từ 0 - 2.900 vòng/phút giúp máy hoạt động nhanh, mạnh, bền bỉ. Tốc độ đập từ 0 - 46.400 lần/phút cho khả năng khoan trên các chất liệu khác nhau tốt hơn các loại máy khoan khác.

Khoan tối đa thép: 13mm
Khoan tối đa trong bê tông: 13mm
Khoan tối đa trên chất liệu gỗ: 25mm
Máy khoan Tolsen vỏ được sử dụng chất liệu cao cấp bền bỉ, có khả năng chống trầy xước và va đập tốt. Ngoài ra, máy còn thiết kế thêm phần tay cầm phụ đảm bảo an toàn và chắc chắn khi khoan vật liệu cứng.

Bên thân máy thiết kế nhiều khe thoáng khí đảm bảo động cơ không bị nóng hoặc quá tải.

Lưu ý: Hình ảnh sản phẩm chỉ có tính chất minh họa, chi tiết sản phẩm, màu sắc có thể thay đổi tùy theo sản phẩm thực tế.", "Loại máy Dùng điện,
Tốc độ không tải 0 - 2.900 vòng/phút,
Mô tơ chổi than,
Công suất 710W,
Nguồn điện áp 220V - 240V / 50Hz - 60Hz,
Tốc độ đập 0 - 46.400 vòng/phút,
Đường kính khoan thép 13mm,
Đường kính khoan gỗ 25mm,
Đường kính mũi khoan tường 13mm,
Chiều dài dây nguồn điện 2m,
Đường kính khoan bê tông 13mm,
Sản xuất tại Trung Quốc,
Xuất xứ thương hiệu Trung Quốc,
Bảo hành 6 tháng");


-- Huynhdai
INSERT INTO products (productId, image, productName, unitPrice, categoryId, nameProducer, describle, specifions)
VALUES (100, 'https://s.meta.com.vn/Data/image/2020/09/01/may-khoan-bua-hyundai-hkb213-1.jpg',
        'Máy khoan búa Hyundai HKB213', 869.000, 03, "Huynhdai", "Máy khoan búa Hyundai HKB213 hiệu suất làm việc cao, bảo hành 6 tháng
Bộ sản phẩm máy khoan búa  Hyundai HKB213 được trang bị hộp đựng bằng nhựa cứng cáp với các phụ kiện khoan bao gồm: Mũi khoan búa/khoan chuyên dụng để ứng dụng trên các vật liệu khác nhau như tường gạch/tường bê tông/gỗ,... 

Công suất hoạt động 810W cùng với lực đập 0 - 44.800 lần/phút cho hiệu suất mang lại mạnh mẽ, giúp đường khoan/đập dứt khoát hơn, hoàn thiện nhanh chóng.

Các đường kính khoan của máy khoan cầm tay Hyundai HKB213 bao gồm: 

Khoan thép 10mm.
Khoan bê tông 13mm.
Khoan gỗ 25mm.
→ Phù hợp cho các ứng dụng như xây dựng, sửa chữa trong ngành xây dựng/thiết kế/sửa chữa trong gia đình. Điểm nổi bật khác của máy khoan búa Hyundai HKB213
Máy khoan búa Hyundai HKB213 có báng cầm phụ để sử dụng bằng cả 2 tay, giúp bạn làm việc chắc chắn, chính xác hơn. Máy khoan được bọc bằng vỏ nhựa dẻo không sợ gãy vỡ, bền bỉ.
Máy chạy bằng điện áp 220V - 50Hz nên rất khỏe, hoạt động công suất cao liên tục, cho những đường khoan đẹp nhất, hoàn thiện công việc nhanh chóng.
Nút điều chỉnh bằng núm vặn với các biểu tưởng tương ứng để khoan thường/khoan búa tiện lợi vô cùng.
Đi kèm là nhiều phụ kiện máy khoan, có tay cầm phụ và thước đo độ sâu mũi khoan
Có nút đảo chiều.
Có nút giữ duy trì thao tác khoan liên tục.
Miễn phí vận chuyển nội thành HN/HCM - Bảo hành 6 tháng - 1 đổi 1 nếu thấy lỗi kỹ thuật từ Nhà Sản Xuất trong vòng 3 ngày đầu sau khi nhận hàng.
", "Loại máy Dùng điện,
Tốc độ không tải 0 - 2.800 vòng/phút,
Lõi mô tơ Dây đồng,
Mô tơ chổi than,
Công suất 810W,
Nguồn điện áp 220V/50Hz,
Tốc độ đập 0 - 44.800 lần/phút,
Đường kính khoan thép 10mm,
Đường kính khoan gỗ 25mm,
Đường kính mũi khoan 13mm,
Đường kính mũi khoan tường 13mm,
Trọng lượng sản phẩm 2,1kg,
Trọng lượng bao bì 2,3kg,
Sản xuất tại Trung Quốc,
Xuất xứ thương hiệu Hàn Quốc,
Bảo hành 6 tháng");
INSERT INTO products (productId, image, productName, unitPrice, categoryId, nameProducer, describle, specifions)
VALUES (101, 'https://s.meta.com.vn/Data/image/2019/05/15/may-khoan-bua-hkb113.jpg', 'Máy khoan búa HKB113', 758.000,
        03, "Huynhdai", "Máy khoan búa HKB113 có khả năng khoan thép, khoan gỗ, khoan bê tông
Máy khoan búa HKB113 chuyên nghiệp sẽ giúp công việc khoan thép 10mm, khoan bê tông 13mm, khoan gỗ 25mm dễ dàng như trở bàn tay. Với thao tác đơn giản, chỉ việc cầm máy khoan một cách nhanh chóng. Lực khoan được đẩy lên tối đa giúp bạn tiết kiệm sức lực và thời gian đáng kể. Đây còn được xem là dụng cụ bất di bất dịch không thể thiếu trong tủ đồ của các anh thợ lành nghề.

HKB113 hoạt động công suất 710W, tốc độ không tải 2800 vòng/phút, tốc độ đập 44.800 vòng/phút giúp người dùng dễ dàng hoàn thành công việc nhanh chóng.

Lưu ý: Hình ảnh sản phẩm chỉ có tính chất minh họa, chi tiết sản phẩm, màu sắc có thể thay đổi tùy theo sản phẩm thực tế.", "Loại máy Dùng điện,
Tốc độ không tải 2.800 vòng/phút,
Lõi mô tơ Dây đồng,
Mô tơ chổi than,
Công suất 710W,
Nguồn điện áp 220V/50Hz,
Tốc độ đập 0 - 44.800 lần/phút,
Đường kính khoan thép 10mm,
Đường kính khoan gỗ 25mm,
Đường kính mũi khoan tường 13mm,
Đường kính mũi khoan 13mm,
Trọng lượng sản phẩm 1,95kg,
Trọng lượng bao bì 2,6kg,
Sản xuất tại Trung Quốc,
Xuất xứ thương hiệu Hàn Quốc,
Bảo hành 6 tháng");


-- Oshima
INSERT INTO products (productId, image, productName, unitPrice, categoryId, nameProducer, describle, specifions)
VALUES (105, 'https://s.meta.com.vn/Data/image/2019/09/22/may-khoan-oshima-k550.jpg', 'Máy khoan OSHIMA K550', 758.000,
        03, "Oshima", "Máy khoan OSHIMA K550 có đường kính mũi khoan 13mm bền chắc:
Máy khoan OSHIMA K550 có tay cầm phụ nên khi sử dụng máy tạo cảm giác rất chắc chắn và an toàn, giảm thiểu sự rung lắc, cho mũi khoan chính xác và đẹp mắt. Máy khoan cần tay OSHIMA K550 có công suất 550W mạnh mẽ và tốc độ không tải đạt 0 - 3.000 vòng/phút nên có thể khoan sâu và nhanh các loại vật liệu. Vỏ máy khoan được làm bằng nhựa cao cấp, chịu được lực tác động lớn khi khoan trên các bề mặt vật liệu cứng, sẽ là trợ thủ đắc lực giúp bạn sửa chữa nhà của nhanh chóng và hiệu quả.", "Loại máy Dùng điện,
Tốc độ không tải 0 - 3.000 vòng/phút,
Mô tơ chổi than,
Công suất 550W,
Nguồn điện áp 220V - 240V / 50Hz - 60Hz,
Đường kính mũi khoan 13mm,
Trọng lượng sản phẩm 1,9kg,
Sản xuất tại Trung Quốc,
Xuất xứ thương hiệu Việt Nam,
Bảo hành 3 tháng");


-- Gomes
INSERT INTO products (productId, image, productName, unitPrice, categoryId, nameProducer, describle, specifions)
VALUES (106, 'https://s.meta.com.vn/Data/image/2022/10/08/may-khoan-be-tong-gomes-gb-5506-1.jpg',
        'Máy khoan bê tông Gomes GB-5506', 1420.000, 03, "Gomes", "Máy khoan bê tông Gomes GB-5506 chịu lực tốt, cho khả năng khoan mạnh mẽ.
Máy khoan bê tông Gomes GB-5506 là dòng máy khoan động lực có công suất lớn 1100W nên có khả năng khoan bê tông lên tới 25mm. Gomes GB-5506 vừa có chế độ khoan và chế độ búa, chắc chắn sẽ đem lại hiệu quả công việc cao cho người sử dụng.

Công suất: 1.100W
Nguồn điện: 220V/50hz
Tốc độ không tải: 0 - 900 vòng/phút
Tốc độ búa: 0 - 4.400 lần/phút
Khả năng khoan: 25mm
Trọng lượng: 6,7kg. Lưu ý: Hình ảnh sản phẩm chỉ có tính chất minh họa, chi tiết sản phẩm, màu sắc có thể thay đổi tùy theo sản phẩm thực tế.", "Bảo hành 3 tháng,
Sản xuất tại Trung Quốc,
Xuất xứ thương hiệu Việt Nam");
INSERT INTO products (productId, image, productName, unitPrice, categoryId, nameProducer, describle, specifions)
VALUES (107, 'https://s.meta.com.vn/Data/image/2015/06/19/May-khoan-Gomes-GB-5168a.jpg', 'Máy khoan Gomes GB-5168',
        586.000, 03, "Gomes", "Máy khoan Gomes GB-5168 được trang bị động cơ mô tơ mạnh mẽ có công suất 780W, thích hợp sử dụng trong gia đình lẫn công việc thi công lắp đặt chuyên nghiệp để khoan gỗ, khoan thép.

Thông số kỹ thuật của máy khoan Gomes GB-5168:
Đầu khoan: 13mm
Khoan thép: 13mm
Khoan gỗ: 25mm
Công suất: 780W
Tốc độ không tải: 2300 vòng/phút
Lưu ý: Hình ảnh sản phẩm chỉ có tính chất minh họa, chi tiết sản phẩm, màu sắc có thể thay đổi tùy theo sản phẩm thực tế.
", "Loại máy Dùng điện,
Tốc độ không tải 0 - 2.300 vòng/phút,
Đường kính đầu cặp 13mm,
Mô tơ chổi than,
Công suất 780W,
Nguồn điện áp 220V/50Hz,
Đường kính khoan thép 13mm,
Đường kính khoan gỗ 25mm,
Sản xuất tại Trung Quốc,
Xuất xứ thương hiệu Trung Quốc,
Bảo hành 3 tháng");



-- máy khoan mini
-- Bosh
INSERT INTO products (productId, image, productName, unitPrice, categoryId, nameProducer, describle, specifions)
VALUES (109, 'https://s.meta.com.vn/Data/image/2020/03/18/may-khoan-bosch-gbm-320.jpg', 'Máy khoan Bosch GBM 320',
        699.000, 05, "Bosh", "Đặc điểm nổi bật của sản phẩm
Công suất 320W giúp khoan dễ dàng trên các chất liệu gỗ và thép.

Chức năng đảo chiều mũi khoan linh hoạt.

Động cơ chổi than mạnh mẽ, khoan được trên nhiều vật liệu khác nhau.

Thiết kế nhiều khe tản nhiệt giúp làm mát động cơ.

Đánh giá máy khoan Bosch GBM 320
Bosch GBM 320 là dòng máy khoan cầm tay gia đình đến từ thương hiệu Bosch nổi tiếng của Đức, được sản xuất tại Trung Quốc. Sản phẩm sở hữu công suất lên tới 320W cùng tốc độ không tải 4.200 vòng/phút, giúp bạn dễ dàng thực hiện công việc khoan lắp trong gia đình hoặc các công việc của thợ sửa chữa, xây dựng…", "Loại máy Dùng điện,
Tốc độ không tải 0 - 4.200 vòng/phút,
Đường kính đầu cặp 6,5mm,
Lõi mô tơ Dây đồng,
Mô tơ chổi than,
Công suất 320W,
Nguồn điện áp 220V - 240V / 50Hz - 60Hz,
Đường kính khoan thép 6,5mm,
Đường kính khoan gỗ 13mm,
Kích thước Rông x Dài x Cao (55mm x 160mm x 175mm),
Trọng lượng sản phẩm 1kg,
Sản xuất tại Trung Quốc,
Xuất xứ thương hiệu Đức,
Bảo hành 6 tháng");
INSERT INTO products (productId, image, productName, unitPrice, categoryId, nameProducer, describle, specifions)
VALUES (110, 'https://s.meta.com.vn/Data/image/2020/03/17/may-khoan-xoay-bosch-gbm-13-re.jpg',
        'Máy khoan xoay Bosch GBM 13 RE', 1380.000, 05, "Bosh", "Đặc điểm nổi bật của sản phẩm
Công suất 600W giúp khoan tốt trên thép, gỗ, nhôm…

Motor chổi than mạnh mẽ.

1 chế độ khoan thường với tốc độ không tải lên tới 2.600 vòng/phút, mô men xoắn định mức 20Nm.

Nút đảo chiều với 3 chế độ khoan ra, khoan vô, khóa.

Thiết kế nhỏ gọn, trọng lượng 1,7kg, dễ cầm nắm, thao tác.

Đánh giá máy khoan Bosch GBM 13 RE
Bosch GBM 13 RE là dòng máy khoan HEAVY DUTY của thương hiệu Bosch, được ra mắt năm 2017. Dòng máy này hội tụ đầy đủ 3 yếu tố gồm sức mạnh, độ bền và hiệu suất. Sản phẩm được thiết kế dành riêng cho các chuyên gia, thợ lành nghề với độ chính xác gần như tuyệt đối trong mỗi mũi khoan gỗ hoặc thép... Bạn cũng có thể sử dụng máy khoan để khoan hoặc sửa chữa các đồ dùng trong gia đình rất tiện dụng.

Đánh giá máy khoan Bosch GBM 13 RE

Xem thêm: Những lý do mà bạn không thể bỏ qua máy khoan Bosch

Cấu tạo từ các vật liệu cao cấp
Giống như các model máy khoan khác của Bosch, máy khoan Bosch GBM 13 RE được cấu tạo từ chất liệu hợp kim thép và nhựa cao cấp, bền bỉ, có khả năng chịu va đập tốt, chịu được các điều kiện làm việc khắc nghiệt. Đặc biệt, phần tay cầm của máy được bọc lớp nhựa nhám chống trơn trượt, giúp bạn thực hiện các thao tác chính xác hơn.

Công suất 600W, khoan được trên nhiều chất liệu
Máy khoan GBM 13 RE chỉ có 1 chế độ khoan thường với tốc độ không tải lên tới 2.600 vòng/phút, công suất hoạt động lên tới 600W, giúp máy có thể khoan trên nhiều vật liệu khác nhau như thép, gỗ, nhôm… Trong đó đường kính mũi khoan như sau:

Đường kính khoan tối đa trên thép là 13mm.

Đường kính khoan tối đa trên gỗ là 30mm.

Đường kính khoan tối đa trên nhôm là 13mm.

Ngoài ra, máy khoan Bosch GBM 13RE 600W còn có thể vặn vít nhanh và chính xác với momen xoắn định mức là 20Nm.

Cò máy điều chỉnh tốc độ vô cấp
Máy khoan Bosch GBM 13 RE được trang bị 1 cò điều tốc. Đây là bộ phận được tích hợp trên hầu hết các dòng máy khoan hiện nay, giúp bạn điều chỉnh tốc độ khoan theo ý muốn. Cò điều tốc của máy khoan GBM 13 RE có độ đàn hồi cao nên bạn chỉ cần bấm nhẹ để sử dụng, không hề gây đau hay mỏi tay. Đặc biệt, bộ phận này được thiết kế dưới tay cầm nên giúp bạn thao tác thuận tiện hơn.

Máy khoan xoay Bosch GBM 13 RE có cò máy điều chỉnh tốc độ vô cấp

Nút đảo chiều với 3 tính năng khoan ra, khoan vô, khóa
Giống nhiều model máy khoan Bosch khác, GBM 13 RE cũng được trang bị 1 nút đảo chiều tích hợp 3 tính năng khoan ra, khoan vô và khóa cò. Trong đó, tính năng khoan ra, khoan vô sẽ được sử dụng khi bạn khoan vào hoặc tháo mũi khoan. Còn khi nút đảo chiều ở vị trí chính giữa máy thì tính năng khóa cò sẽ được thiết lập, lúc này bạn có nhấn cò máy thì máy cũng sẽ không chạy.

Máy khoan Bosch GBM 13 RE có nút đảo chiều với 3 tính năng khoan ra, khoan vô, khóa

Xem thêm: Nguyên tắc sử dụng máy khoan cầm tay

Đầu cặp kim loại mạnh mẽ với đường kính cặp tối đa 13mm
Đầu cặp của máy khoan GBM 13 RE được làm bằng chất liệu kim loại cao cấp, có khả năng siết chặt mũi khoan với đường kính tối đa là 13mm, tối thiểu là 1,5mm. Nhờ vậy, bạn sẽ thực hiện khoan, đục trên những loại chất liệu cứng một cách chắc chắn, dễ dàng hơn.

Máy khoan xoay Bosch GBM 13 RE có đầu cặp phù hợp với nhiều loại mũi khoan

Động cơ chổi than hoạt động mạnh mẽ
Máy khoan cầm tay Bosch GBM 13 RE là dòng máy khoan được trang bị motor chổi than giúp máy trở nên gọn nhẹ và linh hoạt hơn. Động cơ chổi than sẽ giúp công suất làm việc của máy luôn đạt ở mức tối đa.

Nặng 1,7kg, thiết kế nhỏ gọn, chắc chắn
Với thiết kế nhỏ gọn nhưng chắc chắn đặc trưng của các dòng máy khoan cầm tay Bosch, máy khoan xoay Bosch GBM 13 RE sở hữu kích thước chỉ 18cm x 23cm x 4cm, trọng lượng 1,7kg, giúp bạn dễ dàng thực hiện các thao tác khoan ở những nơi chật hẹp hay khó khăn nhất. Đặc biệt, máy còn có thiết kế công thái học nên bạn sẽ không bị mỏi tay khi phải khoan trong thời gian dài.

Kích thước máy khoan Bosch GBM 13 RE

Hiện máy khoan xoay Bosch GBM 13 RE đang được bán với mức giá là 1.380.000 đồng, rất phù hợp với túi tiền người tiêu dùng Việt. Nếu bạn đang cần 1 chiếc máy khoan chuyên nghiệp, có khả năng khoan và bắt vít tốt thì hãy “tậu” ngay sản phẩm này nhé!

Lưu ý: Hiện nay trên thị trường xuất hiện nhiều hàng giả, hàng nhái. Sản phẩm tại META có tem chống hàng giả nên đây là địa chỉ uy tín quý khách nên tham khảo.

Tem chống hàng giả của máy khoan Bosch GBM 13 RE

Tem chống hàng giả trên máy khoan Bosch khi mua hàng tại META.vn

Xem thêm: Cách phân biệt hàng thật - hàng giả với dòng máy khoan Bosch

Lưu ý:

Quý khách vui lòng tải ứng dụng Bosch BeConnected để xác minh nguồn gốc sản phẩm ngay trên điện thoại, cũng như tra cứu thông số kỹ thuật, thời gian bảo hành, tìm kiếm trung tâm bảo hành,... của từng sản phẩm theo thời gian thực.
Hình ảnh sản phẩm chỉ có tính chất minh họa, chi tiết sản phẩm, màu sắc có thể thay đổi tùy theo sản phẩm thực tế.", "Loại máy Dùng điện,
Tốc độ không tải 0 - 2.600 vòng/phút,
Đường kính đầu cặp 1,5mm - 13mm,
Lõi mô tơ Dây đồng,
Mô tơ chổi than,
Công suất Đầu ra (360W), Đầu vào (600W),
Nguồn điện áp 220V - 240V / 50Hz - 60Hz,
Đường kính khoan thép 13mm,
Đường kính khoan gỗ 30mm,
Đường kính khoan nhôm 13mm,
Mô men xoắn Định mức (20Nm),
Kích thước 18cm x 23cm x 4cm,
Trọng lượng sản phẩm 1,7kg,
Sản xuất tại Malaysia,
Xuất xứ thương hiệu Đức,
Bảo hành 12 tháng");


-- Makute
INSERT INTO products (productId, image, productName, unitPrice, categoryId, nameProducer, describle, specifions)
VALUES (112, 'https://s.meta.com.vn/Data/image/2022/08/05/may-khoan-dien-makute-ed010-g.jpg',
        'Máy khoan điện Makute ED010', 435.000, 05, "Makute", "Ưu điểm nổi bật của máy khoan điện Makute ED010
Máy khoan cầm tay Makute ED010 dùng điện 220V - 240V/50hz - 60Hz giúp khoan lỗ bền bỉ hơn. Makute ED010 thiết kế lớp vỏ màu xanh là nhựa cao cấp, cách điện tốt, đảm bảo an toàn khi làm việc. Máy khoan Makute ED010 hoạt động với công suất 450W mạnh mẽ cùng tốc độ không tải đạt tối đa 3.000 vòng/phút giúp khoan lỗ nhanh trên gỗ, sắt. 

Lõi mô tơ được quấn bằng đồng nguyên chất 100% giúp máy có thể chịu được nhiệt độ lên đến 200 độ C, không lo quá tải nhiệt. 

Máy khoan có cần gạt đảo chiều bắt vít khi cần hoặc rút các mũi khoan nằm sâu trong vật liệu dễ dàng. 

Makute ED010 có thiết kế nhỏ gọn, trọng lượng nhẹ cầm thao tác thoải mái, dễ mang theo khi đi làm việc. Máy sử dụng đầu kẹp mũi tự động, có thể tháo lắp mũi khoan nhanh chóng. 

Máy khoan có chiết áp xoay điều chỉnh tốc độ khoan từ 0 - 3.000 vòng/phút, có nút khóa cò duy trì khoan liên tục. 

Lưu ý: Hình ảnh sản phẩm chỉ có tính chất minh họa, chi tiết sản phẩm, màu sắc có thể thay đổi tùy theo sản phẩm thực tế.", "Loại máy Dùng điện,
Tốc độ không tải 0 - 3.000 vòng/phút,
Đường kính đầu cặp 10mm,
Lõi mô tơ Dây đồng,
Mô tơ chổi than,
Công suất 450W,
Nguồn điện áp 220V - 240V / 50Hz - 60Hz,
Sản xuất tại Trung Quốc,
Xuất xứ thương hiệu Trung Quốc,
Bảo hành 4 tháng");


-- DeWalt
INSERT INTO products (productId, image, productName, unitPrice, categoryId, nameProducer, describle, specifions)
VALUES (113, 'https://s.meta.com.vn/Data/image/2023/09/03/may-khoan-cam-tay-550w-dewalt-dwd014s-qs-g.jpg',
        'Máy khoan cầm tay 550W Dewalt DWD014S-QS', 1245.000, 05, "DeWalt", "Ưu điểm nổi bật của máy khoan cầm tay 550W Dewalt DWD014S-QS
Công suất mạnh mẽ
Máy khoan có công suất mô tơ là 550W, tốc độ không tải tối đa 2.800 vòng/phút giúp khoan gỗ với đường kính là 28mm và khoan sắt là 10mm. Cấu tạo đơn giản
Máy khoan Dewalt DWD014S-QS được trang bị nút khóa cò khoan để khoan liên tục.  
Chế độ đảo chiều dễ dàng tháo mũi khoan ra khỏi lỗ.
Chế độ điều khiển tốc độ điện tử ở công tắc cho phép khoan ở nhiều chế độ khác nhau đáp ứng đa dạng các nhu cầu công việc.
Dùng điện vận hành bền bỉ
Dewalt DWD014S-QS dùng điện áp 1 pha 220V giúp vận hành ổn định và liên tục trong thời gian dài. Tay cầm chắc chắn, vừa vặn, chống trơn trượt tốt. 

Máy khoan mini có vỏ bọc nhựa, chỉ nặng 1.3kg nên cầm thao tác không bị mỏi tay khi người dùng cầm máy khoan làm việc, đồng thời thuận tiện cho việc mang theo.  

Lưu ý: Hình ảnh sản phẩm chỉ có tính chất minh họa, chi tiết sản phẩm, màu sắc có thể thay đổi tùy theo sản phẩm thực tế.", "Loại máy Dùng điện,
Tốc độ không tải 0 - 2.800 vòng/phút,
Đường kính đầu cặp 10mm,
Công suất 550W,
Nguồn điện áp 220V - 240V,
Đường kính khoan gỗ 25mm,
Đường kính khoan sắt 10mm,
Sản xuất tại Trung Quốc,
Xuất xứ thương hiệu Mỹ,
Bảo hành 3 năm");


-- Oshima
INSERT INTO products (productId, image, productName, unitPrice, categoryId, nameProducer, describle, specifions)
VALUES (115, 'https://s.meta.com.vn/Data/image/2023/07/28/may-khoan-oshima-k450-g.jpg', 'Máy khoan Oshima K450',
        720.000, 05, "Oshima", "Ưu điểm nổi bật của máy khoan Oshima K450
Oshima K450 có kiểu dáng cầm tay nhỏ gọn, cầm nắm vừa tay, chỉ nặng 1.3kg dễ dàng thao tác. 
Vỏ máy sử dụng loại nhựa cao cấp, chống va đập tốt.
Đầu cặp kim loại có khóa giữ mũi khoan, mũi vít chắc hơn. 
Máy khoan Oshima hoạt động với công suất 450W giúp khoan thép, gỗ cực khỏe. 
Máy khoan mini dùng điện 220V, vỏ máy cách điện kép và cách nhiệt đảm bảo an toàn khi làm việc. 
Máy có tấm chải xoay được tích hợp sẵn sẽ đảm bảo mức công suất hoạt động không thay đổi khi bạn thực hiện các thao tác lùi hoặc tiến. 
Máy khoan sử dụng cò bóp bố trí ngay dưới tay cầm giúp điều khiển máy dễ dàng.
Tay cầm vừa vặn, chắc chắn với thiết kế chống trượt, chống rung đảm bảo lỗ khoan được chính xác. ", "Loại máy Dùng điện,
Tốc độ không tải 0 - 2.800 vòng/phút,
Lõi mô tơ Dây đồng,
Mô tơ chổi than,
Công suất 450W,
Nguồn điện áp 220V/50Hz,
Đường kính mũi khoan 10mm,
Trọng lượng sản phẩm 1.3kg,
Sản xuất tại Trung Quốc,
Xuất xứ thương hiệu Việt Nam,
Bảo hành 12 tháng");


-- Gomes
INSERT INTO products (productId, image, productName, unitPrice, categoryId, nameProducer, describle, specifions)
VALUES (116, 'https://s.meta.com.vn/Data/image/2020/03/18/may-khoan-gomes-gb-5515-710w.jpg',
        'Máy khoan Gomes GB-5515 (710W)', 596.000, 05, "Gomes", "Máy khoan Gomes GB-5515 cho khả năng khoan gỗ, khoan thép mạnh mẽ.
Máy khoan Gomes GB-5515 thiết kế nhỏ gọn giúp bạn dễ dàng mang theo, di chuyển hay cất giữ. Báng cầm mềm, vừa vặn, có độ ma sát cao, giúp thao tác khoan được dễ dàng mà không mỏi hay đau tay khi phải làm việc lâu.

Gomes GB-5515 có thể sử dụng được cho cả người thuận tay phải và người thuận tay trái rất tiện lợi.

Với công suất cực lớn 710W và tốc độ không tải lên đến 2800 vòng/phút, máy hoạt động rất mạnh mẽ và hiệu quả giúp bạn có thể khoan trên nhiều bề mặt chất liệu cứng như gỗ, thép… một cách dễ dàng. Thêm vào đó, với tính năng cách nhiệt, cách điện hai lớp, chiếc máy khoan đảm bảo an toàn tuyệt đối cho người sử dụng khi bị ra mồ hôi tay hay làm việc trong điều kiện bất lợi, khó khăn. Thông số kỹ thuật của máy khoan Gomes GB-5515:
Khoan: 13mm
Tính năng: Thép 13mm, gỗ 25mm
Công suất: 710W
Tốc độ không tải: 0 - 2800 vòng/phút
Lưu ý: Hình ảnh sản phẩm chỉ có tính chất minh họa, chi tiết sản phẩm, màu sắc có thể thay đổi tùy theo sản phẩm thực tế.", "Loại máy Dùng điện,
Tốc độ không tải 0 - 2.800 vòng/phút,
Đường kính đầu cặp 13mm,
Mô tơ chổi than,
Công suất 710W,
Đường kính khoan thép 13mm,
Đường kính khoan gỗ 25mm,
Sản xuất tại Trung Quốc,
Xuất xứ thương hiệu Việt Nam,
Bảo hành 3 tháng");



-- Pin máy khoan
-- Bosh
INSERT INTO products (productId, image, productName, unitPrice, categoryId, nameProducer, describle, specifions)
VALUES (119, 'https://s.meta.com.vn/Data/image/2020/12/25/pin-bosch-12v-2-0ah-g.jpg',
        'Pin Bosch 12V 2.0Ah 1600A00F6X (1607A350C5)', 697.000, 06, "Bosh", "Thông tin chi tiết về pin Bosch 12V 2.0Ah 1600A00F6X
Pin Bosch 12V - 2.0Ah dùng cho các máy khoan pin, máy bắn vít dùng pin sau:

Máy khoan vặn vít dùng pin GSR 120-LI
Máy khoan pin vặn vít Bosch GSR 120-LI GEN II (06019G80K2 - Kèm bộ phụ kiện)
Máy vặn vít dùng pin Bosch GDR 120-LI...
Pin sạc Bosch 12V - 2.0Ah khi sạc đầy sẽ giúp máy móc dùng pin của Bosch làm việc hiệu quả ở nơi không có nguồn điện. Pin có thiết kế kích thước nhỏ gọn, thời gian sạc pin nhanh, chỉ cần sạc đến 70% là có thể sử dụng được pin. Pin có trọng lượng chỉ nặng 180g, được tích hợp công nghệ Coolpack trong pin giúp:

Bảo vệ chống quá nhiệt
Bảo vệ chống tải
Bảo vệ chống xả cạn
Hệ thống dẫn nhiệt (HCH) sẽ giữ cho nhiệt độ của pin không nóng lên, không lo quá tải nhiệt, rất an toàn khi sử dụng.
Pin Bosch 12V - 2.0Ah là dòng pin Li-ion có độ bền gấp 4 lần so với pin thường.   

Lưu ý:

Quý khách vui lòng tải ứng dụng Bosch BeConnected để xác minh nguồn gốc sản phẩm ngay trên điện thoại, cũng như tra cứu thông số kỹ thuật, thời gian bảo hành, tìm kiếm trung tâm bảo hành,... của từng sản phẩm theo thời gian thực.
Hình ảnh sản phẩm chỉ có tính chất minh họa, chi tiết sản phẩm, màu sắc có thể thay đổi tùy theo sản phẩm thực tế.", "Trọng lượng sản phẩm  180g,
Điện thế pin 12V,
Bảo hành 6 tháng,
Sản xuất tại Trung Quốc,
Xuất xứ thương hiệu Đức");
INSERT INTO products (productId, image, productName, unitPrice, categoryId, nameProducer, describle, specifions)
VALUES (120, 'https://s.meta.com.vn/Data/image/2019/05/15/pin-bosch-18v-4-0ah.jpg', 'Pin Bosch 18V 4.0Ah 1600A00163',
        1980.000, 06, "Bosh", "Pin Bosch 18V 4.0Ah 1600A00163 sử dụng cho các loại máy khoan pin 18V
Pin Bosch 18V 4.0Ah là phụ kiện không thể thiếu được đối với các dòng máy khoan pin của thương hiệu Bosch. Máy được ứng dụng đối với các dòng máy khoan GSR 180, GSB 180, các máy pin 18V như:

Máy khoan vặn vít dùng pin Bosch GSR 180-Li - 3.190.000đ
Máy khoan dùng pin Bosch GSB 180-LI - 3.350.000đ
Máy vặn vít động lực dùng pin Bosch GDX 18V Li - 9.150.000đ
Máy vặn vít động lực dùng pin Bosch GDR 18V-LI - 8.990.000đ.
Loại pin này có khả năng hoạt động mạnh mẽ, kéo dài tuổi thọ hơn 65% so với các mẫu pin dung lượng 3Ah.

Pin được ứng dụng công nghệ Coolpack - đây là một công nghệ hiện đại giúp giảm nhiệt, kiểm soát tuyệt đối nhiệt độ của pin. Bạn sẽ có thể yên tâm pin luôn được mát trong suốt quá trình sử dụng ngay cả trong thời gian dài. Đây cùng là yếu tố để giúp pin có tuổi thị cao hơn 100% các dòng pin đế đen.

Thông số kỹ thuật của pin đế đỏ Bosch 18V 4Ah:

 Điện thế pin: 18V
Dung lượng: 4Ah
Công nghệ pin: Lion, Coolpack
Loại pin: Đế đỏ chuyên nghiệp.
Lưu ý:

Quý khách vui lòng tải ứng dụng Bosch BeConnected để xác minh nguồn gốc sản phẩm ngay trên điện thoại, cũng như tra cứu thông số kỹ thuật, thời gian bảo hành, tìm kiếm trung tâm bảo hành,... của từng sản phẩm theo thời gian thực.
Hình ảnh sản phẩm chỉ có tính chất minh họa, chi tiết sản phẩm, màu sắc có thể thay đổi tùy theo sản phẩm thực tế.
", "Sản xuất tại Trung Quốc,
Xuất xứ thương hiệu Đức");


-- Makute
INSERT INTO products (productId, image, productName, unitPrice, categoryId, nameProducer, describle, specifions)
VALUES (127, 'https://s.meta.com.vn/Data/image/2023/06/30/pin-makute-20v-5420-40a.jpg', 'Pin Makute 20V 5420-40A - 4Ah',
        850.000, 06, "Makute", "Thông tin chi tiết về pin Makute 20V 5420-40A/40C
Makute 5420-40A/40C có điện thế pin 20V, dung lượng 4.000mAh. 
Pin Li-ion cấp điện ổn định, tuổi thọ cao. 
Pin Makute 20V 5420-40A/40C có kiểu dáng nhỏ gọn tiện lợi khi mang theo. 
Pin có vỏ bọc chắc chắn, chống va đập tốt.
Pin Li-ion Makute dùng cho công cụ dụng cụ dùng pin 20V Makute.
Lưu ý: Hình ảnh sản phẩm chỉ có tính chất minh họa, chi tiết sản phẩm, màu sắc có thể thay đổi tùy theo sản phẩm thực tế.", "Điện thế pin 20V,
Dung lượng pin 4Ah,
Loại Pin Li-ion,
Sản xuất tại Trung Quốc,
Xuất xứ thương hiệu Trung Quốc");


-- DeWalt
INSERT INTO products (productId, image, productName, unitPrice, categoryId, nameProducer, describle, specifions)
VALUES (128, 'https://s.meta.com.vn/Data/image/2022/05/24/pin-li-ion-20v-4-0ah-dewalt-dcb240-b1-g.jpg',
        'Pin Li-ion 20V-4.0Ah Dewalt DCB240-B1', 1400.000, 06, "DeWalt", "Giới thiệu chi tiết về pin Li-ion 20V-4.0Ah Dewalt DCB240-B1
Dewalt DCB240-B1 sử dụng được cho tất cả các dòng máy Dewalt dùng pin điện áp 20V. Pin Li-ion 20V Dewalt DCB240-B1 có dung lượng 4Ah giúp làm việc được lâu hơn. Pin Li-ion Dewalt được áp dụng công nghệ của Mỹ cho độ bền cao.Vỏ ngoài của pin sạc được làm từ nhựa cao cấp, đảm bảo độ bền. Pin phóng điện khỏe giúp máy móc dùng pin Dewalt làm việc đạt hiệu quả cao.  ", "Chất liệu Nhựa cao cấp,
Điện thế pin 20V,
Dung lượng pin 4Ah,
Công suất Đầu ra (80W),
Loại Pin Li-ion,
Bảo hành 12 tháng,
Sản xuất tại Trung Quốc,
Xuất xứ thương hiệu Mỹ");
INSERT INTO products (productId, image, productName, unitPrice, categoryId, nameProducer, describle, specifions)
VALUES (129, 'https://s.meta.com.vn/Data/image/2019/05/06/pin-dewalt-dcb182-b1-18v-4-0ah-1.jpg',
        'Pin Dewalt DCB182-B1 18V-4.0Ah', 1270.000, 06, "DeWalt", "Pin Dewalt DCB184 18V 5.0Ah - Phụ kiện của máy khoan bê tông dùng pin DeWalt
Pin Dewalt DCB184 dùng cho máy khoan bê tông dùng pin DeWalt 18V DCH253KN (Solo). Pin có trọng lượng nhẹ, thiết kế nhỏ gọn dễ dàng mang theo và lắp đặt vào máy khoan bê tông dễ dàng. 

Pin Dewalt DCB184 có điện thế pin 18V, dung lượng pin 5.0Ah cho thời gian làm việc liên tục trong thời gian dài. 

Đây là dòng pin sạc Li-ion có tuổi thọ sử dụng cao, làm từ nhựa cao cấp chịu va đập tốt. ", "Trọng lượng sản phẩm 499g,
Chất liệu Nhựa cao cấp,
Điện thế pin 18V,
Dung lượng pin 5Ah,
Kích thước bao bì 65cm x 45cm x 12cm,
Điện thế 18V,
Loại Pin Li-ion,
Bảo hành 12 tháng,
Sản xuất tại Trung Quốc,
Xuất xứ thương hiệu Mỹ");


-- Milwaukee
INSERT INTO products (productId, image, productName, unitPrice, categoryId, nameProducer, describle, specifions)
VALUES (135, 'https://s.meta.com.vn/Data/image/2019/09/20/pin-li-ion-18v-5-0ah-milwaukee-m18b5-g.jpg',
        'Pin Li-ion 18V 5.0Ah Milwaukee M18B5', 2010.000, 06, "Milwaukee", "Pin Li-ion 18V Milwaukee M18B5 có dung lượng pin lên tới 5.0Ah.
Pin Milwaukee M18B5 có dung lượng pin 5Ah, khi sạc đầy giúp bạn làm việc được lâu hơn, đảm bảo yêu cầu công việc. Điện thế pin 18V cung cấp điện năng ổn định và mạnh mẽ để máy công cụ hoạt động đúng công suất, mang lại hiệu suất công việc cao. Pin Li-ion 18V Milwaukee M18B5 có chức năng bảo vệ quá tải giúp kéo dài độ bền cho các thiết bị sử dụng. Vỏ được làm từ nhựa cao cấp chống va đập tốt. Cấu trúc pin thiết kế chắc chắn, dễ tháo lắp vào các thân máy công cụ.

Pin sạc Milwaukee M18B5 thường dùng cho máy khoan bắt vít, máy khoan bê tông, máy mài góc, máy siết bu lông... dùng pin của hãng Milwaukee.

Lưu ý: Hình ảnh sản phẩm chỉ có tính chất minh họa, chi tiết sản phẩm, màu sắc có thể thay đổi tùy theo sản phẩm thực tế.", "Điện thế pin 18V,
Dung lượng pin 5Ah,
Loại Pin Li-ion,
Bảo hành 12 tháng,
Sản xuất tại Trung Quốc,
Xuất xứ thương hiệu Mỹ");
INSERT INTO products (productId, image, productName, unitPrice, categoryId, nameProducer, describle, specifions)
VALUES (136, 'https://s.meta.com.vn/Data/image/2019/09/14/pin-12v-2-0ah-milwaukee-m12b2-t1.jpg',
        'Pin 12V 2.0Ah Milwaukee M12B2', 778.000, 06, "Milwaukee", "Thông tin chi tiết về pin Makute 20V 5420-40A/40C
Makute 5420-40A/40C có điện thế pin 20V, dung lượng 4.000mAh. 
Pin Li-ion cấp điện ổn định, tuổi thọ cao. 
Pin Makute 20V 5420-40A/40C có kiểu dáng nhỏ gọn tiện lợi khi mang theo. 
Pin có vỏ bọc chắc chắn, chống va đập tốt.
Pin Li-ion Makute dùng cho công cụ dụng cụ dùng pin 20V Makute.
Lưu ý: Hình ảnh sản phẩm chỉ có tính chất minh họa, chi tiết sản phẩm, màu sắc có thể thay đổi tùy theo sản phẩm thực tế.", "Điện thế pin 20V,
Dung lượng pin 4Ah,
Loại Pin Li-ion,
Sản xuất tại Trung Quốc,
Xuất xứ thương hiệu Trung Quốc");


-- Tolsen
INSERT INTO products (productId, image, productName, unitPrice, categoryId, nameProducer, describle, specifions)
VALUES (141, 'https://s.meta.com.vn/Data/image/2022/08/26/pin-20v-4-0ah-tolsen-87474-2.jpg',
        'Pin 20V 4.0Ah Tolsen 87474', 738.000, 06, "Tolsen", "Thông tin chi tiết về pin 20V 4.0Ah Tolsen 87474
Pin Li-ion Tolsen 87474 có điện thế pin 20V, dung lượng 4Ah. 
Trên pin có đèn LED báo nguồn pin. 
Pin 20V 4.0Ah Tolsen 87474 dùng được với dụng cụ cầm tay dùng pin Tolsen MP20V. 
Pin Lithium-ion 20V tương tích với bộ sạc 87486/87482/87484.", "Kích thước Dài x rộng x cao (12.2cm x 7.9cm x 7.2cm),
Trọng lượng sản phẩm 840g,
Dung lượng pin 4Ah,
Điện thế 20V,
Loại Pin Li-ion,
Bảo hành 1 tháng,
Sản xuất tại Trung Quốc,
Xuất xứ thương hiệu Trung Quốc");
INSERT INTO products (productId, image, productName, unitPrice, categoryId, nameProducer, describle, specifions)
VALUES (142, 'https://s.meta.com.vn/Data/image/2022/11/16/pin-tolsen-87472-20v-2-0-ah-g.jpg',
        'Pin Tolsen 87472 20V 2.0Ah', 430.000, 06, "Tolsen", "Thông tin chi tiết về pin Tolsen 87472 20V 2.0Ah
Tolsen 87472 có điện thế pin 20V, dung lượng 2Ah.
Pin Tolsen 87472 cho thời gian sử dụng lâu và hiệu suất vượt trội.
Pin tương thích với tất cả các công cụ dùng pin Tolsen MP20V.
Pin Tolsen dùng với các mẫu bộ sạc sau: 87485/87481/87484.
Đây là loại pin Lithium-ion (Li-ion) có ưu điểm: Chống rò rỉ tốt, hoạt động mạnh mẽ, độ bền cao. 
Pin còn trang bị nút bấm báo pin để người dùng sạc điện kịp thời. ", "Kích thước Dài x rộng x cao (2cm x 7.9cm x 5.2cm),
Trọng lượng sản phẩm 510g,
Điện thế pin 20V,
Dung lượng pin 2.0Ah,
Loại Pin Lithium-ion,
Bảo hành 1 tháng,
Sản xuất tại Trung Quốc,
Xuất xứ thương hiệu Trung Quốc");



-- Sạc pin máy khoan
-- Bosh
INSERT INTO products (productId, image, productName, unitPrice, categoryId, nameProducer, describle, specifions)
VALUES (144, 'https://s.meta.com.vn/Data/image/2020/08/19/sac-pin-bosch-gal-12v-40-10-8v-12v-g.jpg',
        'Sạc pin Bosch GAL 12V-40 10.8V/12V 1600A01B8X', 657.000, 07, "Bosh", "Thông tin chi tiết về sạc pin Bosch GAL 12V-40 10.8V/12V 1600A01B8X
Bosch GAL 12V-40 có trọng lượng nặng 450g, được làm từ nhựa cao cấp, độ bền cao.

Bộ sạc pin Li-ion đa năng Bosch GAL 12V-40 dùng được dùng cho tất cả các dụng cụ cầm tay dùng pin của Bosch có điện thế pin 10.8V và 12V. Ví dụ như máy khoan pin, máy cưa kiếm dùng pin, máy cưa đĩa, máy phay gỗ, máy cắt kim loại, máy khoan góc, máy cưa lọng... 

Sạc pin Bosch có điện thế ra là 10.8V và 12V, dòng ra là 1.5Ah, 2.0Ah, 4.0Ah, điện thế vào 220V/50Hz. 

Bộ sạc pin tích hợp quạt làm mát pin trong quá trình sạc giúp tăng tuổi thọ pin hơn những sạc thông thường. 

Đế sạc thiết kế nhỏ gọn dễ mang theo, thời gian sạc đầy pin nhanh từ 25 - 90 phút, tùy theo dung lượng pin.

Thời gian nạp pin 1.5Ah từ 0% lên 80%/100% chỉ hết 16/30 phút
Thời gian nạp pin 2.0Ah từ 0 lên 80%/100% chỉ hết 24/35 phút
Thời gian nạp pin 2.5Ah từ 0 lên 80%/100% chỉ hết 30/42 phút
Thời gian nạp pin 3.0Ah từ 0 lên 80%/100% chỉ hết 36/50 phút
Thời gian nạp pin 4.0Ah từ 0 lên 80%/100% chỉ hết 48/65 phút", "Trọng lượng sản phẩm 450g,
Chất liệu Nhựa cao cấp,
Nguồn điện áp 220V/50Hz,
Dòng ra 4Ah,
Dải điện áp ra 10.8V - 12V,
Bảo hành 6 tháng,
Sản xuất tại Trung Quốc,
Xuất xứ thương hiệu Đức");


-- Makute
INSERT INTO products (productId, image, productName, unitPrice, categoryId, nameProducer, describle, specifions)
VALUES (151, 'https://s.meta.com.vn/Data/image/2023/06/30/sac-pin-makute-20v-7120-25a.jpg',
        'Sạc pin Makute 20V 7120-25A', 220.000, 07, "Makute", "Thông tin chi tiết về sạc pin Makute 20V 7120-25A
Makute 7120-25A dùng cho công cụ dụng cụ dùng pin 20V Makute.
Sạc pin Makute 20V 7120-25A có dòng điện sạc 25A giúp sạc pin nhanh chóng và tiết kiệm thời gian cho bạn.
Sạc được thiết kế an toàn với nhiều tính năng bảo vệ để đảm bảo sự an toàn cho người dùng.
Điện áp sạc 20V, thời gian sạc từ 2 - 3 giờ
Sạc có vỏ bọc bằng nhựa chống va đập tốt, tản nhiệt nhanh. ", "Chất liệu Nhựa cao cấp,
Điện thế pin 20V,
Thời gian sạc pin 2 - 3 giờ,
Dòng điện sạc 25A,
Sản xuất tại Trung Quốc,
Xuất xứ thương hiệu Trung Quốc");

-- DeWalt
INSERT INTO products (productId, image, productName, unitPrice, categoryId, nameProducer, describle, specifions)
VALUES (152, 'https://s.meta.com.vn/Data/image/2022/05/24/bo-sac-pin-da-nang-dewalt-dcb118-kr-18v-1.jpg',
        'Bộ sạc pin đa năng Dewalt DCB118-KR', 1090.000, 07, "Makute", "Ưu điểm của bộ sạc pin đa năng Dewalt DCB118-KR
Bộ sạc pin đa năng Dewalt DCB118-KR có thiết kế nhỏ gọn, ứng dụng công nghệ Mỹ hiện đại. 
Trang bị hệ thống đèn gồm đèn dài và đèn ngắn báo hiệu trạng thái hoạt động của bộ sạc. 
Dòng ra là 8Ah cho thời gian sạc nhanh chóng. 
Mặt sau của bộ sạc có trang bị chân treo trên tường tiện lợi.
Bộ sạc chỉ dành cho pin 18V và 20V (Max) của thương hiệu DeWalt. 
Sạc trang bị quạt tản nhiệt tránh quá nhiệt đảm bảo an toàn, kéo dài tuổi thọ cho sản phẩm. 
Thời gian sạc cho pin 6Ah là khoảng 60 phút. ", "Điện thế pin 18V, 20V,
Xuất xứ thương hiệu Mỹ,
Sản xuất tại Trung Quốc,
Bảo hành 12 tháng");


-- Milwaukee
INSERT INTO products (productId, image, productName, unitPrice, categoryId, nameProducer, describle, specifions)
VALUES (158, 'https://s.meta.com.vn/Data/image/2023/11/10/bo-sac-12v-18v-milwaukee-m12-18c.jpg',
        'Bộ sạc Milwaukee M12-18C 12V-18V', 1310.000, 07, "Milwaukee", "Ưu điểm nổi bật của bộ sạc 12V-18V Milwaukee M12-18C
M12-18C sạc điện cho tất cả pin 12V - 18V của hãng Milwaukee rất hiệu quả.

Bộ sạc 12V-18V Milwaukee M12-18C hỗ trợ sạc pin cực nhanh, tăng hiệu năng sạc.

Thời gian sạc cho pin 12V:

Pin 2Ah: 40 phút
Pin 4Ah: 80 phút
Pin 6Ah: 133 phút
Thời gian sạc cho pin 18V:

Pin 4Ah: 80 phút
Pin 5Ah: 100 phút
Bộ sạc pin Milwaukee M12-18C thiết kế kín, hoàn thiện tốt giúp chống bụi bẩn, độ ẩm và ngoại lực hiệu quả, sử dụng bền lâu.", "Nguồn điện áp 220V,
Điện thế pin 12V, 18V,
Bảo hành 12 tháng,
Sản xuất tại Trung Quốc,
Xuất xứ thương hiệu Mỹ");
INSERT INTO products (productId, image, productName, unitPrice, categoryId, nameProducer, describle, specifions)
VALUES (159, 'https://s.meta.com.vn/Data/image/2019/09/16/sac-pin-12v-milwaukee-c12c-g1.jpg',
        'Sạc pin 12V Milwaukee C12C', 930.000, 07, "Milwaukee", "Sạc pin 12V Milwaukee C12C thích hợp tiếp năng lượng cho tất cả thiết bị cầm tay 12V của Milwaukee
Sạc pin là thiết bị chuyển tiếp cung cấp điện năng cho các thiết bị cầm tay như máy khoan, máy cưa kiếm, máy bắt vít.....

Hoạt động với nguồn điện áp vào 220V AC và điện áp đầu ra 12V DC cho dòng ra 3A. Sạc pin Milwaukee C12C sử dụng để sạc cho tất cả các pin 12V của dụng cụ cầm tay của Milwaukee.

Tích hợp đầy đủ các tính năng nâng cao, thiết bị điện tử bảo vệ nhiệt độ giúp tối ưu hóa tốc độ để kéo dài thời gian sử dụng pin cũng như tăng hiệu năng sạc.

Thiết kế khép kín cho phép ngăn chặn thiết bị với khỏi bụi, ẩm và tác động làm ảnh hưởng tới tuổi đời. Sạc pin 12V Milwaukee C12C góp phần thúc đẩy hiệu suất công việc.", "Điện thế pin 12V,
Bảo hành 12 tháng,
Sản xuất tại Trung Quốc,
Xuất xứ thương hiệu Mỹ");


-- Tolsen
INSERT INTO products (productId, image, productName, unitPrice, categoryId, nameProducer, describle, specifions)
VALUES (162, 'https://s.meta.com.vn/Data/image/2022/08/26/sac-pin-20v-4-0ah-cong-suat-110w-tolsen-87486.jpg',
        'Sạc pin 20V 4.0Ah công suất 110W Tolsen 87486', 334.000, 07, "Tolsen", "Giới thiệu sạc pin 20V 4.0Ah công suất 110W Tolsen 87486
Máy khoan không thể thiếu 1 phụ kiện đó là sạc pin. Tolsen 87486 là sạc pin có công suất định mức 110W, điện thế đầu ra 20V DC, đầu vào 220 - 240VAC dễ dàng sử dụng. 

Dung lượng pin sử dụng 4.0Ah sạc đầy trong 60 phút. Khi sạc sẽ có đèn LED báo nguồn pin để người dùng dễ dàng quan sát xem khi nào pin được sạc đầy. ", "Thời gian sạc pin 60 phút,
Dung lượng pin 4Ah,
Điện thế 220V - 240V,
Công suất 110W,
Bảo hành 1 tháng,
Sản xuất tại Trung Quốc,
Xuất xứ thương hiệu Trung Quốc");
INSERT INTO products (productId, image, productName, unitPrice, categoryId, nameProducer, describle, specifions)
VALUES (163, 'https://s.meta.com.vn/Data/image/2022/11/16/tolsen-87485-1.jpg', 'Sạc pin Tolsen 87485 20V 2.0 Ah',
        237.000, 07, "Tolsen", "Thông tin về sạc pin Tolsen 87485 20V 2.0 Ah
Sạc pin Tolsen 87485 20V có dòng nạp 2 Ah giúp sạc nhanh, tối ưu thời gian chờ. 
Sản phẩm thuộc dòng sạc Lithium-Ion (Li-ion) hoạt động ổn định, độ bền cao, chống va đập tốt.
Sạc dùng cho pin Tolsen 20V 2.0 Ah 87472.
Sạc có thiết nhỏ gọn, tiết kế theo tiêu chuẩn thương hiệu Tolsen đảm bảo an toàn vận hành, dễ thao tác. Lưu ý: Hình ảnh sản phẩm chỉ có tính chất minh họa, chi tiết sản phẩm, màu sắc có thể thay đổi tùy theo sản phẩm thực tế.", "Kích thước Dài x Rộng x Cao (13.5cm x 12cm x 8cm),
Trọng lượng sản phẩm 450g,
Dung lượng pin 2.0Ah,
Điện áp đầu ra 20V,
Bảo hành 1 tháng,
Sản xuất tại Trung Quốc,
Xuất xứ thương hiệu Trung Quốc");



-- Mũi khoan
-- bosh
INSERT INTO products (productId, image, productName, unitPrice, categoryId, nameProducer, describle, specifions)
VALUES (164,
        'https://s.meta.com.vn/Data/image/2022/08/20/bo-mui-khoan-kim-loai-13-chi-tiet-15-65-bosch-2608577349-1.jpg',
        'Bộ mũi khoan Bosch HSS PointTeQ 2608577349 (13 mũi 1.5-6.5)', 150.000, 08, "bosh", "Giới thiệu bộ mũi khoan Bosch HSS PointTeQ 2608577349 (13 mũi 1.5-6.5)
Bộ mũi khoan Bosch HSS PointTeQ 2608577349 gồm 13 mũi với kích cỡ khác nhau đáp ứng nhu cầu sử dụng đa dạng từ người dùng. Bộ sản phẩm được sản xuất trên dây chuyền công nghệ hiện đại của Bosch đảm bảo chất lượng vượt trội. Sản phẩm được sử dụng cho các dòng máy khoan dân dụng và các dòng máy khoan cầm tay đa năng.

Các mũi khoan được làm từ hợp kim thép chống gỉ đã gia công và xử lý nhiệt độ cho sản phẩm độ cứng cao, không bị ăn mòn, sáng bóng.

Mũi khoan kết hợp cùng các dòng máy có motor mạnh mẽ giúp thao tác khoan đục trên các vật liệu cứng diễn ra nhanh chóng. 

Mũi khoan được làm từ chất liệu thép đã qua xử lý nhiệt nên có độ cứng cao

Mũi khoan xoắn phải, kiểu N, đầu mũi khoan 135° (theo tiêu chuẩn DIN 338). Đường kính chuôi khoan bằng với đầu mũi khoan hỗ trợ chức năng khoan sắt cho máy khoa có đầu cặp nhỏ hơn 6 mm.

Bộ sản phẩm dễ dàng thay thế và mang theo khi làm việc. 

Lưu ý:

Quý khách vui lòng tải ứng dụng Bosch BeConnected để xác minh nguồn gốc sản phẩm ngay trên điện thoại, cũng như tra cứu thông số kỹ thuật, thời gian bảo hành, tìm kiếm trung tâm bảo hành,... của từng sản phẩm theo thời gian thực.
Hình ảnh sản phẩm chỉ có tính chất minh họa, chi tiết sản phẩm, màu sắc có thể thay đổi tùy theo sản phẩm thực tế. Mũi khoan xoắn phải, kiểu N, đầu mũi khoan 135° (theo tiêu chuẩn DIN 338). Đường kính chuôi khoan bằng với đầu mũi khoan hỗ trợ chức năng khoan sắt cho máy khoa có đầu cặp nhỏ hơn 6 mm.

Bộ sản phẩm dễ dàng thay thế và mang theo khi làm việc. 

Lưu ý:

Quý khách vui lòng tải ứng dụng Bosch BeConnected để xác minh nguồn gốc sản phẩm ngay trên điện thoại, cũng như tra cứu thông số kỹ thuật, thời gian bảo hành, tìm kiếm trung tâm bảo hành,... của từng sản phẩm theo thời gian thực.
Hình ảnh sản phẩm chỉ có tính chất minh họa, chi tiết sản phẩm, màu sắc có thể thay đổi tùy theo sản phẩm thực tế.
", "Chất liệu Thép không gỉ,
Sản xuất tại Trung Quốc,
Xuất xứ thương hiệu Đức");
INSERT INTO products (productId, image, productName, unitPrice, categoryId, nameProducer, describle, specifions)
VALUES (165, 'https://s.meta.com.vn/Data/image/2022/05/31/plus-1-hammer-drill-bits-2868938-ocs-ac-1.jpg',
        'Mũi khoan Bosch SDS+ plus 1', 31.000, 08, "bosh", "Thông tin về mũi khoan Bosch SDS+ plus 1
Bosch SDS+ plus 1 là phụ kiện dành cho dòng máy khoan bê tông (máy khoan búa xoay) có đầu gài SDS plus.
Sản phẩm được sản xuất bởi thương hiệu Bosch. 
Mũi khoan SDS+ plus 1 chính hãng hỗ trợ khoan bê tông cốt thép hiệu quả hơn. 
Mũi khoan Bosch thiết kế đầu 2 lưỡi cắt ngăn mũi khoan cứng hơn, không bị mắc kẹt và không bị gãy.
Thiết kế 2 rãnh xoắn hình chữ U hỗ trợ khả năng hút bụi hiệu quả và độ bền tiêu chuẩn, hạn chế mài mòn. Lưu ý:

Quý khách vui lòng tải ứng dụng Bosch BeConnected để xác minh nguồn gốc sản phẩm ngay trên điện thoại, cũng như tra cứu thông số kỹ thuật, thời gian bảo hành, tìm kiếm trung tâm bảo hành,... của từng sản phẩm theo thời gian thực.
Hình ảnh sản phẩm chỉ có tính chất minh họa, chi tiết sản phẩm, màu sắc có thể thay đổi tùy theo sản phẩm thực tế.", "Sản phẩm gồm 1 mũi khoan,
Sản xuất tại Trung Quốc,
Xuất xứ thương hiệu Đức");


-- DeWalt
INSERT INTO products (productId, image, productName, unitPrice, categoryId, nameProducer, describle, specifions)
VALUES (176, 'https://s.meta.com.vn/Data/image/2023/02/16/bo-mui-da-nang-dewalt-dt0109-qz-g.jpg',
        'Bộ mũi đa năng 109 chi tiết Dewalt DT0109-QZ', 758.000, 08, "DeWalt", "Bộ mũi đa năng 109 chi tiết Dewalt DT0109-QZ gồm có:
Dewalt DT0109-QZ có 109 chi tiết:

Mũi vít PZ2 50mm  x 1
Mũi vít PZ3 50mm x 1
Mũi vít SL6-8 50mm x 1
Mũi vít SL8-10 50mm x 1
Mũi vít SL10-12 50mm x 1
Mũi vít  T10 50mm x 1
Mũi vít  T15 50mm x 1
Mũi vít T20 50mm x 1
Đai ốc 5mm x 2
Đai ốc 6mm x 1
Đai ốc 7mm x 1
Đai ốc 8mm x 1
Đai ốc 9mm x 1
Đai ốc 10mm x 1
Đai ốc 11mm x 1
Đai ốc 12mm x 1
Đai ốc 13mm x 1
Liên kết bộ đếm x 1
Dừng độ sâu x 2
Giữ bit x 1
Tay điều khiển vít x 1
", "Sản phẩm gồm 109 chi tiết,
Sản xuất tại Trung Quốc,
Xuất xứ thương hiệu Mỹ");
INSERT INTO products (productId, image, productName, unitPrice, categoryId, nameProducer, describle, specifions)
VALUES (177, 'https://s.meta.com.vn/Data/image/2023/02/16/bo-mui-vit-da-nang-dewalt-dt70740t-qz-nd.jpg',
        'Bộ mũi vít đa năng 38 chi tiết Dewalt DT70740T-QZ', 657.000, 08, "DeWalt", "Bộ mũi đa năng 109 chi tiết Dewalt DT0109-QZ gồm có:
Dewalt DT0109-QZ có 109 chi tiết:

Mũi vít PZ2 50mm  x 1
Mũi vít PZ3 50mm x 1
Mũi vít SL6-8 50mm x 1
Mũi vít SL8-10 50mm x 1
Mũi vít SL10-12 50mm x 1
Mũi vít  T10 50mm x 1
Mũi vít  T15 50mm x 1
Mũi vít T20 50mm x 1
Đai ốc 5mm x 2
Đai ốc 6mm x 1
Đai ốc 7mm x 1
Đai ốc 8mm x 1
Đai ốc 9mm x 1
Đai ốc 10mm x 1
Đai ốc 11mm x 1
Đai ốc 12mm x 1
Đai ốc 13mm x 1
Liên kết bộ đếm x 1
Dừng độ sâu x 2
Giữ bit x 1
Tay điều khiển vít x 1", "Sản phẩm gồm 109 chi tiết,
Sản xuất tại Trung Quốc,
Xuất xứ thương hiệu Mỹ");


-- Tolsen
INSERT INTO products (productId, image, productName, unitPrice, categoryId, nameProducer, describle, specifions)
VALUES (183, 'https://s.meta.com.vn/Data/image/2023/07/23/bo-vit-42-mon-tolsen-20041-t3.jpg',
        'Bộ vít 42 món Tolsen 20041', 379.000, 08, "Tolsen", "Ưu điểm nổi bật của bộ vít 42 món Tolsen 20041
Về chất liệu
Tolsen 20041 được làm từ vật liệu hợp kim CR-V cho độ bền cao, giúp kéo dài tuổi thọ làm việc của các vít nối.
Gồm 42 chi tiết 
1 dụng cụ vặn vít
4 đầu vít SL bao gồm các kích thước 3, 4, 5, 6 mm
4 đầu vít PH 6.35  x 25mm bao gồm các mẫu mã PH0, PH1, PH2, PH3
4 đầu vít TX 6.35 x 25mm bao gồm các mẫu mã T10, T15, T20, T25
4 vít lục giác 6.35 x 25mm bao gồm các mẫu mã H3, H4, H5, H6
1 thiết bị đầu đổi 25mm
1 thiết bị đỡ có từ tính
3 đầu vít SL: 2, 2.5, 3 mm
3 đầu vít PH 4  x 28mm bao gồm các mẫu mã PH0, PH00, PH000
3 vít TX 4 x 28mm bao gồm các mẫu mã T5, T6, T7
3 đầu vít đầu lục giác 4 x 28mm bao gồm các mẫu mã H1.3, H1.5, H2.0
", "Chất liệu Thép CR-V,
Sản phẩm gồm 42 chi tiết,
Xuất xứ thương hiệu Trung Quốc,
Sản xuất tại Trung Quốc");
INSERT INTO products (productId, image, productName, unitPrice, categoryId, nameProducer, describle, specifions)
VALUES (184, 'https://s.meta.com.vn/Data/image/2023/11/23/bo-mui-khoet-sat-9-mon-tolsen-75860-2.jpg',
        'Bộ mũi khoét sắt 9 món Tolsen 75860', 650.000, 08, "Tolsen", "Thông tin chi tiết về bộ mũi khoét sắt 9 món Tolsen 75860
Gồm 9 món
Tolsen 75860 gồm 9 món: 6 mũi khoét với các kích thước từ 7/8 (22mm) đến 2-1/2 (64mm) và 2 cái Arborsc có mũi khoan HSS polit giúp bạn dễ dàng thay đổi kích thước và độ sâu khoét lỗ. ", "Sản phẩm gồm Bộ 9 món,
Sản xuất tại Trung Quốc,
Xuất xứ thương hiệu Trung Quốc");


-- Oshima
INSERT INTO products (productId, image, productName, unitPrice, categoryId, nameProducer, describle, specifions)
VALUES (187, 'https://s.meta.com.vn/Data/image/2023/09/19/mui-khoan-dat-don-oshima-150mm.jpg',
        'Mũi khoan đất đơn Oshima 150mm', 560.000, 08, "Oshima", "Ưu điểm nổi bật của mũi khoan đất đơn Oshima 150mm
Mũi khoan đất Oshima loại đơn với đường kính mũi là 150mm. 
Chiều cao mũi khoan đất là 100cm cho độ sâu khi khoan lên tới 80cm. 
Mũi khoan đất đơn Oshima 150mm có trọng lượng 2.74kg, được làm từ hợp kim thép cho độ bền cao. 
Mũi khoan sơn tĩnh điện màu đỏ hạn chế han gỉ.
Mũi khoan cứng cáp, chống biến dạng. 
Sản phẩm dùng cho máy khoan đất Oshima 2P và máy khoan đất Oshima 2PS. ", "Trọng lượng sản phẩm 2,74kg,
Chất liệu Hợp kim thép,
Độ sâu khi khoan 80cm,
Đường kính mũi khoan 150mm,
Sản xuất tại Trung Quốc,
Xuất xứ thương hiệu Việt Nam");

-- repo 
INSERT INTO repo (repoId, userId, productId, categoryId, importDate, importPrice, importQuantity)
VALUES (1, 3, 19, 1, '2023-07-04', 12000, 20);
INSERT INTO repo (repoId, userId, productId, categoryId, importDate, importPrice, importQuantity)
VALUES (2, 2, 20, 1, '2023-10-2', 2800, 17);
INSERT INTO repo (repoId, userId, productId, categoryId, importDate, importPrice, importQuantity)
VALUES (3, 2, 29, 1, '2023-10-2', 2600, 17);
INSERT INTO repo (repoId, userId, productId, categoryId, importDate, importPrice, importQuantity)
VALUES (4, 3, 30, 1, '2023-07-04', 6800, 20);
INSERT INTO repo (repoId, userId, productId, categoryId, importDate, importPrice, importQuantity)
VALUES (5, 2, 34, 1, '2023-10-2', 2000, 17);
INSERT INTO repo (repoId, userId, productId, categoryId, importDate, importPrice, importQuantity)
VALUES (6, 2, 37, 1, '2023-10-2', 3400, 17);
INSERT INTO repo (repoId, userId, productId, categoryId, importDate, importPrice, importQuantity)
VALUES (7, 3, 38, 1, '2023-07-04', 5000, 20);
INSERT INTO repo (repoId, userId, productId, categoryId, importDate, importPrice, importQuantity)
VALUES (8, 2, 42, 1, '2023-10-2', 2500, 17);
INSERT INTO repo (repoId, userId, productId, categoryId, importDate, importPrice, importQuantity)
VALUES (9, 2, 43, 1, '2023-10-2', 9000, 17);
INSERT INTO repo (repoId, userId, productId, categoryId, importDate, importPrice, importQuantity)
VALUES (10, 3, 46, 1, '2023-07-04', 12000, 20);
INSERT INTO repo (repoId, userId, productId, categoryId, importDate, importPrice, importQuantity)
VALUES (11, 2, 49, 1, '2023-10-2', 700, 17);
INSERT INTO repo (repoId, userId, productId, categoryId, importDate, importPrice, importQuantity)
VALUES (12, 2, 50, 1, '2023-10-2', 500, 17);
INSERT INTO repo (repoId, userId, productId, categoryId, importDate, importPrice, importQuantity)
VALUES (13, 3, 53, 1, '2023-07-04', 600, 20);
INSERT INTO repo (repoId, userId, productId, categoryId, importDate, importPrice, importQuantity)
VALUES (14, 2, 55, 2, '2023-10-2', 4500, 17);
INSERT INTO repo (repoId, userId, productId, categoryId, importDate, importPrice, importQuantity)
VALUES (15, 2, 58, 2, '2023-10-2', 2500, 17);
INSERT INTO repo (repoId, userId, productId, categoryId, importDate, importPrice, importQuantity)
VALUES (16, 3, 62, 2, '2023-07-04', 2500, 20);
INSERT INTO repo (repoId, userId, productId, categoryId, importDate, importPrice, importQuantity)
VALUES (17, 2, 65, 2, '2023-10-2', 7500, 17);
INSERT INTO repo (repoId, userId, productId, categoryId, importDate, importPrice, importQuantity)
VALUES (18, 2, 66, 2, '2023-10-2', 15000, 17);
INSERT INTO repo (repoId, userId, productId, categoryId, importDate, importPrice, importQuantity)
VALUES (19, 3, 69, 2, '2023-07-04', 12000, 20);
INSERT INTO repo (repoId, userId, productId, categoryId, importDate, importPrice, importQuantity)
VALUES (20, 2, 70, 2, '2023-10-2', 1500, 17);
INSERT INTO repo (repoId, userId, productId, categoryId, importDate, importPrice, importQuantity)
VALUES (21, 2, 72, 2, '2023-10-2', 1000, 17);
INSERT INTO repo (repoId, userId, productId, categoryId, importDate, importPrice, importQuantity)
VALUES (22, 3, 75, 2, '2023-07-04', 700, 20);
INSERT INTO repo (repoId, userId, productId, categoryId, importDate, importPrice, importQuantity)
VALUES (23, 2, 77, 2, '2023-10-2', 1300, 17);
INSERT INTO repo (repoId, userId, productId, categoryId, importDate, importPrice, importQuantity)
VALUES (24, 2, 78, 2, '2023-10-2', 1000, 17);
INSERT INTO repo (repoId, userId, productId, categoryId, importDate, importPrice, importQuantity)
VALUES (25, 2, 80, 2, '2023-07-04', 12000, 20);
INSERT INTO repo (repoId, userId, productId, categoryId, importDate, importPrice, importQuantity)
VALUES (26, 2, 83, 2, '2023-10-2', 900, 17);
INSERT INTO repo (repoId, userId, productId, categoryId, importDate, importPrice, importQuantity)
VALUES (27, 2, 84, 2, '2023-10-2', 800, 17);
INSERT INTO repo (repoId, userId, productId, categoryId, importDate, importPrice, importQuantity)
VALUES (28, 2, 85, 3, '2023-07-04', 1000, 20);
INSERT INTO repo (repoId, userId, productId, categoryId, importDate, importPrice, importQuantity)
VALUES (29, 2, 86, 3, '2023-10-2', 1000, 17);
INSERT INTO repo (repoId, userId, productId, categoryId, importDate, importPrice, importQuantity)
VALUES (30, 2, 90, 3, '2023-10-2', 2500, 17);
INSERT INTO repo (repoId, userId, productId, categoryId, importDate, importPrice, importQuantity)
VALUES (31, 3, 91, 3, '2023-07-04', 800, 20);
INSERT INTO repo (repoId, userId, productId, categoryId, importDate, importPrice, importQuantity)
VALUES (32, 2, 95, 3, '2023-10-2', 2000, 17);
INSERT INTO repo (repoId, userId, productId, categoryId, importDate, importPrice, importQuantity)
VALUES (33, 2, 96, 3, '2023-10-2', 800, 17);
INSERT INTO repo (repoId, userId, productId, categoryId, importDate, importPrice, importQuantity)
VALUES (34, 3, 99, 3, '2023-07-04', 700, 20);
INSERT INTO repo (repoId, userId, productId, categoryId, importDate, importPrice, importQuantity)
VALUES (35, 2, 100, 3, '2023-10-2', 500, 17);
INSERT INTO repo (repoId, userId, productId, categoryId, importDate, importPrice, importQuantity)
VALUES (36, 2, 101, 3, '2023-10-2', 500, 17);
INSERT INTO repo (repoId, userId, productId, categoryId, importDate, importPrice, importQuantity)
VALUES (37, 3, 105, 3, '2023-07-04', 500, 20);
INSERT INTO repo (repoId, userId, productId, categoryId, importDate, importPrice, importQuantity)
VALUES (38, 2, 106, 3, '2023-10-2', 1200, 17);
INSERT INTO repo (repoId, userId, productId, categoryId, importDate, importPrice, importQuantity)
VALUES (39, 2, 107, 3, '2023-10-2', 350, 17);
INSERT INTO repo (repoId, userId, productId, categoryId, importDate, importPrice, importQuantity)
VALUES (40, 3, 1, 4, '2023-07-04', 300, 20);
INSERT INTO repo (repoId, userId, productId, categoryId, importDate, importPrice, importQuantity)
VALUES (41, 2, 2, 4, '2023-10-2', 350, 17);
INSERT INTO repo (repoId, userId, productId, categoryId, importDate, importPrice, importQuantity)
VALUES (42, 2, 7, 4, '2023-10-2', 300, 17);
INSERT INTO repo (repoId, userId, productId, categoryId, importDate, importPrice, importQuantity)
VALUES (43, 3, 8, 4, '2023-07-04', 872, 20);
INSERT INTO repo (repoId, userId, productId, categoryId, importDate, importPrice, importQuantity)
VALUES (44, 2, 11, 4, '2023-10-2', 350, 17);
INSERT INTO repo (repoId, userId, productId, categoryId, importDate, importPrice, importQuantity)
VALUES (45, 2, 14, 4, '2023-10-2', 350, 17);
INSERT INTO repo (repoId, userId, productId, categoryId, importDate, importPrice, importQuantity)
VALUES (46, 2, 18, 4, '2023-10-2', 600, 17);
INSERT INTO repo (repoId, userId, productId, categoryId, importDate, importPrice, importQuantity)
VALUES (47, 3, 109, 5, '2023-07-04', 420, 20);
INSERT INTO repo (repoId, userId, productId, categoryId, importDate, importPrice, importQuantity)
VALUES (48, 2, 110, 5, '2023-10-2', 1000, 17);
INSERT INTO repo (repoId, userId, productId, categoryId, importDate, importPrice, importQuantity)
VALUES (49, 2, 112, 5, '2023-10-2', 350, 17);
INSERT INTO repo (repoId, userId, productId, categoryId, importDate, importPrice, importQuantity)
VALUES (50, 3, 113, 5, '2023-07-04', 945, 20);
INSERT INTO repo (repoId, userId, productId, categoryId, importDate, importPrice, importQuantity)
VALUES (51, 2, 115, 5, '2023-10-2', 500, 17);
INSERT INTO repo (repoId, userId, productId, categoryId, importDate, importPrice, importQuantity)
VALUES (52, 2, 116, 5, '2023-10-2', 350, 17);
INSERT INTO repo (repoId, userId, productId, categoryId, importDate, importPrice, importQuantity)
VALUES (53, 3, 119, 6, '2023-07-04', 420, 20);
INSERT INTO repo (repoId, userId, productId, categoryId, importDate, importPrice, importQuantity)
VALUES (54, 2, 120, 6, '2023-10-2', 610, 17);
INSERT INTO repo (repoId, userId, productId, categoryId, importDate, importPrice, importQuantity)
VALUES (55, 2, 127, 6, '2023-10-2', 500, 17);
INSERT INTO repo (repoId, userId, productId, categoryId, importDate, importPrice, importQuantity)
VALUES (56, 2, 128, 6, '2023-10-2', 1000, 17);
INSERT INTO repo (repoId, userId, productId, categoryId, importDate, importPrice, importQuantity)
VALUES (57, 3, 129, 6, '2023-07-04', 900, 20);
INSERT INTO repo (repoId, userId, productId, categoryId, importDate, importPrice, importQuantity)
VALUES (58, 2, 135, 6, '2023-10-2', 1500, 17);
INSERT INTO repo (repoId, userId, productId, categoryId, importDate, importPrice, importQuantity)
VALUES (59, 2, 136, 6, '2023-10-2', 500, 17);
INSERT INTO repo (repoId, userId, productId, categoryId, importDate, importPrice, importQuantity)
VALUES (60, 3, 141, 6, '2023-07-04', 500, 20);
INSERT INTO repo (repoId, userId, productId, categoryId, importDate, importPrice, importQuantity)
VALUES (61, 2, 142, 6, '2023-10-2', 350, 17);
INSERT INTO repo (repoId, userId, productId, categoryId, importDate, importPrice, importQuantity)
VALUES (62, 2, 144, 7, '2023-10-2', 350, 17);
INSERT INTO repo (repoId, userId, productId, categoryId, importDate, importPrice, importQuantity)
VALUES (63, 3, 151, 7, '2023-07-04', 70, 20);
INSERT INTO repo (repoId, userId, productId, categoryId, importDate, importPrice, importQuantity)
VALUES (64, 2, 152, 7, '2023-10-2', 800, 17);
INSERT INTO repo (repoId, userId, productId, categoryId, importDate, importPrice, importQuantity)
VALUES (65, 2, 158, 7, '2023-10-2', 1050, 17);
INSERT INTO repo (repoId, userId, productId, categoryId, importDate, importPrice, importQuantity)
VALUES (66, 2, 159, 7, '2023-10-2', 800, 17);
INSERT INTO repo (repoId, userId, productId, categoryId, importDate, importPrice, importQuantity)
VALUES (67, 3, 162, 7, '2023-07-04', 210, 20);
INSERT INTO repo (repoId, userId, productId, categoryId, importDate, importPrice, importQuantity)
VALUES (68, 2, 163, 7, '2023-10-2', 100, 17);
INSERT INTO repo (repoId, userId, productId, categoryId, importDate, importPrice, importQuantity)
VALUES (69, 2, 164, 8, '2023-10-2', 90, 17);
INSERT INTO repo (repoId, userId, productId, categoryId, importDate, importPrice, importQuantity)
VALUES (70, 3, 165, 8, '2023-07-04', 10, 20);
INSERT INTO repo (repoId, userId, productId, categoryId, importDate, importPrice, importQuantity)
VALUES (71, 2, 176, 8, '2023-10-2', 500, 17);
INSERT INTO repo (repoId, userId, productId, categoryId, importDate, importPrice, importQuantity)
VALUES (72, 2, 177, 8, '2023-10-2', 350, 17);
INSERT INTO repo (repoId, userId, productId, categoryId, importDate, importPrice, importQuantity)
VALUES (73, 3, 183, 8, '2023-07-04', 250, 20);
INSERT INTO repo (repoId, userId, productId, categoryId, importDate, importPrice, importQuantity)
VALUES (74, 2, 184, 8, '2023-10-2', 350, 17);
INSERT INTO repo (repoId, userId, productId, categoryId, importDate, importPrice, importQuantity)
VALUES (75, 2, 187, 8, '2023-10-2', 350, 17);
INSERT INTO repo (repoId, userId, productId, categoryId, importDate, importPrice, importQuantity)
VALUES (76, 2, 16, 8, '2023-10-2', 900, 17);



SELECT cart.productId,
       products.productName,
       products.unitPrice,
       cart.quantity,
       (products.unitPrice * cart.quantity) AS totalPrice,
FROM products
         JOIN cart ON products.productId = cart.productIddrill_sell
WHERE cart.productId = 2

SELECT productId
FROM products products