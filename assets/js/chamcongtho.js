$(document).ready(function () {
    function loadDataTable(selectedDate) {
        $('#rawattendanceTable').DataTable({
            destroy: true,
            ajax: {
                url: "/api/chamcong/theoNgay", 
                data: { NgayLam: selectedDate }, 
                dataSrc: ""
            },
            columns: [
                { data: "MaNV" },
                { data: "ThoiGianQuet" },
                { data: "LoaiQuet" },
                { data: "NgayLam" } 
            ],
            language: {
                url: "//cdn.datatables.net/plug-ins/1.13.6/i18n/vi.json" 
            }
        });
    }

    // Lấy ngày hiện tại và thiết lập mặc định 
    let today = new Date().toISOString().split('T')[0];
    $('#workDate').val(today);
    loadDataTable(today);

    // Tự động load lại dữ liệu khi thay đổi ngày
    $('#workDate').on('change', function () {
        loadDataTable($(this).val());
    });
});
