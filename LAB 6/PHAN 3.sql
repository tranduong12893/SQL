USE Lab10
GO
CREATE TABLE Student(
	StudentNo INT PRIMARY KEY,
	StudentName nvarchar(50),
	StudentAddress nvarchar(100),
	PhoneNo INT
)
GO
CREATE TABLE Department(
	DeptNo INT PRIMARY KEY,
	DeptName nvarchar(50),
	ManagerName nvarchar(30)
)
GO
CREATE TABLE Assignment(
	AssignmentNo INT PRIMARY KEY,
	Descriptions nvarchar(100)
)
GO
CREATE TABLE Works_Assign(
	JobID INT PRIMARY KEY IDENTITY,
	StudentNo INT,
	AssignmentNo INT,
	TotalHours INT,
	JobDetails nvarchar(450)
	CONSTRAINT WR FOREIGN KEY (StudentNo) REFERENCES Student(StudentNo),
	CONSTRAINT WA FOREIGN KEY (AssignmentNo) REFERENCES Assignment(AssignmentNo)
)
GO

--CHÈN DỮ LIỆU
INSERT INTO Student VALUES(1,N'Trần văn tuấn',N'123 trần phú, hà nội',1252485632),
						  (2,N'Lê thị thắm',N'12 trần phú, hà nội',1257859572),
						  (4,N'nguyễn hoa khôi',N'123 phú la, hà nội',1242525222),
						  (5,N'bùi hữu thành',N'637 trương định, hà nội',1258555555)
GO
INSERT INTO Department VALUES(123,N'IT',N'Lê Thu Huyền'),
						  (322,N'Kinh Tế',N'Hà Văn Hùng'),
						  (452,N'ARENA',N'Bùi Thu TRang')
GO
INSERT INTO Assignment VALUES(101,N'viết phần mềm AI'),
						  (203,N'thiết kế bìa posster'),
						  (405,N'theo dõi và đánh giá biến động của Bitcoin'),
						  (105,N'phần mềm học thay online')
GO
INSERT INTO Works_Assign VALUES(1,101,60,N'viết phần mềm AI'),
						  (2,203,40,N'thiết kế bìa posster'),
						  (4,405,120,N'theo dõi và đánh giá biến động của Bitcoin'),
						  (5,105,200,N'phần mềm học thay online')
GO
--2. Tạo một clustered index tên là IX_Student trên cột StudentNo của bảng Student
CREATE CLUSTERED INDEX IX_Student
ON Student(StudentNo)
GO
--3. Chỉnh sửa và xây dựng lại (rebuild) IX_Student đã được tạo trên bảng Student 
ALTER INDEX IX_Student ON Student REBUILD
--4. Tạo một chỉ non clustered index tên là IX_Dept trên bảng Department sử dụng 2 trường không khóa DeptName và DeptManagerNo. 
CREATE NONCLUSTERED INDEX IX_Dept
ON Department(DeptName,ManagerName)
GO

