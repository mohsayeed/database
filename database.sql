USE [master]
GO
/****** Object:  Database [milan]    Script Date: 28-02-2022 00:40:11 ******/
CREATE DATABASE [milan]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'milan', FILENAME = N'D:\Downloads by Internet\SQL SERVER\MSSQL15.MSSQLSERVER\MSSQL\DATA\milan.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'milan_log', FILENAME = N'D:\Downloads by Internet\SQL SERVER\MSSQL15.MSSQLSERVER\MSSQL\DATA\milan_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [milan] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [milan].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [milan] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [milan] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [milan] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [milan] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [milan] SET ARITHABORT OFF 
GO
ALTER DATABASE [milan] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [milan] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [milan] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [milan] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [milan] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [milan] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [milan] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [milan] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [milan] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [milan] SET  DISABLE_BROKER 
GO
ALTER DATABASE [milan] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [milan] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [milan] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [milan] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [milan] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [milan] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [milan] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [milan] SET RECOVERY FULL 
GO
ALTER DATABASE [milan] SET  MULTI_USER 
GO
ALTER DATABASE [milan] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [milan] SET DB_CHAINING OFF 
GO
ALTER DATABASE [milan] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [milan] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [milan] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [milan] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'milan', N'ON'
GO
ALTER DATABASE [milan] SET QUERY_STORE = OFF
GO
USE [milan]
GO
/****** Object:  Table [dbo].[courseDates]    Script Date: 28-02-2022 00:40:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[courseDates](
	[courseID] [nvarchar](50) NOT NULL,
	[dates] [date] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[courseInfo]    Script Date: 28-02-2022 00:40:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[courseInfo](
	[courseID] [nvarchar](50) NOT NULL,
	[courseName] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_courseInfo] PRIMARY KEY CLUSTERED 
(
	[courseID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[studentcourses]    Script Date: 28-02-2022 00:40:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[studentcourses](
	[studentID] [nvarchar](50) NOT NULL,
	[courseID] [nvarchar](50) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[studentInfo]    Script Date: 28-02-2022 00:40:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[studentInfo](
	[studentID] [nvarchar](50) NOT NULL,
	[studentName] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_studentInfo] PRIMARY KEY CLUSTERED 
(
	[studentID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[courseDates]  WITH CHECK ADD  CONSTRAINT [FK_courseID_dates] FOREIGN KEY([courseID])
REFERENCES [dbo].[courseInfo] ([courseID])
GO
ALTER TABLE [dbo].[courseDates] CHECK CONSTRAINT [FK_courseID_dates]
GO
ALTER TABLE [dbo].[studentcourses]  WITH CHECK ADD  CONSTRAINT [FK_courseID] FOREIGN KEY([courseID])
REFERENCES [dbo].[courseInfo] ([courseID])
GO
ALTER TABLE [dbo].[studentcourses] CHECK CONSTRAINT [FK_courseID]
GO
ALTER TABLE [dbo].[studentcourses]  WITH CHECK ADD  CONSTRAINT [FK_studentID] FOREIGN KEY([studentID])
REFERENCES [dbo].[studentInfo] ([studentID])
GO
ALTER TABLE [dbo].[studentcourses] CHECK CONSTRAINT [FK_studentID]
GO
/****** Object:  StoredProcedure [dbo].[listofdates]    Script Date: 28-02-2022 00:40:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[listofdates]
	-- Add the parameters for the stored procedure here
	@courseid_value nvarchar(50)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	select distinct z.courseID,dates from  (select distinct courseID from (select studentid   from studentcourses where courseID= @courseid_value) x join studentcourses y on x.studentID = y.studentID ) z
join courseDates l on l.courseID = z.courseID
END

GO
USE [master]
GO
ALTER DATABASE [milan] SET  READ_WRITE 
GO
