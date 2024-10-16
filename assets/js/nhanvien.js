$(document).ready(function () {
    $('#employeeTable').DataTable({
        "ajax": {
            "url": "/api/nhanvien",
            "type": "GET",
            "dataSrc": ""
        },
        "columns": [
            { "data": "MaNV" },
            { "data": "TenNV" },
            { "data": "GioiTinh" },
            { "data": "NgaySinh" },
            { "data": "SĐT" },
            { "data": "PhongBan" },
            { "data": "ChucVu" },
        ],
        "language": {
            "url": "//cdn.datatables.net/plug-ins/1.10.24/i18n/Vietnamese.json"
        }
    });
});