using QLChamCong.Model;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Threading.Tasks;
using System.Web.Http;

namespace QLChamCong.Controller
{
    public class XuLyChamCongController : ApiController
    {
        private readonly string connectionString = ConfigurationManager.ConnectionStrings["AttendanceDB"].ConnectionString;

        private void XLChamCong()
        {
            using (var conn = new SqlConnection(connectionString))
            {
                conn.Open();
                using (var cmd = new SqlCommand("sp_XuLyChamCong", conn))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.ExecuteNonQuery();
                }
            }
        }

        [HttpGet]
        public IHttpActionResult GetDSChamCong()
        {
            var xl = new List<XuLyChamCong>();
            XLChamCong();

            try
            {
                using (var conn = new SqlConnection(connectionString))
                {
                    conn.Open();
                    using (var cmd = new SqlCommand("sp_DSChamCong", conn))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;

                        using (var reader = cmd.ExecuteReader())
                        {
                            while (reader.Read())
                            {
                                xl.Add(new XuLyChamCong
                                {
                                    MaXL = Convert.ToInt32(reader["MaXL"]),
                                    MaNV = reader["MaNV"].ToString(),
                                    ThoiGianVao = reader["ThoiGianVao"] != DBNull.Value ?
                                                   (TimeSpan?)TimeSpan.Parse(reader["ThoiGianVao"].ToString()) :
                                                   null,
                                    ThoiGianRa = reader["ThoiGianRa"] != DBNull.Value ?
                                                  (TimeSpan?)TimeSpan.Parse(reader["ThoiGianRa"].ToString()) :
                                                  null,
                                    TongGioLam = reader["TongGioLam"] != DBNull.Value ?
                                                  (float?)Convert.ToSingle(reader["TongGioLam"]) :
                                                  null,

                                    NgayLam = Convert.ToDateTime(reader["NgayLam"]).ToString("dd/MM/yyyy"),
                                    TrangThai = reader["TrangThai"].ToString()
                                });
                            }
                        }

                    }
                }
                return Ok(xl); 
            }
            catch (Exception ex)
            {

                return InternalServerError(ex);
            }
        }

        [HttpGet]
        [Route("api/xulychamcong/theoNgay")]
        public IHttpActionResult GetDSChamCong(string NgayLam)
        {
            var xltheongay = new List<XuLyChamCong>();
            XLChamCong();
            try
            {
                using (var conn = new SqlConnection(connectionString))
                {
                    using (var cmd = new SqlCommand("sp_DsXlChamCongTheoNgay", conn))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.AddWithValue("@NgayLam", NgayLam);
                        conn.Open();
                        using (var reader = cmd.ExecuteReader())
                        {
                            while (reader.Read())
                            {
                                xltheongay.Add(new XuLyChamCong()
                                {
                                    MaXL = Convert.ToInt32(reader["MaXL"]),
                                    MaNV = reader["MaNV"].ToString(),
                                    TenNV = reader["TenNV"].ToString(),
                                    ThoiGianVao = TimeSpan.Parse(reader["ThoiGianVao"].ToString()),
                                    ThoiGianRa = TimeSpan.Parse(reader["ThoiGianRa"].ToString()),
                                    TongGioLam = Convert.ToSingle(reader["TongGioLam"]),
                                    NgayLam = Convert.ToDateTime(reader["NgayLam"]).ToString("dd/MM/yyyy"),
                                    TrangThai = reader["TrangThai"].ToString()
                                });
                            }
                        }
                    }
                }
                return Ok(xltheongay);
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        [HttpPost]
        public IHttpActionResult ThemChamCong([FromBody] XuLyChamCong themcc)
        {
            if (themcc == null || string.IsNullOrEmpty(themcc.MaNV) || themcc.NgayLam == null || themcc.ThoiGianVao == null || themcc.ThoiGianRa == null)
            {
                return BadRequest("Dữ liệu không hợp lệ.");
            }

            try
            {
                using (var conn = new SqlConnection(connectionString))
                {
                    using (var cmd = new SqlCommand("sp_ThemChamCong", conn))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
           
                        cmd.Parameters.AddWithValue("@MaNV", themcc.MaNV);
                        cmd.Parameters.AddWithValue("@ThoiGianVao", themcc.ThoiGianVao);
                        cmd.Parameters.AddWithValue("@ThoiGianRa", themcc.ThoiGianRa);
                        cmd.Parameters.AddWithValue("@NgayLam", Convert.ToDateTime(themcc.NgayLam));

                        conn.Open();
                        cmd.ExecuteNonQuery();


                    }
                }
            }
            catch (Exception ex)
            {
                return InternalServerError(ex);
            }
            return Ok("Thêm chấm công thành công");
        }

        [HttpPut]
        public IHttpActionResult SuaChamCong([FromBody] XuLyChamCong suaCC)
        {

            try
            {
                using (var conn = new SqlConnection(connectionString))
                {
                    using (var cmd = new SqlCommand("sp_SuaChamCong", conn))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;

                        cmd.Parameters.AddWithValue("@MaNV", suaCC.MaNV);
                        cmd.Parameters.AddWithValue("@NgayLam", Convert.ToDateTime(suaCC.NgayLam));
                        cmd.Parameters.AddWithValue("@ThoiGianVao", suaCC.ThoiGianVao ?? (object)DBNull.Value);
                        cmd.Parameters.AddWithValue("@ThoiGianRa", suaCC.ThoiGianRa ?? (object)DBNull.Value);
                       
                        conn.Open();
                        cmd.ExecuteNonQuery();

                    }
                }
            }
            catch (Exception ex)
            {
                return InternalServerError(ex);
            }
            return Ok("Cập nhật chấm công thành công.");
        }

        [HttpDelete]

        public IHttpActionResult XoaChamCong(int id)
        {
            try
            {
                using (var conn = new SqlConnection(connectionString))
                {
                    using (var cmd = new SqlCommand("sp_XoaChamCong", conn))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.AddWithValue("@MaXL", id);

                        conn.Open();
                        var result = cmd.ExecuteNonQuery();

                        if (result > 0)
                        {
                            return Ok("Xóa chấm công thành công.");
                        }
                        else
                        {
                            return NotFound(); 
                        }
                    }
                }
            }
            catch (Exception ex)
            {

                return InternalServerError(ex);
            }
        }

    }
}

