$(document).ready(function () {
    const table = $('#attendanceTable').DataTable({
        ajax: {
            url: 'api/xulychamcong',
            type: 'GET',
            dataSrc: ''
        },
        columns: [
            { data: 'MaNV' },
            {
                data: 'ThoiGianVao',
                render: function (data) {
                    return data ? data : "<span style='color: red;'>Thiếu</span>";
                }
            },
            {
                data: 'ThoiGianRa',
                render: function (data) {
                    return data ? data : "<span style='color: red;'>Thiếu</span>";
                }
            },
            {
                data: 'TongGioLam',
                render: function (data) {
                    return data !== null ? data : "<span style='color: red;'>N/A</span>";
                }
            },
            { data: 'NgayLam' },
            {
                data: 'TrangThai',
            },
            {
                data: null,
                render: function (data, type, row) {
                    return `
                               <button class="btn btn-sm mr-1 edit-btn" style="background-color: #007bff; color: white;" title="Chỉnh sửa">
                                    <i class="fas fa-edit"></i>
                                </button>
                                <button class="btn btn-sm delete-btn" style="background-color: #dc3545; color: white;" title="Xóa" data-maxl="${data.MaXL}">
                                    <i class="fas fa-trash-alt"></i>
                                </button>
                            `;
                }
            }
        ],
        language: {
            url: '//cdn.datatables.net/plug-ins/1.10.24/i18n/Vietnamese.json'
        }
    });

    $('#luuChamCong').on('click', function (e) {
        e.preventDefault();

        var chamCongData = {
            MaNV: $('#MaNV').val(),
            ThoiGianVao: $('#ThoiGianVao').val(),
            ThoiGianRa: $('#ThoiGianRa').val(),
            NgayLam: $('#NgayLam').val()
        };

        $.ajax({
            url: 'api/xulychamcong',
            type: 'POST',
            contentType: 'application/json',
            data: JSON.stringify(chamCongData),
            success: function (response) {
                $('#chamCongModal').modal('hide');
                $('#chamCongPanel').find('input').val('');
                $('#attendanceTable').DataTable().ajax.reload();
                $('#notificationModal .modal-body').text('Thêm chấm công thành công!'); 
                $('#notificationModal').modal('show');
            },
            error: function (xhr, status, error) {
                let errorMessage = xhr.responseJSON ? xhr.responseJSON.Message : 'Đã xảy ra lỗi';
                $('#notificationModal .modal-body').text(errorMessage); 
                $('#notificationModal').modal('show'); 
            }
        });
    });

    $('#attendanceTable tbody').on('click', '.edit-btn', function () {
        const data = table.row($(this).parents('tr')).data();
        $('#EditMaNV').val(data.MaNV);
        $('#EditThoiGianVao').val(data.ThoiGianVao);
        $('#EditThoiGianRa').val(data.ThoiGianRa);
        $('#EditNgayLam').val(data.NgayLam);
        $('#editChamCongModal').modal('show');
    });

    $('#updateChamCong').on('click', function () {
        var chamCongData = {
            MaNV: $('#EditMaNV').val(),
            ThoiGianVao: $('#EditThoiGianVao').val(),
            ThoiGianRa: $('#EditThoiGianRa').val(),
            NgayLam: $('#EditNgayLam').val()
        };

        $.ajax({
            url: 'api/xulychamcong',
            type: 'PUT',
            contentType: 'application/json',
            data: JSON.stringify(chamCongData),
            success: function (response) {
                $('#editChamCongModal').modal('hide');
                $('#attendanceTable').DataTable().ajax.reload();
                $('#notificationModal .modal-body').text('Cập nhật thành công!'); 
                $('#notificationModal').modal('show'); 
            },
            error: function (xhr, status, error) {
                let errorMessage = xhr.responseJSON ? xhr.responseJSON.Message : 'Đã xảy ra lỗi';
                $('#notificationModal .modal-body').text(errorMessage);
                $('#notificationModal').modal('show'); 
            }
        });
    });

   
    $('#attendanceTable tbody').on('click', '.delete-btn', function () {
        const maXL = $(this).data('maxl'); 

      
        $('#confirmDeleteModal').modal('show'); 

        
        $('#confirmDelete').off('click').on('click', function () {
            $.ajax({
                url: `api/xulychamcong/${maXL}`,
                type: 'DELETE',
                success: function (response) {
                    $('#message').html('<div class="alert alert-success">Xóa chấm công thành công!</div>');
                    $('#attendanceTable').DataTable().ajax.reload(); 
                    $('#confirmDeleteModal').modal('hide'); 
                },
                error: function (xhr, status, error) {
                    let errorMessage = xhr.responseJSON ? xhr.responseJSON.Message : 'Đã xảy ra lỗi';
                    $('#message').html('<div class="alert alert-danger">' + errorMessage + '</div>');
                    $('#confirmDeleteModal').modal('hide'); 
                }
            });
        });
    });
});
