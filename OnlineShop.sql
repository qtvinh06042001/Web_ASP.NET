USE [master]
GO
/****** Object:  Database [Shop]    Script Date: 12/05/2023 10:49:49 SA ******/
CREATE DATABASE [Shop]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Shop', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\Shop.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'Shop_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\Shop_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [Shop] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Shop].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Shop] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Shop] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Shop] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Shop] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Shop] SET ARITHABORT OFF 
GO
ALTER DATABASE [Shop] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [Shop] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Shop] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Shop] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Shop] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Shop] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Shop] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Shop] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Shop] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Shop] SET  DISABLE_BROKER 
GO
ALTER DATABASE [Shop] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Shop] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Shop] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Shop] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Shop] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Shop] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Shop] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Shop] SET RECOVERY FULL 
GO
ALTER DATABASE [Shop] SET  MULTI_USER 
GO
ALTER DATABASE [Shop] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Shop] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Shop] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Shop] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [Shop] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [Shop] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'Shop', N'ON'
GO
ALTER DATABASE [Shop] SET QUERY_STORE = ON
GO
ALTER DATABASE [Shop] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [Shop]
GO
/****** Object:  Table [dbo].[Category]    Script Date: 12/05/2023 10:49:50 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Category](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](250) NULL,
	[Avatar] [nvarchar](300) NULL,
 CONSTRAINT [PK_Category] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Contact]    Script Date: 12/05/2023 10:49:50 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Contact](
	[Name] [nvarchar](250) NULL,
	[Address] [nvarchar](500) NULL,
	[Phone] [nvarchar](15) NULL,
	[Fax] [nvarchar](50) NULL,
	[Email] [nvarchar](250) NULL,
	[LinkFB] [nvarchar](250) NULL,
	[LinkGoogleMap] [nvarchar](500) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[News]    Script Date: 12/05/2023 10:49:50 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[News](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](200) NULL,
	[ShortDes] [nvarchar](max) NULL,
	[FullDescription] [nvarchar](max) NULL,
	[Avatar] [nvarchar](300) NULL,
 CONSTRAINT [PK_News] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Order]    Script Date: 12/05/2023 10:49:50 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Order](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](100) NULL,
	[Phone] [nchar](10) NULL,
	[Adress] [nvarchar](max) NULL,
	[UserId] [int] NULL,
	[Status] [int] NULL,
	[CreateOnUtc] [datetime] NULL,
 CONSTRAINT [PK_Order] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OrderDetail]    Script Date: 12/05/2023 10:49:50 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OrderDetail](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[OrderId] [int] NULL,
	[ProductId] [int] NULL,
	[ProductName] [nvarchar](500) NULL,
	[Price] [decimal](18, 0) NULL,
	[Quantity] [int] NULL,
 CONSTRAINT [PK_OrderDetail] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Product]    Script Date: 12/05/2023 10:49:50 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Product](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](200) NULL,
	[Avatar] [nvarchar](300) NULL,
	[CategoryId] [int] NOT NULL,
	[ShortDes] [nvarchar](50) NULL,
	[FullDescription] [nvarchar](500) NULL,
	[Price] [decimal](18, 0) NULL,
 CONSTRAINT [PK_Product] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Response]    Script Date: 12/05/2023 10:49:50 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Response](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](250) NULL,
	[Email] [nvarchar](50) NULL,
	[CompanyName] [nvarchar](50) NULL,
	[Subject] [nvarchar](max) NULL,
 CONSTRAINT [PK_Response] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Users]    Script Date: 12/05/2023 10:49:50 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[idUser] [int] IDENTITY(1,1) NOT NULL,
	[FirstName] [nvarchar](50) NULL,
	[LastName] [nvarchar](50) NULL,
	[Email] [nvarchar](50) NULL,
	[Password] [nvarchar](50) NULL,
 CONSTRAINT [PK_Users] PRIMARY KEY CLUSTERED 
(
	[idUser] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Category] ON 

INSERT [dbo].[Category] ([Id], [Name], [Avatar]) VALUES (7, N'Phòng ăn - Bếp', N'nha-bep.jpg')
INSERT [dbo].[Category] ([Id], [Name], [Avatar]) VALUES (8, N'Phòng tắm', N'phong-tam.jpg')
INSERT [dbo].[Category] ([Id], [Name], [Avatar]) VALUES (9, N'Phòng khách', N'phong-khach.jpg')
INSERT [dbo].[Category] ([Id], [Name], [Avatar]) VALUES (10, N'Phòng ngủ', N'phong-ngu.jpg')
SET IDENTITY_INSERT [dbo].[Category] OFF
GO
SET IDENTITY_INSERT [dbo].[News] ON 

INSERT [dbo].[News] ([Id], [Name], [ShortDes], [FullDescription], [Avatar]) VALUES (1, N'Vì sao ngày càng ít người dùng lò vi sóng?', N'Ra đời năm 1945 và thống trị các nhà bếp khắp thế giới vào cuối thế kỷ 20, nhưng những năm gần đây lò vi sóng đang trở nên lỗi thời, bị nhiều gia đình xếp xó.', N'Lò vi sóng được phát minh bởi Percy Spencer, một kỹ sư của tập đoàn quốc phòng và hàng không vũ trụ đa quốc gia Raytheon. Khi mới ra đời, nó có kích thước như chiếc tủ lạnh, nặng hơn 300 kg và giá tới 3.000 USD, chủ yếu dùng trên tàu và xe lửa.', N'new1.jpg')
INSERT [dbo].[News] ([Id], [Name], [ShortDes], [FullDescription], [Avatar]) VALUES (2, N'Thời hạn sử dụng của 8 đồ gia dụng hay bị quên', N'Giống như thực phẩm, đồ gia dụng cũng có thời hạn để đảm bảo an toàn cho người dùng.', N'Bộ lọc nước

: Nhiều người cho rằng bộ lọc nước có thể tự làm sạch, nhưng thực tế chúng có thể trở thành nơi sản sinh của vi khuẩn nếu không được thay rửa thường xuyên. Vì vậy, bạn nên thay mới trung bình sáu tháng một lần.

', N'new2.jpg')
INSERT [dbo].[News] ([Id], [Name], [ShortDes], [FullDescription], [Avatar]) VALUES (3, N'
Những công dụng phụ ít biết của máy rửa bát', N'Máy rửa bát không chỉ để rửa bát đĩa hay dụng cụ nhà bếp, nó còn có công dụng làm sạch những đồ gia dụng khác mà nhiều người chưa biết.', N'Nếu bạn mệt mỏi vì phải giặt, rửa mọi thứ bằng tay trong khi gia đình có máy rửa bát, nên tận dụng thiết bị này. Hơi nóng từ máy rửa bát có thể tiêu diệt vết bẩn, nấm và vi khuẩn trên các món đồ của bạn, trong khi không làm mất hình dạng (form), ngoại trừ đồ gỗ hay các vật dụng có lông tự nhiên hoặc đồ nhọn, các sản phẩm mà nhà sản xuất khuyến cáo không giặt bằng nhiệt.', N'new3.jpg')
SET IDENTITY_INSERT [dbo].[News] OFF
GO
SET IDENTITY_INSERT [dbo].[Order] ON 

INSERT [dbo].[Order] ([Id], [Name], [Phone], [Adress], [UserId], [Status], [CreateOnUtc]) VALUES (16, N'Triệu Minh Vũ', N'0847562147', N'Thành phố Cao Bằng - Tỉnh Cao Bằng', 4, 1, CAST(N'2023-03-28T17:39:35.903' AS DateTime))
INSERT [dbo].[Order] ([Id], [Name], [Phone], [Adress], [UserId], [Status], [CreateOnUtc]) VALUES (17, N'Quản Thế Vinh', N'0983253241', N'Số 3-Thị trấn Kép-Lạng Giang', 3, 1, CAST(N'2023-03-28T17:40:15.787' AS DateTime))
INSERT [dbo].[Order] ([Id], [Name], [Phone], [Adress], [UserId], [Status], [CreateOnUtc]) VALUES (19, N'Triệu Minh Vũ', N'0983253567', N'Thành phố Cao Bằng - Tỉnh Cao Bằng', 4, 1, CAST(N'2023-03-29T09:12:32.743' AS DateTime))
INSERT [dbo].[Order] ([Id], [Name], [Phone], [Adress], [UserId], [Status], [CreateOnUtc]) VALUES (20, N'Triệu Minh Vũ', N'097356242 ', N'Cao Bằng', 4, 0, CAST(N'2023-04-06T09:33:49.857' AS DateTime))
INSERT [dbo].[Order] ([Id], [Name], [Phone], [Adress], [UserId], [Status], [CreateOnUtc]) VALUES (21, N'Quản Thế Vinh', N'0983253241', N'Số 3-Thị trấn Kép-Lạng Giang', 3, 1, CAST(N'2023-04-18T10:36:45.937' AS DateTime))
INSERT [dbo].[Order] ([Id], [Name], [Phone], [Adress], [UserId], [Status], [CreateOnUtc]) VALUES (22, N'Triệu Minh Vũ', N'0983253241', N'Số 3-Thị trấn Kép-Lạng Giang', 3, 1, CAST(N'2023-04-25T23:07:40.253' AS DateTime))
INSERT [dbo].[Order] ([Id], [Name], [Phone], [Adress], [UserId], [Status], [CreateOnUtc]) VALUES (26, N'Quản Thế Vinh', N'0983253241', N'Số 3-Thị trấn Kép-Lạng Giang', 3, 0, CAST(N'2023-05-06T16:30:35.253' AS DateTime))
SET IDENTITY_INSERT [dbo].[Order] OFF
GO
SET IDENTITY_INSERT [dbo].[OrderDetail] ON 

INSERT [dbo].[OrderDetail] ([Id], [OrderId], [ProductId], [ProductName], [Price], [Quantity]) VALUES (7, 16, 23, N'Đồng hồ báo thức', CAST(179000 AS Decimal(18, 0)), 3)
INSERT [dbo].[OrderDetail] ([Id], [OrderId], [ProductId], [ProductName], [Price], [Quantity]) VALUES (8, 16, 20, N'Thảm trải sàn phòng ngủ', CAST(250000 AS Decimal(18, 0)), 1)
INSERT [dbo].[OrderDetail] ([Id], [OrderId], [ProductId], [ProductName], [Price], [Quantity]) VALUES (9, 17, 10, N'Nồi Cơm Điện Kalpen', CAST(880000 AS Decimal(18, 0)), 4)
INSERT [dbo].[OrderDetail] ([Id], [OrderId], [ProductId], [ProductName], [Price], [Quantity]) VALUES (10, 17, 8, N'Bộ 5 nồi Inox', CAST(700000 AS Decimal(18, 0)), 1)
INSERT [dbo].[OrderDetail] ([Id], [OrderId], [ProductId], [ProductName], [Price], [Quantity]) VALUES (11, 17, 12, N'Đèn sưởi nhà tắm Kottmann 3 bóng', CAST(950000 AS Decimal(18, 0)), 1)
INSERT [dbo].[OrderDetail] ([Id], [OrderId], [ProductId], [ProductName], [Price], [Quantity]) VALUES (13, 19, 12, N'Đèn sưởi nhà tắm Kottmann 3 bóng', CAST(950000 AS Decimal(18, 0)), 2)
INSERT [dbo].[OrderDetail] ([Id], [OrderId], [ProductId], [ProductName], [Price], [Quantity]) VALUES (14, 19, 15, N'Giá treo khăn tắm Oenon', CAST(365000 AS Decimal(18, 0)), 3)
INSERT [dbo].[OrderDetail] ([Id], [OrderId], [ProductId], [ProductName], [Price], [Quantity]) VALUES (15, 20, 22, N'Tab đầu giường Erado', CAST(3900000 AS Decimal(18, 0)), 3)
INSERT [dbo].[OrderDetail] ([Id], [OrderId], [ProductId], [ProductName], [Price], [Quantity]) VALUES (16, 21, 9, N'Kệ đựng bát nhà bếp', CAST(1155000 AS Decimal(18, 0)), 3)
INSERT [dbo].[OrderDetail] ([Id], [OrderId], [ProductId], [ProductName], [Price], [Quantity]) VALUES (17, 22, 21, N'Đèn ngủ để bàn', CAST(230000 AS Decimal(18, 0)), 1)
INSERT [dbo].[OrderDetail] ([Id], [OrderId], [ProductId], [ProductName], [Price], [Quantity]) VALUES (18, 22, 20, N'Thảm trải sàn phòng ngủ', CAST(250000 AS Decimal(18, 0)), 3)
INSERT [dbo].[OrderDetail] ([Id], [OrderId], [ProductId], [ProductName], [Price], [Quantity]) VALUES (24, 26, 18, N'Đèn chùm phòng khách', CAST(4000000 AS Decimal(18, 0)), 1)
SET IDENTITY_INSERT [dbo].[OrderDetail] OFF
GO
SET IDENTITY_INSERT [dbo].[Product] ON 

INSERT [dbo].[Product] ([Id], [Name], [Avatar], [CategoryId], [ShortDes], [FullDescription], [Price]) VALUES (7, N'Chảo chống dính Sunhouse', N'chao-chong-dinh.jpg', 7, N'Chảo chống dính 24cm', N'Có thể nướng cá, gà 1kg', CAST(100000 AS Decimal(18, 0)))
INSERT [dbo].[Product] ([Id], [Name], [Avatar], [CategoryId], [ShortDes], [FullDescription], [Price]) VALUES (8, N'Bộ 5 nồi Inox', N'bo-5-noi.jpg', 7, N'Nấu ăn tiện lợi, dễ dàng, tiết kiệm năng lượng
', N'Bộ nồi inox 3 đáy chất liệu inox 430 sáng bóng, bền tốt, ít bị oxy hóa.
Bộ nồi 5 sản phẩm đường kính là quánh 18 cm, nồi 20 cm, chảo và bộ nồi xửng 24 cm.
Tay cầm dạng đũa chắc chắn dễ cầm nắm, nắp kính giữ nhiệt tốt tiện quan sát.
Dùng được trên bếp gas, bếp hồng ngoại và bếp từ.', CAST(700000 AS Decimal(18, 0)))
INSERT [dbo].[Product] ([Id], [Name], [Avatar], [CategoryId], [ShortDes], [FullDescription], [Price]) VALUES (9, N'Kệ đựng bát nhà bếp', N'ke-bep.jpg', 7, N'Thiết kế đầy đủ vị trí cho việc để dụng cụ bếp. ', N'Kích thước : 85-95-125 x 28 x 80 cm
Chất liệu: Thép Carbon sơn phủ tỉnh điện 5 lớp chống gỉ
,Trọng lượng : 5-8KG,
Độ chịu lực : 60kg', CAST(1155000 AS Decimal(18, 0)))
INSERT [dbo].[Product] ([Id], [Name], [Avatar], [CategoryId], [ShortDes], [FullDescription], [Price]) VALUES (10, N'Nồi Cơm Điện Kalpen', N'noi-com-dien.jpg', 7, N'Nồi cơm điện cao cấp Kalpen R2', N'cơm nóng đều với công nghệ ủ ấm 3D, lòng nồi bền với 3 lớp chống dính Whitford', CAST(880000 AS Decimal(18, 0)))
INSERT [dbo].[Product] ([Id], [Name], [Avatar], [CategoryId], [ShortDes], [FullDescription], [Price]) VALUES (11, N'Combo 7 dao bếp', N'dao.jpg', 7, N'Được sản xuất thủ công', N'Dao Chặt Xương, Dao Chặt Gà, Dao Thái Phở, Dao Bầu Thái Lọc, Dao Thái Vừa, Dao Thái Cỡ  Nhỏ, Kéo cắt gà', CAST(1500000 AS Decimal(18, 0)))
INSERT [dbo].[Product] ([Id], [Name], [Avatar], [CategoryId], [ShortDes], [FullDescription], [Price]) VALUES (12, N'Đèn sưởi nhà tắm Kottmann 3 bóng', N'den-suoi.jpg', 8, N'Loại đènĐèn sưởi nhà tắm treo tường', N'Công suất: 825W
, Số lượng bóng đèn: 3 bóng, Tuổi thọ đèn: 10.000 giờ
, Bóng hồng ngoại tráng kim cương nhân tạo, 
Bảo hành36 tháng', CAST(950000 AS Decimal(18, 0)))
INSERT [dbo].[Product] ([Id], [Name], [Avatar], [CategoryId], [ShortDes], [FullDescription], [Price]) VALUES (13, N'Gương phòng tắm tròn, led', N'guong.jpg', 8, N'Tích hợp chức năng gương soi và chiếu sáng.', N'Gương không chỉ cho hình ảnh sắc nét, chân thực, tự nhiên mà chiếc đèn LED được gắn vào gương tăng thêm độ sáng.', CAST(2200000 AS Decimal(18, 0)))
INSERT [dbo].[Product] ([Id], [Name], [Avatar], [CategoryId], [ShortDes], [FullDescription], [Price]) VALUES (14, N'Kệ góc nhà tắm', N'ke-nha-tam.jpg', 8, N'Dán nhà tắm, phòng bếp tiện lợi', N'Không cần khoan tường bắn vít, chất liệu nhựa ABS cao cấp', CAST(150000 AS Decimal(18, 0)))
INSERT [dbo].[Product] ([Id], [Name], [Avatar], [CategoryId], [ShortDes], [FullDescription], [Price]) VALUES (15, N'Giá treo khăn tắm Oenon', N'gia-treo.jpg', 8, N'Giá Treo Khăn Tắm Oenon Bằng Inox 304 Không Gỉ', N'Sản phẩm đẹp, khá chắc chắn, k bị lỗi gì. Inox thì nói chung là được, có phần mỏng phần dày nhưng đó là do thiết kế cho phù hợp với công dụng của sản phẩm. Mọi người có thể yên tâm mua nha. Cho shop 5 sao vì bán hàng tốt! 
', CAST(365000 AS Decimal(18, 0)))
INSERT [dbo].[Product] ([Id], [Name], [Avatar], [CategoryId], [ShortDes], [FullDescription], [Price]) VALUES (16, N'Mô hình thuyền buồn', N'thuyen.jpg', 9, N'Mô Hình Thuyền Buồm Dát Mạ Vàng 24K Sang Trọng', N'Chất liệu: Dát Vàng 24K
Kích thước: 50cm x 18cm x 34 cm ( Dài x Rộng x Cao )
Hình thức: Hàng có sẵn
Sản phẩm được bảo hành 1 đổi 1 trong 24 tháng', CAST(5500000 AS Decimal(18, 0)))
INSERT [dbo].[Product] ([Id], [Name], [Avatar], [CategoryId], [ShortDes], [FullDescription], [Price]) VALUES (17, N'Đồng hồ treo tường công ngũ sắc', N'dong-ho.jpg', 9, N'Mặt đồng hồ số to dễ nhìn, đổi màu, 72cm', N'Kích thước: 72x70cm, 
Chất liệu: Hợp kim , đính đá, sơn ủ nhiệt 3 lớp.
Động Cơ: Kim trôi, tiêu chuẩn EU.', CAST(2500000 AS Decimal(18, 0)))
INSERT [dbo].[Product] ([Id], [Name], [Avatar], [CategoryId], [ShortDes], [FullDescription], [Price]) VALUES (18, N'Đèn chùm phòng khách', N'den-chum.jpg', 9, N'Hàng order 
nhập khẩu nguyên chiếc
, Đèn thả', N' Kích thước 	 40 - 60 - 80 - 100cm
, Chất liệu: acrylic, 3 chế độ sáng: trắng - vàng - trung  tính, Công suất: 135W ', CAST(4000000 AS Decimal(18, 0)))
INSERT [dbo].[Product] ([Id], [Name], [Avatar], [CategoryId], [ShortDes], [FullDescription], [Price]) VALUES (19, N'Máy lọc không khí Nature Cool FC-AP152C', N'may-loc-kk.jpg', 9, N'Giúp cải thiện chất lượng không khí xung quanh', N'Với hệ thống trang bị màng lọc HEPA hiệu quả cao, có thể loại bỏ các phân tử bụi mịn 0.25 microns, tỷ lệ lọc lên đến 99, 97% vi khuẩn, nấm, virus, chất gây dị ứng,.. ', CAST(9000000 AS Decimal(18, 0)))
INSERT [dbo].[Product] ([Id], [Name], [Avatar], [CategoryId], [ShortDes], [FullDescription], [Price]) VALUES (20, N'Thảm trải sàn phòng ngủ', N'tham-nhung.jpg', 10, N'Thảm lông xù trải sàn phòng ngủ rất được ưa chuộng', N'Thảm trải sàn phòng ngủ lông xù mang đến cho chúng ta không gian phòng ngủ hiện đại hơn, sang trọng hơn. Thảm trải sàn lông xù được Nhà đẹp 968 cung cấp với chất liệu cao cấp, màu sắc đa dạng và giá bán cũng rất cạnh tranh trên thị trường', CAST(250000 AS Decimal(18, 0)))
INSERT [dbo].[Product] ([Id], [Name], [Avatar], [CategoryId], [ShortDes], [FullDescription], [Price]) VALUES (21, N'Đèn ngủ để bàn', N'den-ngu.jpg', 10, N'Thân và đế bằng gỗ hiện đại, cứng cáp, chắc chắn', N'Lắp bóng đèn linh hoạt chuẩn đui E27
Có thể di chuyển tới bất kì vị trí nào mà bạn muốn. 
Dây điện kết nối dễ dàng, chỉ cần cắm điện là có thể sử dụng được. ', CAST(230000 AS Decimal(18, 0)))
INSERT [dbo].[Product] ([Id], [Name], [Avatar], [CategoryId], [ShortDes], [FullDescription], [Price]) VALUES (22, N'Tab đầu giường Erado', N'tab.jpg', 10, N'Thiết kế tối giản nhưng đa dụng', N'Mẫu tủ đầu giường ấn tượng với thiết kế vuông vắn, Ngăn chứa đồ rộng rãi, dễ dàng sử dụng, Mặt bàn rộng để điện thoại, ảnh gia đình đều vô cùng phù hợp', CAST(3900000 AS Decimal(18, 0)))
INSERT [dbo].[Product] ([Id], [Name], [Avatar], [CategoryId], [ShortDes], [FullDescription], [Price]) VALUES (23, N'Đồng hồ báo thức', N'dh-bao-thuc.jpg', 10, N'Đồng hồ báo thức 2 quả chuông kèm đèn', N'Dáng nhỏ gọn và xinh xắn với nhiều màu sắc bắt mắt nổi bật, đồng hồ báo thức 2 quả chuông kèm đèn kiểu cổ điển sẽ là món đồ trang trí hoàn hảo cho văn phòng làm việc của bạn.', CAST(179000 AS Decimal(18, 0)))
SET IDENTITY_INSERT [dbo].[Product] OFF
GO
SET IDENTITY_INSERT [dbo].[Response] ON 

INSERT [dbo].[Response] ([Id], [Name], [Email], [CompanyName], [Subject]) VALUES (2, N'Bùi Đình Huy', N'huybui123@gmail.com', N'NTQ Solution', N' Sản phẩm đẹp, giá cả phù hợp, dùng bền tuy nhiên giao hơi chậm')
SET IDENTITY_INSERT [dbo].[Response] OFF
GO
SET IDENTITY_INSERT [dbo].[Users] ON 

INSERT [dbo].[Users] ([idUser], [FirstName], [LastName], [Email], [Password]) VALUES (3, N'Quan The', N'Vinh', N'vinh@gmail.com', N'c4ca4238a0b923820dcc509a6f75849b')
INSERT [dbo].[Users] ([idUser], [FirstName], [LastName], [Email], [Password]) VALUES (4, N'Vu', N'Trieu', N'vu@gmail.com', N'c4ca4238a0b923820dcc509a6f75849b')
INSERT [dbo].[Users] ([idUser], [FirstName], [LastName], [Email], [Password]) VALUES (5, N'admin', NULL, N'admin@gmail.com', N'202cb962ac59075b964b07152d234b70')
INSERT [dbo].[Users] ([idUser], [FirstName], [LastName], [Email], [Password]) VALUES (6, N'Huy', N'Bùi', N'huybui123@gmail.com', N'c4ca4238a0b923820dcc509a6f75849b')
INSERT [dbo].[Users] ([idUser], [FirstName], [LastName], [Email], [Password]) VALUES (7, N'Linh', N'Dương Quang', N'linhduong@gmail.com', N'c4ca4238a0b923820dcc509a6f75849b')
SET IDENTITY_INSERT [dbo].[Users] OFF
GO
ALTER TABLE [dbo].[Order]  WITH CHECK ADD  CONSTRAINT [FK_Order_Users1] FOREIGN KEY([UserId])
REFERENCES [dbo].[Users] ([idUser])
GO
ALTER TABLE [dbo].[Order] CHECK CONSTRAINT [FK_Order_Users1]
GO
ALTER TABLE [dbo].[OrderDetail]  WITH CHECK ADD  CONSTRAINT [FK_OrderDetail_Order] FOREIGN KEY([OrderId])
REFERENCES [dbo].[Order] ([Id])
GO
ALTER TABLE [dbo].[OrderDetail] CHECK CONSTRAINT [FK_OrderDetail_Order]
GO
ALTER TABLE [dbo].[OrderDetail]  WITH CHECK ADD  CONSTRAINT [FK_OrderDetail_Product] FOREIGN KEY([ProductId])
REFERENCES [dbo].[Product] ([Id])
GO
ALTER TABLE [dbo].[OrderDetail] CHECK CONSTRAINT [FK_OrderDetail_Product]
GO
ALTER TABLE [dbo].[Product]  WITH CHECK ADD  CONSTRAINT [FK_Product_Category1] FOREIGN KEY([CategoryId])
REFERENCES [dbo].[Category] ([Id])
GO
ALTER TABLE [dbo].[Product] CHECK CONSTRAINT [FK_Product_Category1]
GO
USE [master]
GO
ALTER DATABASE [Shop] SET  READ_WRITE 
GO
