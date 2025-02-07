﻿CREATE DATABASE QuanLyNhaKhoa
GO
USE QuanLyNhaKhoa
GO
CREATE TABLE NhanVien
(
	MaNhanVien VARCHAR (10) NOT NULL,
	HoTen NVARCHAR (50),
	Phai NVARCHAR (4),
	NgaySinh DATE,
	DiaChi NVARCHAR (100),
	SDT VARCHAR (12),
	NgayVaoLam DATE,
	LuongCoBan INT,
	PRIMARY KEY(MaNhanVien)
)
CREATE TABLE NhomNguoiDung
(
	MaNhom VARCHAR(20) NOT NULL,
	TenNhom NVARCHAR (50),
	GhiChu NVARCHAR(200),
	PRIMARY KEY(MaNhom)
)
CREATE TABLE NguoiDung
(
	MaNhanVien VARCHAR (10) NOT NULL,
	TenDangNhap VARCHAR(50) NOT NULL,
	MatKhau VARCHAR(50),
	TrangThai NVARCHAR(20),
	PRIMARY KEY(TenDangNhap),
	CONSTRAINT FK_NguoiDung_NhanVien FOREIGN KEY(MaNhanVien) REFERENCES NhanVien(MaNhanVien)
)
CREATE TABLE NguoiDungNhomNguoiDung
(
	TenDangNhap VARCHAR(50) NOT NULL,
	MaNhom VARCHAR(20) NOT NULL,
	GhiChu NVARCHAR(200),
	PRIMARY KEY(TenDangNhap,  MaNhom),
	CONSTRAINT FK_NguoiDung_Nhom FOREIGN KEY(TenDangNhap) REFERENCES NguoiDung(TenDangNhap),
	CONSTRAINT FK_NhomNguoiDung_Nhom FOREIGN KEY(MaNhom) REFERENCES NhomNguoiDung(MaNhom)
)
CREATE TABLE ManHinh
(
	MaManHinh VARCHAR(20) NOT NULL,
	TenManHinh NVARCHAR (50) NOT NULL,	
	PRIMARY KEY(MaManHinh)
)

