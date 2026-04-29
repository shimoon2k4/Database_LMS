DROP DATABASE IF EXISTS LMS_Group9;
CREATE DATABASE LMS_Group9 CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE LMS_Group9;

-- 1. Bảng NguoiDung
CREATE TABLE NguoiDung (
    MaSoTaiKhoan VARCHAR(20) PRIMARY KEY,
    TenDangNhap VARCHAR(50) NOT NULL,
    MatKhau VARCHAR(255) NOT NULL,
    Email VARCHAR(100) NOT NULL,
    HoVaTen VARCHAR(100) NOT NULL,
    VaiTro ENUM('Student', 'Lecturer', 'Admin') NOT NULL,
    NgayThamGia DATE NOT NULL,
    ThoiGianHoatDongGanNhat DATETIME NULL,
    TrangThaiTaiKhoan ENUM('Active', 'Locked') NOT NULL DEFAULT 'Active',

    CONSTRAINT UQ_NguoiDung_TenDangNhap UNIQUE (TenDangNhap),
    CONSTRAINT UQ_NguoiDung_Email UNIQUE (Email)
);

-- 2. Bảng SinhVien
CREATE TABLE SinhVien (
    MaSoTaiKhoan VARCHAR(20) PRIMARY KEY,
    NienKhoa VARCHAR(20) NOT NULL,
    KhoaChuyenNganh VARCHAR(100) NOT NULL
);

-- 3. Bảng GiangVien
CREATE TABLE GiangVien (
    MaSoTaiKhoan VARCHAR(20) PRIMARY KEY,
    KhoaChuyenNganh VARCHAR(100) NOT NULL
);

-- 4. Bảng QuanTriVien
CREATE TABLE QuanTriVien (
    MaSoTaiKhoan VARCHAR(20) PRIMARY KEY
);

-- 5. Bảng KhoaHoc
CREATE TABLE KhoaHoc (
    MaKhoaHoc VARCHAR(20) PRIMARY KEY,
    TenKhoaHoc VARCHAR(100) NOT NULL,
    HocKyTrienKhai VARCHAR(20) NOT NULL,

    CONSTRAINT UQ_KhoaHoc_Ten UNIQUE (TenKhoaHoc)
);

-- 6. Bảng Lop
CREATE TABLE Lop (
    MaSoLop VARCHAR(20) PRIMARY KEY,
    MaKhoaHoc VARCHAR(20) NOT NULL
);

-- 7. Bảng DanhMucNoiDung
CREATE TABLE DanhMucNoiDung (
    MaKhoaHoc VARCHAR(20) NOT NULL,
    SoThuTu INT NOT NULL,
    TenDanhMuc VARCHAR(100) NOT NULL,

    PRIMARY KEY (MaKhoaHoc, SoThuTu),
    CONSTRAINT CHK_DanhMuc_SoThuTu CHECK (SoThuTu > 0)
);

-- 8. Bảng HocVan
CREATE TABLE HocVan (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    Truong VARCHAR(150) NOT NULL,
    ThoiGianTotNghiep YEAR NOT NULL,
    ChuyenNganh VARCHAR(100) NOT NULL,
    TrinhDo VARCHAR(50) NOT NULL,
    MaSoTaiKhoanGV VARCHAR(20) NOT NULL
);

-- 9. Bảng DienDan
CREATE TABLE DienDan (
    MaDienDan VARCHAR(20) PRIMARY KEY,
    TenDienDan VARCHAR(100) NOT NULL,
    ThoiGianKhoiTao DATETIME NOT NULL,
    TrangThai ENUM('Active', 'Closed') NOT NULL DEFAULT 'Active',
    TongSoBaiDang INT NOT NULL DEFAULT 0,
    NguoiKhoiTao VARCHAR(20) NOT NULL,
    MaKhoaHoc VARCHAR(20) NOT NULL,

    CONSTRAINT CHK_DienDan_TongSoBaiDang CHECK (TongSoBaiDang >= 0)
);

-- 10. Bảng ThongBao
CREATE TABLE ThongBao (
    MaSoThongBao VARCHAR(20) PRIMARY KEY,
    SourceType ENUM('Course', 'Forum') NOT NULL,
    SourceID VARCHAR(20) NOT NULL,
    TieuDe VARCHAR(200) NOT NULL,
    NoiDung TEXT NOT NULL,
    ThoiDiemPhatSinh DATETIME NOT NULL,
    MaSoTaiKhoanQTV VARCHAR(20) NOT NULL
);

-- 11. Bảng TaiLieu
CREATE TABLE TaiLieu (
    MaTaiLieu VARCHAR(20) PRIMARY KEY,
    TenTaiLieu VARCHAR(200) NOT NULL,
    DinhDangTep VARCHAR(20) NOT NULL,
    ThoiGianDang DATETIME NOT NULL,
    DungLuongTep DECIMAL(6,2) NOT NULL,
    NguoiDang VARCHAR(20) NOT NULL,
    MaKhoaHoc VARCHAR(20) NULL,
    MaKhoaHoc_DanhMuc VARCHAR(20) NULL,
    SoThuTuDanhMuc INT NULL,

    CONSTRAINT CHK_TaiLieu_DungLuong CHECK (DungLuongTep > 0 AND DungLuongTep <= 10)
);

