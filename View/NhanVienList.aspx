<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="NhanVienList.aspx.cs" Inherits="QLChamCong.NhanVienList" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>Danh sách Nhân viên</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
    <!-- DataTables CSS -->
    <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.13.6/css/dataTables.bootstrap5.min.css" />

    <!-- jQuery -->
    <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
    <!-- DataTables JS -->
    <script src="https://cdn.datatables.net/1.13.6/js/jquery.dataTables.min.js"></script>
    <script src="https://cdn.datatables.net/1.13.6/js/dataTables.bootstrap5.min.js"></script>
    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

    <script src="assets/js/nhanvien.js"></script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <nav class="mt-4 mb-4" aria-label="breadcrumb">
        <ol class="breadcrumb">
            <li class="breadcrumb-item"><a href="Home.aspx">Home</a></li>
            <li class="breadcrumb-item active" aria-current="page">Nhân viên</li>
        </ol>
    </nav>
        <hr class="mb-4" />

    <div class="card shadow mb-4">
        <div class="card-header py-3">
            <h6 class="m-0 font-weight-bold text-primary">DANH SÁCH NHÂN VIÊN</h6>
        </div>
        <div class="card-body">
            <div class="table-responsive">
                <table id="employeeTable" class="table table-striped table-hover" width="100%" cellspacing="0">
                    <thead>
                        <tr>
                            <th>Mã nhân viên</th>
                            <th>Họ tên</th>
                            <th>Giới tính</th>
                            <th>Ngày sinh</th>
                            <th>Số điện thoại</th>
                            <th>Phòng ban</th>
                            <th>Chức vụ</th>
                        </tr>
                    </thead>
                </table>
            </div>
        </div>
    </div>
</asp:Content>
