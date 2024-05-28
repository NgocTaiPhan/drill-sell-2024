document.querySelector(".addProds").addEventListener("click", addProd);

async function addProd() {
    const { value: formValues } = await Swal.fire({
        title: "Nhập Thông Tin Sản Phẩm",
        width: "800px",
        html: `
      <div class="swal2-form">
        <style> /* Thêm khối style ở đây */
          .swal2-form label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold; /* Hoặc bất kỳ kiểu dáng nào bạn muốn */
          }
          
          .swal2-form input, 
          .swal2-form select { 
            width: 500px;
            padding: 8px;
            margin-bottom: 10px;
            box-sizing: border-box;
            border: 1px solid #ccc; 
          }
          .swal2-form select,.swal2-form select option {  text-align: center;}
        </style>
        <label for="productName">Tên sản phẩm</label>
        <input id="productName" class="swal2-input">
        <label for="productPrice">Giá sản phẩm</label>
        <input id="productPrice" class="swal2-input" type="number"> 
        <label for="manufacturerName">Nhà Sản Xuất</label>
        <select name="" id="manufacturerName">
        <option value="1">2</option>
</select>
        <label for="categoryId">Mã Loại</label>
        <input id="categoryId" class="swal2-input">
        <label for="productImage">Ảnh sản phẩm</label>
        <input id="productImage" type="file" accept="image/*" class="swal2-file">
      </div>
    `,
        focusConfirm: false,
        preConfirm: () => {
            const formData = new FormData();
            formData.append("productName", document.getElementById("productName").value);
            formData.append("unitPrice", document.getElementById("productPrice").value);
            formData.append("nameProducer", document.getElementById("manufacturer").value);
            formData.append("categoryId", document.getElementById("categoryId").value);
            formData.append("productImage", document.getElementById("productImage").files[0]);
            formData.append("describle", "");
            formData.append("specifions", "");

            return formData; // Trả về FormData trực tiếp
        },
    });

    if (formValues) {
        try {
            const response = await fetch('/admin/add-prod', {
                method: 'POST',
                body: formValues, // Sử dụng FormData đã chuẩn bị
            });

            const data = await response.json();
            Swal.fire(data.title, data.message, data.type);

            if (data.type === 'success') {
                Swal.fire(data.title, data.message, data.type);
            }
        } catch (error) {
            console.error('Error:', error);
            Swal.fire('Lỗi', 'Đã có lỗi xảy ra khi thêm sản phẩm.', 'error');
        }
    }
}