-- 12. Bảng BaiTap
CREATE TABLE BaiTap (
    MaBaiTap VARCHAR(20) PRIMARY KEY,
    TenBaiTap VARCHAR(200) NOT NULL,
    NoiDungDeBai TEXT NOT NULL,
    ThoiHanLamBai DATETIME NOT NULL,
    ThoiGianGioiHan INT NOT NULL,
    DiemToiDa DECIMAL(5,2) NOT NULL,
    MaSoLop VARCHAR(20) NOT NULL,

    CONSTRAINT CHK_BaiTap_ThoiGian CHECK (ThoiGianGioiHan > 0),
    CONSTRAINT CHK_BaiTap_DiemToiDa CHECK (DiemToiDa > 0)
);

-- 13. Bảng BaiDang
CREATE TABLE BaiDang (
    MaBaiDang VARCHAR(20) PRIMARY KEY,
    TieuDeBaiDang VARCHAR(200) NOT NULL,
    ThoiGianDangBai DATETIME NOT NULL,
    SoLuongCauTraLoi INT NOT NULL DEFAULT 0,
    MaDienDan VARCHAR(20) NOT NULL,
    NguoiDangBai VARCHAR(20) NOT NULL,

    CONSTRAINT CHK_BaiDang_SoLuong CHECK (SoLuongCauTraLoi >= 0)
);

-- 14. Bảng CauTraLoi
CREATE TABLE CauTraLoi (
    MaCauTraLoi VARCHAR(20) PRIMARY KEY,
    NoiDung TEXT NOT NULL,
    ThoiGianTraLoi DATETIME NOT NULL,
    MaBaiDang VARCHAR(20) NOT NULL,
    NguoiTraLoi VARCHAR(20) NOT NULL,
    Reply_To VARCHAR(20) NULL
);

-- 15. Bảng ThamGiaKhoaHoc
CREATE TABLE ThamGiaKhoaHoc (
    MaSoTaiKhoan VARCHAR(20) NOT NULL,
    MaKhoaHoc VARCHAR(20) NOT NULL,
    VaiTroTrongKhoaHoc ENUM('Student') NOT NULL,
    NgayThamGia DATE NOT NULL,

    PRIMARY KEY (MaSoTaiKhoan, MaKhoaHoc)
);

-- 16. Bảng PhuTrachKhoaHoc
CREATE TABLE PhuTrachKhoaHoc (
    MaSoTaiKhoanGV VARCHAR(20) NOT NULL,
    MaKhoaHoc VARCHAR(20) NOT NULL,

    PRIMARY KEY (MaSoTaiKhoanGV, MaKhoaHoc)
);

-- 17. Bảng ThamGiaDienDan
CREATE TABLE ThamGiaDienDan (
    MaSoTaiKhoan VARCHAR(20) NOT NULL,
    MaDienDan VARCHAR(20) NOT NULL,
    NgayThamGia DATE NOT NULL,

    PRIMARY KEY (MaSoTaiKhoan, MaDienDan)
);

-- 18. Bảng NhanThongBao
CREATE TABLE NhanThongBao (
    MaSoTaiKhoan VARCHAR(20) NOT NULL,
    MaSoThongBao VARCHAR(20) NOT NULL,
    TrangThai ENUM('Seen', 'Unseen') NOT NULL DEFAULT 'Unseen',

    PRIMARY KEY (MaSoTaiKhoan, MaSoThongBao)
);

-- 19. Bảng BaiNop
CREATE TABLE BaiNop (
    MaBaiNop VARCHAR(20) PRIMARY KEY,
    MaBaiTap VARCHAR(20) NOT NULL,
    MaSoTaiKhoanSV VARCHAR(20) NOT NULL,
    MaTaiLieu VARCHAR(20) NOT NULL UNIQUE,
    DiemSo DECIMAL(5,2) NULL,
    ThoiGianThucHienThucTe INT NOT NULL,
    ThoiGianNopBai DATETIME NOT NULL,
    TrangThai ENUM('DungHan', 'TreHan') NOT NULL,

    CONSTRAINT CHK_BaiNop_DiemSo CHECK (DiemSo IS NULL OR DiemSo >= 0),
    CONSTRAINT CHK_BaiNop_ThoiGian CHECK (ThoiGianThucHienThucTe > 0)
);

-- 20. Bảng Sinhvien_lop
CREATE TABLE SinhVien_Lop (
    MaSoTaiKhoanSV VARCHAR(20) NOT NULL,
    MaSoLop VARCHAR(20) NOT NULL,
    NgayThamGia DATE NOT NULL,
    PRIMARY KEY (MaSoTaiKhoanSV, MaSoLop)
);
USE LMS_Group9;