CREATE TABLE PhanQuyen
(
	MaNhom VARCHAR(20) NOT NULL,
	MaManHinh VARCHAR(20) NOT NULL,
	CoQuyen bit NOT NULL,
	PRIMARY KEY(MaNhom, MaManHinh),
	CONSTRAINT FK_PhanQuyen_NhomNguoiDung FOREIGN KEY(MaNhom) REFERENCES NhomNguoiDung(MaNhom),
	CONSTRAINT FK_PhanQuyen_ManHinh FOREIGN KEY(MaManHinh) REFERENCES ManHinh(MaManHinh)
)
CREATE TABLE BenhNhan
(
	MaBenhNhan VARCHAR (10) NOT NULL,
	MaThe VARCHAR (10),
	HoTen NVARCHAR (50),
	GioiTinh NVARCHAR (4),
	NgaySinh DATE,
	DiaChi NVARCHAR (100),
	SDT VARCHAR (12),
	Email VARCHAR(50),
	PRIMARY KEY(MaBenhNhan)
)
CREATE TABLE PhongKham
(
	MaPhong VARCHAR(10) NOT NULL,
	TenPhong NVARCHAR(50),
	PRIMARY KEY(MaPhong)
)
CREATE TABLE TiepDonBenhNhan
(
	SoPhieu VARCHAR(10) NOT NULL,
	NgayKham DATE NOT NULL,
	LoaiKham NVARCHAR(50),
	LyDoKham NVARCHAR(50),
	TieuDuong NVARCHAR(20),
	BenhTimMach NVARCHAR(20),
	HuyetAp NVARCHAR(20),
	TinhTrang NVARCHAR(50),
	MaBenhNhan VARCHAR (10) NOT NULL,
	MaPhong VARCHAR(10) NOT NULL,
	NhanVienTiepDon VARCHAR (10) NOT NULL,
	BacSi VARCHAR (10),
	PRIMARY KEY(SoPhieu),
	CONSTRAINT FK_TiepDonBenhNhan_BenhNhan FOREIGN KEY(MaBenhNhan) REFERENCES BenhNhan(MaBenhNhan),
	CONSTRAINT FK_TiepDonBenhNhan_PhongKham FOREIGN KEY(MaPhong) REFERENCES PhongKham(MaPhong),
	CONSTRAINT FK_TiepDonBenhNhan_NhanVien FOREIGN KEY(NhanVienTiepDon) REFERENCES NhanVien(MaNhanVien),
	CONSTRAINT FK_TiepDonBenhNhan_BacSi FOREIGN KEY(BacSi) REFERENCES NhanVien(MaNhanVien),
)
CREATE TABLE PhieuKhamBenh
(
	SoPhieu VARCHAR(10) NOT NULL,
	ChuanDoan NVARCHAR(225),
	KetLuan NVARCHAR(225) NOT NULL,
	PRIMARY KEY(SoPhieu),
	CONSTRAINT FK_PhieuKhamBenh_TiepDonBenhNhan FOREIGN KEY(SoPhieu) REFERENCES TiepDonBenhNhan(SoPhieu)
)
CREATE TABLE LoaiDichVu
(
	MaLoai VARCHAR(10) NOT NULL,
	TenLoai NVARCHAR(50),
	PRIMARY KEY(MaLoai)
)
CREATE TABLE DichVu
(
	MaDV VARCHAR(10) NOT NULL,
	TenDV NVARCHAR(100),
	DonGia INT,
	DonViTinh NVARCHAR(50),
	MaLoai VARCHAR(10) NOT NULL,
	PRIMARY KEY(MaDV),
	CONSTRAINT FK_DichVu_LoaiDichVu FOREIGN KEY(MaLoai) REFERENCES LoaiDichVu(MaLoai)
)
CREATE TABLE PhieuDichVu
(
	SoPhieuDV VARCHAR(10) NOT NULL,
	MaBenhNhan VARCHAR (10) NOT NULL,
	MaPhong VARCHAR(10) NOT NULL,
	SoPhieu VARCHAR(10) NOT NULL,
	NgayLap DATE NOT NULL,
	TinhTrang NVARCHAR(20),
	TongTien INT,
	ThanhToan NVARCHAR(20),
	PRIMARY KEY(SoPhieuDV),
	CONSTRAINT FK_PhieuDV_BenhNhan FOREIGN KEY(MaBenhNhan) REFERENCES BenhNhan(MaBenhNhan),
	CONSTRAINT FK_PhieuDV_Phong FOREIGN KEY(MaPhong) REFERENCES PhongKham(MaPhong),
	CONSTRAINT FK_PhieuDV_PhieuKham FOREIGN KEY(SoPhieu) REFERENCES PhieuKhamBenh(SoPhieu)
)
CREATE TABLE CTPhieuDichVu
(
	SoPhieuDV VARCHAR(10) NOT NULL,
	MaDV VARCHAR(10) NOT NULL,
	PRIMARY KEY(SoPhieuDV,MaDV),
	CONSTRAINT FK_CTPhieuDV_DV FOREIGN KEY(MaDV) REFERENCES DichVu(MaDV),
	CONSTRAINT FK_CTPhieuDV_PDV FOREIGN KEY(SoPhieuDV) REFERENCES PhieuDichVu(SoPhieuDV)
)
CREATE TABLE PhieuKetQua
(
	
	SoPhieuKQ VARCHAR(10) NOT NULL,
	TenDV NVARCHAR(100),
	SoPhieuDV VARCHAR(10) NOT NULL,
	HinhAnh TEXT,
	KetLuan NVARCHAR(50),
	PRIMARY KEY(SoPhieuKQ),
	CONSTRAINT FK_PhieuKQ_PDV FOREIGN KEY(SoPhieuDV) REFERENCES PhieuDichVu(SoPhieuDV)
)
GO

