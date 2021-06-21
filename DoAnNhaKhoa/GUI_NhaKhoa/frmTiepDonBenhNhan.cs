﻿using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using DevExpress.XtraReports.UI;
using GUI_NhaKhoa.BLL_NhaKhoa;
namespace GUI_NhaKhoa
{
    public partial class frmTiepDonBenhNhan : Form
    {
        BLLTiepDonBenhNhan tiepDonBenhNhan = new BLLTiepDonBenhNhan();
        public string TiepDon { get; set; }
        bool them = false;
        public frmTiepDonBenhNhan()
        {
            InitializeComponent();
            // This line of code is generated by Data Source Configuration Wizard
            cbbMaBN.Properties.DataSource = new GUI_NhaKhoa.BLL_NhaKhoa.QuanLyNhaKhoaDataContext().BenhNhans;
        }
        void LoadData()
        {
            tiepDonBenhNhan.LayPhongKham(cbbPhong);
            tiepDonBenhNhan.LayBacSi(cbbBacSi);
            
            cbbMaBN.Properties.DataSource = tiepDonBenhNhan.LayBenhNhan();
            cbbMaBN.Properties.DisplayMember = "MaBenhNhan";
            cbbMaBN.Properties.ValueMember = "MaBenhNhan";
            txtTiepDon.Text = TiepDon;
            cbbNgayKham.Text = DateTime.Now.ToString("dd/MM/yyyy");
            tiepDonBenhNhan.LayThongTin(dtgvDS, cbbNgayKham.Text);
            btnXoa.Enabled = false;
            btnSua.Enabled = false;
            btnLuu.Enabled = false;
            btnThem.Enabled = true;

            cbbLoaiKham.Enabled = false;
            cbbMaBN.Enabled = false;
            txtHoTen.Enabled = false;
            txtMaThe.Enabled = false;
            cbbGioiTinh.Enabled = false;
            txtNgaySinh.Enabled = false;
            txtSDT.Enabled = false;
            txtDiaChi.Enabled = false;
            cbbNgayKham.Enabled = true;
            cbbPhong.Enabled = false;
            txtTiepDon.Enabled = false;
            cbbBacSi.Enabled = false;
            txtLyDo.Enabled = false;
            cbbTieuDuong.Enabled = false;
            cbbTimMach.Enabled = false;
            cbbHuyetAp.Enabled = false;

        }
        private void frmTiepDonBenhNhan_Load(object sender, EventArgs e)
        {
            //cbbMaBN.Properties.DataSource = tiepDonBenhNhan.LayBenhNhan();
            //cbbMaBN.Properties.DisplayMember = "Mã BN";
            //cbbMaBN.Properties.ValueMember = "Mã BN";
        }

        private void btnThemBN_Click(object sender, EventArgs e)
        {
            frmQuanLyBenhNhan benhNhan = new frmQuanLyBenhNhan();
            benhNhan.Text = "Thêm mới bệnh nhân";
            benhNhan.ShowDialog();
            
        }

        private void frmTiepDonBenhNhan_Load_1(object sender, EventArgs e)
        {
            LoadData();
        }

        private void cbbLoaiKham_TextChanged(object sender, EventArgs e)
        {
            if (cbbLoaiKham.Text == "Tái khám")
            {
                btnThemBN.Enabled = false;
            }
            else
                btnThemBN.Enabled = true;
        }

        private void cbbMaBN_TextChanged(object sender, EventArgs e)
        {
            tiepDonBenhNhan.LayTTBenhNhan(cbbMaBN.Text, txtMaThe, txtHoTen, cbbGioiTinh, txtNgaySinh, txtDiaChi, txtSDT);
        }

        private void dtgvDS_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {          
            txtSoPhieu.Text = dtgvDS.CurrentRow.Cells[0].Value.ToString();
            txtHoTen.Text = dtgvDS.CurrentRow.Cells[1].Value.ToString();
            cbbPhong.Text = dtgvDS.CurrentRow.Cells[2].Value.ToString();
            cbbNgayKham.Text = dtgvDS.CurrentRow.Cells[3].Value.ToString();
            cbbLoaiKham.Text = dtgvDS.CurrentRow.Cells[4].Value.ToString();
            txtLyDo.Text = dtgvDS.CurrentRow.Cells[5].Value.ToString();
            cbbTieuDuong.Text = dtgvDS.CurrentRow.Cells[6].Value.ToString();
            cbbTimMach.Text = dtgvDS.CurrentRow.Cells[7].Value.ToString();
            cbbHuyetAp.Text = dtgvDS.CurrentRow.Cells[8].Value.ToString();
            //string mabs = dtgvDS.CurrentRow.Cells[0].Value.ToString();
            cbbBacSi.Text = tiepDonBenhNhan.LayTenBS(txtSoPhieu.Text, cbbNgayKham.Text);
        }