-- 1. SinhVien - NguoiDung
ALTER TABLE SinhVien
ADD CONSTRAINT FK_SinhVien_NguoiDung
FOREIGN KEY (MaSoTaiKhoan) REFERENCES NguoiDung(MaSoTaiKhoan)
ON DELETE CASCADE ON UPDATE CASCADE;

-- 2. GiangVien - NguoiDung
ALTER TABLE GiangVien
ADD CONSTRAINT FK_GiangVien_NguoiDung
FOREIGN KEY (MaSoTaiKhoan) REFERENCES NguoiDung(MaSoTaiKhoan)
ON DELETE CASCADE ON UPDATE CASCADE;

-- 3. QuanTriVien - NguoiDung
ALTER TABLE QuanTriVien
ADD CONSTRAINT FK_QuanTriVien_NguoiDung
FOREIGN KEY (MaSoTaiKhoan) REFERENCES NguoiDung(MaSoTaiKhoan)
ON DELETE CASCADE ON UPDATE CASCADE;

-- 4. Lop - KhoaHoc
ALTER TABLE Lop
ADD CONSTRAINT FK_Lop_KhoaHoc
FOREIGN KEY (MaKhoaHoc) REFERENCES KhoaHoc(MaKhoaHoc)
ON DELETE RESTRICT ON UPDATE CASCADE;

-- 5. DanhMucNoiDung - KhoaHoc
ALTER TABLE DanhMucNoiDung
ADD CONSTRAINT FK_DanhMuc_KhoaHoc
FOREIGN KEY (MaKhoaHoc) REFERENCES KhoaHoc(MaKhoaHoc)
ON DELETE CASCADE ON UPDATE CASCADE;

-- 6. HocVan - GiangVien
ALTER TABLE HocVan
ADD CONSTRAINT FK_HocVan_GiangVien
FOREIGN KEY (MaSoTaiKhoanGV) REFERENCES GiangVien(MaSoTaiKhoan)
ON DELETE CASCADE ON UPDATE CASCADE;

-- 7. DienDan - NguoiDung
ALTER TABLE DienDan
ADD CONSTRAINT FK_DienDan_NguoiDung
FOREIGN KEY (NguoiKhoiTao) REFERENCES NguoiDung(MaSoTaiKhoan)
ON DELETE RESTRICT ON UPDATE CASCADE;

-- 8. DienDan - KhoaHoc
ALTER TABLE DienDan
ADD CONSTRAINT FK_DienDan_KhoaHoc
FOREIGN KEY (MaKhoaHoc) REFERENCES KhoaHoc(MaKhoaHoc)
ON DELETE RESTRICT ON UPDATE CASCADE;

-- 9. TaiLieu - NguoiDung
ALTER TABLE TaiLieu
ADD CONSTRAINT FK_TaiLieu_NguoiDung
FOREIGN KEY (NguoiDang) REFERENCES NguoiDung(MaSoTaiKhoan)
ON DELETE RESTRICT ON UPDATE CASCADE;

-- 10. TaiLieu - KhoaHoc
ALTER TABLE TaiLieu
ADD CONSTRAINT FK_TaiLieu_KhoaHoc
FOREIGN KEY (MaKhoaHoc) REFERENCES KhoaHoc(MaKhoaHoc)
ON DELETE SET NULL ON UPDATE CASCADE;

-- 11. TaiLieu - DanhMucNoiDung
ALTER TABLE TaiLieu
ADD CONSTRAINT FK_TaiLieu_DanhMuc
FOREIGN KEY (MaKhoaHoc_DanhMuc, SoThuTuDanhMuc)
REFERENCES DanhMucNoiDung(MaKhoaHoc, SoThuTu)
ON DELETE SET NULL ON UPDATE CASCADE;

-- 12. BaiTap - Lop
ALTER TABLE BaiTap
ADD CONSTRAINT FK_BaiTap_Lop
FOREIGN KEY (MaSoLop) REFERENCES Lop(MaSoLop)
ON DELETE RESTRICT ON UPDATE CASCADE;

-- 13. BaiDang - DienDan
ALTER TABLE BaiDang
ADD CONSTRAINT FK_BaiDang_DienDan
FOREIGN KEY (MaDienDan) REFERENCES DienDan(MaDienDan)
ON DELETE CASCADE ON UPDATE CASCADE;

-- 14. BaiDang - NguoiDung
ALTER TABLE BaiDang
ADD CONSTRAINT FK_BaiDang_NguoiDung
FOREIGN KEY (NguoiDangBai) REFERENCES NguoiDung(MaSoTaiKhoan)
ON DELETE RESTRICT ON UPDATE CASCADE;

-- 15. CauTraLoi - BaiDang
ALTER TABLE CauTraLoi
ADD CONSTRAINT FK_CauTraLoi_BaiDang
FOREIGN KEY (MaBaiDang) REFERENCES BaiDang(MaBaiDang)
ON DELETE CASCADE ON UPDATE CASCADE;

