create database QL_SINHVIEN

ON PRIMARY
(
	NAME = QLSV_PRIMARY,
	FILENAME= 'E:\LUUDULIEUSINHVIEN\HOANGGG\buoi2\QLSV_PRIMARY.mdf',
	SIZE=15MB,
	MAXSIZE=30MB,
	FILEGROWTH=10%
) 
LOG ON 
(
	NAME=QLSV_LOG,
	FILENAME='E:\LUUDULIEUSINHVIEN\HOANGGG\buoi2\QLSV_LOG.ldf',
	SIZE=10MB,
	MAXSIZE=20MB,
	FILEGROWTH=15%
);
GO

USE QL_SINHVIEN
CREATE TABLE KHOA 
(
	MAKHOA CHAR(10) PRIMARY KEY,
	TENKHOA NVARCHAR(30),
)
GO
CREATE TABLE LOP
(
	MALOP CHAR(10) PRIMARY KEY,
	TENLOP NVARCHAR (30),

	MAKHOA CHAR(10)
)

GO
ALTER TABLE LOP 
ADD CONSTRAINT FK_MAKHOA FOREIGN KEY (MAKHOA) REFERENCES KHOA(MAKHOA)
GO
CREATE TABLE SINHVIEN
(
	MASV CHAR(10)PRIMARY KEY,
	HOTEN NVARCHAR(30),
	NGAYSINH DATE,
	DCHI NVARCHAR(30),
	GIOITINH NVARCHAR(5),
	MALOP CHAR(10)
)
GO
ALTER TABLE SINHVIEN
ADD CONSTRAINT FK_MALOP FOREIGN KEY (MALOP) REFERENCES LOP(MALOP)
GO
CREATE TABLE MONHOC
(
	MAMH CHAR(10) PRIMARY KEY,
	TENMH NVARCHAR(30),
	SOTC INT 

)
GO
CREATE TABLE KETQUA
(
	MASV CHAR (10) ,
	MAMH CHAR(10) ,
	DIEM FLOAT,
	CONSTRAINT PK_KETQUA PRIMARY KEY (MASV,MAMH)
)
GO
ALTER TABLE  KETQUA
ADD CONSTRAINT FK_MASV FOREIGN KEY (MASV) REFERENCES SINHVIEN(MASV)
 GO
ALTER TABLE  KETQUA
ADD CONSTRAINT FK_MAMH FOREIGN KEY (MAMH) REFERENCES MONHOC(MAMH)
GO
INSERT INTO KHOA
VALUES	('01',N'Công nghệ thông tin'),
		('02',N'Điện-điện tử'),
		('03',N'Công nghệ thực phẩm')

go
insert into LOP
values	('L001','15CNTT1','01'),
		('L002','15CNTT2','01'),
		('L003','15ATTT','01'),
		('L004','14DTVT','02'),
		('L005','16ATTP1','03'),
		('L006','16ATTP2','03')
		
GO
set dateformat DMY
INSERT INTO SINHVIEN
VALUES	('SV01',N'Nguyễn Thị Lan','15/07/2005','TPHCM','Nam','L001'),
		('SV02',N'Trần Thanh Tùng','19/05/2005',N'Vũng Tàu','Nam','L001'),
		('SV03',N'Trương Thị Huệ','31/08/2002',N'Đà Nẵng',N'Nữ','L001'),
		('SV04',N'Lê Văn Khánh','18/01/2002',N'Vũng Tàu','Nam','L002'),
		('SV05',N'Ngô Đình Việt','27/09/2004',N'Đà Nẵng','Nam','L003'),
		('SV06',N'Trần Thị Liễu','18/02/2003',N'TPHCM',N'Nữ','L003'),
		('SV07',N'Trần Thanh Nam','22/06/2004',N'Đồng Nai','Nam','L004'),
		('SV08',N'Phạm Hoài Phong','08/12/2003',N'Tiền Giang','Nam','L004'),
		('SV09',N'Trần Thị Tố Anh','28/11/2004',N'TPHCM',N'Nữ','L005'),
		('SV10',N'Đỗ Thị Hạnh','26/04/2004',N'Đồng Nai',N'Nữ','L006')

go
insert into MONHOC
values	('M001',N'Toán cao cấp A1',3),
		('M002',N'Lịch sử đảng',2),
		('M003',N'Chính trị',2),
		('M004',N'Cơ sở dữ liệu',4),
		('M005',N'Hệ quản trị CSDL',4),
		('M006',N'Lập trình C',3),
		('M007',N'Xử lý ảnh',2),
		('M008',N'Tin học vơ bản',3),
		('M009',N'mạng máy tính',2),
		('M010',N'Toán rời rạc',2),
		('M011',N'Lập trình Web',3),
		('M012',N'Công nghệ Java',3)

go
insert into KETQUA
values	('SV01','M001',8),
		('SV01','M002',4),
		('SV01','M003',6),
		('SV02','M001',4),
		('SV02','M004',5),
		('SV03','M002',7),
		('SV03','M006',9),
		('SV04','M004',10),
		('SV05','M005',6),
		('SV06','M006',9),
		('SV07','M008',7),
		('SV08','M001',3),
		('SV08','M002',8),
		('SV09','M003',6),
		('SV10','M002',5)

	
	--4.a--
select sv.MASV,HOTEN
from SINHVIEN sv,KHOA k,LOP l
where sv.MALOP=l.MALOP
and l.MAKHOA=k.MAKHOA
and TENKHOA=N'Công nghệ thông tin'
	--4.b--
select mh.MAMH,TENMH,DIEM
from KETQUA kq,SINHVIEN sv,MONHOC mh
where kq.MASV=sv.MASV 
and kq.MAMH=mh.MAMH
and kq.MASV='SV01'
	--4.c--
select sv.MASV,HOTEN,NGAYSINH,l.TENLOP
from SINHVIEN sv,KETQUA kq, MONHOC mh,LOP l
where sv.MALOP=l.MALOP
and sv.MASV=kq.MASV
and kq.MAMH=mh.MAMH
and mh.MAMH='M001'and DIEM<5
	--4.d--
select sv.MASV,HOTEN,ROUND((Sum(DIEM*SOTC)/Sum(SOTC)),1)as DTB
from SINHVIEN sv,KETQUA kq,MONHOC mh
where sv.MASV=kq.MASV
and kq.MAMH=mh.MAMH
group by sv.MASV,HOTEN
