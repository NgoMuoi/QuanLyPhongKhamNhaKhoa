﻿using DevExpress.XtraEditors;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using GUI_NhaKhoa.BLL_NhaKhoa;
namespace GUI_NhaKhoa
{
    public partial class frmDangNhap : DevExpress.XtraEditors.XtraForm
    {
        BLLDangNhap bLLDangNhap = new BLLDangNhap();
        BLLConfig bLLConfig = new BLLConfig();

        public string MaNVDangChon { get; set; }
        public string TenNVDangChon { get; set; }
        public string QuyenNVDangChon { get; set; }
        public string TenTK { get; set; }

        public frmDangNhap()
        {
            InitializeComponent();
        }

        private void frmDangNhap_Load(object sender, EventArgs e)
        {

        }

        private void btn_login_Click(object sender, EventArgs e)
        {
            int kq = bLLConfig.Check_Config();
            if (kq == 0)
            {
                ProcessLogin();
            }
            if (kq == 1)
            {
                MessageBox.Show("Chuỗi cấu hình không tồn tại");
                ProcessConfig();
            }
            if (kq == 2)
            {
                MessageBox.Show("Chuỗi cấu hình không phù hợp");
                ProcessConfig();
            }
            
        }
        public void ProcessLogin()
        {
            try
            {
                if (bLLDangNhap.LayTaiKhoan(txtTaiKhoan.Text, txtMatKhau.Text) == 1 && bLLDangNhap.LayTrangThai(txtTaiKhoan.Text, txtMatKhau.Text) == "Hoạt động")
                {
                    TenNVDangChon = bLLDangNhap.LayTenNV(txtTaiKhoan.Text, txtMatKhau.Text);
                    QuyenNVDangChon = bLLDangNhap.LayQuyenNV(txtTaiKhoan.Text, txtMatKhau.Text);
                    MaNVDangChon = bLLDangNhap.LayMaNV(txtTaiKhoan.Text, txtMatKhau.Text);
                    TenTK = txtTaiKhoan.Text;
                    MessageBox.Show("Đăng nhập thành công", "Thông báo");
                    frmHome home = new frmHome();
                    home.TenNV = TenNVDangChon;
                    home.Quyen = QuyenNVDangChon;
                    home.TK = MaNVDangChon;
                    home.TenDN = TenTK;
                    home.Show();
                    this.Hide();
                }
                else if (bLLDangNhap.LayTaiKhoan(txtTaiKhoan.Text, txtMatKhau.Text) == 1 && bLLDangNhap.LayTrangThai(txtTaiKhoan.Text, txtMatKhau.Text) == "Khóa")
                {
                    MessageBox.Show("Tài khoản đã bị khóa", "Thông báo");                    
                }
                else
                {
                    MessageBox.Show("Đăng nhập thất bại, kiểm tra lại tài khoản và mật khẩu", "Thông báo");
                }
            }
            catch
            {
                MessageBox.Show("Đăng nhập thất bại", "Thông báo");
            }

        }
        public void ProcessConfig()
        {
            frmKetNoi ketNoi = new frmKetNoi();
            ketNoi.ShowDialog();
        }
        private void btn_thoat_Click(object sender, EventArgs e)
        {
            DialogResult dialog;
            dialog = MessageBox.Show("Bạn có muốn thoát khỏi chương trình hay không", "Cảnh báo", MessageBoxButtons.YesNo, MessageBoxIcon.Question);
            if (dialog == DialogResult.Yes)
            {
                Application.Exit();
            }
        }

        private void frmDangNhap_FormClosed(object sender, FormClosedEventArgs e)
        {
            Application.Exit();
        }
    }
}