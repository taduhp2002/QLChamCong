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
    public class NhanVienController : ApiController
    {
        private readonly string connectionstring = ConfigurationManager.ConnectionStrings["AttendanceDB"].ConnectionString;
        [HttpGet]
        public IEnumerable<NhanVien> GetNhanVienList()
        {
            try
            {
                List<NhanVien> nv = new List<NhanVien>();
                using (SqlConnection conn = new SqlConnection(connectionstring))
                {
                    using (SqlCommand cmd = new SqlCommand("sp_GetEmployeeList", conn))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        conn.Open();
                        using (SqlDataReader reader = cmd.ExecuteReader())
                        {
                            while (reader.Read())
                            {
                                nv.Add(new NhanVien
                                {
                                    MaNV = reader["MaNV"].ToString(),
                                    TenNV = reader["TenNV"].ToString(),
                                    GioiTinh = reader["GioiTinh"].ToString(),
                                    NgaySinh = Convert.ToDateTime(reader["NgaySinh"]).ToString("dd/MM/yyyy"),
                                    SĐT = reader["SĐT"].ToString(),
                                    PhongBan = reader["PhongBan"].ToString(),
                                    ChucVu = reader["ChucVu"].ToString(),
                                });

                            }
                        }
                    }
                }
                return nv;
            }
            catch (Exception ex)
            {
                throw ex;
            }

        }

       

    }
}