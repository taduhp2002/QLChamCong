using QLChamCong.Model;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;

namespace QLChamCong.Controller
{
    public class ChamCongController : ApiController
    {
        private readonly string connectionstring = ConfigurationManager.ConnectionStrings["AttendanceDB"].ConnectionString;

        [HttpGet]
        [Route("api/chamcong/theoNgay")]
        public IHttpActionResult DsChamCongTho(string NgayLam)
        {
            var chamcongtho = new List<ChamCongTho>();
            try
            {
                using (var conn = new SqlConnection(connectionstring))
                {
                    using (var cmd = new SqlCommand("sp_DsQuetCongTheoNgay", conn))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.AddWithValue("@NgayLam", NgayLam);
                        conn.Open();
                        using (var reader = cmd.ExecuteReader())
                        {
                            while (reader.Read())
                            {
                                chamcongtho.Add(new ChamCongTho()
                                {
                                    MaCC = Convert.ToInt32(reader["MaCC"]),
                                    MaNV = reader["MaNV"].ToString(),
                                    ThoiGianQuet = TimeSpan.Parse(reader["ThoiGianQuet"].ToString()),
                                    LoaiQuet = reader["LoaiQuet"].ToString(),
                                    NgayLam = Convert.ToDateTime(reader["NgayLam"]).ToString("dd/MM/yyyy")  
                                });
                            }
                        }
                    }
                }
                return Ok(chamcongtho);
            }
            catch (Exception ex)
            {
                return InternalServerError(ex);  
            }
        }


        [HttpPost]
        public IHttpActionResult QuetCong([FromBody] ChamCongTho record)
        {
            try
            {
                using (SqlConnection conn = new SqlConnection(connectionstring))
                {
                    conn.Open();
                   
                    using (SqlCommand cmd = new SqlCommand("sp_QuetCong", conn))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;

                        cmd.Parameters.AddWithValue("@MaNV", record.MaNV);
                        cmd.Parameters.AddWithValue("@ThoiGianQuet", record.ThoiGianQuet);
                        cmd.Parameters.AddWithValue("@LoaiQuet", record.LoaiQuet);
                        cmd.Parameters.AddWithValue("@NgayLam", record.NgayLam);

                        
                        SqlParameter returnValue = new SqlParameter
                        {
                            Direction = ParameterDirection.ReturnValue
                        };
                        cmd.Parameters.Add(returnValue);

                        cmd.ExecuteNonQuery();

                        int result = (int)returnValue.Value;

                        if (result == 0)
                        {
                            return BadRequest("Mã nhân viên không tồn tại.");
                        }
                    }
                }
                return Ok("Quét công thành công");
            }
            catch (Exception ex)
            {
                return InternalServerError(ex);
            }
        }


    }
}
