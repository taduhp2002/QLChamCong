<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="DSChamCong.aspx.cs" Inherits="QLChamCong.DSChamCong" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>Danh sách chấm công</title>
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
    <script src="assets/js/xlchamcong.js"></script>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <nav class="mt-4 mb-4" aria-label="breadcrumb">
        <ol class="breadcrumb">
            <li class="breadcrumb-item"><a href="Home.aspx">Home</a></li>
            <li class="breadcrumb-item active" aria-current="page">Danh sách chấm công</li>
        </ol>
    </nav>

    <hr class="mb-4" />
     <div class="row mb-4">
     <div class="col-md-4">
         <label for="workDate" class="form-label">Chọn ngày:</label>
         <input type="date" id="workDate" class="form-control" style="max-width: 200px;" />
     </div>
 </div>

    <div class="card shadow mb-4">
        <div class="card-header py-3">
            <h6 class="m-0 font-weight-bold text-primary">DANH SÁCH CHẤM CÔNG</h6>
        </div>
        <div class="card-body">
            <div class="table-responsive">
                <table id="dschamcongTable" class="table table-striped table-hover" width="100%" cellspacing="0">
                    <thead>
                        <tr>
                            <th>Mã nhân viên</th>
                            <th>Tên nhân viên</th>
                            <th>Thời gian vào</th>
                            <th>Thời gian ra</th>
                            <th>Tổng giờ làm</th>
                            <th>Ngày làm</th>
                            <th>Trạng thái</th>
                        </tr>
                    </thead>
                </table>
            </div>
        </div>
    </div>
</asp:Content>