-- 16. CauTraLoi - NguoiDung
ALTER TABLE CauTraLoi
ADD CONSTRAINT FK_CauTraLoi_NguoiDung
FOREIGN KEY (NguoiTraLoi) REFERENCES NguoiDung(MaSoTaiKhoan)
ON DELETE RESTRICT ON UPDATE CASCADE;

-- 17. CauTraLoi - CauTraLoi
ALTER TABLE CauTraLoi
ADD CONSTRAINT FK_CauTraLoi_ReplyTo
FOREIGN KEY (Reply_To) REFERENCES CauTraLoi(MaCauTraLoi)
ON DELETE SET NULL ON UPDATE CASCADE;

-- 18. ThamGiaKhoaHoc - NguoiDung
ALTER TABLE ThamGiaKhoaHoc
ADD CONSTRAINT FK_TGKH_NguoiDung
FOREIGN KEY (MaSoTaiKhoan) REFERENCES NguoiDung(MaSoTaiKhoan)
ON DELETE CASCADE ON UPDATE CASCADE;

-- 19. ThamGiaKhoaHoc - KhoaHoc
ALTER TABLE ThamGiaKhoaHoc
ADD CONSTRAINT FK_TGKH_KhoaHoc
FOREIGN KEY (MaKhoaHoc) REFERENCES KhoaHoc(MaKhoaHoc)
ON DELETE CASCADE ON UPDATE CASCADE;

-- 20. PhuTrachKhoaHoc - GiangVien
ALTER TABLE PhuTrachKhoaHoc
ADD CONSTRAINT FK_PTKH_GiangVien
FOREIGN KEY (MaSoTaiKhoanGV) REFERENCES GiangVien(MaSoTaiKhoan)
ON DELETE CASCADE ON UPDATE CASCADE;

-- 21. PhuTrachKhoaHoc - KhoaHoc
ALTER TABLE PhuTrachKhoaHoc
ADD CONSTRAINT FK_PTKH_KhoaHoc
FOREIGN KEY (MaKhoaHoc) REFERENCES KhoaHoc(MaKhoaHoc)
ON DELETE CASCADE ON UPDATE CASCADE;

-- 22. ThamGiaDienDan - NguoiDung
ALTER TABLE ThamGiaDienDan
ADD CONSTRAINT FK_TGDD_NguoiDung
FOREIGN KEY (MaSoTaiKhoan) REFERENCES NguoiDung(MaSoTaiKhoan)
ON DELETE CASCADE ON UPDATE CASCADE;

-- 23. ThamGiaDienDan - DienDan
ALTER TABLE ThamGiaDienDan
ADD CONSTRAINT FK_TGDD_DienDan
FOREIGN KEY (MaDienDan) REFERENCES DienDan(MaDienDan)
ON DELETE CASCADE ON UPDATE CASCADE;

-- 24. NhanThongBao - NguoiDung
ALTER TABLE NhanThongBao
ADD CONSTRAINT FK_NTB_NguoiDung
FOREIGN KEY (MaSoTaiKhoan) REFERENCES NguoiDung(MaSoTaiKhoan)
ON DELETE CASCADE ON UPDATE CASCADE;

-- 25. NhanThongBao - ThongBao
ALTER TABLE NhanThongBao
ADD CONSTRAINT FK_NTB_ThongBao
FOREIGN KEY (MaSoThongBao) REFERENCES ThongBao(MaSoThongBao)
ON DELETE CASCADE ON UPDATE CASCADE;

-- 26. BaiNop - BaiTap
ALTER TABLE BaiNop
ADD CONSTRAINT FK_BaiNop_BaiTap
FOREIGN KEY (MaBaiTap) REFERENCES BaiTap(MaBaiTap)
ON DELETE CASCADE ON UPDATE CASCADE;

-- 27. BaiNop - SinhVien
ALTER TABLE BaiNop
ADD CONSTRAINT FK_BaiNop_SinhVien
FOREIGN KEY (MaSoTaiKhoanSV) REFERENCES SinhVien(MaSoTaiKhoan)
ON DELETE CASCADE ON UPDATE CASCADE;

-- 28. BaiNop - TaiLieu
ALTER TABLE BaiNop
ADD CONSTRAINT FK_BaiNop_TaiLieu
FOREIGN KEY (MaTaiLieu) REFERENCES TaiLieu(MaTaiLieu)
ON DELETE RESTRICT ON UPDATE CASCADE;

-- 29. Sinhvien_Lop
ALTER TABLE SinhVien_Lop
ADD CONSTRAINT FK_SVL_SinhVien
FOREIGN KEY (MaSoTaiKhoanSV) REFERENCES SinhVien(MaSoTaiKhoan)
ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE SinhVien_Lop
ADD CONSTRAINT FK_SVL_Lop
FOREIGN KEY (MaSoLop) REFERENCES Lop(MaSoLop)
ON DELETE CASCADE ON UPDATE CASCADE;

