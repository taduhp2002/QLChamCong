using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace QLChamCong.Model
{
    public class ChamCongTho
    {
        public int MaCC {  get; set; }
        public string MaNV { get; set; }
        public TimeSpan ThoiGianQuet { get; set; }
        public string LoaiQuet { get; set; }
        public string NgayLam { get; set; }

    }
}