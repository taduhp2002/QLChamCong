using Newtonsoft.Json;
using QLChamCong.Model;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Net.Http;
using System.Text;
using System.Threading.Tasks;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace QLChamCong
{
    public partial class QuetCong : System.Web.UI.Page
    {
        private readonly string apiUrl = "https://localhost:44361/api/chamcong/";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Tải danh sách chấm công khi trang được tải
                _ = LoadAttendanceListByDate(DateTime.Today);
            }
        }

        protected void Timer1_Tick(object sender, EventArgs e)
        {
            lblTime.Text = DateTime.Now.ToString("dd/MM/yyyy HH:mm:ss");
        }

        protected async void BtnCheckIn_Click(object sender, EventArgs e)
        {
            await RecordAttendance("Quét vào");
        }

        protected async void BtnCheckOut_Click(object sender, EventArgs e)
        {
            await RecordAttendance("Quét ra");
        }

        private async Task RecordAttendance(string LoaiQuet)
        {
            if (string.IsNullOrEmpty(TextBox1.Text))
            {
                lblMessage.Text = "Mã nhân viên không được để trống.";
                return;
            }

            var attendanceRecord = new ChamCongTho
            {
                MaNV = TextBox1.Text.Trim(),
                ThoiGianQuet = DateTime.Now.TimeOfDay,
                LoaiQuet = LoaiQuet,
                NgayLam = DateTime.Today.ToString("yyyy-MM-dd")  
            };

            using (HttpClient client = new HttpClient())
            {
                var json = JsonConvert.SerializeObject(attendanceRecord);
                var content = new StringContent(json, Encoding.UTF8, "application/json");
                var response = await client.PostAsync(apiUrl + "QuetCong", content);  

                if (response.IsSuccessStatusCode)
                {
                    lblMessage.Text = "Quét công thành công!";
                    // Tải lại danh sách chấm công sau khi chấm công thành công
                    await LoadAttendanceListByDate(DateTime.Today);
                }
                else
                {
                    // Đọc nội dung phản hồi lỗi từ API
                    var errorResponse = await response.Content.ReadAsStringAsync();
                    if (errorResponse.Contains("Mã nhân viên không tồn tại"))
                    {
                        lblMessage.Text = "Mã nhân viên không tồn tại. Vui lòng kiểm tra lại.";
                    }
                    else
                    {
                        lblMessage.Text = "Chấm công thất bại. Vui lòng thử lại.";
                    }
                }
            }
        }


        // Tải danh sách chấm công của ngày hôm nay
        private async Task LoadAttendanceListByDate(DateTime workDate)
        {
            using (HttpClient client = new HttpClient())
            {
                string formattedDate = workDate.ToString("yyyy-MM-dd");
                HttpResponseMessage response = await client.GetAsync(apiUrl + "DsChamCongTho?NgayLam=" + formattedDate);  // Đảm bảo URL đúng với API

                if (response.IsSuccessStatusCode)
                {
                    var jsonResponse = await response.Content.ReadAsStringAsync();
                    var attendanceList = JsonConvert.DeserializeObject<List<ChamCongTho>>(jsonResponse);

                    if (attendanceList != null && attendanceList.Any())
                    {
                        DataTable dt = new DataTable();
                        dt.Columns.AddRange(new DataColumn[4]
                        {
                            new DataColumn("Mã nhân viên", typeof(string)),
                            new DataColumn("Thời gian quét", typeof(string)),
                            new DataColumn("Loại quét", typeof(string)),
                            new DataColumn("Ngày làm", typeof (string))
                        });

                        foreach (var item in attendanceList)
                        {
                            dt.Rows.Add( item.MaNV, item.ThoiGianQuet.ToString(), item.LoaiQuet, item.NgayLam);
                        }

                        gvAttendanceList.DataSource = dt;
                        gvAttendanceList.DataBind();
                    }
                    else
                    {
                        lblMessage.Text = "Không có dữ liệu chấm công cho ngày hôm nay.";
                    }
                }
                else
                {
                    lblMessage.Text = "Không thể tải dữ liệu chấm công.";
                }
            }
        }
    }
}