-- 30. ThongBao - QTV
ALTER TABLE ThongBao
ADD CONSTRAINT FK_ThongBao_QuanTriVien
FOREIGN KEY (MaSoTaiKhoanQTV)
REFERENCES QuanTriVien(MaSoTaiKhoan)
ON DELETE RESTRICT ON UPDATE CASCADE;

USE LMS_Group9;

-- =====================================================
-- 1. NGUOIDUNG
-- 15 dòng
-- =====================================================
INSERT INTO NguoiDung
(MaSoTaiKhoan, TenDangNhap, MatKhau, Email, HoVaTen, VaiTro, NgayThamGia, ThoiGianHoatDongGanNhat, TrangThaiTaiKhoan)
VALUES
('U001', 'nhu2212466',   'pass123', 'nhu2212466@hcmut.edu.vn',   'Le Phan Bao Nhu',     'Student',  '2026-01-10', '2026-04-20 09:15:00', 'Active'),
('U002', 'son2212937',   'pass123', 'son2212937@hcmut.edu.vn',   'Hoang Sy Xuan Son',   'Student',  '2026-01-10', '2026-04-20 10:20:00', 'Active'),
('U003', 'tan2213054',   'pass123', 'tan2213054@hcmut.edu.vn',   'Lam Hoang Tan',       'Student',  '2026-01-10', '2026-04-21 08:30:00', 'Active'),
('U004', 'tu2213858',    'pass123', 'tu2213858@hcmut.edu.vn',    'Vo Quoc Tu',          'Student',  '2026-01-10', '2026-04-19 14:00:00', 'Active'),
('U005', 'minh2213001',  'pass123', 'minh2213001@hcmut.edu.vn',  'Nguyen Quang Minh',   'Student',  '2026-01-11', '2026-04-18 16:45:00', 'Active'),
('U006', 'gvnam',        'pass123', 'nam.ldh@hcmut.edu.vn',      'Le Duc Hoang Nam',    'Lecturer', '2025-12-20', '2026-04-21 11:00:00', 'Active'),
('U007', 'gvlinh',       'pass123', 'linh.nt@hcmut.edu.vn',      'Nguyen Thi Linh',     'Lecturer', '2025-12-20', '2026-04-21 12:15:00', 'Active'),
('U008', 'adminbk',      'pass123', 'adminbk@hcmut.edu.vn',      'BK LMS Admin',        'Admin',    '2025-12-01', '2026-04-21 13:00:00', 'Active'),
('U009', 'gvhuy',        'pass123', 'huy.tt@hcmut.edu.vn',       'Tran Thanh Huy',      'Lecturer', '2025-12-21', '2026-04-21 09:00:00', 'Active'),
('U010', 'gvmai',        'pass123', 'mai.pt@hcmut.edu.vn',       'Pham Thi Mai',        'Lecturer', '2025-12-21', '2026-04-21 09:30:00', 'Active'),
('U011', 'gvkhanh',      'pass123', 'khanh.na@hcmut.edu.vn',     'Nguyen Anh Khanh',    'Lecturer', '2025-12-21', '2026-04-21 10:00:00', 'Active'),
('U012', 'admin01',      'pass123', 'admin01@hcmut.edu.vn',      'Admin Mot',           'Admin',    '2025-12-01', '2026-04-21 13:10:00', 'Active'),
('U013', 'admin02',      'pass123', 'admin02@hcmut.edu.vn',      'Admin Hai',           'Admin',    '2025-12-01', '2026-04-21 13:20:00', 'Active'),
('U014', 'admin03',      'pass123', 'admin03@hcmut.edu.vn',      'Admin Ba',            'Admin',    '2025-12-01', '2026-04-21 13:30:00', 'Active'),
('U015', 'admin04',      'pass123', 'admin04@hcmut.edu.vn',      'Admin Bon',           'Admin',    '2025-12-01', '2026-04-21 13:40:00', 'Active');

-- =====================================================
-- 2. SINHVIEN
-- 5 dòng
-- =====================================================
INSERT INTO SinhVien (MaSoTaiKhoan, NienKhoa, KhoaChuyenNganh)
VALUES
('U001', '2022', 'Khoa hoc may tinh'),
('U002', '2022', 'Khoa hoc may tinh'),
('U003', '2022', 'Ky thuat may tinh'),
('U004', '2022', 'Khoa hoc may tinh'),
('U005', '2022', 'He thong thong tin');

-- =====================================================
-- 3. GIANGVIEN
-- 5 dòng
-- =====================================================
INSERT INTO GiangVien (MaSoTaiKhoan, KhoaChuyenNganh)
VALUES
('U006', 'Khoa hoc may tinh'),
('U007', 'He thong thong tin'),
('U009', 'Ky thuat may tinh'),
('U010', 'Cong nghe phan mem'),
('U011', 'He thong thong tin');

-- =====================================================
-- 4. QUANTRIVIEN
-- 5 dòng
-- =====================================================
INSERT INTO QuanTriVien (MaSoTaiKhoan)
VALUES
('U008'),
('U012'),
('U013'),
('U014'),
('U015');

