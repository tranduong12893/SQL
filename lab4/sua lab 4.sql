﻿CREATE Database QuanLyBanHang;
GO

CREATE TABLE Category(
	CatID NVARCHAR(100) PRIMARY KEY,
	TenHang VARCHAR(100),
)
GO
SELECT * FROM Category
GO

CREATE TABLE Product(
	ProID INT PRIMARY KEY IDENTITY,
	TenHang NVARCHAR(50),
	DonVi NVARCHAR(10),
	Gia Money,
	SoLuong INT,
	Mota NVARCHAR(100),
	CatID NVARCHAR(100)
	CONSTRAINT li FOREIGN KEY (CatID) REFERENCES Category(CatID)
)
GO
SELECT * FROM Product
GO
drop table OrderDetails

CREATE TABLE Customer(
	CusID Int PRIMARY KEY,
	TenKhachHang NVARCHAR(50),
	DiaChi NVARCHAR(100),
	DienThoai INT,
)
GO
SELECT * FROM Customer
GO

CREATE TABLE ORderss(
	OrderID Int PRIMARY KEY IDENTITY,
	CustomerID INT,
	Loai NVarchar(50),
	NgayDatHang Date,
	CONSTRAINT pt FOREIGN KEY (CustomerID) REFERENCES Customer(CusID)
)
GO
SELECT * FROM ORderss
GO

CREATE TABLE OrderDetailss(
	OrderID INT,
	ProductID INT,
	Giaban Money,
	SoLuong INT,
	CONSTRAINT gi FOREIGN KEY (OrderID) REFERENCES ORderss(OrderID),
	CONSTRAINT gt FOREIGN KEY (ProductID) REFERENCES Product(ProID)
)
GO
SELECT * FROM OrderDetailss
GO

--3. Nhập dữ liệu
INSERT INTO Category VALUES (N'Máy Tính',N'Máy Tính T450'),
							(N'Điện Thoại',N'Điện Thoại Nokia5670'),
							(N'Máy In',N'Máy In Samsung 450')
GO
INSERT INTO Product VALUES (N'Máy Tính T450',N'Chiếc',1000,10,N'Máy nhập mới',N'Máy Tính'),
						   (N'Điện Thoại Nokia5670',N'Chiếc',200,10,N'Điện Thoại đang hot',N'Điện Thoại'),
						   (N'Máy In Samsung 450',N'Chiếc',100,10,'Máy in đang ê',N'Máy In')
GO

INSERT INTO Customer VALUES (1,N'Nguyễn Văn An',N'111 Nguyễn Trãi, Thanh Xuân, Hà Nội',987654321),
							(2,N'Trần Văn Quân',N'17 Cau giấy, Cầu Giấy, Hà Nội',987456123),
							(3,N'Lê Văn Tuấn',N'56 Quan Hoa, Cầu Giấy, Hà Nội',889969533)
GO
INSERT INTO ORderss VALUES (1,N'Máy Tính','11-18-19'),
						   (1,N'Điên Thoại','11-18-19'),
						   (1,N'Máy TínhIn','11-18-19')
GO
INSERT INTO OrderDetailss VALUES (1,3,1000,1),
								 (2,4,200,2),
								 (3,5,100,1)
GO

--4.Truy Vấn
SELECT (CusID) FROM Customer
GO
SELECT (ProID) FROM Product
GO
SELECT * FROM ORderss
GO
--5.Truy Vấn
Select CusID from Customer
Order by CusID;
GO
Select ProID,Gia from Product
Order by Gia DESC;
GO
Select proID from Product
WHERE TenKH = N'Nguyễn Văn An';
GO
--6.Truy Vấn
SELECT COUNT(TenKhachHang) FROM KhachHang
GO
SELECT COUNT(TenHang) FROM SanPham
GO
SELECT SUM(ThanhTien)
FROM OrderDetails
WHERE MaDonHang =1
GO
SELECT SUM(ThanhTien)
FROM OrderDetails
WHERE MaDonHang =2
GO
--7.Thay đổi những thông tin từ cơ sở dữ liệu
ALTER TABLE SanPham ADD CONSTRAINT Gia Check(Gia>0)
GO
ALTER TABLE Orders ADD CONSTRAINT NgayDatHang Check(NgayDatHang<getdate()) 
GO
ALTER TABLE SanPham ADD Ngayramat date
GO
SELECT *FROM SanPham
GO
--8. Thực hiện yêu cầu
--a) Đặt chỉ mục (index) cho cột Tên hàng và Người đặt hàng để tăng tốc độ truy vấn dữ liệu trên các cột này.
CREATE INDEX index_TenKh ON OrderDetails(TenKH)
GO
CREATE INDEX index_TenHang ON OrderDetails(TenHang)
GO
--b) Xây dựng các view:
--View_KhachHang với các cột: Tên khách hàng, Địa chỉ, Điện thoại
CREATE VIEW View_KhachHang AS SELECT TenKhachHang,diachi,DienThoai
FROM KhachHang
GO
SELECT *FROM View_KhachHang
GO
--View_SanPham với các cột: Tên sản phẩm, Giá bán
CREATE VIEW View_SanPham AS SELECT TenHang,Gia
FROM SanPham
GO
SELECT *FROM View_SanPham
GO
--View_KhachHang_SanPham với các cột: Tên khách hàng, Số điện thoại, Tên sản phẩm, Số lượng, Ngày mua
CREATE VIEW View_KhachHang_SanPham AS SELECT TenKH,TEL,TenHang,SoLuong,NgayDatHang
FROM OrderDetails
GO
SELECT *FROM View_KhachHang_SanPham
GO
--c) Viết các Store Procedure (Thủ tục lưu trữ) sau:
--SP_TimKH_MaKH: Tìm khách hàng theo mã khách hàng
CREATE PROCEDURE SP_TimKH_MaKH AS
SELECT TenKhachHang,diachi,DiaChi FROM KhachHang
WHERE MaKhachHang LIKE 1
GO
EXECUTE SP_TimKH_MaKH
GO
--SP_TimKH_MaHD: Tìm thông tin khách hàng theo mã hóa đơn
CREATE PROCEDURE SP_TimKH_MaHD AS
SELECT TenKH,diachi,TEL FROM OrderDetails
WHERE MaDonHang LIKE '1'
GO
EXECUTE SP_TimKH_MaHD
GO
--SP_SanPham_MaKH: Liệt kê các sản phẩm được mua bởi khách hàng có mã được truyền vào Store.
CREATE PROCEDURE SP_SanPham_MaKH AS
SELECT TenHang,SoLuong,MoTa FROM OrderDetails
WHERE MaKhachHang LIKE '1'
GO
EXECUTE SP_TimKH_MaHD
GO