--NHẬP DỮ LIỆU
SET DATEFORMAT DMY
INSERT INTO NhanVien
VALUES
('NV001', N'Ngô Văn Mười', N'Nam', '08/09/1999', N'123 Nguyễn Hữu Tiến, Tây Thạnh, Tân Phú, Tp.Hcm', '0392419643', '30/05/2010', 200000),
('NV002', N'Nguyễn Thị Thùy Dương', N'Nữ', '23/05/2001', N'11/50 Nguyễn Hữu Tiến, Tây Thạnh, Tân Phú, Tp.Hcm', '0351248625', '02/06/2020', 110000),
('NV003', N'Chung Tử Đơn', N'Nam', '21/03/1990', N'11 Bàu Bàng, Phường 13, Tân Bình, Tp.HCM', '0935224412', '12/05/2015', 200000),
('NV004', N'Châu Nhuận Phát ', N'Nam', '15/12/1991', N'64 Đường số 17, Linh Trung, Thủ Đức', '0392419643', '30/05/2010', 200000),
('NV005', N'Lý Gia Hân', N'Nữ', '01/10/1995', N'4 đường D11, P.Tây Thạnh ,Q.Tân Phú, Tp.Hcm', '0924032217', '21/12/2018', 150000),
('NV006', N'Huỳnh Thúy Như', N'Nữ', '16/02/1993', N'37 Trần Quý Cáp, Phường 11, Q.Bình Thạnh, Tp.Hcm', '0935124588', '04/11/2019', 120000),
('NV007', N'Trần Mỹ Loan', N'Nữ', '29/07/1996', N'30 Kha Vạn Cân, Hiệp Bình Chánh, Thủ Đức', '0322548963', '04/11/2019', 120000),
('NV008', N'Bùi Hoàng Khánh Ngọc', N'Nữ', '30/05/1999', N' 60 Giang Văn Minh, An Phú, Q.2, Tp.Hcm', '0935010234', '04/11/2019', 120000),
('NV009', N'Trương Trung Hiếu', N'Nam', '28/02/1990', N'224 Hoàng Hoa Thám, Phường 13, Q.Tân Bình, Tp.Hcm', '0396542214', '04/11/2019', 120000),
('NV010', N'Bùi Hồng Ngọc', N'Nữ', '14/01/1997', N'130 Hoàng Văn Thụ, Phường 9, Q.Phú Nhuận, Tp.Hcm', '0987362214', '04/11/2019', 120000),
('NV011', N'Võ Trường Giang', N'Nam', '23/03/1996', N'25 Cao Thắng, Phường 11, Q.3, Tp.Hcm', '0365210025', '04/11/2019', 120000),
('NV012', N'Trương Thế Vinh', N'Nam', '20/11/1995', N'135 Điện Biên Phủ, P.Đa Kao, Q.1, Tp.Hcm', '0123547824', '04/11/2019', 120000)

INSERT INTO NhomNguoiDung
VALUES
('admin',N'Quản lý',N'admin nnè'),
('BS',N'Bác sĩ',N'Bác sĩ nè'),
('ThuNgan',N'Thu Ngân',N'dành cho thu ngân'),
('LeTan',N'Lễ Tân',N'hihi')

INSERT INTO NguoiDung
VALUES
('NV001','ngo10','32441859',N'Hoạt động'),
('NV002','duong','32441859',N'Hoạt động'),
('NV003','don123','32441859',N'Hoạt động'),
('NV004','phat1','32441859',N'Hoạt động'),
('NV005','giahan','32441859',N'Hoạt động'),
('NV006','nhu01','32441859',N'Hoạt động')

INSERT INTO NguoiDungNhomNguoiDung
VALUES
('ngo10','admin',N'không có ghi chú'),
('duong','LeTan',N'hehe'),
('don123','BS',N'chung tử đơn'),
('phat1','BS',N'anh phát'),
('giahan','BS',N'hân hân'),
('nhu01','BS',N'như nè')

INSERT INTO ManHinh
VALUES
('ribbThuNgan',N'Màn hình nghiệp vụ thu ngân'),
('ribbBacSi',N'Màn hình nghiệp vụ bác sĩ'),
('ribbCaNhan',N'Màn hình cá nhân'),
('ribbThongKe',N'Màn hình thống kê'),
('ribbQuanLy',N'Màn hình quản lý'),
('ribbLeTan',N'Màn hình lễ tân')

INSERT INTO PhanQuyen
VALUES
('admin','ribbCaNhan',1),
('LeTan','ribbCaNhan',1),
('BS','ribbCaNhan',1),
('ThuNgan','ribbCaNhan',1),
('BS','ribbQuanLy',0),
('ThuNgan','ribbQuanLy',0),
('admin','ribbQuanLy',1),
('LeTan','ribbQuanLy',0),
('admin','ribbThongKe',1),
('LeTan','ribbThongKe',0),
('BS','ribbThongKe',0),
('ThuNgan','ribbThongKe',1),
('admin','ribbLeTan',1),
('LeTan','ribbLeTan',1),
('BS','ribbLeTan',0),
('ThuNgan','ribbLeTan',1),
('admin','ribbBacSi',1),
('LeTan','ribbBacSi',0),
('BS','ribbBacSi',1),
('ThuNgan','ribbBacSi',0),
('admin','ribbThuNgan',1),
('LeTan','ribbThuNgan',1),
('BS','ribbThuNgan',0),
('ThuNgan','ribbThuNgan',1)