-- =====================================================
-- 5. KHOAHOC
-- 5 dòng
-- =====================================================
INSERT INTO KhoaHoc (MaKhoaHoc, TenKhoaHoc, HocKyTrienKhai)
VALUES
('KH001', 'Co so du lieu',                 'HK252'),
('KH002', 'Cau truc du lieu va giai thuat','HK252'),
('KH003', 'Nhap mon tri tue nhan tao',     'HK252'),
('KH004', 'Lap trinh web',                 'HK252'),
('KH005', 'He quan tri co so du lieu',     'HK252');

-- =====================================================
-- 6. LOP
-- 5 dòng
-- =====================================================
INSERT INTO Lop (MaSoLop, MaKhoaHoc)
VALUES
('L001', 'KH001'),
('L002', 'KH002'),
('L003', 'KH003'),
('L004', 'KH004'),
('L005', 'KH005');

-- =====================================================
-- 7. DANHMUCNOIDUNG
-- 5 dòng
-- =====================================================
INSERT INTO DanhMucNoiDung (MaKhoaHoc, SoThuTu, TenDanhMuc)
VALUES
('KH001', 1, 'Chung'),
('KH002', 1, 'Chung'),
('KH003', 1, 'Chung'),
('KH004', 1, 'Chung'),
('KH005', 1, 'Chung');

-- =====================================================
-- 8. HOCVAN
-- 5 dòng
-- =====================================================
INSERT INTO HocVan (Truong, ThoiGianTotNghiep, ChuyenNganh, TrinhDo, MaSoTaiKhoanGV)
VALUES
('Dai hoc Bach Khoa TP.HCM', 2012, 'Khoa hoc may tinh',  'Cu nhan', 'U006'),
('Dai hoc Bach Khoa TP.HCM', 2015, 'Khoa hoc may tinh',  'Thac si', 'U006'),
('Dai hoc Khoa hoc Tu nhien', 2014, 'He thong thong tin','Thac si', 'U007'),
('Dai hoc Bach Khoa TP.HCM', 2016, 'Ky thuat may tinh',  'Thac si', 'U009'),
('Dai hoc Su pham Ky thuat', 2018, 'Cong nghe phan mem', 'Thac si', 'U010');

-- =====================================================
-- 9. DIENDAN
-- 5 dòng
-- =====================================================
INSERT INTO DienDan (MaDienDan, TenDienDan, ThoiGianKhoiTao, TrangThai, TongSoBaiDang, NguoiKhoiTao, MaKhoaHoc)
VALUES
('DD001', 'Dien dan hoi dap CSDL',      '2026-02-01 08:00:00', 'Active', 1, 'U006', 'KH001'),
('DD002', 'Dien dan CTDL va GT',        '2026-02-02 08:00:00', 'Active', 1, 'U006', 'KH002'),
('DD003', 'Dien dan AI can ban',        '2026-02-03 08:00:00', 'Active', 1, 'U007', 'KH003'),
('DD004', 'Dien dan Lap trinh Web',     '2026-02-04 08:00:00', 'Active', 1, 'U010', 'KH004'),
('DD005', 'Dien dan He QTCSDL',         '2026-02-05 08:00:00', 'Active', 1, 'U009', 'KH005');

-- =====================================================
-- 10. THONGBAO
-- 5 dòng
-- =====================================================
INSERT INTO ThongBao
(MaSoThongBao, SourceType, SourceID, TieuDe, NoiDung, ThoiDiemPhatSinh, MaSoTaiKhoanQTV)
VALUES
('TB001', 'Course', 'KH001', 'Mo lop Co so du lieu',        'Hoc phan Co so du lieu da duoc mo tren LMS.', '2026-02-01 09:00:00', 'U008'),
('TB002', 'Course', 'KH002', 'Cap nhat slide chuong 1',     'Da cap nhat slide chuong 1 va bai tap tuan 1.', '2026-02-02 09:00:00', 'U012'),
('TB003', 'Forum',  'DD003', 'Nhac nho tham gia thao luan', 'Sinh vien can tham gia thao luan AI truoc thu 6.', '2026-02-03 09:00:00', 'U013'),
('TB004', 'Course', 'KH004', 'Deadline bai tap web',        'Han nop bai tap 1 la 23:59 ngay 25/04.', '2026-02-04 09:00:00', 'U014'),
('TB005', 'Forum',  'DD005', 'Mo chu de hoi dap SQL',       'Dien dan da mo them chu de hoi dap ve trigger.', '2026-02-05 09:00:00', 'U015');