        private void txtHoTen_TextChanged(object sender, EventArgs e)
        {
            string mabn = tiepDonBenhNhan.LayMaBenhNhan(txtHoTen.Text);
            cbbMaBN.Text = mabn;
            tiepDonBenhNhan.LayTTBenhNhan(mabn, txtMaThe, txtHoTen, cbbGioiTinh, txtNgaySinh, txtDiaChi, txtSDT);           
            btnXoa.Enabled = true;
            btnSua.Enabled = true;
        }

        private void btnThem_Click(object sender, EventArgs e)
        {
            them = true;

            btnThem.Enabled = false;
            btnXoa.Enabled = false;
            btnSua.Enabled = false;
            btnLuu.Enabled = true;
            btnLaySoPhieu.Enabled = false;

            cbbLoaiKham.Enabled = true;
            cbbMaBN.Enabled = true;
            txtHoTen.Enabled = true;
            txtMaThe.Enabled = true;
            cbbGioiTinh.Enabled = true;
            txtNgaySinh.Enabled = true;
            txtSDT.Enabled = true;
            txtDiaChi.Enabled = true;
            cbbNgayKham.Enabled = true;
            cbbPhong.Enabled = true;
            txtTiepDon.Enabled = true;
            cbbBacSi.Enabled = true;
            txtLyDo.Enabled = true;
            cbbTieuDuong.Enabled = true;
            cbbTimMach.Enabled = true;
            cbbHuyetAp.Enabled = true;
            
            cbbLoaiKham.Text = "Chọn loại khoám";
            txtSoPhieu.ResetText();
            cbbNgayKham.Text = DateTime.Now.ToString("dd/MM/yyyy");
            txtLyDo.ResetText();
            cbbTieuDuong.Text = "Chưa chọn";
            cbbTimMach.Text = "Chưa chọn";
            cbbHuyetAp.Text = "Chưa chọn";
        }

        private string LaySoPhieuTuDong(string pPhong)
        {
            //try
            //{
            DataTable dt = tiepDonBenhNhan.LayDSTiepDonTheoPhong(pPhong, cbbNgayKham.Text);
            int count = dt.Rows.Count;
            string phieu = "";
            string soPhieuMoi = "";
            int soPhieu = 0;
            if(count == 0 && pPhong == "PK001")
            {
                return "PH01-01";
            }
            else if(count == 0 && pPhong == "PK002")
            {
                return "PH02-01";
            }
            else if( count != 0 && pPhong == "PK001")
            {
                phieu = dt.Rows[count -1][0].ToString();
                soPhieu = Convert.ToInt32((phieu.Remove(0, 5)));
                if (soPhieu + 1 < 10)
                {
                    soPhieuMoi = "PH01-0" + (soPhieu + 1).ToString();
                }
                else if (soPhieu + 1 < 100)
                {
                    soPhieuMoi = "PH01-" + (soPhieu + 1).ToString();
                }
                else if (soPhieu + 1 < 1000)
                {
                    soPhieuMoi = "PH01-1" + (soPhieu + 1).ToString();
                }
                return soPhieuMoi;
            }
            else if (count != 0 && pPhong == "PK002")
            {
                phieu = dt.Rows[count - 1][0].ToString();
                soPhieu = Convert.ToInt32((phieu.Remove(0, 5)));
                if (soPhieu + 1 < 10)
                {
                    soPhieuMoi = "PH02-0" + (soPhieu + 1).ToString();
                }
                else if (soPhieu + 1 < 100)
                {
                    soPhieuMoi = "PH02-" + (soPhieu + 1).ToString();
                }
                else if (soPhieu + 1 < 1000)
                {
                    soPhieuMoi = "PH02-1" + (soPhieu + 1).ToString();
                }
                return soPhieuMoi;
            }
            return soPhieuMoi;
            //}
            //catch { return "Lỗi"; }
        }

        private void cbbPhong_TextChanged(object sender, EventArgs e)
        {
            string maPhong = tiepDonBenhNhan.LayMaPhongKham(cbbPhong.Text);
            if (cbbPhong.Text == "Chưa chọn phòng khám")
            {
                txtSoPhieu.Text = "";
            }
            else
            {
                txtSoPhieu.Text = LaySoPhieuTuDong(maPhong);
            }
            
        }

        private void cbbNgayKham_TextChanged(object sender, EventArgs e)
        {
            string maPhong = tiepDonBenhNhan.LayMaPhongKham(cbbPhong.Text);
            if (cbbPhong.Text == "Chưa chọn phòng khám")
            {
                txtSoPhieu.Text = "";
            }
            else
            {
                txtSoPhieu.Text = LaySoPhieuTuDong(maPhong);
            }
            tiepDonBenhNhan.LayThongTin(dtgvDS, cbbNgayKham.Text);
        }