SET DATEFORMAT DMY
INSERT INTO BenhNhan
VALUES
('BN001', '', N'Viên Vịnh Nghi', N'Nữ', '02/03/1991', N'61/11, Đường Liên Khu 5 - 6, Phường Bình Hưng Hoà B, Quận Bình Tân', '0365882156', 'nghitv@gmail.com'),
('BN002', '', N'Ngô Mạnh Đạt', N'Nam', '11/06/1988', N'12 Đường số 66, Phường 10, Quận 6', '0326510015', 'datmocsung@gmail.com'),
('BN003', '', N'Khưu Thục Trinh', N'Nữ', '10/03/1990', N'75, Long Thuận, Phường Trường Thạnh, Quận 9', '0935125572', 'trinh123@gmail.com'),
('BN004', '', N'Trương Mẫn', N'Nữ', '23/05/1993', N'112 Đường Nguyễn Đình Chiểu, Phường 4, Quận Phú Nhuận', '0123452568', 'manman@gmail.com'),
('BN005', '', N'Trương Quốc Vinh', N'Nam', '28/04/1991', N'79, Đường Giải Phóng, Phường 4, Quận Tân Bình', '0932561004', 'quocvinh@gmail.com'),
('BN006', '', N'Lưu Đức Hoa', N'Nam', '06/12/1989', N'281/2, Phường 13, Quận Bình Thạnh', '0123005699', 'luuhoa11@gmail.com'),
('BN007', '', N'Lý Liên Kiệt', N'Nam', '17/12/1994', N'79, Đường Trung Chánh, Phường Trung Mỹ Tây, Quận 12', '0935122452', 'lykiet102@gmail.com'),
('BN008', '', N'Phạm Băng Băng', N'Nữ', '10/01/1995', N'111 Đường Nguyễn Văn Đậu, Phường 11, Quận Bình Thạnh', '0389802451', 'bangcute@gmail.com'),
('BN009', '', N'Triệu Hựu Đình', N'Nam', '03/08/1992', N'76 Đường Phan Xích Long, Phường 7, Quận Phú Nhuận', '0914563652', 'dinh3sinh@gmail.com'),
('BN010', '', N'Triệu Lệ Dĩnh', N'Nữ', '26/12/1993', N'Đường 16, Phường Tân Phú, Quận 7', '0989651246', 'bedinhdethuong@gmail.com')

INSERT INTO PhongKham
VALUES
('PDV003',N'Phòng Dịch Vụ 1'),
('PDV004',N'Phòng Dịch Vụ 2'),
('PK001',N'Phòng Khám 1'),
('PK002',N'Phòng Khám 2')

SET DATEFORMAT DMY
INSERT INTO TiepDonBenhNhan
VALUES
('PH01-001','16/06/2021', N'Khám miễn phí', N'Khám miệng-đau nhức răng hàm', N'Không', N'Không', N'Trung bình', N'Đã khám', 'BN003', 'PK001', 'NV001', 'NV006'),
('PH01-002','17/06/2021', N'Khám miễn phí', N'Khám miệng-chảy máu chân răng', N'Không', N'Không', N'Trung bình',N'Chờ khám', 'BN001', 'PK001', 'NV001', 'NV005'),
('PH01-003','01/07/2021', N'Khám miễn phí', N'Khám miệng-đau nhức răng hàm', N'Không', N'Không', N'Trung bình', N'Chờ khám', 'BN002', 'PK001', 'NV001', 'NV006')

INSERT INTO LoaiDichVu
VALUES
('L001',N'Chụp X-Quang'),
('L002',N'Bọc Răng Sứ'),
('L003',N'Cấy Ghép Implant'),
('L004',N'Niềng Răng Thẩm Mỹ'),
('L005',N'Tẩy Trắng Răng'),
('L006',N'Nhổ Răng Khôn'),
('L007',N'Xử Lý Răng Sâu'),
('L008',N'Điều Trị Nha Chu')

