<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="Home.aspx.cs" Inherits="QLChamCong.Demo" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
  
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
     <nav class="mt-4 mb-4" aria-label="breadcrumb">
     <ol class="breadcrumb">
         <li class="breadcrumb-item"><a href="Home.aspx">Home</a></li>
         <li class="breadcrumb-item active" aria-current="page">Dashboard</li>
     </ol>
 </nav>

 <hr class="mb-4" />
 
    <div class="row">
        <div class="col-xl-3 col-md-6 mb-4">
            <div class="card border-left-primary shadow h-100 py-2 dashboard-card">
                <div class="card-body">
                    <div class="row no-gutters align-items-center">
                        <div class="col mr-2">
                            <div class="text-xs font-weight-bold text-primary text-uppercase mb-1">Nhân viên đi làm hôm nay</div>
                            <div class="h5 mb-0 font-weight-bold text-gray-800">45/50</div>
                        </div>
                        <div class="col-auto">
                            <i class="bi bi-person-check fa-2x text-gray-300"></i>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="col-xl-3 col-md-6 mb-4">
            <div class="card border-left-success shadow h-100 py-2 dashboard-card">
                <div class="card-body">
                    <div class="row no-gutters align-items-center">
                        <div class="col mr-2">
                            <div class="text-xs font-weight-bold text-success text-uppercase mb-1">Tỷ lệ đi làm tháng này</div>
                            <div class="h5 mb-0 font-weight-bold text-gray-800">95%</div>
                        </div>
                        <div class="col-auto">
                            <i class="bi bi-graph-up fa-2x text-gray-300"></i>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="col-xl-3 col-md-6 mb-4">
            <div class="card border-left-info shadow h-100 py-2 dashboard-card">
                <div class="card-body">
                    <div class="row no-gutters align-items-center">
                        <div class="col mr-2">
                            <div class="text-xs font-weight-bold text-info text-uppercase mb-1">Yêu cầu nghỉ phép chờ duyệt</div>
                            <div class="h5 mb-0 font-weight-bold text-gray-800">3</div>
                        </div>
                        <div class="col-auto">
                            <i class="bi bi-calendar-minus fa-2x text-gray-300"></i>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="col-xl-3 col-md-6 mb-4">
            <div class="card border-left-warning shadow h-100 py-2 dashboard-card">
                <div class="card-body">
                    <div class="row no-gutters align-items-center">
                        <div class="col mr-2">
                            <div class="text-xs font-weight-bold text-warning text-uppercase mb-1">Tổng số giờ làm tháng này</div>
                            <div class="h5 mb-0 font-weight-bold text-gray-800">1250 giờ</div>
                        </div>
                        <div class="col-auto">
                            <i class="bi bi-clock-history fa-2x text-gray-300"></i>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="row">
        <div class="col-xl-8 col-lg-7">
            <div class="card shadow mb-4">
                <div class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
                    <h6 class="m-0 font-weight-bold text-primary">Biểu đồ chấm công tháng này</h6>
                </div>
                <div class="card-body">
                    <div class="chart-area">
                        <canvas id="attendanceChart"></canvas>
                    </div>
                </div>
            </div>
        </div>

        <div class="col-xl-4 col-lg-5">
            <div class="card shadow mb-4">
                <div class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
                    <h6 class="m-0 font-weight-bold text-primary">Thông báo gần đây</h6>
                </div>
                <div class="card-body">
                    <div class="list-group">
                        <a href="#" class="list-group-item list-group-item-action">
                            <div class="d-flex w-100 justify-content-between">
                                <h5 class="mb-1">Cập nhật chính sách OT</h5>
                                <small>3 ngày trước</small>
                            </div>
                            <p class="mb-1">Chính sách mới về làm thêm giờ sẽ được áp dụng từ tháng sau.</p>
                        </a>
                        <a href="#" class="list-group-item list-group-item-action">
                            <div class="d-flex w-100 justify-content-between">
                                <h5 class="mb-1">Bảo trì hệ thống</h5>
                                <small>1 tuần trước</small>
                            </div>
                            <p class="mb-1">Hệ thống sẽ được bảo trì vào cuối tuần này.</p>
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Chart.js Script -->
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <script>
        // Biểu đồ chấm công
        var ctx = document.getElementById('attendanceChart').getContext('2d');
        var myChart = new Chart(ctx, {
            type: 'line',
            data: {
                labels: ['1', '2', '3', '4', '5', '6', '7', '8', '9', '10', '11', '12', '13', '14', '15', '16', '17', '18', '19', '20', '21', '22', '23', '24', '25', '26', '27', '28', '29', '30'],
                datasets: [{
                    label: 'Số nhân viên đi làm',
                    data: [45, 47, 48, 46, 45, 43, 44, 45, 46, 47, 48, 49, 50, 48, 47, 46, 45, 44, 43, 45, 46, 47, 48, 49, 50, 48, 47, 46, 45, 44],
                    borderColor: 'rgb(75, 192, 192)',
                    tension: 0.1
                }]
            },
            options: {
                responsive: true,
                scales: {
                    y: {
                        beginAtZero: true
                    }
                }
            }
        });
    </script>
</asp:Content>
