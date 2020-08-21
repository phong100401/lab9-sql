CREATE DATABASE Assignment_02
GO
USE Assignment_02
GO

CREATE TABLE HangSP(
	IDHang INT PRIMARY KEY,
	TenHang VARCHAR(30),
	DiaChi VARCHAR(50),
	DienThoai INT
)
CREATE TABLE DanhSachSP(
	TenSP NVARCHAR(20),
	MoTaSP NVARCHAR(50),
	GiaBan MONEY,
	SoLuong INT,
	IDHang INT,
	CONSTRAINT fk FOREIGN KEY (IDHang) REFERENCES HangSP(IDHang)
)
INSERT INTO HangSP VALUES 
(123,'Asus','USA',983232),
(345,'Nokia','JP',991231),
(678,'SAMSUNG','Korea',7689421)
GO 
INSERT INTO DanhSachSP VALUES 
(N'Máy Tính T450',N'Máy Nhập Mới','1000',10,123),
(N'Điện Thoại Nokia5670',N'Điện Thoại Đang Hot','200',200,345),
(N'Máy In Samsung450',N'Máy In Đang Ế','100',10,678)
GO
DROP TABLE HangSP
DROP TABLE DanhSachSP
--Hiển thị tất cả các hãng sản xuất.
SELECT * FROM HangSP

--Hiển thị tất cả các sản phẩm.
SELECT * FROM DanhSachSP

--Liệt kê danh sách hãng theo thứ thự ngược với alphabet của tên.
SELECT TenHang FROM HangSP ORDER BY TenHang DESC

--Liệt kê danh sách sản phẩm của cửa hàng theo thứ thự giá giảm dần.
SELECT TenSP FROM DanhSachSP ORDER BY SoLuong DESC

--Hiển thị thông tin của hãng Asus.
SELECT * FROM HangSP WHERE TenHang = 'Asus'

--Liệt kê danh sách sản phẩm còn ít hơn 11 chiếc trong kho
SELECT TenSP FROM DanhSachSP WHERE(SoLuong <11)

--Liệt kê danh sách sản phẩm của hãng Asus
SELECT TenSP FROM DanhSachSP WHERE(IDHang = 123)

--Số hãng sản phẩm mà cửa hàng có.
SELECT COUNT(TenHang) AS 'Nhung Hang Cua Hang Co ' FROM HangSP

--Số mặt hàng mà cửa hàng bán.
SELECT COUNT(TenSP) AS 'cac mat hang ma cua hang co' FROM DanhSachSP

--Tổng số loại sản phẩm của mỗi hãng có trong cửa hàng.
SELECT DanhSachSP.SoLuong,HangSP.TenHang FROM DanhSachSP INNER JOIN HangSP ON DanhSachSP.IDHang = HangSP.IDHang 

--câu lệnh để thay đổi trường giá tiền của từng mặt hàng là dương(>0).
ALTER TABLE DanhSachSP ALTER COLUMN GiaBan INT CHECK (GiaBan > 0)

--Viết câu lệnh để thay đổi số điện thoại phải bắt đầu bằng 0.
ALTER TABLE HangSP 
ADD CONSTRAINT DienThoai CHECK(DienThoai LIKE '0%')

--Thiết lập chỉ mục (Index) cho các cột Tên hàng và Mô tả hàng để tăng hiệu suất truy vấn 
CREATE INDEX ProductName ON DanhSachSP(TenSP)
CREATE INDEX Sta ON DanhSachSP(MoTaSP)

CREATE VIEW View_SanPham AS 
SELECT TenSP,GiaBan FROM DanhSachSP
CREATE VIEW View_SanPham_Hang AS 
SELECT DanhSachSP.TenSP,HangSP.TenHang FROM DanhSachSP INNER JOIN HangSP ON DanhSachSP.IDHang = HangSP.IDHang