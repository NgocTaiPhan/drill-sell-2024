<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <script src="https://code.jquery.com/jquery-3.7.1.js"></script>
    <link rel="stylesheet" href="https://cdn.datatables.net/2.0.5/css/dataTables.dataTables.css">
    <link rel="stylesheet" href="https://cdn.datatables.net/buttons/3.0.1/css/buttons.dataTables.min.css">
    <script src="https://cdn.datatables.net/2.0.5/js/dataTables.js"></script>
    <script src="https://cdn.datatables.net/buttons/3.0.2/js/dataTables.buttons.js"></script>
    <script src="https://cdn.datatables.net/buttons/3.0.1/js/buttons.jqueryui.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jszip/3.10.1/jszip.min.js"></script>
    <script src="https://cdn.datatables.net/buttons/3.0.2/js/buttons.html5.js"></script>
</head>
<body>
<h1>Danh sách User</h1>
                                <table id="user-mn" class="table table-striped">
                                    <thead>
                                    <tr>
                                        <th>ID</th>
                                        <th>Tên người dùng</th>
                                        <th>Email</th>
                                        <th>Hành Động</th>
                                    </tr>
                                    </thead>
                                </table>
                                <script>
                                    $(document).ready(function (){
                                        var table = $('#user-mn').DataTable({
                                            "ajax" :{
                                                "url":"ShowUser",
                                                "dataSrc":"",
                                            },
                                            "columns": [
                                                {"data":"id"},
                                                {"data":"username"},
                                                {"data":"email"},
                                                {
                                                    "data":null,

                                                    render: (data,type)=>   ' <button type="button" class="btn btn-info">Xem chi tiết </button>' +
                                                        '  <button type="button" class="btn btn-warning" >Sửa </button>' +
                                                        '<button type="button" class="btn btn-danger" >Xóa </button>'
                                                }
                                            ],
                                        });



                                        //

                                    })
                                </script>

</body>
</html>