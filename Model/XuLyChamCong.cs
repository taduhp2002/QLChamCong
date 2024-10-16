using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace QLChamCong.Model
{
    public class XuLyChamCong
    {
        public int MaXL { get; set; }
        public string MaNV { get; set; }
        public string TenNV { get; set; }
        public TimeSpan? ThoiGianVao {  get; set; }
        public TimeSpan? ThoiGianRa { get; set; }
        public float? TongGioLam { get; set; }
        public string NgayLam { get; set; }
        public string TrangThai { get; set; }

    }
}