INSERT INTO DichVu
VALUES
('DV001',N'Chụp xquang quanh chóp Digital Xray',40000,N'1 Răng','L001'),
('DV002',N'Chụp x quang răng toàn cảnh Panorama',40000,N'1 Lần','L001'),
('DV003',N'Chụp X-ray Occlusal',45000,N'1 Lần','L001'),
('DV004',N'Răng Inox.',500000,N'1 Răng','L002'),
('DV005',N'Răng sứ kim loại',1000000,N'1 Răng','L002'),
('DV006',N'Răng sứ hợp kim Titan',2500000,N'1 Răng','L002'),
('DV007',N'Răng sứ Crom Cobalt 3.5',3500000,N'1 Răng','L002'),
('DV008',N'Răng sứ toàn sứ Zirconia',5000000,N'1 Răng','L002'),
('DV009',N'Răng sứ Cercon',5500000,N'1 Răng','L002'),
('DV010',N'Răng sứ Lava Plus',7000000,N'1 Răng','L002'),
('DV011',N'Venneer sứ',6000000,N'1 Răng','L002'),
('DV012',N'Nail Venneer sứ siêu mỏng',12000000,N'1 Răng','L002'),
('DV013',N'Scan Digital',500000,N'1 Lần','L001'),
('DV014',N'Implant Dio – Hàn Quốc',9500000,N'1 Trụ','L003'),
('DV015',N'Implant California – Mỹ',11700000,N'1 Trụ','L003'),
('DV016',N'Implant C1 – Đức',15200000,N'1 Trụ','L003'),
('DV017',N'Implant Straumann – Thụy Sĩ',21000000,N'1 Trụ','L003'),
('DV018',N'Niềng răng trong suốt Invisalign',90000,N'2 Hàm','L004'),
('DV019',N'Mắc cài Sino Trung Quốc',18000000,N'2 Hàm','L004'),
('DV020',N'Mắc cài thép buộc chun',27000000,N'2 Hàm','L004'),
('DV021',N'Mắc cài tự khóa thông minh',32000000,N'2 Hàm','L004'),
('DV022',N'Mắc cài Pitts',35000000,N'2 Hàm','L004'),
('DV023',N'Mắc cài sứ thẩm mỹ',42000000,N'2 Hàm','L004'),
('DV024',N'Mắc cài sứ thẩm mỹ thông minh',50000000,N'2 Hàm','L004'),
('DV025',N'Tẩy trắng răng tại nhà 2 ống thuốc (Máng tẩy trắng răng)',700000,N'1 Lần','L005'),
('DV026',N'Tẩy trắng răng tại phòng khám',1000000,N'1 Lần','L005'),
('DV027',N'Tẩy trắng răng kết hợp tại nhà 2 ống thuốc & tại phòng khám',1500000,N'1 Lần','L005'),
('DV028',N'Răng khôn mọc dễ',500000,N'1 Răng','L006'),
('DV029',N'Răng khôn mọc khó loại 1',1000000,N'1 Răng','L006'),
('DV030',N'Răng khôn mọc khó loại 2',2000000,N'1 Răng','L006'),
('DV031',N'Răng khôn mọc khó loại 3',3500000,N'1 Răng','L006'),
('DV032',N'Trám răng sữa',70000,N'1 Răng','L007'),
('DV033',N'Trám răng mòn cổ',250000,N'1 Răng','L007'),
('DV034',N'Trám răng sâu (không lấy tủy) composite',300000,N'1 Răng','L007'),
('DV035',N'Trám răng sâu (không lấy tủy) GIC',150000,N'1 Răng','L007'),
('DV036',N'Trám kẽ răng',300000,N'1 Răng','L007'),
('DV037',N'Đắp mặt răng',400000,N'1 Răng','L007'),
('DV038',N'Chữa tủy răng cửa',500000,N'1 Răng','L007'),
('DV039',N'Chữa tủy răng tiền cối',700000,N'1 Răng','L007'),
('DV040',N'Chữa tủy răng cối lớn',1000000,N'1 Răng','L007'),
('DV041',N'Điều trị nha chu mức 1',1000000,N'1 Lần','L008'),
('DV042',N'Điều trị nha chu mức 2',2500000,N'1 Lần','L008'),
('DV043',N'Điều trị nha chu mức 3',5000000,N'1 Lần','L008'),
('DV044',N'Điều trị nha chu mức 4',10000000,N'1 Lần','L008')