-- =====================================================
-- 11. TAILIEU
-- 10 dòng
-- TL001-TL005: tài liệu học tập
-- TL006-TL010: tài liệu đính kèm bài nộp
-- =====================================================
INSERT INTO TaiLieu
(MaTaiLieu, TenTaiLieu, DinhDangTep, ThoiGianDang, DungLuongTep, NguoiDang, MaKhoaHoc, MaKhoaHoc_DanhMuc, SoThuTuDanhMuc)
VALUES
('TL001', 'Slide_CSDL_Chuong1.pdf',    'pdf', '2026-02-01 10:00:00', 2.50, 'U006', 'KH001', 'KH001', 1),
('TL002', 'Slide_CTDL_Chuong1.pdf',    'pdf', '2026-02-02 10:00:00', 3.10, 'U006', 'KH002', 'KH002', 1),
('TL003', 'Slide_AI_Chuong1.pdf',      'pdf', '2026-02-03 10:00:00', 2.90, 'U007', 'KH003', 'KH003', 1),
('TL004', 'HuongDan_Web_BaiTap1.pdf',  'pdf', '2026-02-04 10:00:00', 1.80, 'U010', 'KH004', 'KH004', 1),
('TL005', 'TaiLieu_SQL_Trigger.pdf',   'pdf', '2026-02-05 10:00:00', 2.20, 'U009', 'KH005', 'KH005', 1),

('TL006', 'BaiNop_Nhu_BT1.zip',        'zip', '2026-04-20 20:00:00', 4.50, 'U001', 'KH001', NULL, NULL),
('TL007', 'BaiNop_Son_BT1.zip',        'zip', '2026-04-20 20:10:00', 4.10, 'U002', 'KH002', NULL, NULL),
('TL008', 'BaiNop_Tan_BT1.zip',        'zip', '2026-04-20 20:20:00', 3.80, 'U003', 'KH003', NULL, NULL),
('TL009', 'BaiNop_Tu_BT1.zip',         'zip', '2026-04-20 20:30:00', 4.00, 'U004', 'KH004', NULL, NULL),
('TL010', 'BaiNop_Minh_BT1.zip',       'zip', '2026-04-20 20:40:00', 3.60, 'U005', 'KH005', NULL, NULL);

-- =====================================================
-- 12. BAITAP
-- 5 dòng
-- =====================================================
INSERT INTO BaiTap
(MaBaiTap, TenBaiTap, NoiDungDeBai, ThoiHanLamBai, ThoiGianGioiHan, DiemToiDa, MaSoLop)
VALUES
('BT001', 'Bai tap 1 - Mo hinh ER',          'Thiet ke mo hinh ER cho he thong quan ly thu vien.',      '2026-04-25 23:59:00', 120, 10.00, 'L001'),
('BT002', 'Bai tap 1 - Cay nhi phan',        'Cai dat cay nhi phan tim kiem va cac phep duyet cay.',   '2026-04-26 23:59:00', 90,  10.00, 'L002'),
('BT003', 'Bai tap 1 - Tim kiem BFS DFS',    'Trinh bay va cai dat BFS, DFS cho do thi.',               '2026-04-27 23:59:00', 100, 10.00, 'L003'),
('BT004', 'Bai tap 1 - Giao dien dang nhap', 'Xay dung giao dien dang nhap bang HTML CSS JavaScript.', '2026-04-28 23:59:00', 120, 10.00, 'L004'),
('BT005', 'Bai tap 1 - Trigger trong SQL',   'Viet trigger kiem tra rang buoc nghiep vu trong CSDL.',  '2026-04-29 23:59:00', 120, 10.00, 'L005');

-- =====================================================
-- 13. BAIDANG
-- 5 dòng
-- =====================================================
INSERT INTO BaiDang
(MaBaiDang, TieuDeBaiDang, ThoiGianDangBai, SoLuongCauTraLoi, MaDienDan, NguoiDangBai)
VALUES
('BD001', 'Hoi ve mo hinh ER trong bai tap 1',      '2026-04-10 19:00:00', 2, 'DD001', 'U001'),
('BD002', 'Thac mac ve cay nhi phan tim kiem',      '2026-04-11 20:00:00', 2, 'DD002', 'U002'),
('BD003', 'Hoi ve BFS va DFS khac nhau the nao',    '2026-04-12 21:00:00', 2, 'DD003', 'U003'),
('BD004', 'Loi can giua form khi dung flexbox',     '2026-04-13 18:30:00', 2, 'DD004', 'U004'),
('BD005', 'Trigger BEFORE INSERT dung khi nao',     '2026-04-14 17:45:00', 2, 'DD005', 'U005');

-- =====================================================
-- 14. CAUTRALOI
-- 10 dòng
-- =====================================================
INSERT INTO CauTraLoi
(MaCauTraLoi, NoiDung, ThoiGianTraLoi, MaBaiDang, NguoiTraLoi, Reply_To)
VALUES
('CTL001', 'Ban can xac dinh thuc the, thuoc tinh va moi lien ket truoc.', '2026-04-10 20:00:00', 'BD001', 'U006', NULL),
('CTL002', 'Hay dung them hinh ve cay de de debug hon.',                   '2026-04-11 21:00:00', 'BD002', 'U006', NULL),
('CTL003', 'BFS di theo muc con DFS di theo nhanh truoc.',                 '2026-04-12 22:00:00', 'BD003', 'U007', NULL),
('CTL004', 'Ban thu them justify-content va align-items center xem.',      '2026-04-13 19:15:00', 'BD004', 'U010', NULL),
('CTL005', 'BEFORE INSERT dung de chan du lieu sai truoc khi luu.',        '2026-04-14 18:20:00', 'BD005', 'U009', NULL),