        private void btnLuu_Click(object sender, EventArgs e)
        {

            string soPhieu = txtSoPhieu.Text;
            string ngayKham = cbbNgayKham.Text;
            string loaiKham = cbbLoaiKham.Text;
            string lyDo = txtLyDo.Text;
            string tieuDuong = cbbTieuDuong.Text;
            string timMach = cbbTimMach.Text;
            string huyetAp = cbbHuyetAp.Text;
            string tinhTrang = "Chờ khám";
            string maBN = cbbMaBN.Text;
            string maPhong = tiepDonBenhNhan.LayMaPhongKham(cbbPhong.Text);
            string tiepDon = tiepDonBenhNhan.LayMaNV(txtTiepDon.Text);
            string bacSi = tiepDonBenhNhan.LayMaNV(cbbBacSi.Text); ; 
            
            try
            {
                if (them)
                {
                    try
                    {
                        tiepDonBenhNhan.ThemTiepDon(soPhieu, ngayKham, loaiKham, lyDo, tieuDuong, timMach, huyetAp, tinhTrang, maBN, maPhong, tiepDon, bacSi);
                        LoadData();
                        tiepDonBenhNhan.LayThongTin(dtgvDS, cbbNgayKham.Text);
                        MessageBox.Show("Thêm thông tin tiếp đón thành công");
                    }
                    catch
                    {
                        MessageBox.Show("Thêm thông tin tiếp đón thất bại");
                        LoadData();
                    }

                }
                else
                {
                    try
                    {
                        tiepDonBenhNhan.SuaTiepDon(soPhieu, ngayKham, loaiKham, lyDo, tieuDuong, timMach, huyetAp, tinhTrang, maBN, maPhong, tiepDon, bacSi);
                        LoadData();
                        tiepDonBenhNhan.LayThongTin(dtgvDS, cbbNgayKham.Text);
                        MessageBox.Show("Sửa thông tin tiếp đón thành công");
                    }
                    catch
                    {
                        MessageBox.Show("Sửa thông tin tiếp đón thất bại");
                        LoadData();
                    }
                }
            }
            catch
            {
                MessageBox.Show("Lỗi rồi");
            }
        }

        private void btnXoa_Click(object sender, EventArgs e)
        {
            DialogResult xoa;
            xoa = MessageBox.Show("Bạn có chắc muốn xóa thông tin tiếp đón này chứ ?", "Cảnh báo", MessageBoxButtons.YesNo, MessageBoxIcon.Question);
            if (xoa == DialogResult.Yes)
            {
                try
                {
                    if (tiepDonBenhNhan.XoaTiepDon(txtSoPhieu.Text))
                    {
                        LoadData();
                        tiepDonBenhNhan.LayThongTin(dtgvDS, cbbNgayKham.Text);
                        MessageBox.Show("Xóa thông tin tiếp đón thành công", "Thông báo");
                    }
                    else
                    {
                        MessageBox.Show("Xóa thông tin tiếp đón thất bại", "Thông Báo");
                    }
                }
                catch
                {
                    MessageBox.Show("Lỗi rồi", "Thông báo");
                }
            }
        }

        private void btnSua_Click(object sender, EventArgs e)
        {
            them = false;
            btnThem.Enabled = false;
            btnXoa.Enabled = false;
            btnSua.Enabled = false;
            btnLuu.Enabled = true;
            btnIn.Enabled = false;
            btnLaySoPhieu.Enabled = false;
            cbbPhong.Enabled = true;
            cbbBacSi.Enabled = true;
            txtLyDo.Enabled = true;
            cbbTieuDuong.Enabled = true;
            cbbTimMach.Enabled = true;
            cbbHuyetAp.Enabled = true;

        }

        private void btnIn_Click(object sender, EventArgs e)
        {
            DataTable dt = new DataTable();
            dt = tiepDonBenhNhan.RPPhieuDangKyKham(txtSoPhieu.Text, cbbNgayKham.Text);
            RPPhieuDangKyKham rp = new RPPhieuDangKyKham();
            rp.DataSource = dt;
            rp.NguoiLap = txtTiepDon.Text;
            rp.ShowPreview();
        }

        private void btnLaySoPhieu_Click(object sender, EventArgs e)
        {
            DataTable dt = new DataTable();
            dt = tiepDonBenhNhan.RPSoPhieu(txtSoPhieu.Text, cbbNgayKham.Text);
            RPSoPhieu rp = new RPSoPhieu();
            rp.DataSource = dt;
            rp.ShowPreview();
        }
    }
}
