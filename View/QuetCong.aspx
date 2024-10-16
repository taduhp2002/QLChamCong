<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="QuetCong.aspx.cs" Inherits="QLChamCong.QuetCong" Async="true" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Quét Công</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.1.3/css/bootstrap.min.css" rel="stylesheet" />
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet" />
    <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.1.3/js/bootstrap.bundle.min.js"></script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <nav class="mt-4 mb-4" aria-label="breadcrumb">
        <ol class="breadcrumb">
            <li class="breadcrumb-item"><a href="Home.aspx">Home</a></li>
            <li class="breadcrumb-item active" aria-current="page">Quét công</li>
        </ol>
    </nav>
    <hr />

    <h4 class="card-title text-center mb-4 ">
        <i class="fas fa-user-clock me-2 text-primary"></i>CHẤM CÔNG NHÂN SỰ
    </h4>
    <div class="card shadow mb-4">
        <div class="card-body">

            <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
            <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                <ContentTemplate>
                    <asp:Timer ID="Timer1" runat="server" OnTick="Timer1_Tick" Interval="1000"></asp:Timer>
                    <div class="text-center mb-4">
                        <asp:Label ID="lblTime" runat="server" CssClass="display-6  fw-bold text-primary"></asp:Label>
                    </div>
                </ContentTemplate>
            </asp:UpdatePanel>

            <div class="row justify-content-center">
                <div class="col-md-6">
                    <div class="input-group mb-3">
                        <span class="input-group-text bg-primary text-white"><i class="fas fa-id-card"></i></span>
                        <asp:TextBox ID="TextBox1" runat="server" placeholder="Nhập mã nhân viên" CssClass="form-control form-control-lg"></asp:TextBox>
                    </div>
                    <div class="text-center mb-3">
                        <asp:Label ID="lblMessage" runat="server" CssClass="text-danger"></asp:Label>
                    </div>
                    <div class="d-grid gap-2">
                        <asp:Button ID="btnCheckIn" runat="server" Text="Quét vào" OnClick="BtnCheckIn_Click"
                            CssClass="btn btn-primary btn-lg rounded-pill" />

                        <asp:Button ID="btnCheckOut" runat="server" Text="Quét ra" OnClick="BtnCheckOut_Click"
                            CssClass="btn btn-outline-primary btn-lg rounded-pill" />
                    </div>

                </div>
            </div>

            <div class="mt-5">
                <asp:GridView ID="gvAttendanceList" runat="server" CssClass="table table-striped table-hover table-bordered">
                    <HeaderStyle CssClass="table-primary" />
                </asp:GridView>
            </div>
        </div>
    </div>


</asp:Content>
