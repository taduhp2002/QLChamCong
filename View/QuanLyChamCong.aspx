<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="QuanLyChamCong.aspx.cs" Inherits="QLChamCong.QuanLyChamCong" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" href="https://cdn.datatables.net/1.11.5/css/dataTables.bootstrap4.min.css" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" />
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" />
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <nav class="mt-4 mb-4" aria-label="breadcrumb">
        <ol class="breadcrumb">
            <li class="breadcrumb-item"><a href="Home.aspx">Home</a></li>
            <li class="breadcrumb-item active" aria-current="page">Quản lý chấm công</li>
        </ol>
    </nav>

    <hr class="mb-4" />
    <div class="row mb-4">
        <div class="col-md-3 ">
            <button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#chamCongModal">Thêm chấm công</button>
        </div>
    </div>

     <div class="card shadow mb-4">
     <div class="card-header py-3">
         <h6 class="m-0 font-weight-bold text-primary">QUẢN LÝ CHẤM CÔNG</h6>
     </div>
     <div class="card-body">
        <table id="attendanceTable" class="table table-striped table-hover" width="100%" cellspacing="0">
            <thead>
                <tr>
                    <th>Mã nhân viên</th>
                    <th>Giờ vào</th>
                    <th>Giờ ra</th>
                    <th>Tổng giờ</th>
                    <th>Ngày làm</th>
                    <th>Trạng thái</th>
                    <th>Thao tác</th>
                </tr>
            </thead>
            <tbody></tbody>
        </table>
    </div>
         </div>
    

    <!-- Modal thêm -->
    <div class="modal fade" id="chamCongModal" tabindex="-1" aria-labelledby="chamCongModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="chamCongModalLabel">Thêm Chấm Công</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <asp:Panel ID="chamCongPanel" runat="server">
                        <div class="mb-3">
                            <label for="MaNV" class="form-label">Mã nhân viên</label>
                            <input type="text" class="form-control" id="MaNV" name="MaNV" required="required" />
                        </div>
                        <div class="mb-3">
                            <label for="ThoiGianVao" class="form-label">Thời gian vào</label>
                            <input type="time" class="form-control" id="ThoiGianVao" name="ThoiGianVao" required="required" />
                        </div>
                        <div class="mb-3">
                            <label for="ThoiGianRa" class="form-label">Thời gian ra</label>
                            <input type="time" class="form-control" id="ThoiGianRa" name="ThoiGianRa" required="required" />
                        </div>
                        <div class="mb-3">
                            <label for="NgayLam" class="form-label">Ngày làm việc</label>
                            <input type="date" class="form-control" id="NgayLam" name="NgayLam" required="required" />
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
                            <button type="button" class="btn btn-primary" id="luuChamCong">Xác nhận</button>
                        </div>
                    </asp:Panel>
                </div>
            </div>
        </div>
    </div>

    <!-- Modal chỉnh sửa -->
    <div class="modal fade" id="editChamCongModal" tabindex="-1" aria-labelledby="editChamCongModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="editChamCongModalLabel">Chỉnh Sửa Chấm Công</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <asp:Panel ID="editChamCongPanel" runat="server">
                        <div class="mb-3">
                            <label for="EditMaNV" class="form-label">Mã nhân viên</label>
                            <input type="text" class="form-control" id="EditMaNV" name="MaNV" readonly="" />
                        </div>
                        <div class="mb-3">
                            <label for="EditThoiGianVao" class="form-label">Thời gian vào</label>
                            <input type="time" class="form-control" id="EditThoiGianVao" name="ThoiGianVao" required="required" />
                        </div>
                        <div class="mb-3">
                            <label for="EditThoiGianRa" class="form-label">Thời gian ra</label>
                            <input type="time" class="form-control" id="EditThoiGianRa" name="ThoiGianRa" required="required" />
                        </div>
                        <div class="mb-3">
                            <label for="EditNgayLam" class="form-label">Ngày làm việc</label>
                            <input type="date" class="form-control" id="EditNgayLam" name="NgayLam" required="required" />
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
                            <button type="button" class="btn btn-primary" id="updateChamCong">Cập nhật</button>
                        </div>
                    </asp:Panel>
                </div>
            </div>
        </div>
    </div>

    <!-- Modal xác nhận xóa -->
    <div class="modal fade" id="confirmDeleteModal" tabindex="-1" role="dialog" aria-labelledby="confirmDeleteLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="confirmDeleteLabel">Xác nhận xóa</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    Bạn có chắc chắn muốn xóa chấm công này?
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Không</button>
                    <button type="button" class="btn btn-danger" id="confirmDelete">Có</button>
                </div>
            </div>
        </div>
    </div>

    <!-- Modal Thông báo -->
<div class="modal fade" id="notificationModal" tabindex="-1" aria-labelledby="notificationModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="notificationModalLabel">Thông báo</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <p id="notificationMessage"></p>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
            </div>
        </div>
    </div>
</div>


    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.datatables.net/1.11.5/js/jquery.dataTables.min.js"></script>
    <script src="https://cdn.datatables.net/1.11.5/js/dataTables.bootstrap4.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.bundle.min.js"></script>
    <script src="assets/js/quanlychamcong.js"></script>
</asp:Content>