('CTL006', 'Em cam on thay, em se bo sung phan thuc the va thuoc tinh.',   '2026-04-10 20:15:00', 'BD001', 'U001', 'CTL001'),
('CTL007', 'Cam on thay, em se ve them cay minh hoa.',                     '2026-04-11 21:20:00', 'BD002', 'U002', 'CTL002'),
('CTL008', 'Da hieu, em se bo sung vi du do thi cu the.',                  '2026-04-12 22:10:00', 'BD003', 'U003', 'CTL003'),
('CTL009', 'Em da sua duoc roi, cam on co.',                               '2026-04-13 19:30:00', 'BD004', 'U004', 'CTL004'),
('CTL010', 'Vay trigger nay phu hop cho rang buoc lien bang dung khong?',  '2026-04-14 18:35:00', 'BD005', 'U005', 'CTL005');

-- =====================================================
-- 15. THAMGIAKHOAHOC
-- 10 dòng
-- =====================================================
INSERT INTO ThamGiaKhoaHoc
(MaSoTaiKhoan, MaKhoaHoc, VaiTroTrongKhoaHoc, NgayThamGia)
VALUES
('U001', 'KH001', 'Student', '2026-02-01'),
('U002', 'KH002', 'Student', '2026-02-01'),
('U003', 'KH003', 'Student', '2026-02-01'),
('U004', 'KH004', 'Student', '2026-02-01'),
('U005', 'KH005', 'Student', '2026-02-01');

-- =====================================================
-- 16. PHUTRACHKHOAHOC
-- 5 dòng
-- =====================================================
INSERT INTO PhuTrachKhoaHoc
(MaSoTaiKhoanGV, MaKhoaHoc)
VALUES
('U006', 'KH001'),
('U006', 'KH002'),
('U007', 'KH003'),
('U010', 'KH004'),
('U009', 'KH005');

-- =====================================================
-- 17. THAMGIADIENDAN
-- 10 dòng
-- =====================================================
INSERT INTO ThamGiaDienDan
(MaSoTaiKhoan, MaDienDan, NgayThamGia)
VALUES
('U001', 'DD001', '2026-02-02'),
('U002', 'DD002', '2026-02-02'),
('U003', 'DD003', '2026-02-02'),
('U004', 'DD004', '2026-02-02'),
('U005', 'DD005', '2026-02-02'),
('U006', 'DD001', '2026-02-02'),
('U006', 'DD002', '2026-02-02'),
('U007', 'DD003', '2026-02-02'),
('U010', 'DD004', '2026-02-02'),
('U009', 'DD005', '2026-02-02');

-- =====================================================
-- 18. NHANTHONGBAO
-- 10 dòng
-- =====================================================
INSERT INTO NhanThongBao
(MaSoTaiKhoan, MaSoThongBao, TrangThai)
VALUES
('U001', 'TB001', 'Seen'),
('U002', 'TB002', 'Seen'),
('U003', 'TB003', 'Unseen'),
('U004', 'TB004', 'Seen'),
('U005', 'TB005', 'Unseen'),
('U006', 'TB001', 'Seen'),
('U006', 'TB002', 'Seen'),
('U007', 'TB003', 'Seen'),
('U010', 'TB004', 'Seen'),
('U009', 'TB005', 'Seen');

-- =====================================================
-- 19. BAINOP
-- 5 dòng
-- =====================================================
INSERT INTO BaiNop
(MaBaiNop, MaBaiTap, MaSoTaiKhoanSV, MaTaiLieu, DiemSo, ThoiGianThucHienThucTe, ThoiGianNopBai, TrangThai)
VALUES
('BN001', 'BT001', 'U001', 'TL006', 8.50, 110, '2026-04-20 20:05:00', 'DungHan'),
('BN002', 'BT002', 'U002', 'TL007', 9.00,  85, '2026-04-20 20:15:00', 'DungHan'),
('BN003', 'BT003', 'U003', 'TL008', 8.00,  95, '2026-04-20 20:25:00', 'DungHan'),
('BN004', 'BT004', 'U004', 'TL009', 9.25, 100, '2026-04-20 20:35:00', 'DungHan'),
('BN005', 'BT005', 'U005', 'TL010', 8.75, 115, '2026-04-20 20:45:00', 'DungHan');

-- =====================================================
-- 20. SinhVien_Lop
-- 5 dòng
-- =====================================================
INSERT INTO SinhVien_Lop (MaSoTaiKhoanSV, MaSoLop, NgayThamGia)
VALUES
('U001', 'L001', '2026-02-01'),
('U002', 'L002', '2026-02-01'),
('U003', 'L003', '2026-02-01'),
('U004', 'L004', '2026-02-01'),
('U005', 'L005', '2026-02-01');