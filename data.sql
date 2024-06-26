USE [master]
GO
/****** Object:  Database [KTMT]    Script Date: 5/26/2024 10:14:10 PM ******/
CREATE DATABASE [KTMT]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'KTMT', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\KTMT.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'KTMT_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\KTMT_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [KTMT] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [KTMT].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [KTMT] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [KTMT] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [KTMT] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [KTMT] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [KTMT] SET ARITHABORT OFF 
GO
ALTER DATABASE [KTMT] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [KTMT] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [KTMT] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [KTMT] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [KTMT] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [KTMT] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [KTMT] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [KTMT] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [KTMT] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [KTMT] SET  DISABLE_BROKER 
GO
ALTER DATABASE [KTMT] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [KTMT] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [KTMT] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [KTMT] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [KTMT] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [KTMT] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [KTMT] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [KTMT] SET RECOVERY FULL 
GO
ALTER DATABASE [KTMT] SET  MULTI_USER 
GO
ALTER DATABASE [KTMT] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [KTMT] SET DB_CHAINING OFF 
GO
ALTER DATABASE [KTMT] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [KTMT] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [KTMT] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [KTMT] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [KTMT] SET QUERY_STORE = ON
GO
ALTER DATABASE [KTMT] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [KTMT]
GO
/****** Object:  Table [dbo].[account_admins]    Script Date: 5/26/2024 10:14:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[account_admins](
	[ip] [varchar](255) NULL,
	[username] [nvarchar](20) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[username] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[account_normals]    Script Date: 5/26/2024 10:14:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[account_normals](
	[rule_account] [varchar](255) NULL,
	[time_limit] [date] NULL,
	[username] [nvarchar](20) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[username] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[accounts]    Script Date: 5/26/2024 10:14:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[accounts](
	[username] [nvarchar](20) NOT NULL,
	[password] [nvarchar](20) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[username] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[classes]    Script Date: 5/26/2024 10:14:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[classes](
	[clazzid] [varchar](255) NOT NULL,
	[clazz_name] [varchar](255) NULL,
	[discription] [varchar](255) NULL,
	[quantity] [int] NOT NULL,
	[id] [varchar](255) NULL,
	[majorid] [nvarchar](10) NULL,
PRIMARY KEY CLUSTERED 
(
	[clazzid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[course_major]    Script Date: 5/26/2024 10:14:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[course_major](
	[courseid] [nvarchar](10) NOT NULL,
	[majorid] [nvarchar](10) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[courses]    Script Date: 5/26/2024 10:14:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[courses](
	[courseid] [nvarchar](10) NOT NULL,
	[credits] [int] NULL,
	[name] [nvarchar](100) NULL,
	[type] [nvarchar](50) NULL,
	[courseafid] [nvarchar](10) NULL,
PRIMARY KEY CLUSTERED 
(
	[courseid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[departments]    Script Date: 5/26/2024 10:14:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[departments](
	[deptid] [nvarchar](10) NOT NULL,
	[address] [varchar](255) NULL,
	[email] [varchar](255) NULL,
	[phone] [varchar](255) NULL,
	[date] [date] NULL,
	[dept_name] [nvarchar](50) NULL,
	[description] [nvarchar](150) NULL,
	[deanid] [varchar](255) NULL,
 CONSTRAINT [PK__departme__BE2C1AEEFA932E6A] PRIMARY KEY CLUSTERED 
(
	[deptid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[enrollment_practives]    Script Date: 5/26/2024 10:14:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[enrollment_practives](
	[enrollmentpid] [varchar](255) NOT NULL,
	[name] [varchar](255) NULL,
	[quantity] [int] NOT NULL,
	[room] [varchar](255) NULL,
	[enrollmentid] [varchar](255) NULL,
	[id] [varchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[enrollmentpid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[enrollments]    Script Date: 5/26/2024 10:14:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[enrollments](
	[enrollmentid] [varchar](255) NOT NULL,
	[date_apply_end] [date] NULL,
	[date_apply_start] [date] NULL,
	[date_start] [date] NULL,
	[name] [nvarchar](50) NOT NULL,
	[quantity] [int] NOT NULL,
	[room_name] [nvarchar](50) NOT NULL,
	[semester] [int] NOT NULL,
	[status] [varchar](255) NULL,
	[year] [int] NOT NULL,
	[courseid] [nvarchar](10) NULL,
	[scheduleid] [int] NOT NULL,
	[id] [varchar](255) NOT NULL,
 CONSTRAINT [PK__enrollme__ACFE20AEA5BE02C6] PRIMARY KEY CLUSTERED 
(
	[enrollmentid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[infor_students]    Script Date: 5/26/2024 10:14:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[infor_students](
	[scholarship] [nvarchar](50) NOT NULL,
	[id] [varchar](255) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[instructors]    Script Date: 5/26/2024 10:14:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[instructors](
	[gradute_degree] [nvarchar](50) NULL,
	[salary] [float] NOT NULL,
	[id] [varchar](255) NOT NULL,
 CONSTRAINT [PK__instruct__3213E83F319F4C80] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[majors]    Script Date: 5/26/2024 10:14:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[majors](
	[majorid] [nvarchar](10) NOT NULL,
	[description] [nvarchar](150) NULL,
	[name] [nvarchar](100) NULL,
	[deptid] [nvarchar](10) NULL,
PRIMARY KEY CLUSTERED 
(
	[majorid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[peoples]    Script Date: 5/26/2024 10:14:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[peoples](
	[id] [varchar](255) NOT NULL,
	[age] [int] NOT NULL,
	[cccd] [varchar](255) NULL,
	[address] [nvarchar](50) NULL,
	[email] [nvarchar](50) NULL,
	[phone] [varchar](255) NULL,
	[img] [varchar](255) NULL,
	[name] [nvarchar](50) NULL,
	[nationality] [nvarchar](50) NULL,
	[sex] [bit] NOT NULL,
	[accountid] [nvarchar](20) NOT NULL,
	[majorid] [nvarchar](10) NOT NULL,
 CONSTRAINT [PK__peoples__3213E83FCC0B9273] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[practice_scores]    Script Date: 5/26/2024 10:14:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[practice_scores](
	[resultid] [nvarchar](20) NOT NULL,
	[practice_score] [float] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[regular_score]    Script Date: 5/26/2024 10:14:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[regular_score](
	[resultid] [nvarchar](20) NOT NULL,
	[regular_score] [float] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[results]    Script Date: 5/26/2024 10:14:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[results](
	[resultid] [nvarchar](20) NOT NULL,
	[final_score] [float] NULL,
	[midterm_score] [float] NULL,
	[overall_score] [float] NULL,
 CONSTRAINT [PK__results__C6EBD0432D938568] PRIMARY KEY CLUSTERED 
(
	[resultid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[schedules]    Script Date: 5/26/2024 10:14:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[schedules](
	[scheduleid] [int] IDENTITY(1,1) NOT NULL,
	[classes_end] [int] NOT NULL,
	[classes_start] [int] NOT NULL,
	[day_of_week] [varchar](255) NULL,
	[enrollmentid] [varchar](255) NULL,
	[enrollmentpid] [varchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[scheduleid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[student_enrollment]    Script Date: 5/26/2024 10:14:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[student_enrollment](
	[code_practive] [varchar](255) NULL,
	[date_apply] [date] NULL,
	[note_student_enrollment] [nvarchar](50) NOT NULL,
	[payment_status] [nvarchar](20) NOT NULL,
	[process_study] [int] NOT NULL,
	[study_status] [nvarchar](20) NOT NULL,
	[enrollmentid] [varchar](255) NOT NULL,
	[studentid] [varchar](255) NOT NULL,
	[resultid] [nvarchar](20) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[enrollmentid] ASC,
	[studentid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[students]    Script Date: 5/26/2024 10:14:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[students](
	[academic_year] [int] NOT NULL,
	[status] [int] NOT NULL,
	[id] [varchar](255) NOT NULL,
	[clazzid] [varchar](255) NULL,
 CONSTRAINT [PK__students__3213E83F4EFF8B19] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[account_normals] ([rule_account], [time_limit], [username]) VALUES (N'GV', CAST(N'2030-12-24' AS Date), N'12345678')
INSERT [dbo].[account_normals] ([rule_account], [time_limit], [username]) VALUES (N'GV', CAST(N'2030-12-24' AS Date), N'12347895')
INSERT [dbo].[account_normals] ([rule_account], [time_limit], [username]) VALUES (N'GV', CAST(N'2030-12-24' AS Date), N'12587469')
INSERT [dbo].[account_normals] ([rule_account], [time_limit], [username]) VALUES (N'GV', CAST(N'2030-09-09' AS Date), N'14204554')
INSERT [dbo].[account_normals] ([rule_account], [time_limit], [username]) VALUES (N'GV', CAST(N'2029-02-03' AS Date), N'14204914')
INSERT [dbo].[account_normals] ([rule_account], [time_limit], [username]) VALUES (N'GV', CAST(N'2030-12-24' AS Date), N'14598762')
INSERT [dbo].[account_normals] ([rule_account], [time_limit], [username]) VALUES (N'GV', CAST(N'2030-12-24' AS Date), N'14725898')
INSERT [dbo].[account_normals] ([rule_account], [time_limit], [username]) VALUES (N'GV', CAST(N'2030-12-24' AS Date), N'14785236')
INSERT [dbo].[account_normals] ([rule_account], [time_limit], [username]) VALUES (N'GV', CAST(N'2030-12-24' AS Date), N'14785987')
INSERT [dbo].[account_normals] ([rule_account], [time_limit], [username]) VALUES (N'SV', CAST(N'2025-05-19' AS Date), N'20013345')
INSERT [dbo].[account_normals] ([rule_account], [time_limit], [username]) VALUES (N'SV', CAST(N'2026-05-19' AS Date), N'21000945')
INSERT [dbo].[account_normals] ([rule_account], [time_limit], [username]) VALUES (N'SV', CAST(N'2026-05-19' AS Date), N'21001145')
INSERT [dbo].[account_normals] ([rule_account], [time_limit], [username]) VALUES (N'SV', CAST(N'2026-05-19' AS Date), N'21001245')
INSERT [dbo].[account_normals] ([rule_account], [time_limit], [username]) VALUES (N'SV', CAST(N'2026-05-19' AS Date), N'21002345')
INSERT [dbo].[account_normals] ([rule_account], [time_limit], [username]) VALUES (N'SV', CAST(N'2026-05-19' AS Date), N'21003345')
INSERT [dbo].[account_normals] ([rule_account], [time_limit], [username]) VALUES (N'SV', CAST(N'2026-05-19' AS Date), N'21005345')
INSERT [dbo].[account_normals] ([rule_account], [time_limit], [username]) VALUES (N'SV', CAST(N'2030-12-24' AS Date), N'21108651')
INSERT [dbo].[account_normals] ([rule_account], [time_limit], [username]) VALUES (N'SV', CAST(N'2030-12-24' AS Date), N'21113731')
INSERT [dbo].[account_normals] ([rule_account], [time_limit], [username]) VALUES (N'SV', CAST(N'2026-05-19' AS Date), N'21222345')
INSERT [dbo].[account_normals] ([rule_account], [time_limit], [username]) VALUES (N'SV', CAST(N'2027-05-19' AS Date), N'22003245')
INSERT [dbo].[account_normals] ([rule_account], [time_limit], [username]) VALUES (N'SV', CAST(N'2027-05-19' AS Date), N'22003345')
INSERT [dbo].[account_normals] ([rule_account], [time_limit], [username]) VALUES (N'SV', CAST(N'2027-05-19' AS Date), N'22013245')
GO
INSERT [dbo].[accounts] ([username], [password]) VALUES (N'1', N'123')
INSERT [dbo].[accounts] ([username], [password]) VALUES (N'12345678', N'123')
INSERT [dbo].[accounts] ([username], [password]) VALUES (N'12347895', N'123')
INSERT [dbo].[accounts] ([username], [password]) VALUES (N'12587469', N'123')
INSERT [dbo].[accounts] ([username], [password]) VALUES (N'14204554', N'123')
INSERT [dbo].[accounts] ([username], [password]) VALUES (N'14204914', N'123')
INSERT [dbo].[accounts] ([username], [password]) VALUES (N'14598762', N'123')
INSERT [dbo].[accounts] ([username], [password]) VALUES (N'14725898', N'123')
INSERT [dbo].[accounts] ([username], [password]) VALUES (N'14785236', N'123')
INSERT [dbo].[accounts] ([username], [password]) VALUES (N'14785987', N'123')
INSERT [dbo].[accounts] ([username], [password]) VALUES (N'20013345', N'123')
INSERT [dbo].[accounts] ([username], [password]) VALUES (N'21000945', N'123')
INSERT [dbo].[accounts] ([username], [password]) VALUES (N'21001145', N'123')
INSERT [dbo].[accounts] ([username], [password]) VALUES (N'21001245', N'123')
INSERT [dbo].[accounts] ([username], [password]) VALUES (N'21002345', N'123')
INSERT [dbo].[accounts] ([username], [password]) VALUES (N'21003345', N'123')
INSERT [dbo].[accounts] ([username], [password]) VALUES (N'21005345', N'123')
INSERT [dbo].[accounts] ([username], [password]) VALUES (N'21005545', N'123')
INSERT [dbo].[accounts] ([username], [password]) VALUES (N'21006545', N'123')
INSERT [dbo].[accounts] ([username], [password]) VALUES (N'21007545', N'123')
INSERT [dbo].[accounts] ([username], [password]) VALUES (N'21007645', N'123')
INSERT [dbo].[accounts] ([username], [password]) VALUES (N'21009845', N'123')
INSERT [dbo].[accounts] ([username], [password]) VALUES (N'21108651', N'123')
INSERT [dbo].[accounts] ([username], [password]) VALUES (N'21113731', N'123')
INSERT [dbo].[accounts] ([username], [password]) VALUES (N'21222345', N'123')
INSERT [dbo].[accounts] ([username], [password]) VALUES (N'22003245', N'123')
INSERT [dbo].[accounts] ([username], [password]) VALUES (N'22003345', N'123')
INSERT [dbo].[accounts] ([username], [password]) VALUES (N'22013245', N'123')
GO
INSERT [dbo].[classes] ([clazzid], [clazz_name], [discription], [quantity], [id], [majorid]) VALUES (N'1', N'DHKTPM17A', N'không', 80, N'12345678', N'KTPM')
INSERT [dbo].[classes] ([clazzid], [clazz_name], [discription], [quantity], [id], [majorid]) VALUES (N'2', N'DHKTPM17B', N'không', 80, N'12347895', N'KTPM')
GO
INSERT [dbo].[course_major] ([courseid], [majorid]) VALUES (N'C1', N'CNTT')
INSERT [dbo].[course_major] ([courseid], [majorid]) VALUES (N'C2', N'KTPM')
INSERT [dbo].[course_major] ([courseid], [majorid]) VALUES (N'C3', N'KTPM')
INSERT [dbo].[course_major] ([courseid], [majorid]) VALUES (N'C4', N'KTPM')
INSERT [dbo].[course_major] ([courseid], [majorid]) VALUES (N'C5', N'CNTT')
INSERT [dbo].[course_major] ([courseid], [majorid]) VALUES (N'C4', N'CNTT')
INSERT [dbo].[course_major] ([courseid], [majorid]) VALUES (N'C6', N'KTPM')
INSERT [dbo].[course_major] ([courseid], [majorid]) VALUES (N'C3', N'CT')
INSERT [dbo].[course_major] ([courseid], [majorid]) VALUES (N'C9', N'CNTT')
INSERT [dbo].[course_major] ([courseid], [majorid]) VALUES (N'C10', N'CNTT')
INSERT [dbo].[course_major] ([courseid], [majorid]) VALUES (N'C12', N'KTPM')
INSERT [dbo].[course_major] ([courseid], [majorid]) VALUES (N'C15', N'CNTT')
INSERT [dbo].[course_major] ([courseid], [majorid]) VALUES (N'C16', N'CNTT')
INSERT [dbo].[course_major] ([courseid], [majorid]) VALUES (N'C16', N'CT')
INSERT [dbo].[course_major] ([courseid], [majorid]) VALUES (N'C30', N'CT')
INSERT [dbo].[course_major] ([courseid], [majorid]) VALUES (N'C36', N'CT')
INSERT [dbo].[course_major] ([courseid], [majorid]) VALUES (N'C5', N'KTPM')
INSERT [dbo].[course_major] ([courseid], [majorid]) VALUES (N'C7', N'KTPM')
INSERT [dbo].[course_major] ([courseid], [majorid]) VALUES (N'C8', N'KTPM')
INSERT [dbo].[course_major] ([courseid], [majorid]) VALUES (N'C9', N'KTPM')
INSERT [dbo].[course_major] ([courseid], [majorid]) VALUES (N'C10', N'KTPM')
INSERT [dbo].[course_major] ([courseid], [majorid]) VALUES (N'C11', N'KTPM')
INSERT [dbo].[course_major] ([courseid], [majorid]) VALUES (N'C13', N'CNTT')
INSERT [dbo].[course_major] ([courseid], [majorid]) VALUES (N'C14', N'CNTT')
INSERT [dbo].[course_major] ([courseid], [majorid]) VALUES (N'C38', N'CNTT')
INSERT [dbo].[course_major] ([courseid], [majorid]) VALUES (N'C39', N'KTPM')
INSERT [dbo].[course_major] ([courseid], [majorid]) VALUES (N'C40', N'KTPM')
INSERT [dbo].[course_major] ([courseid], [majorid]) VALUES (N'C41', N'CT')
INSERT [dbo].[course_major] ([courseid], [majorid]) VALUES (N'C42', N'CT')
INSERT [dbo].[course_major] ([courseid], [majorid]) VALUES (N'C43', N'CT')
INSERT [dbo].[course_major] ([courseid], [majorid]) VALUES (N'C1', N'KTPM')
INSERT [dbo].[course_major] ([courseid], [majorid]) VALUES (N'C44', N'KTPM')
GO
INSERT [dbo].[courses] ([courseid], [credits], [name], [type], [courseafid]) VALUES (N'C1', 4, N'Kiến trúc và Thiết kế phần mềm', N'Bắt buộc', NULL)
INSERT [dbo].[courses] ([courseid], [credits], [name], [type], [courseafid]) VALUES (N'C10', 2, N'Nhập môn tin học', N'Bắt buộc', NULL)
INSERT [dbo].[courses] ([courseid], [credits], [name], [type], [courseafid]) VALUES (N'C11', 3, N'Hệ cơ sở dữ liệu', N'Bắt buộc', N'C21')
INSERT [dbo].[courses] ([courseid], [credits], [name], [type], [courseafid]) VALUES (N'C12', 3, N'Logic học', N'Tự chọn', NULL)
INSERT [dbo].[courses] ([courseid], [credits], [name], [type], [courseafid]) VALUES (N'C13', 3, N'Mạng máy tính', N'Bắt buộc', NULL)
INSERT [dbo].[courses] ([courseid], [credits], [name], [type], [courseafid]) VALUES (N'C14', 4, N'Hệ thống máy tính', N'Bắt buộc', NULL)
INSERT [dbo].[courses] ([courseid], [credits], [name], [type], [courseafid]) VALUES (N'C15', 3, N'Cấu trúc rời rạc', N'Bắt buộc', NULL)
INSERT [dbo].[courses] ([courseid], [credits], [name], [type], [courseafid]) VALUES (N'C16', 2, N'Kinh tế chính trị Mac-Lenin', N'Bắt buộc', NULL)
INSERT [dbo].[courses] ([courseid], [credits], [name], [type], [courseafid]) VALUES (N'C17', 2, N'Toán cao cấp 2', N'Bắt buộc', NULL)
INSERT [dbo].[courses] ([courseid], [credits], [name], [type], [courseafid]) VALUES (N'C18', 3, N'Cấu trúc dữ liệu và giải thuật ', N'Bắt buộc', NULL)
INSERT [dbo].[courses] ([courseid], [credits], [name], [type], [courseafid]) VALUES (N'C19', 3, N'Kỹ năng xây dựng kế hoạch', N'Tự chọn', NULL)
INSERT [dbo].[courses] ([courseid], [credits], [name], [type], [courseafid]) VALUES (N'C2', 3, N'Nhập môn lập trình', N'Bắt buộc', N'C4')
INSERT [dbo].[courses] ([courseid], [credits], [name], [type], [courseafid]) VALUES (N'C20', 3, N'Hệ thống và Công nghệ Web', N'Bắt buộc', NULL)
INSERT [dbo].[courses] ([courseid], [credits], [name], [type], [courseafid]) VALUES (N'C21', 3, N'Phân tích thiết kế hệ thống ', N'Bắt buộc', NULL)
INSERT [dbo].[courses] ([courseid], [credits], [name], [type], [courseafid]) VALUES (N'C22', 3, N'Hệ quản trị cơ sở dữ liệu NoSQL MongoDB', N'Bắt buộc', N'C31')
INSERT [dbo].[courses] ([courseid], [credits], [name], [type], [courseafid]) VALUES (N'C23', 3, N'Tương tác người máy', N'Tự chọn', N'C14')
INSERT [dbo].[courses] ([courseid], [credits], [name], [type], [courseafid]) VALUES (N'C24', 4, N'Lập trình hướng sự kiện với công nghệ Java', N'Tự chọn', NULL)
INSERT [dbo].[courses] ([courseid], [credits], [name], [type], [courseafid]) VALUES (N'C25', 3, N'Lý thuyết đồ thị', N'Bắt buộc', N'C15')
INSERT [dbo].[courses] ([courseid], [credits], [name], [type], [courseafid]) VALUES (N'C26', 2, N'Phương pháp luận nghiên cứu khoa học', N'Bắt buộc ', NULL)
INSERT [dbo].[courses] ([courseid], [credits], [name], [type], [courseafid]) VALUES (N'C27', 3, N'Phát triển ứng dụng', N'Bắt buộc', NULL)
INSERT [dbo].[courses] ([courseid], [credits], [name], [type], [courseafid]) VALUES (N'C28', 3, N'Tiếng việt thực hành', N'Tự chọn', NULL)
INSERT [dbo].[courses] ([courseid], [credits], [name], [type], [courseafid]) VALUES (N'C29', 3, N'Nhập môn an toàn thông tin', N'Bắt buộc', NULL)
INSERT [dbo].[courses] ([courseid], [credits], [name], [type], [courseafid]) VALUES (N'C3', 2, N'Triết học Mac-Lenin', N'Bắt buộc', N'C16')
INSERT [dbo].[courses] ([courseid], [credits], [name], [type], [courseafid]) VALUES (N'C30', 2, N'Chủ nghĩa xã hội khoa học', N'Bắt buộc', NULL)
INSERT [dbo].[courses] ([courseid], [credits], [name], [type], [courseafid]) VALUES (N'C31', 3, N'Mô hình hóa dữ liệu NoSQL MonoDB', N'Bắt buộc', NULL)
INSERT [dbo].[courses] ([courseid], [credits], [name], [type], [courseafid]) VALUES (N'C32', 3, N'Công nghệ phần mềm', N'Bắt buộc', NULL)
INSERT [dbo].[courses] ([courseid], [credits], [name], [type], [courseafid]) VALUES (N'C33', 3, N'Tâm lý học đại cương', N'Tự chọn', NULL)
INSERT [dbo].[courses] ([courseid], [credits], [name], [type], [courseafid]) VALUES (N'C34', 3, N'Thống kê máy tính và ứng dụng', N'Bắt buộc', NULL)
INSERT [dbo].[courses] ([courseid], [credits], [name], [type], [courseafid]) VALUES (N'C35', 3, N'Khai thác dữ liệu và ứng dụng', N'Tự chọn', NULL)
INSERT [dbo].[courses] ([courseid], [credits], [name], [type], [courseafid]) VALUES (N'C36', 2, N'Pháp luật đại cương', N'Bắt buộc', NULL)
INSERT [dbo].[courses] ([courseid], [credits], [name], [type], [courseafid]) VALUES (N'C37', 4, N'Lập trình thiết bị di động', N'Bắt buộc ', NULL)
INSERT [dbo].[courses] ([courseid], [credits], [name], [type], [courseafid]) VALUES (N'C38', 4, N'Thể dục', N'Bắt buộc', NULL)
INSERT [dbo].[courses] ([courseid], [credits], [name], [type], [courseafid]) VALUES (N'C39', 2, N'Toán tin', N'Bắt buộc', NULL)
INSERT [dbo].[courses] ([courseid], [credits], [name], [type], [courseafid]) VALUES (N'C4', 3, N'Kỹ thuật lập trình', N'Bắt buộc', N'C18')
INSERT [dbo].[courses] ([courseid], [credits], [name], [type], [courseafid]) VALUES (N'C40', 3, N'Lập trình', N'Bắt buộc', NULL)
INSERT [dbo].[courses] ([courseid], [credits], [name], [type], [courseafid]) VALUES (N'C41', 3, N'Tư tưởng HCM', N'Bắt buộc', NULL)
INSERT [dbo].[courses] ([courseid], [credits], [name], [type], [courseafid]) VALUES (N'C42', 3, N'Lịch sử Đảng Cộng sản Việt Nam', N'Bắt buộc', NULL)
INSERT [dbo].[courses] ([courseid], [credits], [name], [type], [courseafid]) VALUES (N'C43', 3, N'Thống kê xã hội học', N'Bắt buộc', NULL)
INSERT [dbo].[courses] ([courseid], [credits], [name], [type], [courseafid]) VALUES (N'C44', 4, N'Lập trình phân tán', N'Bắt buộc', NULL)
INSERT [dbo].[courses] ([courseid], [credits], [name], [type], [courseafid]) VALUES (N'C5', 2, N'Kỹ năng làm việc nhóm', N'Bắt buộc', NULL)
INSERT [dbo].[courses] ([courseid], [credits], [name], [type], [courseafid]) VALUES (N'C6', 4, N'Toán cao cấp 1', N'Bắt buộc', N'C17')
INSERT [dbo].[courses] ([courseid], [credits], [name], [type], [courseafid]) VALUES (N'C7', 3, N'Quản lý dự án CNTT ', N'Tự chọn', NULL)
INSERT [dbo].[courses] ([courseid], [credits], [name], [type], [courseafid]) VALUES (N'C8', 3, N'Tiếp thị điện tử', N'Tự chọn', NULL)
INSERT [dbo].[courses] ([courseid], [credits], [name], [type], [courseafid]) VALUES (N'C9', 3, N'Lập trình hướng đối tượng', N'Bắt buộc', N'C24')
GO
INSERT [dbo].[departments] ([deptid], [address], [email], [phone], [date], [dept_name], [description], [deanid]) VALUES (N'1', N'HCM', N'fif@gmail.com', N'0914653334', CAST(N'2003-12-12' AS Date), N'Công Nghệ Thông Tin', N'không', N'12587469')
INSERT [dbo].[departments] ([deptid], [address], [email], [phone], [date], [dept_name], [description], [deanid]) VALUES (N'2', N'HCM', N'llct@gmail.com', N'0912345678', CAST(N'2001-12-12' AS Date), N'Lý Luận Chính Trị', N'không ', N'14598762')
INSERT [dbo].[departments] ([deptid], [address], [email], [phone], [date], [dept_name], [description], [deanid]) VALUES (N'3', N'HCM', N'tt@gmail.com', N'091452859', CAST(N'2000-04-04' AS Date), N'Hóa học', N'không ', N'14725898')
INSERT [dbo].[departments] ([deptid], [address], [email], [phone], [date], [dept_name], [description], [deanid]) VALUES (N'4', N'HCM ', N'mkt', N'034851095', CAST(N'2000-08-03' AS Date), N'Makerting', N'không', N'14785987')
GO
INSERT [dbo].[enrollment_practives] ([enrollmentpid], [name], [quantity], [room], [enrollmentid], [id]) VALUES (N'10011', N'Nhóm 1', 30, N'H5.1', N'1001', N'12347895')
INSERT [dbo].[enrollment_practives] ([enrollmentpid], [name], [quantity], [room], [enrollmentid], [id]) VALUES (N'10012', N'Nhóm 2', 30, N'H2.1', N'1001', N'12347895')
INSERT [dbo].[enrollment_practives] ([enrollmentpid], [name], [quantity], [room], [enrollmentid], [id]) VALUES (N'10041', N'Nhóm 1', 25, N'H5.2', N'1004', N'12347895')
INSERT [dbo].[enrollment_practives] ([enrollmentpid], [name], [quantity], [room], [enrollmentid], [id]) VALUES (N'10042', N'Nhóm 2', 25, N'H5.1', N'1004', N'12347895')
INSERT [dbo].[enrollment_practives] ([enrollmentpid], [name], [quantity], [room], [enrollmentid], [id]) VALUES (N'10061', N'nhom 1', 20, N'H8.02', N'1006', N'12587469')
INSERT [dbo].[enrollment_practives] ([enrollmentpid], [name], [quantity], [room], [enrollmentid], [id]) VALUES (N'40021', N'Nhóm 1', 25, N'H5.1', N'4002', N'12347895')
INSERT [dbo].[enrollment_practives] ([enrollmentpid], [name], [quantity], [room], [enrollmentid], [id]) VALUES (N'40022', N'Nhóm 2', 25, N'H5.2', N'4002', N'12345678')
INSERT [dbo].[enrollment_practives] ([enrollmentpid], [name], [quantity], [room], [enrollmentid], [id]) VALUES (N'40023', N'Nhóm 3', 25, N'H5.2', N'4002', N'12345678')
GO
INSERT [dbo].[enrollments] ([enrollmentid], [date_apply_end], [date_apply_start], [date_start], [name], [quantity], [room_name], [semester], [status], [year], [courseid], [scheduleid], [id]) VALUES (N'10001', CAST(N'2023-10-13' AS Date), CAST(N'2023-12-13' AS Date), CAST(N'2024-01-15' AS Date), N'DHKTPM19G', 50, N'X10.04', 2, N'ACTIVE', 2024, N'C10', 1, N'14725898')
INSERT [dbo].[enrollments] ([enrollmentid], [date_apply_end], [date_apply_start], [date_start], [name], [quantity], [room_name], [semester], [status], [year], [courseid], [scheduleid], [id]) VALUES (N'1001', CAST(N'2023-10-13' AS Date), CAST(N'2023-12-13' AS Date), CAST(N'2024-01-26' AS Date), N'DHKTPM17A', 80, N'H8.2', 2, N'ACTIVE', 2024, N'C1', 1, N'12345678')
INSERT [dbo].[enrollments] ([enrollmentid], [date_apply_end], [date_apply_start], [date_start], [name], [quantity], [room_name], [semester], [status], [year], [courseid], [scheduleid], [id]) VALUES (N'1002', CAST(N'2023-10-13' AS Date), CAST(N'2023-12-13' AS Date), CAST(N'2024-01-26' AS Date), N'DHKTPM17B', 80, N'H8.3', 2, N'ACTIVE', 2024, N'C1', 1, N'12345678')
INSERT [dbo].[enrollments] ([enrollmentid], [date_apply_end], [date_apply_start], [date_start], [name], [quantity], [room_name], [semester], [status], [year], [courseid], [scheduleid], [id]) VALUES (N'1003', CAST(N'2023-10-13' AS Date), CAST(N'2023-12-13' AS Date), CAST(N'2024-01-26' AS Date), N'DHCNTT18B', 80, N'H8.3', 2, N'ACTIVE', 2024, N'C1', 1, N'12345678')
INSERT [dbo].[enrollments] ([enrollmentid], [date_apply_end], [date_apply_start], [date_start], [name], [quantity], [room_name], [semester], [status], [year], [courseid], [scheduleid], [id]) VALUES (N'1004', CAST(N'2024-04-13' AS Date), CAST(N'2024-05-13' AS Date), CAST(N'2024-06-13' AS Date), N'DHKTPM19D', 80, N'X10.04', 3, N'ACTIVE', 2024, N'C1', 1, N'12345678')
INSERT [dbo].[enrollments] ([enrollmentid], [date_apply_end], [date_apply_start], [date_start], [name], [quantity], [room_name], [semester], [status], [year], [courseid], [scheduleid], [id]) VALUES (N'1006', CAST(N'2023-07-12' AS Date), CAST(N'2023-08-12' AS Date), CAST(N'2023-09-12' AS Date), N'DHKTPM19N', 40, N'X10.02', 1, N'ACTIVE', 2024, N'C1', 1, N'12345678')
INSERT [dbo].[enrollments] ([enrollmentid], [date_apply_end], [date_apply_start], [date_start], [name], [quantity], [room_name], [semester], [status], [year], [courseid], [scheduleid], [id]) VALUES (N'11001', CAST(N'2023-10-13' AS Date), CAST(N'2023-12-13' AS Date), CAST(N'2024-01-13' AS Date), N'DHKTPM19J', 80, N'X10.02', 2, N'ACTIVE', 2024, N'C11', 1, N'12345678')
INSERT [dbo].[enrollments] ([enrollmentid], [date_apply_end], [date_apply_start], [date_start], [name], [quantity], [room_name], [semester], [status], [year], [courseid], [scheduleid], [id]) VALUES (N'11002', CAST(N'2024-04-13' AS Date), CAST(N'2024-05-13' AS Date), CAST(N'2024-06-13' AS Date), N'DHKTPM19K', 80, N'X10.04', 3, N'ACTIVE', 2024, N'C11', 1, N'12347895')
INSERT [dbo].[enrollments] ([enrollmentid], [date_apply_end], [date_apply_start], [date_start], [name], [quantity], [room_name], [semester], [status], [year], [courseid], [scheduleid], [id]) VALUES (N'12001', CAST(N'2023-10-13' AS Date), CAST(N'2023-12-13' AS Date), CAST(N'2024-01-13' AS Date), N'DHKTPM19H', 80, N'V7.02', 2, N'ACTIVE', 2024, N'C12', 1, N'14785987')
INSERT [dbo].[enrollments] ([enrollmentid], [date_apply_end], [date_apply_start], [date_start], [name], [quantity], [room_name], [semester], [status], [year], [courseid], [scheduleid], [id]) VALUES (N'12002', CAST(N'2024-04-13' AS Date), CAST(N'2024-05-13' AS Date), CAST(N'2024-06-13' AS Date), N'DHKTPM19L', 80, N'V7.02', 3, N'ACTIVE', 2024, N'C12', 1, N'12345678')
INSERT [dbo].[enrollments] ([enrollmentid], [date_apply_end], [date_apply_start], [date_start], [name], [quantity], [room_name], [semester], [status], [year], [courseid], [scheduleid], [id]) VALUES (N'2001', CAST(N'2023-10-13' AS Date), CAST(N'2023-12-13' AS Date), CAST(N'2024-01-26' AS Date), N'DHKTPM17D', 80, N'H8.3', 2, N'ACTIVE', 2024, N'C2', 1, N'12345678')
INSERT [dbo].[enrollments] ([enrollmentid], [date_apply_end], [date_apply_start], [date_start], [name], [quantity], [room_name], [semester], [status], [year], [courseid], [scheduleid], [id]) VALUES (N'3001', CAST(N'2023-10-13' AS Date), CAST(N'2023-12-13' AS Date), CAST(N'2024-01-13' AS Date), N'DHCT19@', 80, N'V7.02', 2, N'ACTIVE', 2024, N'C3', 1, N'14785236')
INSERT [dbo].[enrollments] ([enrollmentid], [date_apply_end], [date_apply_start], [date_start], [name], [quantity], [room_name], [semester], [status], [year], [courseid], [scheduleid], [id]) VALUES (N'38001', CAST(N'2024-04-13' AS Date), CAST(N'2024-05-13' AS Date), CAST(N'2024-06-01' AS Date), N'DHCNTT19A', 80, N'Sân vận động', 3, N'ACTIVE', 2024, N'C38', 1, N'14785987')
INSERT [dbo].[enrollments] ([enrollmentid], [date_apply_end], [date_apply_start], [date_start], [name], [quantity], [room_name], [semester], [status], [year], [courseid], [scheduleid], [id]) VALUES (N'39001', CAST(N'2023-10-13' AS Date), CAST(N'2023-12-13' AS Date), CAST(N'2024-01-13' AS Date), N'DHKTPM19M', 80, N'X10.04', 2, N'ACTIVE', 2024, N'C39', 1, N'12587469')
INSERT [dbo].[enrollments] ([enrollmentid], [date_apply_end], [date_apply_start], [date_start], [name], [quantity], [room_name], [semester], [status], [year], [courseid], [scheduleid], [id]) VALUES (N'4001', CAST(N'2023-10-13' AS Date), CAST(N'2023-12-13' AS Date), CAST(N'2024-01-26' AS Date), N'DHKTPM17E', 80, N'H8.3', 2, N'ACTIVE', 2024, N'C4', 1, N'12345678')
INSERT [dbo].[enrollments] ([enrollmentid], [date_apply_end], [date_apply_start], [date_start], [name], [quantity], [room_name], [semester], [status], [year], [courseid], [scheduleid], [id]) VALUES (N'4002', CAST(N'2023-10-13' AS Date), CAST(N'2023-12-13' AS Date), CAST(N'2024-01-13' AS Date), N'DHKTPM19F', 80, N'X10.04', 2, N'ACTIVE', 2024, N'C4', 1, N'12345678')
INSERT [dbo].[enrollments] ([enrollmentid], [date_apply_end], [date_apply_start], [date_start], [name], [quantity], [room_name], [semester], [status], [year], [courseid], [scheduleid], [id]) VALUES (N'43001', CAST(N'2023-10-13' AS Date), CAST(N'2023-12-13' AS Date), CAST(N'2024-01-13' AS Date), N'DHCT19A', 80, N'V7.02', 2, N'ACTIVE', 2024, N'C43', 1, N'14785236')
INSERT [dbo].[enrollments] ([enrollmentid], [date_apply_end], [date_apply_start], [date_start], [name], [quantity], [room_name], [semester], [status], [year], [courseid], [scheduleid], [id]) VALUES (N'43002', CAST(N'2024-04-13' AS Date), CAST(N'2024-05-13' AS Date), CAST(N'2024-06-13' AS Date), N'DHCT19B', 80, N'X10.04', 3, N'ACTIVE', 2024, N'C43', 1, N'14785236')
INSERT [dbo].[enrollments] ([enrollmentid], [date_apply_end], [date_apply_start], [date_start], [name], [quantity], [room_name], [semester], [status], [year], [courseid], [scheduleid], [id]) VALUES (N'43003', CAST(N'2024-04-13' AS Date), CAST(N'2024-05-13' AS Date), CAST(N'2024-06-01' AS Date), N'DHCT19C', 80, N'V7.02', 3, N'ACTIVE', 2024, N'C43', 1, N'14785236')
INSERT [dbo].[enrollments] ([enrollmentid], [date_apply_end], [date_apply_start], [date_start], [name], [quantity], [room_name], [semester], [status], [year], [courseid], [scheduleid], [id]) VALUES (N'6001', CAST(N'2024-04-13' AS Date), CAST(N'2024-05-13' AS Date), CAST(N'2024-06-13' AS Date), N'DHKTPM19I', 80, N'X10.04', 3, N'INACTIVE', 2024, N'C6', 1, N'14725898')
GO
INSERT [dbo].[infor_students] ([scholarship], [id]) VALUES (N'không', N'20013345')
INSERT [dbo].[infor_students] ([scholarship], [id]) VALUES (N'không', N'21000945')
INSERT [dbo].[infor_students] ([scholarship], [id]) VALUES (N'không', N'21001145')
INSERT [dbo].[infor_students] ([scholarship], [id]) VALUES (N'không', N'21001245')
INSERT [dbo].[infor_students] ([scholarship], [id]) VALUES (N'không', N'21002345')
INSERT [dbo].[infor_students] ([scholarship], [id]) VALUES (N'không', N'21003345')
INSERT [dbo].[infor_students] ([scholarship], [id]) VALUES (N'không', N'21005345')
INSERT [dbo].[infor_students] ([scholarship], [id]) VALUES (N'không', N'21108651')
INSERT [dbo].[infor_students] ([scholarship], [id]) VALUES (N'không', N'21113731')
INSERT [dbo].[infor_students] ([scholarship], [id]) VALUES (N'không', N'21222345')
INSERT [dbo].[infor_students] ([scholarship], [id]) VALUES (N'không', N'22003245')
INSERT [dbo].[infor_students] ([scholarship], [id]) VALUES (N'không', N'22003345')
INSERT [dbo].[infor_students] ([scholarship], [id]) VALUES (N'không', N'22013245')
GO
INSERT [dbo].[instructors] ([gradute_degree], [salary], [id]) VALUES (N'Tiến sĩ', 11000000, N'12345678')
INSERT [dbo].[instructors] ([gradute_degree], [salary], [id]) VALUES (N'Thạc sĩ', 30000000, N'12347895')
INSERT [dbo].[instructors] ([gradute_degree], [salary], [id]) VALUES (N'Thạc sĩ', 27000000, N'12587469')
INSERT [dbo].[instructors] ([gradute_degree], [salary], [id]) VALUES (N'Thạc sĩ', 28000000, N'14598762')
INSERT [dbo].[instructors] ([gradute_degree], [salary], [id]) VALUES (N'Tiến sĩ', 10000000, N'14725898')
INSERT [dbo].[instructors] ([gradute_degree], [salary], [id]) VALUES (N'Tiến sĩ', 10000000, N'14785236')
INSERT [dbo].[instructors] ([gradute_degree], [salary], [id]) VALUES (N'Thạc sĩ', 30000000, N'14785987')
GO
INSERT [dbo].[majors] ([majorid], [description], [name], [deptid]) VALUES (N'CNTT', N'không ', N'Công nghệ thông tin', N'1')
INSERT [dbo].[majors] ([majorid], [description], [name], [deptid]) VALUES (N'CT', N'không ', N'Chính trị', N'2')
INSERT [dbo].[majors] ([majorid], [description], [name], [deptid]) VALUES (N'HH', N'không ', N'Hóa học', N'3')
INSERT [dbo].[majors] ([majorid], [description], [name], [deptid]) VALUES (N'HTTT', N'không', N'Hệ thống thông tin ', N'1')
INSERT [dbo].[majors] ([majorid], [description], [name], [deptid]) VALUES (N'KTPM', N'không', N'Kĩ thuật phần mềm ', N'1')
INSERT [dbo].[majors] ([majorid], [description], [name], [deptid]) VALUES (N'MKR', N'không ', N'Makerting', N'4')
GO
INSERT [dbo].[peoples] ([id], [age], [cccd], [address], [email], [phone], [img], [name], [nationality], [sex], [accountid], [majorid]) VALUES (N'12345678', 30, N'072145698753', N'Tây Ninh', N'abc@gmail.com', N'0914787548', N'/img/avatar.jpg', N'Vũ Hoàng', N'Việt Nam', 1, N'12345678', N'KTPM')
INSERT [dbo].[peoples] ([id], [age], [cccd], [address], [email], [phone], [img], [name], [nationality], [sex], [accountid], [majorid]) VALUES (N'12347895', 30, N'072145698753', N'Tây Ninh', N'abc@gmail.com', N'0914787548', N'/img/avatar.jpg', N'Lạc Thế Thịnh', N'Việt Nam', 1, N'12347895', N'KTPM')
INSERT [dbo].[peoples] ([id], [age], [cccd], [address], [email], [phone], [img], [name], [nationality], [sex], [accountid], [majorid]) VALUES (N'12587469', 31, N'072145698753', N'Tây Ninh', N'abc@gmail.com', N'0914787548', N'/img/avatar.jpg', N'Hoàng Sơn', N'Việt Nam', 1, N'12587469', N'KTPM')
INSERT [dbo].[peoples] ([id], [age], [cccd], [address], [email], [phone], [img], [name], [nationality], [sex], [accountid], [majorid]) VALUES (N'14204554', 50, N'072145698753', N'Tây Ninh', N'abc@gmail.com', N'0914787548', N'/img/avatar.jpg', N'Nguyễn Trọng Huy', N'Việt Nam', 1, N'14204554', N'MKR')
INSERT [dbo].[peoples] ([id], [age], [cccd], [address], [email], [phone], [img], [name], [nationality], [sex], [accountid], [majorid]) VALUES (N'14204914', 32, N'072145698753', N'Tây Ninh', N'abc@gmail.com', N'0914787548', N'/img/avatar.jpg', N'Nguyễn Văn A', N'Việt Nam', 1, N'14204914', N'HH')
INSERT [dbo].[peoples] ([id], [age], [cccd], [address], [email], [phone], [img], [name], [nationality], [sex], [accountid], [majorid]) VALUES (N'14598762', 23, N'072145698753', N'Tây Ninh', N'abc@gmail.com', N'0914787548', N'/img/avatar.jpg', N'Long Vinh', N'Việt Nam', 1, N'14598762', N'KTPM')
INSERT [dbo].[peoples] ([id], [age], [cccd], [address], [email], [phone], [img], [name], [nationality], [sex], [accountid], [majorid]) VALUES (N'14725898', 40, N'072145698753', N'Tây Ninh', N'abc@gmail.com', N'0914787548', N'/img/avatar.jpg', N'Hàn Vi', N'Việt Nam', 0, N'14725898', N'KTPM')
INSERT [dbo].[peoples] ([id], [age], [cccd], [address], [email], [phone], [img], [name], [nationality], [sex], [accountid], [majorid]) VALUES (N'14785236', 35, N'072145698753', N'Tây Ninh', N'abc@gmail.com', N'0914787548', N'/img/avatar.jpg', N'Lê Tố Nga', N'Việt Nam', 0, N'14785236', N'CT')
INSERT [dbo].[peoples] ([id], [age], [cccd], [address], [email], [phone], [img], [name], [nationality], [sex], [accountid], [majorid]) VALUES (N'14785987', 32, N'072145698753', N'Tây Ninh', N'abc@gmail.com', N'0914787548', N'/img/avatar.jpg', N'Lâm Vĩnh An', N'Việt Nam', 1, N'14785987', N'KTPM')
INSERT [dbo].[peoples] ([id], [age], [cccd], [address], [email], [phone], [img], [name], [nationality], [sex], [accountid], [majorid]) VALUES (N'20013345', 22, N'072147159123', N'Nghệ An', N'min@gmail.com', N'0914785264', N'/img/avatar.jpg', N'Trần Minh', N'Việt Nam', 1, N'20013345', N'KTPM')
INSERT [dbo].[peoples] ([id], [age], [cccd], [address], [email], [phone], [img], [name], [nationality], [sex], [accountid], [majorid]) VALUES (N'21000945', 21, N'073147854987', N'Ninh Bình', N'dun@gmail.com', N'0914787547', N'/img/avatar.jpg', N'Nguyễn Ngọc Dung', N'Việt Nam', 0, N'21000945', N'KTPM')
INSERT [dbo].[peoples] ([id], [age], [cccd], [address], [email], [phone], [img], [name], [nationality], [sex], [accountid], [majorid]) VALUES (N'21001145', 21, N'072145698753', N'Bến Tre', N'an@gmail.com', N'0931478456', N'/img/avatar.jpg', N'Lương Vĩnh An', N'Việt Nam', 0, N'21001145', N'KTPM')
INSERT [dbo].[peoples] ([id], [age], [cccd], [address], [email], [phone], [img], [name], [nationality], [sex], [accountid], [majorid]) VALUES (N'21001245', 21, N'072147159123', N'Bình Dương', N'hin@gmail.com', N'0914785265', N'/img/avatar.jpg', N'Hạ Hinh ', N'Việt Nam', 0, N'21001245', N'KTPM')
INSERT [dbo].[peoples] ([id], [age], [cccd], [address], [email], [phone], [img], [name], [nationality], [sex], [accountid], [majorid]) VALUES (N'21002345', 21, N'072145698753', N'An Giang', N'an@gmail.com', N'0931478456', N'/img/avatar.jpg', N'Bùi Thế Anh', N'Việt Nam', 1, N'21002345', N'KTPM')
INSERT [dbo].[peoples] ([id], [age], [cccd], [address], [email], [phone], [img], [name], [nationality], [sex], [accountid], [majorid]) VALUES (N'21003345', 21, N'072147159123', N'Hòa Bình', N'bin@gmail.com', N'0914785269', N'/img/avatar.jpg', N'Lâm Bình', N'Việt Nam', 1, N'21003345', N'KTPM')
INSERT [dbo].[peoples] ([id], [age], [cccd], [address], [email], [phone], [img], [name], [nationality], [sex], [accountid], [majorid]) VALUES (N'21005345', 21, N'072147159123', N'Cà Mau', N'an@gmail.com', N'0914785263', N'/img/avatar.jpg', N'Dương Thái Hòa', N'Việt Nam', 1, N'21005345', N'KTPM')
INSERT [dbo].[peoples] ([id], [age], [cccd], [address], [email], [phone], [img], [name], [nationality], [sex], [accountid], [majorid]) VALUES (N'21108651', 21, N'072159874563', N'Tây Ninh', N'kieu@gmail.com', N'0798547896', N'/img/avatar.jpg', N'Lê Thị Thúy Kiều', N'Việt Nam', 0, N'21108651', N'KTPM')
INSERT [dbo].[peoples] ([id], [age], [cccd], [address], [email], [phone], [img], [name], [nationality], [sex], [accountid], [majorid]) VALUES (N'21113731', 21, N'073147895478', N'Khánh Hòa', N'dat@gmail.com', N'0784154789', N'/img/avatar.jpg', N'Nguyễn Trọng Đạt', N'Việt Nam', 1, N'21113731', N'KTPM')
INSERT [dbo].[peoples] ([id], [age], [cccd], [address], [email], [phone], [img], [name], [nationality], [sex], [accountid], [majorid]) VALUES (N'21222345', 21, N'073547896547', N'Kiên Giang', N'li@gmail.com', N'0379548567', N'/img/avatar.jpg', N'Tạ Liên', N'Việt Nam', 0, N'21222345', N'KTPM')
INSERT [dbo].[peoples] ([id], [age], [cccd], [address], [email], [phone], [img], [name], [nationality], [sex], [accountid], [majorid]) VALUES (N'22003245', 20, N'072147159123', N'Đồng Nai', N'ti@gmail.com', N'0379548562', N'/img/avatar.jpg', N'Hoa Thành', N'Việt Nam', 1, N'22003245', N'KTPM')
INSERT [dbo].[peoples] ([id], [age], [cccd], [address], [email], [phone], [img], [name], [nationality], [sex], [accountid], [majorid]) VALUES (N'22003345', 20, N'073547896547', N'Tây Ninh', N'tin@gmail.com', N'0931478454', N'/img/avatar.jpg', N'Hà Phúc Thịnh', N'Việt Nam', 1, N'22003345', N'KTPM')
INSERT [dbo].[peoples] ([id], [age], [cccd], [address], [email], [phone], [img], [name], [nationality], [sex], [accountid], [majorid]) VALUES (N'22013245', 20, N'073547896547', N'Tây Ninh', N'ant@gmail.com', N'0379548563', N'/img/avatar.jpg', N'Dương Thành Tấn', N'Việt Nam', 1, N'22013245', N'KTPM')
GO
INSERT [dbo].[practice_scores] ([resultid], [practice_score]) VALUES (N'20013345-10001', 6)
INSERT [dbo].[practice_scores] ([resultid], [practice_score]) VALUES (N'21108651-1006', 6)
GO
INSERT [dbo].[regular_score] ([resultid], [regular_score]) VALUES (N'21108651-1006', 6)
GO
INSERT [dbo].[results] ([resultid], [final_score], [midterm_score], [overall_score]) VALUES (N'1-1001', 0, 0, 0)
INSERT [dbo].[results] ([resultid], [final_score], [midterm_score], [overall_score]) VALUES (N'1-4002', 0, 0, 0)
INSERT [dbo].[results] ([resultid], [final_score], [midterm_score], [overall_score]) VALUES (N'20013345-10001', 6, 6, 6)
INSERT [dbo].[results] ([resultid], [final_score], [midterm_score], [overall_score]) VALUES (N'20013345-11001', 0, 0, 0)
INSERT [dbo].[results] ([resultid], [final_score], [midterm_score], [overall_score]) VALUES (N'20013345-12001', 0, 0, 0)
INSERT [dbo].[results] ([resultid], [final_score], [midterm_score], [overall_score]) VALUES (N'20013345-3001', 0, 0, 0)
INSERT [dbo].[results] ([resultid], [final_score], [midterm_score], [overall_score]) VALUES (N'20013345-39001', 0, 0, 0)
INSERT [dbo].[results] ([resultid], [final_score], [midterm_score], [overall_score]) VALUES (N'21108651-1001', 0, 0, 0)
INSERT [dbo].[results] ([resultid], [final_score], [midterm_score], [overall_score]) VALUES (N'21108651-1006', 6, 6, 6)
INSERT [dbo].[results] ([resultid], [final_score], [midterm_score], [overall_score]) VALUES (N'21108651-12001', 0, 0, 0)
INSERT [dbo].[results] ([resultid], [final_score], [midterm_score], [overall_score]) VALUES (N'21108651-12002', 0, 0, 0)
INSERT [dbo].[results] ([resultid], [final_score], [midterm_score], [overall_score]) VALUES (N'21108651-2001', 0, 0, 0)
INSERT [dbo].[results] ([resultid], [final_score], [midterm_score], [overall_score]) VALUES (N'21108651-39001', 0, 0, 0)
INSERT [dbo].[results] ([resultid], [final_score], [midterm_score], [overall_score]) VALUES (N'21108651-4002', 0, 0, 0)
INSERT [dbo].[results] ([resultid], [final_score], [midterm_score], [overall_score]) VALUES (N'21108651-6001', 0, 0, 0)
GO
SET IDENTITY_INSERT [dbo].[schedules] ON 

INSERT [dbo].[schedules] ([scheduleid], [classes_end], [classes_start], [day_of_week], [enrollmentid], [enrollmentpid]) VALUES (1, 0, 0, N'0', NULL, NULL)
INSERT [dbo].[schedules] ([scheduleid], [classes_end], [classes_start], [day_of_week], [enrollmentid], [enrollmentpid]) VALUES (3, 3, 1, N'2', N'1003', NULL)
INSERT [dbo].[schedules] ([scheduleid], [classes_end], [classes_start], [day_of_week], [enrollmentid], [enrollmentpid]) VALUES (4, 6, 4, N'2', NULL, N'10011')
INSERT [dbo].[schedules] ([scheduleid], [classes_end], [classes_start], [day_of_week], [enrollmentid], [enrollmentpid]) VALUES (5, 3, 1, N'4', N'1001', NULL)
INSERT [dbo].[schedules] ([scheduleid], [classes_end], [classes_start], [day_of_week], [enrollmentid], [enrollmentpid]) VALUES (6, 3, 1, N'7', NULL, N'10012')
INSERT [dbo].[schedules] ([scheduleid], [classes_end], [classes_start], [day_of_week], [enrollmentid], [enrollmentpid]) VALUES (7, 3, 1, N'6', N'1002', NULL)
INSERT [dbo].[schedules] ([scheduleid], [classes_end], [classes_start], [day_of_week], [enrollmentid], [enrollmentpid]) VALUES (8, 12, 10, N'2', NULL, N'10041')
INSERT [dbo].[schedules] ([scheduleid], [classes_end], [classes_start], [day_of_week], [enrollmentid], [enrollmentpid]) VALUES (9, 12, 10, N'2', NULL, N'10042')
INSERT [dbo].[schedules] ([scheduleid], [classes_end], [classes_start], [day_of_week], [enrollmentid], [enrollmentpid]) VALUES (10, 3, 1, N'3', N'1004', NULL)
INSERT [dbo].[schedules] ([scheduleid], [classes_end], [classes_start], [day_of_week], [enrollmentid], [enrollmentpid]) VALUES (14, 12, 10, N'2', NULL, N'40021')
INSERT [dbo].[schedules] ([scheduleid], [classes_end], [classes_start], [day_of_week], [enrollmentid], [enrollmentpid]) VALUES (15, 12, 10, N'2', NULL, N'40022')
INSERT [dbo].[schedules] ([scheduleid], [classes_end], [classes_start], [day_of_week], [enrollmentid], [enrollmentpid]) VALUES (16, 12, 10, N'3', NULL, N'40023')
INSERT [dbo].[schedules] ([scheduleid], [classes_end], [classes_start], [day_of_week], [enrollmentid], [enrollmentpid]) VALUES (17, 3, 1, N'2', N'4002', NULL)
INSERT [dbo].[schedules] ([scheduleid], [classes_end], [classes_start], [day_of_week], [enrollmentid], [enrollmentpid]) VALUES (18, 9, 7, N'3', N'10001', NULL)
INSERT [dbo].[schedules] ([scheduleid], [classes_end], [classes_start], [day_of_week], [enrollmentid], [enrollmentpid]) VALUES (19, 9, 7, N'7', N'12001', NULL)
INSERT [dbo].[schedules] ([scheduleid], [classes_end], [classes_start], [day_of_week], [enrollmentid], [enrollmentpid]) VALUES (20, 3, 1, N'8', N'38001', NULL)
INSERT [dbo].[schedules] ([scheduleid], [classes_end], [classes_start], [day_of_week], [enrollmentid], [enrollmentpid]) VALUES (21, 12, 10, N'7', N'3001', NULL)
INSERT [dbo].[schedules] ([scheduleid], [classes_end], [classes_start], [day_of_week], [enrollmentid], [enrollmentpid]) VALUES (22, 3, 1, N'7', N'43001', NULL)
INSERT [dbo].[schedules] ([scheduleid], [classes_end], [classes_start], [day_of_week], [enrollmentid], [enrollmentpid]) VALUES (23, 6, 4, N'6', N'43002', NULL)
INSERT [dbo].[schedules] ([scheduleid], [classes_end], [classes_start], [day_of_week], [enrollmentid], [enrollmentpid]) VALUES (24, 9, 7, N'2', N'43003', NULL)
INSERT [dbo].[schedules] ([scheduleid], [classes_end], [classes_start], [day_of_week], [enrollmentid], [enrollmentpid]) VALUES (25, 15, 13, N'7', N'6001', NULL)
INSERT [dbo].[schedules] ([scheduleid], [classes_end], [classes_start], [day_of_week], [enrollmentid], [enrollmentpid]) VALUES (26, 3, 1, N'4', N'11001', NULL)
INSERT [dbo].[schedules] ([scheduleid], [classes_end], [classes_start], [day_of_week], [enrollmentid], [enrollmentpid]) VALUES (27, 12, 10, N'7', N'11002', NULL)
INSERT [dbo].[schedules] ([scheduleid], [classes_end], [classes_start], [day_of_week], [enrollmentid], [enrollmentpid]) VALUES (28, 3, 1, N'7', N'12002', NULL)
INSERT [dbo].[schedules] ([scheduleid], [classes_end], [classes_start], [day_of_week], [enrollmentid], [enrollmentpid]) VALUES (29, 6, 4, N'4', N'39001', NULL)
INSERT [dbo].[schedules] ([scheduleid], [classes_end], [classes_start], [day_of_week], [enrollmentid], [enrollmentpid]) VALUES (30, 3, 1, N'3', NULL, N'10061')
INSERT [dbo].[schedules] ([scheduleid], [classes_end], [classes_start], [day_of_week], [enrollmentid], [enrollmentpid]) VALUES (31, 3, 1, N'2', N'1006', NULL)
INSERT [dbo].[schedules] ([scheduleid], [classes_end], [classes_start], [day_of_week], [enrollmentid], [enrollmentpid]) VALUES (32, 9, 7, N'3', N'2001', NULL)
SET IDENTITY_INSERT [dbo].[schedules] OFF
GO
INSERT [dbo].[student_enrollment] ([code_practive], [date_apply], [note_student_enrollment], [payment_status], [process_study], [study_status], [enrollmentid], [studentid], [resultid]) VALUES (N'', CAST(N'2024-04-25' AS Date), N'khong', N'hoàn thành', 0, N'đã thi', N'10001', N'20013345', N'20013345-10001')
INSERT [dbo].[student_enrollment] ([code_practive], [date_apply], [note_student_enrollment], [payment_status], [process_study], [study_status], [enrollmentid], [studentid], [resultid]) VALUES (N'10061', CAST(N'2024-04-26' AS Date), N'khong', N'chưa hoàn thành', 0, N'đã thi', N'1006', N'21108651', N'21108651-1006')
INSERT [dbo].[student_enrollment] ([code_practive], [date_apply], [note_student_enrollment], [payment_status], [process_study], [study_status], [enrollmentid], [studentid], [resultid]) VALUES (N'', CAST(N'2024-04-25' AS Date), N'khong', N'hoàn thành', 0, N'được phép thi', N'12001', N'20013345', N'20013345-12001')
INSERT [dbo].[student_enrollment] ([code_practive], [date_apply], [note_student_enrollment], [payment_status], [process_study], [study_status], [enrollmentid], [studentid], [resultid]) VALUES (N'', CAST(N'2024-04-25' AS Date), N'khong', N'hoàn thành', 0, N'được phép thi', N'12001', N'21108651', N'21108651-12001')
INSERT [dbo].[student_enrollment] ([code_practive], [date_apply], [note_student_enrollment], [payment_status], [process_study], [study_status], [enrollmentid], [studentid], [resultid]) VALUES (N'', CAST(N'2024-04-25' AS Date), N'khong', N'chưa hoàn thành', 0, N'không được phép thi', N'12002', N'21108651', N'21108651-12002')
INSERT [dbo].[student_enrollment] ([code_practive], [date_apply], [note_student_enrollment], [payment_status], [process_study], [study_status], [enrollmentid], [studentid], [resultid]) VALUES (N'40022', CAST(N'2024-04-26' AS Date), N'khong', N'hoàn thành', 0, N'được phép thi', N'2001', N'21108651', N'21108651-2001')
INSERT [dbo].[student_enrollment] ([code_practive], [date_apply], [note_student_enrollment], [payment_status], [process_study], [study_status], [enrollmentid], [studentid], [resultid]) VALUES (N'', CAST(N'2024-04-25' AS Date), N'khong', N'hoàn thành', 0, N'được phép thi', N'3001', N'20013345', N'20013345-3001')
INSERT [dbo].[student_enrollment] ([code_practive], [date_apply], [note_student_enrollment], [payment_status], [process_study], [study_status], [enrollmentid], [studentid], [resultid]) VALUES (N'', CAST(N'2024-04-25' AS Date), N'khong', N'hoàn thành', 0, N'được phép thi', N'39001', N'20013345', N'20013345-39001')
INSERT [dbo].[student_enrollment] ([code_practive], [date_apply], [note_student_enrollment], [payment_status], [process_study], [study_status], [enrollmentid], [studentid], [resultid]) VALUES (N'', CAST(N'2024-04-26' AS Date), N'khong', N'hoàn thành', 0, N'được phép thi', N'39001', N'21108651', N'21108651-39001')
INSERT [dbo].[student_enrollment] ([code_practive], [date_apply], [note_student_enrollment], [payment_status], [process_study], [study_status], [enrollmentid], [studentid], [resultid]) VALUES (N'40023', CAST(N'2024-04-26' AS Date), N'khong', N'hoàn thành', 0, N'được phép thi', N'4002', N'21108651', N'21108651-4002')
INSERT [dbo].[student_enrollment] ([code_practive], [date_apply], [note_student_enrollment], [payment_status], [process_study], [study_status], [enrollmentid], [studentid], [resultid]) VALUES (N'', CAST(N'2024-04-24' AS Date), N'khong', N'chưa hoàn thành', 0, N'không được phép thi', N'6001', N'21108651', N'21108651-6001')
GO
INSERT [dbo].[students] ([academic_year], [status], [id], [clazzid]) VALUES (2020, 1, N'20013345', N'1')
INSERT [dbo].[students] ([academic_year], [status], [id], [clazzid]) VALUES (2021, 1, N'21000945', N'1')
INSERT [dbo].[students] ([academic_year], [status], [id], [clazzid]) VALUES (2021, 1, N'21001145', N'1')
INSERT [dbo].[students] ([academic_year], [status], [id], [clazzid]) VALUES (2021, 1, N'21001245', N'1')
INSERT [dbo].[students] ([academic_year], [status], [id], [clazzid]) VALUES (2021, 1, N'21002345', N'1')
INSERT [dbo].[students] ([academic_year], [status], [id], [clazzid]) VALUES (2021, 1, N'21003345', N'1')
INSERT [dbo].[students] ([academic_year], [status], [id], [clazzid]) VALUES (2021, 1, N'21005345', N'1')
INSERT [dbo].[students] ([academic_year], [status], [id], [clazzid]) VALUES (2021, 1, N'21108651', N'1')
INSERT [dbo].[students] ([academic_year], [status], [id], [clazzid]) VALUES (2021, 1, N'21113731', N'1')
INSERT [dbo].[students] ([academic_year], [status], [id], [clazzid]) VALUES (2021, 1, N'21222345', N'1')
INSERT [dbo].[students] ([academic_year], [status], [id], [clazzid]) VALUES (2022, 1, N'22003245', N'1')
INSERT [dbo].[students] ([academic_year], [status], [id], [clazzid]) VALUES (2022, 1, N'22003345', N'1')
INSERT [dbo].[students] ([academic_year], [status], [id], [clazzid]) VALUES (2022, 1, N'22013245', N'1')
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UK_3hqr0o83xm1933jx4rt931w32]    Script Date: 5/26/2024 10:14:11 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [UK_3hqr0o83xm1933jx4rt931w32] ON [dbo].[classes]
(
	[id] ASC
)
WHERE ([id] IS NOT NULL)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UK_9djenb21jjdqqobcegwjyecu0]    Script Date: 5/26/2024 10:14:11 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [UK_9djenb21jjdqqobcegwjyecu0] ON [dbo].[departments]
(
	[deanid] ASC
)
WHERE ([deanid] IS NOT NULL)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UK_976du5wqre0kot95s1hm2vsr1]    Script Date: 5/26/2024 10:14:11 PM ******/
ALTER TABLE [dbo].[peoples] ADD  CONSTRAINT [UK_976du5wqre0kot95s1hm2vsr1] UNIQUE NONCLUSTERED 
(
	[accountid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UK_kwg0d7o977hwk11jcgti43ogr]    Script Date: 5/26/2024 10:14:11 PM ******/
ALTER TABLE [dbo].[student_enrollment] ADD  CONSTRAINT [UK_kwg0d7o977hwk11jcgti43ogr] UNIQUE NONCLUSTERED 
(
	[resultid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[account_admins]  WITH CHECK ADD  CONSTRAINT [FKphtjsrwnfy4q1rj8ndylhn6va] FOREIGN KEY([username])
REFERENCES [dbo].[accounts] ([username])
GO
ALTER TABLE [dbo].[account_admins] CHECK CONSTRAINT [FKphtjsrwnfy4q1rj8ndylhn6va]
GO
ALTER TABLE [dbo].[account_normals]  WITH CHECK ADD  CONSTRAINT [FKig9vyibo8oidhg0802xvvstdf] FOREIGN KEY([username])
REFERENCES [dbo].[accounts] ([username])
GO
ALTER TABLE [dbo].[account_normals] CHECK CONSTRAINT [FKig9vyibo8oidhg0802xvvstdf]
GO
ALTER TABLE [dbo].[classes]  WITH CHECK ADD  CONSTRAINT [FKfwudva3bmmkmr92408hcmaqkv] FOREIGN KEY([id])
REFERENCES [dbo].[instructors] ([id])
GO
ALTER TABLE [dbo].[classes] CHECK CONSTRAINT [FKfwudva3bmmkmr92408hcmaqkv]
GO
ALTER TABLE [dbo].[classes]  WITH CHECK ADD  CONSTRAINT [FKnbc6d8f52u3ns76fvspl6oe0i] FOREIGN KEY([majorid])
REFERENCES [dbo].[majors] ([majorid])
GO
ALTER TABLE [dbo].[classes] CHECK CONSTRAINT [FKnbc6d8f52u3ns76fvspl6oe0i]
GO
ALTER TABLE [dbo].[course_major]  WITH CHECK ADD  CONSTRAINT [FKkg9260ue9nptffnds0mlnumcx] FOREIGN KEY([courseid])
REFERENCES [dbo].[courses] ([courseid])
GO
ALTER TABLE [dbo].[course_major] CHECK CONSTRAINT [FKkg9260ue9nptffnds0mlnumcx]
GO
ALTER TABLE [dbo].[course_major]  WITH CHECK ADD  CONSTRAINT [FKn4ig7yqeu50l19atpnuon4b9u] FOREIGN KEY([majorid])
REFERENCES [dbo].[majors] ([majorid])
GO
ALTER TABLE [dbo].[course_major] CHECK CONSTRAINT [FKn4ig7yqeu50l19atpnuon4b9u]
GO
ALTER TABLE [dbo].[courses]  WITH CHECK ADD  CONSTRAINT [FK604gfuekqq4tmxkg3aqfwog1o] FOREIGN KEY([courseafid])
REFERENCES [dbo].[courses] ([courseid])
GO
ALTER TABLE [dbo].[courses] CHECK CONSTRAINT [FK604gfuekqq4tmxkg3aqfwog1o]
GO
ALTER TABLE [dbo].[courses]  WITH CHECK ADD  CONSTRAINT [FK7314ryeerf41xfb4iqw85ojas] FOREIGN KEY([courseid])
REFERENCES [dbo].[courses] ([courseid])
GO
ALTER TABLE [dbo].[courses] CHECK CONSTRAINT [FK7314ryeerf41xfb4iqw85ojas]
GO
ALTER TABLE [dbo].[departments]  WITH CHECK ADD  CONSTRAINT [FK3hn0dcniioalgc63o3ywco5dc] FOREIGN KEY([deanid])
REFERENCES [dbo].[instructors] ([id])
GO
ALTER TABLE [dbo].[departments] CHECK CONSTRAINT [FK3hn0dcniioalgc63o3ywco5dc]
GO
ALTER TABLE [dbo].[enrollment_practives]  WITH CHECK ADD  CONSTRAINT [FKff1mbjtqehvxvhgeau0wqpy5u] FOREIGN KEY([enrollmentid])
REFERENCES [dbo].[enrollments] ([enrollmentid])
GO
ALTER TABLE [dbo].[enrollment_practives] CHECK CONSTRAINT [FKff1mbjtqehvxvhgeau0wqpy5u]
GO
ALTER TABLE [dbo].[enrollment_practives]  WITH CHECK ADD  CONSTRAINT [FKfpw5rnu0oa8h38yul6rt51qtb] FOREIGN KEY([id])
REFERENCES [dbo].[instructors] ([id])
GO
ALTER TABLE [dbo].[enrollment_practives] CHECK CONSTRAINT [FKfpw5rnu0oa8h38yul6rt51qtb]
GO
ALTER TABLE [dbo].[enrollments]  WITH CHECK ADD  CONSTRAINT [FKciej7drnalc3bnbpw7mw7w1og] FOREIGN KEY([courseid])
REFERENCES [dbo].[courses] ([courseid])
GO
ALTER TABLE [dbo].[enrollments] CHECK CONSTRAINT [FKciej7drnalc3bnbpw7mw7w1og]
GO
ALTER TABLE [dbo].[enrollments]  WITH CHECK ADD  CONSTRAINT [FKq0rhspje0l6maaebmggempy1v] FOREIGN KEY([id])
REFERENCES [dbo].[instructors] ([id])
GO
ALTER TABLE [dbo].[enrollments] CHECK CONSTRAINT [FKq0rhspje0l6maaebmggempy1v]
GO
ALTER TABLE [dbo].[enrollments]  WITH CHECK ADD  CONSTRAINT [FKsubklb5agvoxux5q4prblr0hl] FOREIGN KEY([scheduleid])
REFERENCES [dbo].[schedules] ([scheduleid])
GO
ALTER TABLE [dbo].[enrollments] CHECK CONSTRAINT [FKsubklb5agvoxux5q4prblr0hl]
GO
ALTER TABLE [dbo].[infor_students]  WITH CHECK ADD  CONSTRAINT [FKfkcbk9lyts4n5f3j0vh5pins7] FOREIGN KEY([id])
REFERENCES [dbo].[students] ([id])
GO
ALTER TABLE [dbo].[infor_students] CHECK CONSTRAINT [FKfkcbk9lyts4n5f3j0vh5pins7]
GO
ALTER TABLE [dbo].[infor_students]  WITH CHECK ADD  CONSTRAINT [FKrycyao9k3it0qaqjgwjdsryr8] FOREIGN KEY([id])
REFERENCES [dbo].[peoples] ([id])
GO
ALTER TABLE [dbo].[infor_students] CHECK CONSTRAINT [FKrycyao9k3it0qaqjgwjdsryr8]
GO
ALTER TABLE [dbo].[instructors]  WITH CHECK ADD  CONSTRAINT [FKccf7d1pjhdv7beex92hivsmf3] FOREIGN KEY([id])
REFERENCES [dbo].[peoples] ([id])
GO
ALTER TABLE [dbo].[instructors] CHECK CONSTRAINT [FKccf7d1pjhdv7beex92hivsmf3]
GO
ALTER TABLE [dbo].[majors]  WITH CHECK ADD  CONSTRAINT [FK2m705ejfj53in3o37smnaxknd] FOREIGN KEY([deptid])
REFERENCES [dbo].[departments] ([deptid])
GO
ALTER TABLE [dbo].[majors] CHECK CONSTRAINT [FK2m705ejfj53in3o37smnaxknd]
GO
ALTER TABLE [dbo].[peoples]  WITH CHECK ADD  CONSTRAINT [FK9dqmd8wpvi1uu4sdxong7lbsj] FOREIGN KEY([accountid])
REFERENCES [dbo].[account_normals] ([username])
GO
ALTER TABLE [dbo].[peoples] CHECK CONSTRAINT [FK9dqmd8wpvi1uu4sdxong7lbsj]
GO
ALTER TABLE [dbo].[peoples]  WITH CHECK ADD  CONSTRAINT [FKm3yhrg4w29t4k21x3cwoaui0b] FOREIGN KEY([majorid])
REFERENCES [dbo].[majors] ([majorid])
GO
ALTER TABLE [dbo].[peoples] CHECK CONSTRAINT [FKm3yhrg4w29t4k21x3cwoaui0b]
GO
ALTER TABLE [dbo].[practice_scores]  WITH CHECK ADD  CONSTRAINT [FKc1mcp6c5j4r72xthvud5r1iny] FOREIGN KEY([resultid])
REFERENCES [dbo].[results] ([resultid])
GO
ALTER TABLE [dbo].[practice_scores] CHECK CONSTRAINT [FKc1mcp6c5j4r72xthvud5r1iny]
GO
ALTER TABLE [dbo].[regular_score]  WITH CHECK ADD  CONSTRAINT [FK2gbi6a36hicesk8n4fux7nc06] FOREIGN KEY([resultid])
REFERENCES [dbo].[results] ([resultid])
GO
ALTER TABLE [dbo].[regular_score] CHECK CONSTRAINT [FK2gbi6a36hicesk8n4fux7nc06]
GO
ALTER TABLE [dbo].[schedules]  WITH CHECK ADD  CONSTRAINT [FK6lqxie5ivqyf2yh8rqq1av68c] FOREIGN KEY([enrollmentid])
REFERENCES [dbo].[enrollments] ([enrollmentid])
GO
ALTER TABLE [dbo].[schedules] CHECK CONSTRAINT [FK6lqxie5ivqyf2yh8rqq1av68c]
GO
ALTER TABLE [dbo].[schedules]  WITH CHECK ADD  CONSTRAINT [FKs5belmggteafqrwrecurj01i] FOREIGN KEY([enrollmentpid])
REFERENCES [dbo].[enrollment_practives] ([enrollmentpid])
GO
ALTER TABLE [dbo].[schedules] CHECK CONSTRAINT [FKs5belmggteafqrwrecurj01i]
GO
ALTER TABLE [dbo].[student_enrollment]  WITH CHECK ADD  CONSTRAINT [FKfw9sefguppiqrrntfcuay7fik] FOREIGN KEY([studentid])
REFERENCES [dbo].[infor_students] ([id])
GO
ALTER TABLE [dbo].[student_enrollment] CHECK CONSTRAINT [FKfw9sefguppiqrrntfcuay7fik]
GO
ALTER TABLE [dbo].[student_enrollment]  WITH CHECK ADD  CONSTRAINT [FKt9bictwisg30k0mllpoish8jg] FOREIGN KEY([resultid])
REFERENCES [dbo].[results] ([resultid])
GO
ALTER TABLE [dbo].[student_enrollment] CHECK CONSTRAINT [FKt9bictwisg30k0mllpoish8jg]
GO
ALTER TABLE [dbo].[student_enrollment]  WITH CHECK ADD  CONSTRAINT [FKtn3ogj6h266nmgcvmwdee7k3d] FOREIGN KEY([enrollmentid])
REFERENCES [dbo].[enrollments] ([enrollmentid])
GO
ALTER TABLE [dbo].[student_enrollment] CHECK CONSTRAINT [FKtn3ogj6h266nmgcvmwdee7k3d]
GO
ALTER TABLE [dbo].[students]  WITH CHECK ADD  CONSTRAINT [FKhrbikbwv4idtgobr8f6vjj97d] FOREIGN KEY([id])
REFERENCES [dbo].[peoples] ([id])
GO
ALTER TABLE [dbo].[students] CHECK CONSTRAINT [FKhrbikbwv4idtgobr8f6vjj97d]
GO
ALTER TABLE [dbo].[students]  WITH CHECK ADD  CONSTRAINT [FKjr7e11whw9ol74nucoeqmp2ur] FOREIGN KEY([clazzid])
REFERENCES [dbo].[classes] ([clazzid])
GO
ALTER TABLE [dbo].[students] CHECK CONSTRAINT [FKjr7e11whw9ol74nucoeqmp2ur]
GO
ALTER TABLE [dbo].[enrollments]  WITH CHECK ADD  CONSTRAINT [CK__enrollmen__statu__45F365D3] CHECK  (([status]='FINISHED' OR [status]='INACTIVE' OR [status]='ACTIVE'))
GO
ALTER TABLE [dbo].[enrollments] CHECK CONSTRAINT [CK__enrollmen__statu__45F365D3]
GO
USE [master]
GO
ALTER DATABASE [KTMT] SET  READ_WRITE 
GO
