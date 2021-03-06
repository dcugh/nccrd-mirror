USE [master]
GO
/****** Object:  Database [NCCRD]    Script Date: 2018/12/03 07:46:59 ******/
CREATE DATABASE [NCCRD] ON  PRIMARY 
( NAME = N'DEAT', FILENAME = N'D:\Databases\MSSQL\Data\NCCRD.mdf' , SIZE = 12480KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'DEAT_log', FILENAME = N'D:\Databases\MSSQL\Log\NCCRD_log.ldf' , SIZE = 35712KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [NCCRD] SET COMPATIBILITY_LEVEL = 100
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [NCCRD].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [NCCRD] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [NCCRD] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [NCCRD] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [NCCRD] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [NCCRD] SET ARITHABORT OFF 
GO
ALTER DATABASE [NCCRD] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [NCCRD] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [NCCRD] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [NCCRD] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [NCCRD] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [NCCRD] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [NCCRD] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [NCCRD] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [NCCRD] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [NCCRD] SET  DISABLE_BROKER 
GO
ALTER DATABASE [NCCRD] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [NCCRD] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [NCCRD] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [NCCRD] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [NCCRD] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [NCCRD] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [NCCRD] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [NCCRD] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [NCCRD] SET  MULTI_USER 
GO
ALTER DATABASE [NCCRD] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [NCCRD] SET DB_CHAINING OFF 
GO
EXEC sys.sp_db_vardecimal_storage_format N'NCCRD', N'ON'
GO
USE [NCCRD]
GO
/****** Object:  User [ermweb]    Script Date: 2018/12/03 07:46:59 ******/
CREATE USER [ermweb] WITHOUT LOGIN WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [deatweb]    Script Date: 2018/12/03 07:46:59 ******/
CREATE USER [deatweb] WITHOUT LOGIN WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [deabs]    Script Date: 2018/12/03 07:46:59 ******/
CREATE USER [deabs] WITHOUT LOGIN WITH DEFAULT_SCHEMA=[dbo]
GO
sys.sp_addrolemember @rolename = N'db_owner', @membername = N'ermweb'
GO
sys.sp_addrolemember @rolename = N'db_owner', @membername = N'deatweb'
GO
sys.sp_addrolemember @rolename = N'db_datareader', @membername = N'deatweb'
GO
sys.sp_addrolemember @rolename = N'db_datawriter', @membername = N'deatweb'
GO
/****** Object:  UserDefinedFunction [dbo].[format_LeftPad]    Script Date: 2018/12/03 07:46:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


create  FUNCTION [dbo].[format_LeftPad](@Value int, @Len int ) 

RETURNS nvarchar(10) AS
BEGIN
	
	declare @str as nvarchar(10)
	set @str= cast(@Value as nvarchar)
	
	While len(@str) < @len
		Begin
		set @str='0'+ @str
	 	End 
	
	return @str
END






GO
/****** Object:  UserDefinedFunction [dbo].[GetStartOfWeek]    Script Date: 2018/12/03 07:46:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


create function [dbo].[GetStartOfWeek] (
@value datetime
)
returns datetime
as begin
return   DATEADD(d, -( DATEPART(dw,@value) -1),@value)
end

GO
/****** Object:  Table [dbo].[tb_erm_announcement]    Script Date: 2018/12/03 07:46:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tb_erm_announcement](
	[AnnouncementID] [int] NOT NULL,
	[ShowLoginAnnouncement] [int] NULL,
	[LoginAnnouncement] [ntext] NOT NULL,
	[ShowHomeAnnouncement] [int] NULL,
	[HomeAnnouncement] [ntext] NOT NULL,
	[UpdtUser] [nvarchar](50) NULL,
	[UpdtTime] [datetime] NULL,
 CONSTRAINT [pk_tb_erm_announcement] PRIMARY KEY NONCLUSTERED 
(
	[AnnouncementID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tb_erm_appusers]    Script Date: 2018/12/03 07:46:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tb_erm_appusers](
	[AppUserID] [int] IDENTITY(10000,1) NOT NULL,
	[RoleID] [int] NULL,
	[AppUserName] [nvarchar](50) NULL,
	[AppUserpwd] [nvarchar](50) NULL,
	[LoginAdmin] [int] NULL,
	[IsBlock] [int] NULL,
	[IsFirstLogin] [int] NULL,
	[UserTitle] [int] NULL,
	[UserSector] [int] NULL,
	[IsReponsible] [int] NULL,
	[UserFirstName] [nvarchar](30) NULL,
	[UserSurname] [nvarchar](30) NULL,
	[UserJobTitle] [nvarchar](50) NULL,
	[UserOrganisation] [nvarchar](50) NULL,
	[PhysLine1] [nvarchar](150) NULL,
	[PhysLine2] [nvarchar](150) NULL,
	[PhysLine3] [nvarchar](150) NULL,
	[PostLine1] [nvarchar](150) NULL,
	[PostLine2] [nvarchar](150) NULL,
	[PostLine3] [nvarchar](150) NULL,
	[PhyTown] [nvarchar](150) NULL,
	[PostTown] [nvarchar](150) NULL,
	[PhyProvince] [nvarchar](150) NULL,
	[PostProvince] [nvarchar](150) NULL,
	[PhyCode] [nvarchar](150) NULL,
	[PostCode] [nvarchar](150) NULL,
	[PhyCountry] [nvarchar](150) NULL,
	[PostCountry] [nvarchar](150) NULL,
	[UserPhoneNumber] [nvarchar](20) NULL,
	[UserMobileNumber] [nvarchar](20) NULL,
	[UserFax] [nvarchar](20) NULL,
	[UpdtUser] [nvarchar](50) NULL,
	[UpdtTime] [datetime] NULL,
	[chkadmin] [int] NULL,
	[WinAuth] [int] NULL,
	[SiteRoleID] [int] NULL,
	[CultureID] [int] NULL,
 CONSTRAINT [AppUserID_PK] PRIMARY KEY NONCLUSTERED 
(
	[AppUserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [AppUserUK] UNIQUE NONCLUSTERED 
(
	[AppUserName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tb_erm_audit_log]    Script Date: 2018/12/03 07:46:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tb_erm_audit_log](
	[AuditLogID] [int] IDENTITY(10000,1) NOT NULL,
	[PkId] [int] NOT NULL,
	[TableName] [nvarchar](100) NOT NULL,
	[ColumnName] [nvarchar](200) NOT NULL,
	[OldValue] [ntext] NULL,
	[NewValue] [ntext] NULL,
	[UpdtUser] [nvarchar](50) NULL,
	[UpdtTime] [datetime] NULL,
 CONSTRAINT [AuditLogID_PK] PRIMARY KEY NONCLUSTERED 
(
	[AuditLogID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tb_erm_Cultures]    Script Date: 2018/12/03 07:46:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tb_erm_Cultures](
	[CultureID] [int] IDENTITY(10000,1) NOT NULL,
	[CultureName] [nvarchar](100) NULL,
	[CultureCode] [nvarchar](100) NULL,
	[LangID] [int] NULL,
	[UpdtUser] [nvarchar](50) NULL,
	[UpdtTime] [datetime] NULL,
 CONSTRAINT [CultureID_PK] PRIMARY KEY NONCLUSTERED 
(
	[CultureID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tb_erm_Languages]    Script Date: 2018/12/03 07:46:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tb_erm_Languages](
	[LangID] [int] IDENTITY(10000,1) NOT NULL,
	[LangName] [nvarchar](50) NULL,
	[UpdtUser] [nvarchar](50) NULL,
	[UpdtTime] [datetime] NULL,
 CONSTRAINT [LangID_PK] PRIMARY KEY NONCLUSTERED 
(
	[LangID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tb_erm_Local_Municipalities]    Script Date: 2018/12/03 07:46:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tb_erm_Local_Municipalities](
	[LocalMunicipalityID] [int] IDENTITY(10000,1) NOT NULL,
	[ProvinceID] [int] NOT NULL,
	[MetroID] [int] NOT NULL,
	[LocalMunicipalityName] [nvarchar](100) NULL,
	[Description] [nvarchar](255) NULL,
	[UpdtUser] [nvarchar](50) NULL,
	[UpdtTime] [datetime] NULL,
 CONSTRAINT [LocalMunicipalityID_PK] PRIMARY KEY NONCLUSTERED 
(
	[LocalMunicipalityID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tb_erm_Metro_DistrictMunicipality]    Script Date: 2018/12/03 07:46:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tb_erm_Metro_DistrictMunicipality](
	[MetroID] [int] IDENTITY(10000,1) NOT NULL,
	[ProvinceID] [int] NOT NULL,
	[MetroName] [nvarchar](100) NULL,
	[Description] [nvarchar](255) NULL,
	[IsMetro] [int] NULL,
	[UpdtUser] [nvarchar](50) NULL,
	[UpdtTime] [datetime] NULL,
 CONSTRAINT [MetroID_PK] PRIMARY KEY NONCLUSTERED 
(
	[MetroID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tb_erm_Metro_DistrictMunicipality_lat_long]    Script Date: 2018/12/03 07:46:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tb_erm_Metro_DistrictMunicipality_lat_long](
	[MetroDistrictMunicipalityLatLongId] [int] IDENTITY(10000,1) NOT NULL,
	[MetroID] [int] NOT NULL,
	[ProvinceID] [int] NULL,
	[LatDegree] [float] NULL,
	[LatMinutes] [float] NULL,
	[LatSeconds] [float] NULL,
	[LatDirection] [float] NULL,
	[LonDegree] [float] NULL,
	[LonMinutes] [float] NULL,
	[LonSeconds] [float] NULL,
	[LonDirection] [float] NULL,
	[UpdtUser] [nvarchar](50) NULL,
	[UpdtTime] [datetime] NULL,
 CONSTRAINT [pk_erm_MetroDistrictMunicipalityLatLongId] PRIMARY KEY NONCLUSTERED 
(
	[MetroDistrictMunicipalityLatLongId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tb_erm_mitigation_details]    Script Date: 2018/12/03 07:46:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tb_erm_mitigation_details](
	[MitigationDetailsId] [int] IDENTITY(10000,1) NOT NULL,
	[ProjectDetailsId] [int] NOT NULL,
	[ProjectType] [int] NULL,
	[ProjectSubType] [int] NULL,
	[HostSector] [int] NULL,
	[HostMainSubSector] [int] NULL,
	[HostSubSector] [int] NULL,
	[ExecutiveStatus] [int] NULL,
	[CarbonCredit] [int] NULL,
	[CarbonCreditMarket] [int] NULL,
	[CDMStatus] [int] NULL,
	[CDMMethodoloy] [int] NULL,
	[VolMethodoloy] [nvarchar](100) NULL,
	[GoldStandard] [int] NULL,
	[VCS] [int] NULL,
	[Other] [int] NULL,
	[otherDesc] [nvarchar](200) NULL,
	[UpdtUser] [nvarchar](50) NULL,
	[UpdtTime] [datetime] NULL,
	[CDMProjectNumber] [nvarchar](100) NULL,
 CONSTRAINT [pk_erm_MitigationDetailsId] PRIMARY KEY NONCLUSTERED 
(
	[MitigationDetailsId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tb_erm_Mitigation_Emissions_Data]    Script Date: 2018/12/03 07:46:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tb_erm_Mitigation_Emissions_Data](
	[MitigationEmissionsDataId] [int] IDENTITY(10000,1) NOT NULL,
	[ProjectLocationDataId] [int] NOT NULL,
	[Year] [int] NOT NULL,
	[CO2] [float] NULL,
	[CH4] [float] NULL,
	[CH4_CO2e] [float] NULL,
	[N2O] [float] NULL,
	[N2O_CO2e] [float] NULL,
	[HFC] [float] NULL,
	[HFC_CO2e] [float] NULL,
	[PFC] [float] NULL,
	[PFC_CO2e] [float] NULL,
	[SF6] [float] NULL,
	[SF6_CO2e] [float] NULL,
	[Hydro] [float] NULL,
	[Tidal] [float] NULL,
	[Wind] [float] NULL,
	[Solar] [float] NULL,
	[FossilFuelElecRed] [float] NULL,
	[UpdtUser] [nvarchar](50) NULL,
	[UpdtTime] [datetime] NULL,
	[BioWaste] [float] NULL,
	[BioWaste_CO2e] [float] NULL,
	[Geothermal] [float] NULL,
	[Geothermal_CO2e] [float] NULL,
	[Hydro_CO2e] [float] NULL,
	[Solar_CO2e] [float] NULL,
	[Tidal_CO2e] [float] NULL,
	[Wind_CO2e] [float] NULL,
	[FossilFuelElecRed_CO2e] [float] NULL,
 CONSTRAINT [pk_erm_MitigationEmissionsId] PRIMARY KEY NONCLUSTERED 
(
	[MitigationEmissionsDataId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tb_erm_Mitigation_MainSubSector]    Script Date: 2018/12/03 07:46:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tb_erm_Mitigation_MainSubSector](
	[MainSubSectorId] [int] IDENTITY(10000,1) NOT NULL,
	[HostSectorId] [int] NULL,
	[MainSubSectorType] [nvarchar](100) NULL,
	[Description] [nvarchar](255) NULL,
	[UpdtUser] [nvarchar](50) NULL,
	[UpdtTime] [datetime] NULL,
 CONSTRAINT [pk_erm_MainSubSectorId] PRIMARY KEY NONCLUSTERED 
(
	[MainSubSectorId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tb_erm_Mitigation_SubSector]    Script Date: 2018/12/03 07:46:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tb_erm_Mitigation_SubSector](
	[SubSectorId] [int] IDENTITY(10000,1) NOT NULL,
	[MainSubSectorId] [int] NULL,
	[SubSectorType] [nvarchar](100) NULL,
	[Description] [nvarchar](255) NULL,
	[UpdtUser] [nvarchar](50) NULL,
	[UpdtTime] [datetime] NULL,
 CONSTRAINT [pk_erm_SubSectorId] PRIMARY KEY NONCLUSTERED 
(
	[SubSectorId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tb_erm_navigation_module]    Script Date: 2018/12/03 07:46:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tb_erm_navigation_module](
	[NavigationModuleID] [int] NOT NULL,
	[ModuleName] [varchar](50) NOT NULL,
	[UpdtUser] [varchar](50) NULL,
	[UpdtTime] [datetime] NULL,
 CONSTRAINT [pk_erm_navigation_module] PRIMARY KEY NONCLUSTERED 
(
	[NavigationModuleID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [uk_ModuleName] UNIQUE NONCLUSTERED 
(
	[ModuleName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tb_erm_navtree]    Script Date: 2018/12/03 07:46:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tb_erm_navtree](
	[NavTreeID] [int] IDENTITY(10000,1) NOT NULL,
	[NavigationModuleID] [int] NOT NULL,
	[ObjID] [int] NOT NULL,
	[Title] [nvarchar](50) NULL,
	[URL] [nvarchar](3000) NULL,
	[AdminLink] [int] NOT NULL,
	[ParentID] [int] NULL,
	[Level] [int] NOT NULL,
	[SortOrder] [int] NULL,
	[Target] [nvarchar](20) NULL,
	[UpdtUser] [varchar](50) NULL,
	[UpdtTime] [datetime] NULL,
 CONSTRAINT [pk_erm_NavTree] PRIMARY KEY NONCLUSTERED 
(
	[NavTreeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tb_erm_obj]    Script Date: 2018/12/03 07:46:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tb_erm_obj](
	[ObjID] [int] NOT NULL,
	[ObjName] [varchar](50) NOT NULL,
	[UpdtUser] [varchar](50) NULL,
	[UpdtTime] [datetime] NULL,
 CONSTRAINT [pk_erm_obj] PRIMARY KEY NONCLUSTERED 
(
	[ObjID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [uk_erm_objname] UNIQUE NONCLUSTERED 
(
	[ObjName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tb_erm_obj_roles]    Script Date: 2018/12/03 07:46:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tb_erm_obj_roles](
	[ObjRoleID] [int] IDENTITY(10000,1) NOT NULL,
	[RoleID] [int] NOT NULL,
	[ObjID] [int] NOT NULL,
	[AddPerm] [int] NOT NULL,
	[ReadPerm] [int] NOT NULL,
	[DeletePerm] [int] NOT NULL,
	[UpdatePerm] [int] NOT NULL,
	[UpdtUser] [varchar](50) NULL,
	[UpdtTime] [datetime] NULL,
 CONSTRAINT [pk_erm_obj_roles] PRIMARY KEY NONCLUSTERED 
(
	[ObjRoleID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [uk_erm_obj_roles] UNIQUE NONCLUSTERED 
(
	[RoleID] ASC,
	[ObjID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tb_erm_picklist]    Script Date: 2018/12/03 07:46:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tb_erm_picklist](
	[ListId] [int] IDENTITY(10000,1) NOT NULL,
	[ListName] [nvarchar](255) NOT NULL,
	[OrderAlphabatically] [int] NULL,
	[UpdtUser] [nvarchar](50) NULL,
	[UpdtTime] [datetime] NULL,
 CONSTRAINT [pk_erm_ListId] PRIMARY KEY NONCLUSTERED 
(
	[ListId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tb_erm_picklist_value]    Script Date: 2018/12/03 07:46:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tb_erm_picklist_value](
	[PickListId] [int] IDENTITY(10000,1) NOT NULL,
	[ListId] [int] NOT NULL,
	[ItemDisplay] [nvarchar](255) NOT NULL,
	[ItemNum] [int] NULL,
	[ItemOrder] [int] NULL,
	[Description] [nvarchar](255) NULL,
	[IsDefault] [int] NULL,
	[IsDisabled] [int] NULL,
	[UpdtUser] [nvarchar](50) NULL,
	[UpdtTime] [datetime] NULL,
 CONSTRAINT [pk_erm_pickListId] PRIMARY KEY NONCLUSTERED 
(
	[PickListId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tb_erm_Project_Adaptation_Data]    Script Date: 2018/12/03 07:46:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tb_erm_Project_Adaptation_Data](
	[ProjectAdaptationDataId] [int] IDENTITY(10000,1) NOT NULL,
	[ProjectDetailsId] [int] NOT NULL,
	[Province] [int] NULL,
	[City] [int] NULL,
	[Municipality] [int] NULL,
	[LocalMunicipality] [int] NULL,
	[HostSector] [int] NULL,
	[HostSubSector] [int] NULL,
	[PurposeOfAdaptation] [int] NULL,
	[LatDegree] [float] NULL,
	[LatMinutes] [float] NULL,
	[LatSeconds] [float] NULL,
	[LatDirection] [float] NULL,
	[LatCalculated] [float] NULL,
	[LonDegree] [float] NULL,
	[LonMinutes] [float] NULL,
	[LonSeconds] [float] NULL,
	[LonDirection] [float] NULL,
	[LonCalculated] [float] NULL,
	[UpdtUser] [nvarchar](50) NULL,
	[UpdtTime] [datetime] NULL,
 CONSTRAINT [pk_erm_ProjectAdaptationDataId] PRIMARY KEY NONCLUSTERED 
(
	[ProjectAdaptationDataId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tb_erm_project_details]    Script Date: 2018/12/03 07:46:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tb_erm_project_details](
	[ProjectDetailsId] [int] IDENTITY(10000,1) NOT NULL,
	[ProjectDetailsIdentifier] [nvarchar](10) NULL,
	[ProjectTitle] [nvarchar](100) NOT NULL,
	[TypeOfProject] [int] NULL,
	[TypeOfIntervention] [int] NULL,
	[LeadAgent] [nvarchar](50) NOT NULL,
	[HostPartner] [nvarchar](100) NOT NULL,
	[FundingOrganisation] [nvarchar](50) NOT NULL,
	[FundingPartner] [nvarchar](100) NOT NULL,
	[HostOrganisation] [nvarchar](50) NOT NULL,
	[HostSector] [int] NULL,
	[Status] [int] NULL,
	[StartYear] [int] NULL,
	[EndYear] [int] NULL,
	[EstimatedBudget] [int] NULL,
	[ProjectManager] [int] NULL,
	[ReminderSent] [int] NULL,
	[Description] [nvarchar](4000) NULL,
	[AlternativeContact] [nvarchar](150) NULL,
	[AlternativeContactEmail] [nvarchar](150) NULL,
	[Link] [nvarchar](100) NULL,
	[ValidationStatus] [nvarchar](12) NULL,
	[UpdtUser] [nvarchar](50) NULL,
	[UpdtTime] [datetime] NULL,
	[FUNDINGSTATUS] [int] NULL,
	[VALIDATIONCOMMENTS] [nvarchar](255) NULL,
	[BudgetLower] [float] NULL,
	[BudgetUpper] [float] NULL,
 CONSTRAINT [pk_erm_ProjectDetailsId] PRIMARY KEY NONCLUSTERED 
(
	[ProjectDetailsId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tb_erm_Project_Location_Data]    Script Date: 2018/12/03 07:46:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tb_erm_Project_Location_Data](
	[ProjectLocationDataId] [int] IDENTITY(10000,1) NOT NULL,
	[ProjectDetailsId] [int] NOT NULL,
	[Province] [int] NOT NULL,
	[Metro] [int] NULL,
	[LocalMunicipality] [int] NULL,
	[Town] [int] NULL,
	[LatDegree] [float] NULL,
	[LatMinutes] [float] NULL,
	[LatSeconds] [float] NULL,
	[LatDirection] [float] NULL,
	[LatCalculated] [float] NULL,
	[LonDegree] [float] NULL,
	[LonMinutes] [float] NULL,
	[LonSeconds] [float] NULL,
	[LonDirection] [float] NULL,
	[LonCalculated] [float] NULL,
	[Comments] [nvarchar](4000) NULL,
	[UpdtUser] [nvarchar](50) NULL,
	[UpdtTime] [datetime] NULL,
 CONSTRAINT [pk_erm_ProjectLocationDataId] PRIMARY KEY NONCLUSTERED 
(
	[ProjectLocationDataId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [ProjectLocation_UK] UNIQUE NONCLUSTERED 
(
	[ProjectDetailsId] ASC,
	[Province] ASC,
	[Metro] ASC,
	[LocalMunicipality] ASC,
	[Town] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tb_erm_Project_Research_Data]    Script Date: 2018/12/03 07:46:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tb_erm_Project_Research_Data](
	[ProjectResearchDataId] [int] IDENTITY(10000,1) NOT NULL,
	[ProjectDetailsId] [int] NOT NULL,
	[Province] [int] NULL,
	[City] [int] NULL,
	[Municipality] [int] NULL,
	[LocalMunicipality] [int] NULL,
	[TypeOfResearch] [int] NULL,
	[TargetAudience] [int] NULL,
	[Author] [nvarchar](50) NULL,
	[Paper] [nvarchar](50) NULL,
	[LatDegree] [float] NULL,
	[LatMinutes] [float] NULL,
	[LatSeconds] [float] NULL,
	[LatDirection] [float] NULL,
	[LatCalculated] [float] NULL,
	[LonDegree] [float] NULL,
	[LonMinutes] [float] NULL,
	[LonSeconds] [float] NULL,
	[LonDirection] [float] NULL,
	[LonCalculated] [float] NULL,
	[UpdtUser] [nvarchar](50) NULL,
	[UpdtTime] [datetime] NULL,
 CONSTRAINT [pk_erm_ProjectResearchDataId] PRIMARY KEY NONCLUSTERED 
(
	[ProjectResearchDataId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tb_erm_Project_SubType]    Script Date: 2018/12/03 07:46:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tb_erm_Project_SubType](
	[ProjectSubTypeId] [int] IDENTITY(10000,1) NOT NULL,
	[ProjectTypeId] [int] NULL,
	[ProjectSubType] [nvarchar](100) NULL,
	[Description] [nvarchar](255) NULL,
	[UpdtUser] [nvarchar](50) NULL,
	[UpdtTime] [datetime] NULL,
 CONSTRAINT [pk_erm_ProjectSubTypeId] PRIMARY KEY NONCLUSTERED 
(
	[ProjectSubTypeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tb_erm_Province]    Script Date: 2018/12/03 07:46:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tb_erm_Province](
	[ProvinceID] [int] IDENTITY(10000,1) NOT NULL,
	[ProvinceName] [nvarchar](100) NULL,
	[Description] [nvarchar](255) NULL,
	[UpdtUser] [nvarchar](50) NULL,
	[UpdtTime] [datetime] NULL,
 CONSTRAINT [ProvinceID_PK] PRIMARY KEY NONCLUSTERED 
(
	[ProvinceID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tb_erm_roles]    Script Date: 2018/12/03 07:46:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tb_erm_roles](
	[RoleID] [int] IDENTITY(10000,1) NOT NULL,
	[RoleName] [varchar](50) NOT NULL,
	[UpdtUser] [varchar](50) NULL,
	[UpdtTime] [datetime] NULL,
 CONSTRAINT [pk_erm_roles] PRIMARY KEY NONCLUSTERED 
(
	[RoleID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [uk_erm_RoleName] UNIQUE NONCLUSTERED 
(
	[RoleName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tb_erm_Town]    Script Date: 2018/12/03 07:46:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tb_erm_Town](
	[TownID] [int] IDENTITY(10000,1) NOT NULL,
	[ProvinceID] [int] NOT NULL,
	[IsUnderMetro] [int] NULL,
	[MetroID] [int] NULL,
	[LocalMunicipalityID] [int] NULL,
	[TownName] [nvarchar](100) NULL,
	[Description] [nvarchar](255) NULL,
	[UpdtUser] [nvarchar](50) NULL,
	[UpdtTime] [datetime] NULL,
 CONSTRAINT [TownID_PK] PRIMARY KEY NONCLUSTERED 
(
	[TownID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tb_erm_version_history]    Script Date: 2018/12/03 07:46:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tb_erm_version_history](
	[HistId] [int] IDENTITY(10000,1) NOT NULL,
	[VersionNumber] [nvarchar](255) NOT NULL,
	[ChangeDateTime] [datetime] NULL,
	[Comments] [nvarchar](4000) NULL,
	[UpdtUser] [nvarchar](50) NULL,
	[UpdtTime] [datetime] NULL,
 CONSTRAINT [pk_erm_HistId] PRIMARY KEY NONCLUSTERED 
(
	[HistId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[AllSearch]    Script Date: 2018/12/03 07:46:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


create view [dbo].[AllSearch] as
(

select pd.ProjectDetailsId,ProjectDetailsIdentifier,LeadAgent,ProjectTitle,
HostPartner,FundingOrganisation,FundingPartner,HostOrganisation,pd.Status, 'Adaptation' as  'Intervention', 'Project' as 'ProjectType',
prvnce.ProvinceID  as Province,twn.TownID  as Town,lm.LocalMunicipalityID as 'Localmunicipality', 0 as 'CO2e',
mdm.MetroID as Metro ,pd.ValidationStatus as 'ValidationStatus' ,' ' as 'ResearchType' ,
pd.StartYear,pd.EndYear,pd.EstimatedBudget,pd.AlternativeContact,pd.AlternativeContactEmail,pd.Link
,convert(nvarchar(4000),pd.Description) as 'Description',pd.FUNDINGSTATUS,pd.BudgetLower,pd.BudgetUpper,
0 as 'HostSector',0 as 'HostSubSector',0 as 'HostSubSubSector'
from tb_erm_project_details pd
left join 
(select * from tb_erm_picklist_value where listid = (select listid from tb_erm_picklist 
where ListName = 'Type of Project')) TypeProject on pd.TypeOfProject = TypeProject.ItemNum left join 
(select * from tb_erm_picklist_value where listid = (select listid from tb_erm_picklist where ListName = 'Status'))
 Status on pd.Status = Status.ItemNum left join (select * from tb_erm_picklist_value where listid = 
(select listid from tb_erm_picklist where ListName = 'Adaptation Host Sector')) HostSector 
on pd.HostSector = HostSector.ItemNum left join tb_erm_Project_Adaptation_Data pad on 
pd.ProjectDetailsId = pad.ProjectDetailsId
inner join tb_erm_Province prvnce on pad.Province = prvnce.ProvinceID 
left join tb_erm_Metro_DistrictMunicipality mdm on pad.Municipality = mdm.MetroID
left join tb_erm_Local_Municipalities lm on  pad.LocalMunicipality =lm.LocalMunicipalityID
left join tb_erm_Town twn on pad.city=twn.TownID where pd.TypeOfIntervention='2' 
and pd.TypeOfProject='1' 
union 
select pd.ProjectDetailsId,ProjectDetailsIdentifier,LeadAgent,ProjectTitle,
HostPartner,FundingOrganisation,FundingPartner,HostOrganisation,pd.Status, 'Mitigation' as  'Intervention', 'Project' as 'ProjectType',
prvnce.ProvinceID  as Province,twn.TownID  as Town,lm.LocalMunicipalityID as 'Localmunicipality',
 (
select sum(CO2) + sum(CH4_CO2e)+ sum(N2O_CO2e)+ sum(HFC_CO2e)  + sum(PFC_CO2e)+ sum(SF6_CO2e) + sum(BioWaste_CO2e) + sum(Geothermal_CO2e) + sum(Hydro_CO2e) + sum(Solar_CO2e) + sum(Tidal_CO2e) + sum(Wind_CO2e) + sum(FossilFuelElecRed_CO2e)
from dbo.tb_erm_Mitigation_Emissions_Data  med1 where med1.ProjectLocationDataId= pld.ProjectLocationDataId
) as 'CO2e',
mdm.MetroID as Metro ,pd.ValidationStatus as 'ValidationStatus',' ' as 'ResearchType' ,
pd.StartYear,pd.EndYear,pd.EstimatedBudget,pd.AlternativeContact,pd.AlternativeContactEmail,pd.Link
,convert(nvarchar(4000),pd.Description) as 'Description',pd.FUNDINGSTATUS,pd.BudgetLower,pd.BudgetUpper
,HostSector.itemnum as 'HostSector',tmms.MainSubSectorId as 'HostSubSector',tmss.SubSectorId as 'HostSubSubSector'
from tb_erm_project_details pd
left join 
(select * from tb_erm_picklist_value where listid = (select listid from tb_erm_picklist where ListName = 'Status'))
 Status on pd.Status = Status.ItemNum   left join tb_erm_Project_Location_Data pld 
on pd.ProjectDetailsId = pld.ProjectDetailsId
inner join tb_erm_Province prvnce on pld.Province = prvnce.ProvinceID 
left join tb_erm_Metro_DistrictMunicipality mdm on pld.Metro = mdm.MetroID
left join tb_erm_Local_Municipalities lm on  pld.LocalMunicipality =lm.LocalMunicipalityID
left join tb_erm_Town twn on pld.Town=twn.TownID
left join tb_erm_mitigation_details mt on pd.ProjectDetailsId = mt.ProjectDetailsId 
left join (select * from tb_erm_picklist_value where listid = 
(select listid from tb_erm_picklist where ListName = 'Host Sector')) HostSector 
on mt.HostSector = HostSector.ItemNum
left join tb_erm_Mitigation_MainSubSector tmms on tmms.MainSubSectorId =mt.HostMainSubSector
left join tb_erm_Mitigation_SubSector tmss on tmss.SubSectorId =mt.HostSubSector
left join (select * from tb_erm_picklist_value where listid = (select listid from tb_erm_picklist 
where ListName = 'Type of Project')) TypeProject on mt.ProjectType = TypeProject.ItemNum
where pd.TypeOfIntervention='1' and pd.TypeOfProject='1' 


union 
select pd.ProjectDetailsId,ProjectDetailsIdentifier,LeadAgent,ProjectTitle,
HostPartner,FundingOrganisation,FundingPartner,HostOrganisation,pd.Status, case pd.TypeOfIntervention 
   when 1 then 'Mitigation' 
   else 'Adaptation ' end  as 'Intervention', 'Research' as 'ProjectType', 
prvnce.ProvinceID  as Province,twn.TownID  as Town,lm.LocalMunicipalityID as 'Localmunicipality', 0 as 'CO2e',
mdm.MetroID as Metro ,pd.ValidationStatus as 'ValidationStatus',ResearchType.ItemDisplay as 'ResearchType',
pd.StartYear,pd.EndYear,pd.EstimatedBudget,pd.AlternativeContact,pd.AlternativeContactEmail,pd.Link
,convert(nvarchar(4000),pd.Description) as 'Description',pd.FUNDINGSTATUS,pd.BudgetLower,pd.BudgetUpper,
0 as 'HostSector',0 as 'HostSubSector',0 as 'HostSubSubSector'
 from tb_erm_project_details pd
left join 
(select * from tb_erm_picklist_value where listid = (select listid from tb_erm_picklist where ListName = 'Status'))
 Status on pd.Status = Status.ItemNum   left join 
tb_erm_Project_Research_Data rd on pd.ProjectDetailsId = rd.ProjectDetailsId 
left join (select * from tb_erm_picklist_value where listid = 
(select listid from tb_erm_picklist where ListName = 'Type of research')) ResearchType 
on rd.TypeOfResearch = ResearchType.ItemNum
inner join tb_erm_Province prvnce on rd.Province = prvnce.ProvinceID 
left join tb_erm_Metro_DistrictMunicipality mdm on rd.Municipality = mdm.MetroID
left join tb_erm_Local_Municipalities lm on  rd.LocalMunicipality =lm.LocalMunicipalityID
left join tb_erm_Town twn on rd.City=twn.TownID
left join (select * from tb_erm_picklist_value where listid = (select listid from tb_erm_picklist 
where ListName = 'Target audience')) tarAudience on rd.TargetAudience = tarAudience.ItemNum
where pd.TypeOfProject='2'  
) 
GO
ALTER TABLE [dbo].[tb_erm_appusers]  WITH CHECK ADD  CONSTRAINT [CultureID_FK] FOREIGN KEY([CultureID])
REFERENCES [dbo].[tb_erm_Cultures] ([CultureID])
GO
ALTER TABLE [dbo].[tb_erm_appusers] CHECK CONSTRAINT [CultureID_FK]
GO
ALTER TABLE [dbo].[tb_erm_Cultures]  WITH CHECK ADD  CONSTRAINT [LangID_FK] FOREIGN KEY([LangID])
REFERENCES [dbo].[tb_erm_Languages] ([LangID])
GO
ALTER TABLE [dbo].[tb_erm_Cultures] CHECK CONSTRAINT [LangID_FK]
GO
ALTER TABLE [dbo].[tb_erm_Local_Municipalities]  WITH CHECK ADD  CONSTRAINT [MetroID_FK1] FOREIGN KEY([MetroID])
REFERENCES [dbo].[tb_erm_Metro_DistrictMunicipality] ([MetroID])
GO
ALTER TABLE [dbo].[tb_erm_Local_Municipalities] CHECK CONSTRAINT [MetroID_FK1]
GO
ALTER TABLE [dbo].[tb_erm_Local_Municipalities]  WITH CHECK ADD  CONSTRAINT [ProvinceID_FK1] FOREIGN KEY([ProvinceID])
REFERENCES [dbo].[tb_erm_Province] ([ProvinceID])
GO
ALTER TABLE [dbo].[tb_erm_Local_Municipalities] CHECK CONSTRAINT [ProvinceID_FK1]
GO
ALTER TABLE [dbo].[tb_erm_Metro_DistrictMunicipality]  WITH CHECK ADD  CONSTRAINT [ProvinceID_FK] FOREIGN KEY([ProvinceID])
REFERENCES [dbo].[tb_erm_Province] ([ProvinceID])
GO
ALTER TABLE [dbo].[tb_erm_Metro_DistrictMunicipality] CHECK CONSTRAINT [ProvinceID_FK]
GO
ALTER TABLE [dbo].[tb_erm_Metro_DistrictMunicipality_lat_long]  WITH CHECK ADD  CONSTRAINT [LatLongProvinceID_FK] FOREIGN KEY([ProvinceID])
REFERENCES [dbo].[tb_erm_Province] ([ProvinceID])
GO
ALTER TABLE [dbo].[tb_erm_Metro_DistrictMunicipality_lat_long] CHECK CONSTRAINT [LatLongProvinceID_FK]
GO
ALTER TABLE [dbo].[tb_erm_Metro_DistrictMunicipality_lat_long]  WITH CHECK ADD  CONSTRAINT [MetroID_FK] FOREIGN KEY([MetroID])
REFERENCES [dbo].[tb_erm_Metro_DistrictMunicipality] ([MetroID])
GO
ALTER TABLE [dbo].[tb_erm_Metro_DistrictMunicipality_lat_long] CHECK CONSTRAINT [MetroID_FK]
GO
ALTER TABLE [dbo].[tb_erm_mitigation_details]  WITH CHECK ADD  CONSTRAINT [ProjectDetailsId_FK] FOREIGN KEY([ProjectDetailsId])
REFERENCES [dbo].[tb_erm_project_details] ([ProjectDetailsId])
GO
ALTER TABLE [dbo].[tb_erm_mitigation_details] CHECK CONSTRAINT [ProjectDetailsId_FK]
GO
ALTER TABLE [dbo].[tb_erm_navtree]  WITH CHECK ADD  CONSTRAINT [fk_NavigationModuleID] FOREIGN KEY([NavigationModuleID])
REFERENCES [dbo].[tb_erm_navigation_module] ([NavigationModuleID])
GO
ALTER TABLE [dbo].[tb_erm_navtree] CHECK CONSTRAINT [fk_NavigationModuleID]
GO
ALTER TABLE [dbo].[tb_erm_navtree]  WITH CHECK ADD  CONSTRAINT [fkey_erm_obj_id] FOREIGN KEY([ObjID])
REFERENCES [dbo].[tb_erm_obj] ([ObjID])
GO
ALTER TABLE [dbo].[tb_erm_navtree] CHECK CONSTRAINT [fkey_erm_obj_id]
GO
ALTER TABLE [dbo].[tb_erm_obj_roles]  WITH CHECK ADD  CONSTRAINT [fk_erm_obj_id] FOREIGN KEY([ObjID])
REFERENCES [dbo].[tb_erm_obj] ([ObjID])
GO
ALTER TABLE [dbo].[tb_erm_obj_roles] CHECK CONSTRAINT [fk_erm_obj_id]
GO
ALTER TABLE [dbo].[tb_erm_obj_roles]  WITH CHECK ADD  CONSTRAINT [fk_erm_role_id] FOREIGN KEY([RoleID])
REFERENCES [dbo].[tb_erm_roles] ([RoleID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[tb_erm_obj_roles] CHECK CONSTRAINT [fk_erm_role_id]
GO
ALTER TABLE [dbo].[tb_erm_picklist_value]  WITH CHECK ADD  CONSTRAINT [fk_erm_ListId] FOREIGN KEY([ListId])
REFERENCES [dbo].[tb_erm_picklist] ([ListId])
GO
ALTER TABLE [dbo].[tb_erm_picklist_value] CHECK CONSTRAINT [fk_erm_ListId]
GO
ALTER TABLE [dbo].[tb_erm_Project_Adaptation_Data]  WITH CHECK ADD  CONSTRAINT [ProjectAdaptation_FK] FOREIGN KEY([ProjectDetailsId])
REFERENCES [dbo].[tb_erm_project_details] ([ProjectDetailsId])
GO
ALTER TABLE [dbo].[tb_erm_Project_Adaptation_Data] CHECK CONSTRAINT [ProjectAdaptation_FK]
GO
ALTER TABLE [dbo].[tb_erm_Project_Location_Data]  WITH CHECK ADD  CONSTRAINT [ProjectLocation_FK] FOREIGN KEY([ProjectDetailsId])
REFERENCES [dbo].[tb_erm_project_details] ([ProjectDetailsId])
GO
ALTER TABLE [dbo].[tb_erm_Project_Location_Data] CHECK CONSTRAINT [ProjectLocation_FK]
GO
ALTER TABLE [dbo].[tb_erm_Project_Research_Data]  WITH CHECK ADD  CONSTRAINT [ProjectResearch_FK] FOREIGN KEY([ProjectDetailsId])
REFERENCES [dbo].[tb_erm_project_details] ([ProjectDetailsId])
GO
ALTER TABLE [dbo].[tb_erm_Project_Research_Data] CHECK CONSTRAINT [ProjectResearch_FK]
GO
/****** Object:  StoredProcedure [dbo].[getLatLongDetails]    Script Date: 2018/12/03 07:46:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

---Create Procedure for Latitude and Longitude Details
create procedure [dbo].[getLatLongDetails]
@MetroName as nvarchar(200),
@Latdeg as float,
@LatMin as float,
@LatSec as float,
@Longdeg as float,
@LongMin as float,
@LongSec as float
as
If exists (select MetroID, ProvinceID from tb_erm_Metro_DistrictMunicipality where MetroName=@MetroName)
begin
	declare 
		@MetroId int,
		@ProvinceId int
	select @MetroId = MetroID , @ProvinceId = ProvinceID 
	from tb_erm_Metro_DistrictMunicipality where MetroName= @MetroName
	If not exists (select * from tb_erm_Metro_DistrictMunicipality_lat_long where MetroID = @MetroId and ProvinceID= @ProvinceId)
	begin
		insert into tb_erm_Metro_DistrictMunicipality_lat_long (MetroID,ProvinceID,LatDegree,LatMinutes,LatSeconds,LatDirection,LonDegree,LonMinutes,LonSeconds,LonDirection)
		values(@MetroId,@ProvinceId,@Latdeg,@LatMin,@LatSec,2,@Longdeg,@LongMin,@LongSec,1)
	end
end
GO
/****** Object:  StoredProcedure [dbo].[getMitigationEmissionData]    Script Date: 2018/12/03 07:46:59 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

/************************************************************************************************************************************************************************************/
--Modified stored procedue to add FossilFuelElecRed_CO2e column
CREATE PROCEDURE [dbo].[getMitigationEmissionData]

 @Syear int,
 @Eyear int,
 @ProjectLocationDataId int
AS 
Begin
	declare @year int
	declare @sql as nvarchar(4000)
    declare @ParentId int
   	set @year = @Syear
	set @sql=''
	declare @SelectListEditMode nvarchar(1000)
	declare @SelectListNewMode nvarchar(1000)
	declare @TablesList nvarchar(1000)
	create table #MyTable (
           	 [ProjectLocationDataId]		 [int] not null,[MitigationEmissionsDataId]		 [int],
             [Year]						     [int] not null,	 	
			 [CO2]							 [float], [CH4]							 [float],
			 [CH4_CO2e]						 [float], [N2O]							 [float],
			 [N2O_CO2e]						 [float], [HFC]							 [float],
			 [HFC_CO2e]						 [float], [PFC]							 [float],
			 [PFC_CO2e]						 [float], [SF6]							 [float],
			 [SF6_CO2e]						 [float], [Hydro]						 [float],
			 [Tidal]						 [float], [Wind]						 [float],
			 [Solar]						 [float], [FossilFuelElecRed]			 [float],
			 [BioWaste]						 [float], [BioWaste_CO2e]				 [float],
			 [Geothermal]					 [float], [Geothermal_CO2e]				 [float],
			 [Hydro_CO2e]					 [float], [Solar_CO2e]					 [float],
			 [Tidal_CO2e]					 [float], [Wind_CO2e]					 [float],
			 [FossilFuelElecRed_CO2e]		 [float]
)

	   if (@ProjectLocationDataId=-1 )
			Begin
				WHILE @year <= @Eyear
					BEGIN
																
						insert into #MyTable values (-1,-1,@year,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0)
						 set @year=@year+1
					END
			end
      else
           begin

			WHILE @year <= @Eyear
				BEGIN
				   if Exists(Select * from tb_erm_Mitigation_Emissions_Data where [year]=@year and ProjectLocationDataId=@ProjectLocationDataId)
						Begin
						insert into #MyTable  Select  pld.ProjectLocationDataId, MED.[MitigationEmissionsDataId] ,  
                                Convert(nvarchar(5) ,@year)  as 'Myyear',isnull(MED.CO2,'0'),
								isnull(MED.CH4,'0'), isnull(MED.CH4_CO2e,'0'),
								isnull(MED.N2O,'0') ,isnull(MED.N2O_CO2e,'0') , 
								isnull(MED.HFC,'0'),
								isnull(MED.HFC_CO2e,'0'),	 isnull(MED.PFC,'0'),
								isnull(MED.PFC_CO2e,'0'), isnull(MED.SF6,'0') ,
								isnull(MED.SF6_CO2e,'0') , isnull(MED.Hydro,'0') ,
								isnull(MED.Tidal,'0') , isnull(MED.Wind,'0'),
								isnull(MED.Solar,'0') , isnull(MED.FossilFuelElecRed,'0'),
								isnull(MED.BioWaste,'0'), isnull(MED.BioWaste_CO2e,'0'),
								isnull(MED.Geothermal,'0'), isnull(MED.Geothermal_CO2e,'0'),
								isnull(MED.Hydro_CO2e,'0'), isnull(MED.Solar_CO2e,'0'),
								isnull(MED.Tidal_CO2e,'0'), isnull(MED.Wind_CO2e,'0'),
								 isnull(MED.FossilFuelElecRed_CO2e,'0')
								from tb_erm_Project_location_data PLD 	left join  tb_erm_Mitigation_Emissions_Data MED  
								on PLD.ProjectLocationDataId=MED.ProjectLocationDataId 
                                where PLD.ProjectLocationDataId= @ProjectLocationDataId
                                And MED.[year]=  Convert(nvarchar(5) ,@year) 
							END
				 ELSE
							begin
                              --  select @ParentId= ProjectLocationDataId   
								insert into #MyTable values (@ProjectLocationDataId,-1,@year, 0,0, 0,0,0, 0,0,0,0, 0,0, 0,0,0,0, 0, 0,0,0,0,0,0,0,0,0)

							end

					   set @year=@year+1
					end
           END
	


select  [MitigationEmissionsDataId],[ProjectLocationDataId],[Year] as 'Year',				 	
			 [CO2] as 'CO2', [CH4]	as 'CH4',
			 [CH4_CO2e]  as 'CH4-CO2e', [N2O]  as 'N2O',
			 [N2O_CO2e]  as 'N2O-CO2e', [HFC]  as 'HFC',
			 [HFC_CO2e]	  as 'HFC-CO2e', [PFC]   as 'PFC',
			 [PFC_CO2e]  as 'PFC-CO2e'	, [SF6]  as 'SF6',
			 [SF6_CO2e]	  as 'SF6-CO2e', [Hydro]  as 'Hydro',
			 [Tidal]   as 'Tidal', [Wind]  as 'Wind',
			 [Solar]  as 'Solar' , [FossilFuelElecRed]  as 'Fossil Fuel Electricity Reduction',	
			 [BioWaste] as 'BioWaste', [BioWaste_CO2e] as 'BioWasteCO2e',
			 [Geothermal] as 'Geothermal', [Geothermal_CO2e] as 'GeothermalCO2e',
			 [Hydro_CO2e] as 'HydroCO2e', [Solar_CO2e] as 'SolarCO2e',
			 [Tidal_CO2e] as 'TidalCO2e', [Wind_CO2e] as 'WindCO2e' , 
			 [FossilFuelElecRed_CO2e] as 'FossilFuelElecRedCO2e'
             from #Mytable
--select * from #Mytable
Drop table #Mytable

END

/************************************************************************************************************************************************************************************/


GO
/****** Object:  StoredProcedure [dbo].[getYearlyProject]    Script Date: 2018/12/03 07:46:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[getYearlyProject]
(
@range int
)
as Begin

select  pv.itemdisplay as 'Year' ,
(
select count (*) from  dbo.tb_erm_project_details where  StartYear<=pv.itemnum and EndYear>=pv.itemnum
and  TypeOfProject='1' and TypeOfIntervention='1' and ValidationStatus='1'
) as 'mitigation',
(
select count (*) from  dbo.tb_erm_project_details where  StartYear<=pv.itemnum and EndYear>=pv.itemnum
and  TypeOfProject='1' and TypeOfIntervention='2' and ValidationStatus='1'
) as 'Adaptation',
(
select count (*) from  dbo.tb_erm_project_details where  StartYear<=pv.itemnum and EndYear>=pv.itemnum
and  TypeOfProject='2' and ValidationStatus='1'
) as 'Research',
(
select count (*) from  dbo.tb_erm_project_details where  StartYear<=pv.itemnum and EndYear>=pv.itemnum
and ValidationStatus='1'
) as 'Total',
(
select   isnull (sum(CO2)+sum(CH4_CO2e)+sum(N2O_CO2e)+sum(HFC_CO2e)+sum(PFC_CO2e)+sum(SF6_CO2e),0)
from dbo.tb_erm_Mitigation_Emissions_Data med left join
 dbo.tb_erm_Project_Location_Data pld on med.ProjectLocationDataId=pld.ProjectLocationDataId 
and med.[Year] <= pv.itemdisplay 
left join tb_erm_project_details pd on pd.ProjectDetailsId=pld.ProjectDetailsId
where -- pd.StartYear<=pv.itemnum and pd.EndYear>=pv.itemnum and  
pd.TypeOfProject='1' and pd.TypeOfIntervention='1' and pd.ValidationStatus='1'
) as 'Co2'

from 
dbo.tb_erm_picklist_value pv where pv.listid=(select listid from tb_erm_picklist where  listname='Year') and
 pv.itemdisplay <= convert(nvarchar(4),year(getdate())+@range) and 
 pv.itemdisplay >= convert(nvarchar(4),year(getdate())-@range)

END
GO
/****** Object:  StoredProcedure [dbo].[InsertHostSector_SubSector]    Script Date: 2018/12/03 07:46:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[InsertHostSector_SubSector]
@type nvarchar(100),
@itemdisplay nvarchar(100),
@itennum int
AS begin
	declare @ListId int
		begin
			select @ListId= ListId from tb_erm_picklist where listname=@type
		end

		if not exists(select * from tb_erm_picklist_value where Itemdisplay=@itemdisplay and ListId=@ListId)
			begin
				insert into tb_erm_picklist_value(ListId,ItemDisplay,ItemNum,ItemOrder) 
				 values(@ListId,@itemdisplay,@itennum,@itennum)
			end
		else
			begin
				print @itemdisplay+' already exists'
		   end
end
GO
/****** Object:  StoredProcedure [dbo].[InsertProvinceTownData]    Script Date: 2018/12/03 07:46:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[InsertProvinceTownData]
(
@Province nvarchar(100),
@Metro nvarchar(255),
@Municipality nvarchar(255),
@Town nvarchar(255)
)
as
BEGIN
	declare @ProvinceId int
	declare @MetroId int
	declare @MunicipalityId int


	if not exists(select * from tb_erm_Province where ProvinceName=@Province)
		begin
         insert into  tb_erm_Province(ProvinceName)values(@Province)
         set @ProvinceId=Ident_current('tb_erm_Province')
		end 
	else
		begin
           select @ProvinceId=ProvinceID  from tb_erm_Province where ProvinceName=@Province
		end



	if not exists(select * from tb_erm_Metro_DistrictMunicipality where MetroName=@Metro and ProvinceID = @ProvinceId)
		begin

          if(@Municipality='')
             begin
                insert into  tb_erm_Metro_DistrictMunicipality(ProvinceID,MetroName,IsMetro)values(@ProvinceId,@Metro,-1)
                set @MetroId=Ident_current('tb_erm_Metro_DistrictMunicipality')

			 end
		  else
			 begin
              insert into  tb_erm_Metro_DistrictMunicipality(ProvinceID,MetroName,IsMetro)values(@ProvinceId,@Metro,0)
              set @MetroId=Ident_current('tb_erm_Metro_DistrictMunicipality')
			 end
         
		end 
	 else
		begin
           select @MetroId=MetroID  from tb_erm_Metro_DistrictMunicipality where MetroName=@Metro and ProvinceID = @ProvinceId 
		end


   if(@Municipality <>'')
      begin
		 if not exists(select * from tb_erm_Local_Municipalities where LocalMunicipalityName=@Municipality)
			begin
			 insert into  tb_erm_Local_Municipalities(ProvinceID,MetroID,LocalMunicipalityName)values(@ProvinceID,@MetroId,@Municipality)
			 set @MunicipalityId=Ident_current('tb_erm_Local_Municipalities')
			end 
		else
			begin
			   select @MunicipalityId=LocalMunicipalityID from tb_erm_Local_Municipalities where LocalMunicipalityName=@Municipality
                       and MetroID=@MetroId and ProvinceID=@ProvinceID
			end
      end

  

--towns
	if(@Town<>'')
	begin
	   if(@Municipality='')
			begin
					 if not exists(select * from tb_erm_Town where TownName=@Town and MetroID=@MetroId)
							begin 
							   insert into  tb_erm_Town( ProvinceID,IsUnderMetro,MetroID,LocalMunicipalityID,TownName)
								 values( @ProvinceID,-1,@MetroId,0,@Town)
							end
					else
						   begin
							 print 'Town='+ @Town --+' MetroId='+@Metro+' MunicipalityId='+@Municipality+' Provinceid='+@Province
						   end
			end
		else
			begin
					if not exists(select * from tb_erm_Town where TownName=@Town and LocalMunicipalityID=@MunicipalityId and MetroID=@MetroId)
							begin 
							   insert into  tb_erm_Town(ProvinceID,IsUnderMetro,MetroID,LocalMunicipalityID,TownName)
								 values(@ProvinceID, 0,@MetroId,@MunicipalityId,@Town)
							end
					else
						  begin
							print 'Town='+ @Town --+' MetroId='+@Metro+' MunicipalityId='+@Municipality+' Provinceid='+@Province
						  end
			end
	   end
END

--------------------------------------------------------------------------------------------------------------------	
--[MSM-20090127] Resolved issue# 20875

IF NOT EXISTS (SELECT * FROM SYSCOLUMNS WHERE  NAME ='VALIDATIONCOMMENTS' AND OBJECT_NAME(ID)='TB_ERM_PROJECT_DETAILS')
BEGIN
	ALTER TABLE TB_ERM_PROJECT_DETAILS ADD VALIDATIONCOMMENTS NVARCHAR (255)
END
GO
/****** Object:  StoredProcedure [dbo].[ProcInserFreeState]    Script Date: 2018/12/03 07:46:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


create procedure [dbo].[ProcInserFreeState]
(
@Province nvarchar(100),
@Metro nvarchar(255),
@LocalMunicipality nvarchar(255),
@Town nvarchar(255)
)
AS BEGIN

	declare @ProvinceId int
	declare @MetroId int
	declare @MunicipalityId int
    declare @TownId int

--PROVINCE
	  if not exists(select * from tb_erm_Province where ProvinceName=@Province)
		begin
          insert into  tb_erm_Province(ProvinceName)values(@Province)
           set @ProvinceId=Ident_current('tb_erm_Province')
		end 
	  else
		begin
           select @ProvinceId=ProvinceID  from tb_erm_Province where ProvinceName=@Province
		end
       print @ProvinceId
--METRO
       if not exists(select * from tb_erm_Metro_DistrictMunicipality where MetroName=@Metro)
		 begin
			insert into  tb_erm_Metro_DistrictMunicipality(ProvinceID,MetroName,IsMetro)values(@ProvinceId,@Metro,0)
			set @MetroId=Ident_current('tb_erm_Metro_DistrictMunicipality')
         end
       else
         begin
		    select @MetroId=MetroID from tb_erm_Metro_DistrictMunicipality where  MetroName=@Metro
	     end
           print @MetroId
       begin
			update  tb_erm_Metro_DistrictMunicipality
			set  ProvinceID=@ProvinceId
			where  MetroID=@MetroId
       end

--LOCAL MUNICIPALITY

        if not exists(select * from tb_erm_Local_Municipalities where LocalMunicipalityName=@LocalMunicipality)
			begin
				insert into  tb_erm_Local_Municipalities(ProvinceID,MetroID,LocalMunicipalityName)values(@ProvinceID,@MetroId,@LocalMunicipality)
				set @MunicipalityId=Ident_current('tb_erm_Local_Municipalities')
			end 
		else
			begin
				select @MunicipalityId=LocalMunicipalityID from tb_erm_Local_Municipalities where LocalMunicipalityName=@LocalMunicipality
				and MetroID=@MetroId 
				
			end
                  print @MunicipalityId
            begin
				update  tb_erm_Local_Municipalities
				set  ProvinceID=@ProvinceId, MetroID=@MetroId
				where LocalMunicipalityID= @MunicipalityId
            end


--TOWN

		if not exists(select * from tb_erm_Town where TownName=@Town and LocalMunicipalityID=@MunicipalityId and MetroID=@MetroId)
			begin 
				insert into  tb_erm_Town(ProvinceID,IsUnderMetro,MetroID,LocalMunicipalityID,TownName)
				values(@ProvinceID, 0,@MetroId,@MunicipalityId,@Town)
			end
		else
			begin
                select @TownId= TownID from tb_erm_Town where TownName=@Town
              
			end
                 print @TownId
            begin
                update tb_erm_Town 
				set 
				ProvinceID =@ProvinceId,
				LocalMunicipalityID =@MunicipalityId,
                MetroID=@MetroId 
				where TownName=@Town  and   MetroID=@MetroId and LocalMunicipalityID =@MunicipalityId
			end



END

GO
/****** Object:  StoredProcedure [dbo].[sp_insert_obj_roles]    Script Date: 2018/12/03 07:46:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[sp_insert_obj_roles]

(

	@ObjID int

)

AS

DECLARE @RoleID as int

DECLARE curRoles CURSOR FOR SELECT RoleID FROM tb_erm_roles

OPEN curRoles

FETCH NEXT FROM curRoles INTO @RoleID

WHILE @@fetch_status = 0

BEGIN

	IF NOT( EXISTS( SELECT * FROM tb_erm_obj_roles WHERE RoleID = @RoleID AND ObjID =@ObjID ) )

	BEGIN
		IF(@RoleID = 10000 or (@RoleID = 10002 and @ObjID = 10008))		
			BEGIN
				INSERT INTO tb_erm_obj_roles(ROLEID,OBJID,ADDPERM,READPERM,DELETEPERM,UPDATEPERM)VALUES(@RoleID, @ObjID , -1 , -1, -1, -1)
			END		
			ELSE
			BEGIN
				INSERT INTO tb_erm_obj_roles(ROLEID,OBJID,ADDPERM,READPERM,DELETEPERM,UPDATEPERM)VALUES(@RoleID, @ObjID , 0 , -1 , 0, 0)		
			END		

	END
	FETCH NEXT FROM curRoles INTO @RoleID

END
CLOSE curRoles
DEALLOCATE curRoles
GO
/****** Object:  StoredProcedure [dbo].[stp_insertMitigation_MainSubSector_SubSector]    Script Date: 2018/12/03 07:46:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





create procedure  [dbo].[stp_insertMitigation_MainSubSector_SubSector]  
(
@HostSector nvarchar(100),
@HostMainSubSector nvarchar(100),
@HostSubSector nvarchar(100)
)
as
BEGIN
declare @itemnum int
declare @MainSubSectorid int

select @itemnum=itemnum from tb_erm_picklist_value where ListId=(select ListId from dbo.tb_erm_picklist where ListName='Host Sector')
and ItemDisplay= @HostSector


--if(not isnull(@itemnum))
	begin
	   IF NOT( EXISTS( SELECT * FROM tb_erm_Mitigation_MainSubSector WHERE  MainSubSectorType =@HostMainSubSector and HostSectorId=@itemnum )  )
			begin
			INSERT INTO tb_erm_Mitigation_MainSubSector(HostSectorId,MainSubSectorType)
			VALUES(@itemnum,@HostMainSubSector)
			select @MainSubSectorid= IDENT_CURRENT('tb_erm_Mitigation_MainSubSector')
			end
		else
			begin
			SELECT @MainSubSectorid=MainSubSectorId FROM tb_erm_Mitigation_MainSubSector WHERE  MainSubSectorType =@HostMainSubSector and HostSectorId=@itemnum 
			end
	   
	end


	if(@HostSubSector <> '')
		begin
			IF NOT( EXISTS( SELECT * FROM tb_erm_Mitigation_SubSector WHERE  SubSectorType =@HostSubSector and MainSubSectorId=@MainSubSectorid )  )
					begin
						INSERT INTO tb_erm_Mitigation_SubSector(MainSubSectorId,SubSectorType)
						VALUES(@MainSubSectorid,@HostSubSector)
					end
				else
					begin
						print @HostSubSector + ' already exists' + @HostMainSubSector
					end
		end

 END


GO
/****** Object:  StoredProcedure [dbo].[stp_insertProSubType]    Script Date: 2018/12/03 07:46:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



create procedure [dbo].[stp_insertProSubType]
(
@projecttype nvarchar(100),
@Subtype nvarchar(100)
)
as
BEGIN

declare @itemnum int

select @itemnum=itemnum from tb_erm_picklist_value where ListId=(select ListId from dbo.tb_erm_picklist where ListName='Type of Project')
and ItemDisplay= @projecttype


--if(not isnull(@itemnum))
	begin
	   IF NOT( EXISTS( SELECT * FROM tb_erm_Project_SubType WHERE  ProjectSubType =@Subtype and ProjectTypeId=@itemnum )  )
			begin
			INSERT INTO tb_erm_Project_SubType(ProjectTypeId,ProjectSubType)
			VALUES(@itemnum,@Subtype)
			end
		else
			begin
			print @Subtype + ' already exists'
			end
	   END
	end
--else
 -- begin
--print 'Project '+@projecttype+' does not exist'
   --end

GO
/****** Object:  StoredProcedure [dbo].[Stp_UpdateProjectManager]    Script Date: 2018/12/03 07:46:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


create procedure [dbo].[Stp_UpdateProjectManager]
(
@ProjectIden nvarchar(100),
@Email nvarchar(100)
)
AS BEGIN
declare @userid int
declare @projectid int
  print  @Email
	if exists(select * from  tb_erm_appusers where AppUserName=@Email)
		begin
			select @userid=AppUserID from   tb_erm_appusers where AppUserName=@Email
		end
	else
		begin 
			print @Email+' does not Exists'
			set  @userid=0
		end

   if(@userid <>0)
	   begin

           if  exists(select * from  tb_erm_project_details where ProjectDetailsIdentifier=@ProjectIden)
            begin
		        update tb_erm_project_details set ProjectManager= @userid 
                where ProjectDetailsIdentifier=@ProjectIden
			end
		else
			begin 
              print 'project with identifier '+@ProjectIden+' does not exists'
			end
	   end



END

GO
/****** Object:  StoredProcedure [dbo].[UpdateMitigationData]    Script Date: 2018/12/03 07:46:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[UpdateMitigationData]
 @Syear int,
 @Eyear int,
 @ProjectDetailID int
as
begin
	If exists (select * from tb_erm_Mitigation_Emissions_Data where([year]< @Syear or [year]> @Eyear)
	and ProjectLocationDataId in (select ProjectLocationDataId
	from dbo.tb_erm_Project_Location_Data where ProjectDetailsId=@ProjectDetailID))
	begin 
			update tb_erm_Mitigation_Emissions_Data
			set CO2 = 0,CH4 =0,CH4_CO2e =0 ,N2O=0,N2O_CO2e=0,HFC=0,HFC_CO2e=0,PFC=0,PFC_CO2e=0,
			SF6=0,SF6_CO2e =0,Hydro=0,Tidal=0,Wind=0,Solar=0,FossilFuelElecRed=0,
			BioWaste=0,BioWaste_CO2e=0,Geothermal=0,Geothermal_CO2e=0,Hydro_CO2e=0,
			Solar_CO2e=0,Tidal_CO2e=0,Wind_CO2e=0 
			where ([year]< @Syear or [year]> @Eyear) and 
			ProjectLocationDataId in (select ProjectLocationDataId
			from dbo.tb_erm_Project_Location_Data where ProjectDetailsId=@ProjectDetailID)
	end
end
GO
/****** Object:  Trigger [dbo].[tI_tb_erm_announcement]    Script Date: 2018/12/03 07:46:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tI_tb_erm_announcement] ON [dbo].[tb_erm_announcement] FOR INSERT AS
	BEGIN
		DECLARE @NUMROWS INT,
		@NULLCNT INT,
		@VALIDCNT INT,
		@ERRNO   INT,
		@ERRMSG  NVARCHAR(255),
		@USRID NVARCHAR(255)

		SELECT @NUMROWS = @@ROWCOUNT
		/* UPDATE USER NAME AND TIME */
		UPDATE tb_erm_announcement SET /* UpdtUsr = SUSER_SNAME(), */ UpdtTime = GETDATE()
		FROM tb_erm_announcement, INSERTED WHERE tb_erm_announcement.AnnouncementID = INSERTED.AnnouncementID
		RETURN
		ERROR:
		RAISERROR @ERRNO @ERRMSG
		ROLLBACK TRANSACTION
	END
GO
ALTER TABLE [dbo].[tb_erm_announcement] ENABLE TRIGGER [tI_tb_erm_announcement]
GO
/****** Object:  Trigger [dbo].[tU_tb_erm_announcement]    Script Date: 2018/12/03 07:46:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tU_tb_erm_announcement] ON [dbo].[tb_erm_announcement] FOR UPDATE AS
	BEGIN
		DECLARE @NUMROWS INT,
		@NULLCNT INT,
		@VALIDCNT INT,
		@ERRNO   INT,
		@ERRMSG  NVARCHAR(255),
		@COUNT   INT

		SELECT @NUMROWS = @@ROWCOUNT
		/* UPDATE USER NAME AND TIME */
		UPDATE tb_erm_announcement SET
		/*UPDTUSER = suser_sname(),*/
		UPDTTIME = GETDATE()
		FROM tb_erm_announcement, INSERTED WHERE tb_erm_announcement.AnnouncementID = INSERTED.AnnouncementID		
		RETURN
		ERROR:
		RAISERROR @ERRNO @ERRMSG
		ROLLBACK TRANSACTION
	END
	
GO
ALTER TABLE [dbo].[tb_erm_announcement] ENABLE TRIGGER [tU_tb_erm_announcement]
GO
/****** Object:  Trigger [dbo].[tI_tb_erm_appusers]    Script Date: 2018/12/03 07:46:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tI_tb_erm_appusers] ON [dbo].[tb_erm_appusers] FOR INSERT AS
	BEGIN
		DECLARE @NUMROWS INT,
		@NULLCNT INT,
		@VALIDCNT INT,
		@ERRNO   INT,
		@ERRMSG  NVARCHAR(255),
		@usrid nvarchar(255)
		
		SELECT @NUMROWS = @@ROWCOUNT
		/* UPDATE USER NAME AND TIME */
		UPDATE tb_erm_appusers SET /* UpdtUsr = SUSER_SNAME(), */ UpdtTime = GETDATE()
		FROM tb_erm_appusers, INSERTED WHERE tb_erm_appusers.AppUserID = INSERTED.AppUserID
		RETURN
		ERROR:
		RAISERROR @ERRNO @ERRMSG
		ROLLBACK TRANSACTION
	END
GO
ALTER TABLE [dbo].[tb_erm_appusers] ENABLE TRIGGER [tI_tb_erm_appusers]
GO
/****** Object:  Trigger [dbo].[tU_tb_erm_appusers]    Script Date: 2018/12/03 07:46:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tU_tb_erm_appusers] ON [dbo].[tb_erm_appusers] FOR UPDATE AS 
	BEGIN
		DECLARE @NUMROWS INT,
		@NULLCNT INT,
		@VALIDCNT INT,
		@ERRNO   INT,
		@ERRMSG  NVARCHAR(255),
		@COUNT   INT

		SELECT @NUMROWS = @@ROWCOUNT
		/* UPDATE USER NAME AND TIME */
		UPDATE tb_erm_appusers SET
		/*UPDTUSER = suser_sname(),*/
		UPDTTIME = GETDATE()
		FROM tb_erm_appusers, INSERTED WHERE tb_erm_appusers.AppUserID = INSERTED.AppUserID
		RETURN
		ERROR:
		RAISERROR @ERRNO @ERRMSG
		ROLLBACK TRANSACTION
	END	
GO
ALTER TABLE [dbo].[tb_erm_appusers] ENABLE TRIGGER [tU_tb_erm_appusers]
GO
/****** Object:  Trigger [dbo].[tI_tb_erm_audit_log]    Script Date: 2018/12/03 07:46:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tI_tb_erm_audit_log] ON [dbo].[tb_erm_audit_log] FOR INSERT AS
BEGIN
	DECLARE @NUMROWS INT,
	@NULLCNT INT,
	@VALIDCNT INT,
	@ERRNO   INT,
	@ERRMSG  NVARCHAR(255),
	@usrid nvarchar(255)
	
	SELECT @NUMROWS = @@ROWCOUNT
	/* UPDATE USER NAME AND TIME */
	UPDATE tb_erm_audit_log SET /* UpdtUsr = SUSER_SNAME(), */ UpdtTime = GETDATE()
	FROM tb_erm_audit_log, INSERTED WHERE tb_erm_audit_log.AuditLogID = INSERTED.AuditLogID
	RETURN
	ERROR:
	RAISERROR @ERRNO @ERRMSG
	ROLLBACK TRANSACTION
END
GO
ALTER TABLE [dbo].[tb_erm_audit_log] ENABLE TRIGGER [tI_tb_erm_audit_log]
GO
/****** Object:  Trigger [dbo].[tU_tb_erm_audit_log]    Script Date: 2018/12/03 07:46:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tU_tb_erm_audit_log] ON [dbo].[tb_erm_audit_log] FOR UPDATE AS 
BEGIN
	DECLARE @NUMROWS INT,
	@NULLCNT INT,
	@VALIDCNT INT,
	@ERRNO   INT,
	@ERRMSG  NVARCHAR(255),
	@COUNT   INT

	SELECT @NUMROWS = @@ROWCOUNT
	/* UPDATE USER NAME AND TIME */
	UPDATE tb_erm_audit_log SET
	/*UPDTUSER = suser_sname(),*/
	UPDTTIME = GETDATE()
	FROM tb_erm_audit_log, INSERTED WHERE tb_erm_audit_log.AuditLogID = INSERTED.AuditLogID
	RETURN
	ERROR:
	RAISERROR @ERRNO @ERRMSG
	ROLLBACK TRANSACTION
END	
GO
ALTER TABLE [dbo].[tb_erm_audit_log] ENABLE TRIGGER [tU_tb_erm_audit_log]
GO
/****** Object:  Trigger [dbo].[tI_tb_erm_Cultures]    Script Date: 2018/12/03 07:46:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

	CREATE TRIGGER [dbo].[tI_tb_erm_Cultures] ON [dbo].[tb_erm_Cultures] FOR INSERT AS
	BEGIN
		DECLARE @NUMROWS INT,
		@NULLCNT INT,
		@VALIDCNT INT,
		@ERRNO   INT,
		@ERRMSG  NVARCHAR(255),
		@usrid nvarchar(255)
		
		SELECT @NUMROWS = @@ROWCOUNT
		/* UPDATE USER NAME AND TIME */
		UPDATE tb_erm_Cultures SET /* UpdtUsr = SUSER_SNAME(), */ UpdtTime = GETDATE()
		FROM tb_erm_Cultures, INSERTED WHERE tb_erm_Cultures.CultureID = INSERTED.CultureID
		RETURN
		ERROR:
		RAISERROR @ERRNO @ERRMSG
		ROLLBACK TRANSACTION
	END
GO
ALTER TABLE [dbo].[tb_erm_Cultures] ENABLE TRIGGER [tI_tb_erm_Cultures]
GO
/****** Object:  Trigger [dbo].[tU_tb_erm_Cultures]    Script Date: 2018/12/03 07:46:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

	CREATE TRIGGER [dbo].[tU_tb_erm_Cultures] ON [dbo].[tb_erm_Cultures] FOR UPDATE AS 
	BEGIN
		DECLARE @NUMROWS INT,
		@NULLCNT INT,
		@VALIDCNT INT,
		@ERRNO   INT,
		@ERRMSG  NVARCHAR(255),
		@COUNT   INT

		SELECT @NUMROWS = @@ROWCOUNT
		/* UPDATE USER NAME AND TIME */
		UPDATE tb_erm_Cultures SET
		/*UPDTUSER = suser_sname(),*/
		UPDTTIME = GETDATE()
		FROM tb_erm_Cultures, INSERTED WHERE tb_erm_Cultures.CultureID = INSERTED.CultureID
		RETURN
		ERROR:
		RAISERROR @ERRNO @ERRMSG
		ROLLBACK TRANSACTION
	END	
GO
ALTER TABLE [dbo].[tb_erm_Cultures] ENABLE TRIGGER [tU_tb_erm_Cultures]
GO
/****** Object:  Trigger [dbo].[tI_tb_erm_Languages]    Script Date: 2018/12/03 07:46:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

	CREATE TRIGGER [dbo].[tI_tb_erm_Languages] ON [dbo].[tb_erm_Languages] FOR INSERT AS
	BEGIN
		DECLARE @NUMROWS INT,
		@NULLCNT INT,
		@VALIDCNT INT,
		@ERRNO   INT,
		@ERRMSG  NVARCHAR(255),
		@usrid nvarchar(255)
		
		SELECT @NUMROWS = @@ROWCOUNT
		/* UPDATE USER NAME AND TIME */
		UPDATE tb_erm_Languages SET /* UpdtUsr = SUSER_SNAME(), */ UpdtTime = GETDATE()
		FROM tb_erm_Languages, INSERTED WHERE tb_erm_Languages.LangID = INSERTED.LangID
		RETURN
		ERROR:
		RAISERROR @ERRNO @ERRMSG
		ROLLBACK TRANSACTION
	END
GO
ALTER TABLE [dbo].[tb_erm_Languages] ENABLE TRIGGER [tI_tb_erm_Languages]
GO
/****** Object:  Trigger [dbo].[tU_tb_erm_Languages]    Script Date: 2018/12/03 07:46:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

	CREATE TRIGGER [dbo].[tU_tb_erm_Languages] ON [dbo].[tb_erm_Languages] FOR UPDATE AS 
	BEGIN
		DECLARE @NUMROWS INT,
		@NULLCNT INT,
		@VALIDCNT INT,
		@ERRNO   INT,
		@ERRMSG  NVARCHAR(255),
		@COUNT   INT

		SELECT @NUMROWS = @@ROWCOUNT
		/* UPDATE USER NAME AND TIME */
		UPDATE tb_erm_Cultures SET
		/*UPDTUSER = suser_sname(),*/
		UPDTTIME = GETDATE()
		FROM tb_erm_Languages, INSERTED WHERE tb_erm_Languages.LangID = INSERTED.LangID
		RETURN
		ERROR:
		RAISERROR @ERRNO @ERRMSG
		ROLLBACK TRANSACTION
	END	
GO
ALTER TABLE [dbo].[tb_erm_Languages] ENABLE TRIGGER [tU_tb_erm_Languages]
GO
/****** Object:  Trigger [dbo].[tI_tb_erm_Local_Municipalities]    Script Date: 2018/12/03 07:46:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

	CREATE TRIGGER [dbo].[tI_tb_erm_Local_Municipalities] ON [dbo].[tb_erm_Local_Municipalities] FOR INSERT AS
	BEGIN
		DECLARE @NUMROWS INT,
		@NULLCNT INT,
		@VALIDCNT INT,
		@ERRNO   INT,
		@ERRMSG  NVARCHAR(255),
		@usrid nvarchar(255)
		
		SELECT @NUMROWS = @@ROWCOUNT
		/* UPDATE USER NAME AND TIME */
		UPDATE tb_erm_Local_Municipalities SET /* UpdtUsr = SUSER_SNAME(), */ UpdtTime = GETDATE()
		FROM tb_erm_Local_Municipalities, INSERTED WHERE tb_erm_Local_Municipalities.LocalMunicipalityID = INSERTED.LocalMunicipalityID
		RETURN
		ERROR:
		RAISERROR @ERRNO @ERRMSG
		ROLLBACK TRANSACTION
	END
GO
ALTER TABLE [dbo].[tb_erm_Local_Municipalities] ENABLE TRIGGER [tI_tb_erm_Local_Municipalities]
GO
/****** Object:  Trigger [dbo].[tU_tb_erm_Local_Municipalities]    Script Date: 2018/12/03 07:46:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

	CREATE TRIGGER [dbo].[tU_tb_erm_Local_Municipalities] ON [dbo].[tb_erm_Local_Municipalities] FOR UPDATE AS 
	BEGIN
		DECLARE @NUMROWS INT,
		@NULLCNT INT,
		@VALIDCNT INT,
		@ERRNO   INT,
		@ERRMSG  NVARCHAR(255),
		@COUNT   INT

		SELECT @NUMROWS = @@ROWCOUNT
		/* UPDATE USER NAME AND TIME */
		UPDATE tb_erm_Local_Municipalities SET
		/*UPDTUSER = suser_sname(),*/
		UPDTTIME = GETDATE()
		FROM tb_erm_Local_Municipalities, INSERTED WHERE tb_erm_Local_Municipalities.LocalMunicipalityID = INSERTED.LocalMunicipalityID
		RETURN
		ERROR:
		RAISERROR @ERRNO @ERRMSG
		ROLLBACK TRANSACTION
	END	
GO
ALTER TABLE [dbo].[tb_erm_Local_Municipalities] ENABLE TRIGGER [tU_tb_erm_Local_Municipalities]
GO
/****** Object:  Trigger [dbo].[tI_tb_erm_Metro_DistrictMunicipality]    Script Date: 2018/12/03 07:46:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

	CREATE TRIGGER [dbo].[tI_tb_erm_Metro_DistrictMunicipality] ON [dbo].[tb_erm_Metro_DistrictMunicipality] FOR INSERT AS
	BEGIN
		DECLARE @NUMROWS INT,
		@NULLCNT INT,
		@VALIDCNT INT,
		@ERRNO   INT,
		@ERRMSG  NVARCHAR(255),
		@usrid nvarchar(255)
		
		SELECT @NUMROWS = @@ROWCOUNT
		/* UPDATE USER NAME AND TIME */
		UPDATE tb_erm_Metro_DistrictMunicipality SET /* UpdtUsr = SUSER_SNAME(), */ UpdtTime = GETDATE()
		FROM tb_erm_Metro_DistrictMunicipality, INSERTED WHERE tb_erm_Metro_DistrictMunicipality.MetroID = INSERTED.MetroID
		RETURN
		ERROR:
		RAISERROR @ERRNO @ERRMSG
		ROLLBACK TRANSACTION
	END
GO
ALTER TABLE [dbo].[tb_erm_Metro_DistrictMunicipality] ENABLE TRIGGER [tI_tb_erm_Metro_DistrictMunicipality]
GO
/****** Object:  Trigger [dbo].[tU_tb_erm_Metro_DistrictMunicipality]    Script Date: 2018/12/03 07:46:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

	CREATE TRIGGER [dbo].[tU_tb_erm_Metro_DistrictMunicipality] ON [dbo].[tb_erm_Metro_DistrictMunicipality] FOR UPDATE AS 
	BEGIN
		DECLARE @NUMROWS INT,
		@NULLCNT INT,
		@VALIDCNT INT,
		@ERRNO   INT,
		@ERRMSG  NVARCHAR(255),
		@COUNT   INT

		SELECT @NUMROWS = @@ROWCOUNT
		/* UPDATE USER NAME AND TIME */
		UPDATE tb_erm_Metro_DistrictMunicipality SET
		/*UPDTUSER = suser_sname(),*/
		UPDTTIME = GETDATE()
		FROM tb_erm_Metro_DistrictMunicipality, INSERTED WHERE tb_erm_Metro_DistrictMunicipality.MetroID = INSERTED.MetroID
		RETURN
		ERROR:
		RAISERROR @ERRNO @ERRMSG
		ROLLBACK TRANSACTION
	END	
GO
ALTER TABLE [dbo].[tb_erm_Metro_DistrictMunicipality] ENABLE TRIGGER [tU_tb_erm_Metro_DistrictMunicipality]
GO
/****** Object:  Trigger [dbo].[tI_tb_erm_Metro_DistrictMunicipality_lat_long]    Script Date: 2018/12/03 07:46:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tI_tb_erm_Metro_DistrictMunicipality_lat_long] ON [dbo].[tb_erm_Metro_DistrictMunicipality_lat_long] FOR INSERT AS
	BEGIN
		DECLARE @NUMROWS INT,
		@NULLCNT INT,
		@VALIDCNT INT,
		@ERRNO   INT,
		@ERRMSG  NVARCHAR(255),
		@USRID NVARCHAR(255)

		SELECT @NUMROWS = @@ROWCOUNT
		/* UPDATE USER NAME AND TIME */
		UPDATE tb_erm_Metro_DistrictMunicipality_lat_long SET  UpdtTime = GETDATE()
		FROM tb_erm_Metro_DistrictMunicipality_lat_long, INSERTED WHERE tb_erm_Metro_DistrictMunicipality_lat_long.MetroDistrictMunicipalityLatLongId = INSERTED.MetroDistrictMunicipalityLatLongId
		RETURN
		ERROR:
		RAISERROR @ERRNO @ERRMSG
		ROLLBACK TRANSACTION
	END
GO
ALTER TABLE [dbo].[tb_erm_Metro_DistrictMunicipality_lat_long] ENABLE TRIGGER [tI_tb_erm_Metro_DistrictMunicipality_lat_long]
GO
/****** Object:  Trigger [dbo].[tU_tb_erm_Metro_DistrictMunicipality_lat_long]    Script Date: 2018/12/03 07:46:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tU_tb_erm_Metro_DistrictMunicipality_lat_long] ON [dbo].[tb_erm_Metro_DistrictMunicipality_lat_long] FOR UPDATE AS
	BEGIN
		DECLARE @NUMROWS INT,
		@NULLCNT INT,
		@VALIDCNT INT,
		@ERRNO   INT,
		@ERRMSG  NVARCHAR(255),
		@COUNT   INT

		SELECT @NUMROWS = @@ROWCOUNT
		UPDATE tb_erm_Metro_DistrictMunicipality_lat_long SET
			UPDTTIME = GETDATE()
		FROM tb_erm_Metro_DistrictMunicipality_lat_long, INSERTED WHERE tb_erm_Metro_DistrictMunicipality_lat_long.MetroDistrictMunicipalityLatLongId  = INSERTED.MetroDistrictMunicipalityLatLongId
		RETURN
		ERROR:
		RAISERROR @ERRNO @ERRMSG
		ROLLBACK TRANSACTION
	END

GO
ALTER TABLE [dbo].[tb_erm_Metro_DistrictMunicipality_lat_long] ENABLE TRIGGER [tU_tb_erm_Metro_DistrictMunicipality_lat_long]
GO
/****** Object:  Trigger [dbo].[td_tb_erm_mitigation_details]    Script Date: 2018/12/03 07:46:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[td_tb_erm_mitigation_details] ON [dbo].[tb_erm_mitigation_details]  AFTER DELETE  AS
BEGIN	
declare @Id int
select @Id=MitigationDetailsId from Deleted
delete from dbo.tb_erm_audit_log where PkId=@id and TableName='tb_erm_mitigation_details'
END
GO
ALTER TABLE [dbo].[tb_erm_mitigation_details] ENABLE TRIGGER [td_tb_erm_mitigation_details]
GO
/****** Object:  Trigger [dbo].[tI_tb_erm_mitigation_details]    Script Date: 2018/12/03 07:46:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tI_tb_erm_mitigation_details] ON [dbo].[tb_erm_mitigation_details] FOR INSERT AS
	BEGIN
		DECLARE @NUMROWS INT,
		@NULLCNT INT,
		@VALIDCNT INT,
		@ERRNO   INT,
		@ERRMSG  NVARCHAR(255),
		@USRID NVARCHAR(255)

		SELECT @NUMROWS = @@ROWCOUNT
		/* UPDATE USER NAME AND TIME */
		UPDATE tb_erm_mitigation_details SET  UpdtTime = GETDATE()
		FROM tb_erm_mitigation_details, INSERTED WHERE tb_erm_mitigation_details.MitigationDetailsId = INSERTED.MitigationDetailsId
		

         --to update time in project details table
        UPDATE tb_erm_project_details  SET  UpdtTime = GETDATE()
		FROM tb_erm_mitigation_details, INSERTED WHERE tb_erm_project_details.ProjectDetailsId = INSERTED.ProjectDetailsId
   


       RETURN
		ERROR:
		RAISERROR @ERRNO @ERRMSG
		ROLLBACK TRANSACTION
	END
GO
ALTER TABLE [dbo].[tb_erm_mitigation_details] ENABLE TRIGGER [tI_tb_erm_mitigation_details]
GO
/****** Object:  Trigger [dbo].[tU_tb_erm_mitigation_details]    Script Date: 2018/12/03 07:46:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tU_tb_erm_mitigation_details] ON [dbo].[tb_erm_mitigation_details] FOR UPDATE AS
	BEGIN
		DECLARE @NUMROWS INT,
		@NULLCNT INT,
		@VALIDCNT INT,
		@ERRNO   INT,
		@ERRMSG  NVARCHAR(255),
		@COUNT   INT,
		@MitigationDetailsId INT,
		@UPDTUSER nvarchar(50),
		
		@Old_ProjectType nvarchar(100),
		@New_ProjectType nvarchar(100),

		@Old_ProjectSubType nvarchar(100),
		@New_ProjectSubType nvarchar(100),

		@Old_HostSector nvarchar(100),
		@New_HostSector nvarchar(100),

		@Old_HostMainSubSector nvarchar(100),
		@New_HostMainSubSector nvarchar(100),

		@Old_HostSubSector nvarchar(100),
		@New_HostSubSector nvarchar(100),

		@Old_ExecutiveStatus nvarchar(100),
		@New_ExecutiveStatus nvarchar(100),

		@Old_CarbonCredit nvarchar(100),
		@New_CarbonCredit nvarchar(100),

		@Old_CarbonCreditMarket nvarchar(100),
		@New_CarbonCreditMarket nvarchar(100),

		@Old_CDMStatus nvarchar(100),
		@New_CDMStatus nvarchar(100),

		@Old_CDMMethodoloy nvarchar(100),
		@New_CDMMethodoloy nvarchar(100),

		@Old_VolMethodoloy nvarchar(100),
		@New_VolMethodoloy nvarchar(100),

		@Old_GoldStandard nvarchar(100),
		@New_GoldStandard nvarchar(100),

		@Old_VCS nvarchar(100),
		@New_VCS nvarchar(100),

		@Old_Other nvarchar(100),
		@New_Other nvarchar(100),

		@Old_otherDesc nvarchar(200),
		@New_otherDesc nvarchar(200),

		@OLDVALUE VARCHAR(100),
		@NEWVALUE VARCHAR(100),


        @OLDCDMProjectNumber VARCHAR(100),
		@NEWCDMProjectNumber VARCHAR(100),

		@ProjectDetailsId int

		SELECT @NUMROWS = @@ROWCOUNT
		UPDATE tb_erm_mitigation_details SET
			UPDTTIME = GETDATE()
		FROM tb_erm_mitigation_details, INSERTED WHERE tb_erm_mitigation_details.MitigationDetailsId  = tb_erm_mitigation_details.MitigationDetailsId
		

       -- UPDATE TIME IN PROJECT DETAILS TABLE
        UPDATE tb_erm_project_details  SET  UpdtTime = GETDATE()
		FROM tb_erm_mitigation_details, INSERTED WHERE tb_erm_project_details.ProjectDetailsId = INSERTED.ProjectDetailsId



  		select @UPDTUSER = inserted.UpdtUser, @MitigationDetailsId = deleted.MitigationDetailsId,@ProjectDetailsId=deleted.ProjectDetailsId,
			@Old_ProjectType = deleted.ProjectType, @New_ProjectType = inserted.ProjectType,
			@Old_ProjectSubType = deleted.ProjectSubType, @New_ProjectSubType = inserted.ProjectSubType,
			@Old_HostSector = deleted.HostSector, @New_HostSector = inserted.HostSector,
			@Old_HostMainSubSector = deleted.HostMainSubSector, @New_HostMainSubSector = inserted.HostMainSubSector,
			@Old_HostSubSector = deleted.HostSubSector, @New_HostSubSector = inserted.HostSubSector,
			@Old_ExecutiveStatus = deleted.ExecutiveStatus, @New_ExecutiveStatus = inserted.ExecutiveStatus,
			@Old_CarbonCredit = deleted.CarbonCredit, @New_CarbonCredit = inserted.CarbonCredit,
			@Old_CarbonCreditMarket = deleted.CarbonCreditMarket, @New_CarbonCreditMarket = inserted.CarbonCreditMarket,			
			@Old_CDMStatus = deleted.CDMStatus, @New_CDMStatus = inserted.CDMStatus,
			@Old_CDMMethodoloy = deleted.CDMMethodoloy, @New_CDMMethodoloy = inserted.CDMMethodoloy,
			@Old_VolMethodoloy = deleted.VolMethodoloy, @New_VolMethodoloy = inserted.VolMethodoloy,
			@Old_GoldStandard = deleted.GoldStandard, @New_GoldStandard = inserted.GoldStandard,
			@Old_VCS = deleted.VCS, @New_VCS = inserted.VCS,	
			@Old_Other = deleted.Other, @New_Other = inserted.Other,
			@Old_otherDesc = deleted.otherDesc, @New_otherDesc = inserted.otherDesc,
			@OLDCDMProjectNumber=deleted.CDMProjectNumber,@NEWCDMProjectNumber=inserted.CDMProjectNumber
		from inserted,deleted
	
	IF EXISTS(select * from tb_erm_project_details where validationstatus in (select itemnum from tb_erm_picklist_value where listid in 
		(select listid from tb_erm_picklist where listname like 'DEAT Validation Status') and Itemdisplay like 'Accepted') and ProjectDetailsId= @ProjectDetailsId)
	BEGIN
		IF NOT (@Old_ProjectType = @New_ProjectType)
		BEGIN
			
			SET @OLDVALUE=(SELECT ITEMDISPLAY FROM TB_ERM_PICKLIST_VALUE WHERE LISTID=(SELECT LISTID FROM TB_ERM_PICKLIST WHERE LISTNAME='Type of Project') AND ITEMNUM=@Old_ProjectType)
			SET @NEWVALUE=(SELECT ITEMDISPLAY FROM TB_ERM_PICKLIST_VALUE WHERE LISTID=(SELECT LISTID FROM TB_ERM_PICKLIST WHERE LISTNAME='Type of Project') AND ITEMNUM=@New_ProjectType)

			INSERT INTO tb_erm_audit_log(PkId,TableName,ColumnName,OldValue,NewValue,UpdtUser)
            VALUES (@MitigationDetailsId,'tb_erm_mitigation_details','Project Type',@OLDVALUE,@NEWVALUE,@UPDTUSER)
		END

		IF NOT (@Old_ProjectSubType = @New_ProjectSubType)
		BEGIN
			

			SET @OLDVALUE=(select PROJECTSUBTYPE from tb_erm_Project_SubType where ProjectSubType=@Old_ProjectSubType)
			SET @NEWVALUE=(select PROJECTSUBTYPE from tb_erm_Project_SubType where ProjectSubType=@New_ProjectSubType)
			
			INSERT INTO tb_erm_audit_log(PkId,TableName,ColumnName,OldValue,NewValue,UpdtUser)
            VALUES (@MitigationDetailsId,'tb_erm_mitigation_details','Project Sub-Type',@OLDVALUE,@NEWVALUE,@UPDTUSER)
		END

		IF NOT (@Old_HostSector = @New_HostSector)
		BEGIN
			
			SET @OLDVALUE=(SELECT ITEMDISPLAY FROM TB_ERM_PICKLIST_VALUE WHERE LISTID=(SELECT LISTID FROM TB_ERM_PICKLIST WHERE LISTNAME='Host Sector') AND ITEMNUM=@Old_HostSector)
			SET @NEWVALUE=(SELECT ITEMDISPLAY FROM TB_ERM_PICKLIST_VALUE WHERE LISTID=(SELECT LISTID FROM TB_ERM_PICKLIST WHERE LISTNAME='Host Sector') AND ITEMNUM=@New_HostSector)
			
			INSERT INTO tb_erm_audit_log(PkId,TableName,ColumnName,OldValue,NewValue,UpdtUser)
            VALUES (@MitigationDetailsId,'tb_erm_mitigation_details','Host Sector',@OLDVALUE,@NEWVALUE,@UPDTUSER)
		END
     
		IF NOT (@Old_HostMainSubSector = @New_HostMainSubSector)
		BEGIN
			
			SET @OLDVALUE=(select MainSubSectorType from tb_erm_Mitigation_MainSubSector where MainSubSectorId=@Old_HostMainSubSector)
			SET @NEWVALUE=(select MainSubSectorType from tb_erm_Mitigation_MainSubSector where MainSubSectorId=@New_HostMainSubSector)

			INSERT INTO tb_erm_audit_log(PkId,TableName,ColumnName,OldValue,NewValue,UpdtUser)
            VALUES (@MitigationDetailsId,'tb_erm_mitigation_details','Sub Sector',@OLDVALUE,@NEWVALUE,@UPDTUSER)
		END

		IF NOT (@Old_HostSubSector = @New_HostSubSector)
		BEGIN
			SET @OLDVALUE=(select SubSectorType from tb_erm_Mitigation_SubSector where SubSectorId=@Old_HostSubSector)
			SET @NEWVALUE=(select SubSectorType from tb_erm_Mitigation_SubSector where SubSectorId=@New_HostSubSector)
				
			INSERT INTO tb_erm_audit_log(PkId,TableName,ColumnName,OldValue,NewValue,UpdtUser)
            VALUES (@MitigationDetailsId,'tb_erm_mitigation_details','Sub Sub Sector',@OLDVALUE,@NEWVALUE,@UPDTUSER)
		END

		IF NOT (@Old_ExecutiveStatus = @New_ExecutiveStatus)
		BEGIN
			
			SET @OLDVALUE=(SELECT ITEMDISPLAY FROM TB_ERM_PICKLIST_VALUE WHERE LISTID=(SELECT LISTID FROM TB_ERM_PICKLIST WHERE LISTNAME='Executive Board Status') AND ITEMNUM=@Old_ExecutiveStatus)
			SET @NEWVALUE=(SELECT ITEMDISPLAY FROM TB_ERM_PICKLIST_VALUE WHERE LISTID=(SELECT LISTID FROM TB_ERM_PICKLIST WHERE LISTNAME='Executive Board Status') AND ITEMNUM=@New_ExecutiveStatus)
			
			INSERT INTO tb_erm_audit_log(PkId,TableName,ColumnName,OldValue,NewValue,UpdtUser)
            VALUES (@MitigationDetailsId,'tb_erm_mitigation_details','CDM Executive Board Status',@OLDVALUE,@NEWVALUE,@UPDTUSER)
		END

		IF NOT (@Old_CarbonCredit = @New_CarbonCredit)
		BEGIN
			

			SET @OLDVALUE=(SELECT ITEMDISPLAY FROM TB_ERM_PICKLIST_VALUE WHERE LISTID=(SELECT LISTID FROM TB_ERM_PICKLIST WHERE LISTNAME='Carbon credits') AND ITEMNUM=@Old_CarbonCredit)
			SET @NEWVALUE=(SELECT ITEMDISPLAY FROM TB_ERM_PICKLIST_VALUE WHERE LISTID=(SELECT LISTID FROM TB_ERM_PICKLIST WHERE LISTNAME='Carbon credits') AND ITEMNUM=@New_CarbonCredit)
			
			INSERT INTO tb_erm_audit_log(PkId,TableName,ColumnName,OldValue,NewValue,UpdtUser)
			VALUES (@MitigationDetailsId,'tb_erm_mitigation_details','Does Project Generate Carbon Credits?',@OLDVALUE,@NEWVALUE,@UPDTUSER)
			
		END

		IF NOT (@Old_CarbonCreditMarket = @New_CarbonCreditMarket)
		BEGIN
			

			SET @OLDVALUE=(SELECT ITEMDISPLAY FROM TB_ERM_PICKLIST_VALUE WHERE LISTID=(SELECT LISTID FROM TB_ERM_PICKLIST WHERE LISTNAME='Carbon credit Market') AND ITEMNUM=@Old_CarbonCreditMarket)
			SET @NEWVALUE=(SELECT ITEMDISPLAY FROM TB_ERM_PICKLIST_VALUE WHERE LISTID=(SELECT LISTID FROM TB_ERM_PICKLIST WHERE LISTNAME='Carbon credit Market') AND ITEMNUM=@New_CarbonCreditMarket)
			INSERT INTO tb_erm_audit_log(PkId,TableName,ColumnName,OldValue,NewValue,UpdtUser)
            VALUES (@MitigationDetailsId,'tb_erm_mitigation_details','Type of Carbon Credits',@OLDVALUE,@NEWVALUE,@UPDTUSER)
		END

		IF NOT (@Old_CDMStatus = @New_CDMStatus)
		BEGIN
			

			SET @OLDVALUE=(SELECT ITEMDISPLAY FROM TB_ERM_PICKLIST_VALUE WHERE LISTID=(SELECT LISTID FROM TB_ERM_PICKLIST WHERE LISTNAME='CDM Status') AND ITEMNUM=@Old_CDMStatus)
			SET @NEWVALUE=(SELECT ITEMDISPLAY FROM TB_ERM_PICKLIST_VALUE WHERE LISTID=(SELECT LISTID FROM TB_ERM_PICKLIST WHERE LISTNAME='CDM Status') AND ITEMNUM=@New_CDMStatus)

			INSERT INTO tb_erm_audit_log(PkId,TableName,ColumnName,OldValue,NewValue,UpdtUser)
            VALUES (@MitigationDetailsId,'tb_erm_mitigation_details','CDM Status',@OLDVALUE,@NEWVALUE,@UPDTUSER)
		END

		IF NOT (@Old_CDMMethodoloy = @New_CDMMethodoloy)
		BEGIN
			

			SET @OLDVALUE=(SELECT ITEMDISPLAY FROM TB_ERM_PICKLIST_VALUE WHERE LISTID=(SELECT LISTID FROM TB_ERM_PICKLIST WHERE LISTNAME='CDM Approved Methodology') AND ITEMNUM=@Old_CDMMethodoloy)
			SET @NEWVALUE=(SELECT ITEMDISPLAY FROM TB_ERM_PICKLIST_VALUE WHERE LISTID=(SELECT LISTID FROM TB_ERM_PICKLIST WHERE LISTNAME='CDM Approved Methodology') AND ITEMNUM=@New_CDMMethodoloy)

			INSERT INTO tb_erm_audit_log(PkId,TableName,ColumnName,OldValue,NewValue,UpdtUser)
            VALUES (@MitigationDetailsId,'tb_erm_mitigation_details','CDM Approved Methodology',@OLDVALUE,@NEWVALUE,@UPDTUSER)
		END
		
		IF NOT (@Old_VolMethodoloy = @New_VolMethodoloy)
		BEGIN
			INSERT INTO tb_erm_audit_log(PkId,TableName,ColumnName,OldValue,NewValue,UpdtUser)
            VALUES (@MitigationDetailsId,'tb_erm_mitigation_details','Methodology',@Old_VolMethodoloy,@New_VolMethodoloy,@UPDTUSER)
		END
		
		IF NOT (@Old_GoldStandard = @New_GoldStandard)
		BEGIN
			IF(@Old_GoldStandard=-1)
				SET @Old_GoldStandard='YES'
			ELSE
				SET @Old_GoldStandard='NO'

			IF(@New_GoldStandard=-1)
				SET @New_GoldStandard='YES'
			ELSE
				SET @New_GoldStandard='NO'

			INSERT INTO tb_erm_audit_log(PkId,TableName,ColumnName,OldValue,NewValue,UpdtUser)
            VALUES (@MitigationDetailsId,'tb_erm_mitigation_details','Gold Standard VERs',@Old_GoldStandard,@New_GoldStandard,@UPDTUSER)
		END

		IF NOT (@Old_VCS = @New_VCS)
		BEGIN
			IF(@Old_VCS=-1)
				SET @Old_VCS='YES'
			ELSE
				SET @Old_VCS='NO'
			
			IF(@New_VCS=-1)
				SET @New_VCS='YES'
			ELSE
				SET @New_VCS='NO'

			INSERT INTO tb_erm_audit_log(PkId,TableName,ColumnName,OldValue,NewValue,UpdtUser)
            VALUES (@MitigationDetailsId,'tb_erm_mitigation_details','VCS',@Old_VCS,@New_VCS,@UPDTUSER)
		END
		
		IF NOT (@Old_Other = @New_Other)
		BEGIN
			IF(@Old_Other=-1)
				SET @Old_Other='YES'
			ELSE
				SET @Old_Other='NO'
			
			IF(@New_Other=-1)
				SET @New_Other='YES'
			ELSE
				SET @New_Other='NO'
			
			INSERT INTO tb_erm_audit_log(PkId,TableName,ColumnName,OldValue,NewValue,UpdtUser)
            VALUES (@MitigationDetailsId,'tb_erm_mitigation_details','Other',@Old_Other,@New_Other,@UPDTUSER)
		END

		IF NOT (@Old_otherDesc = @New_otherDesc)
		BEGIN
			INSERT INTO tb_erm_audit_log(PkId,TableName,ColumnName,OldValue,NewValue,UpdtUser)
            VALUES (@MitigationDetailsId,'tb_erm_mitigation_details','Other Organisation Issuing Credits',@Old_otherDesc,@New_otherDesc,@UPDTUSER)
		END

		IF(@OLDCDMProjectNumber IS NOT NULL AND @NEWCDMProjectNumber IS NULL)
		BEGIN
			IF NOT (@OLDCDMProjectNumber = @NEWCDMProjectNumber)
			BEGIN
				INSERT INTO tb_erm_audit_log(PkId,TableName,ColumnName,OldValue,NewValue,UpdtUser)
				VALUES (@MitigationDetailsId,'tb_erm_mitigation_details','CDM Project Number',@OLDCDMProjectNumber,'',@UPDTUSER)
            END  
		END
		ELSE IF(@OLDCDMProjectNumber IS NOT NULL AND @NEWCDMProjectNumber IS NOT NULL)
		BEGIN
			IF NOT (@OLDCDMProjectNumber = @NEWCDMProjectNumber)
			BEGIN
				INSERT INTO tb_erm_audit_log(PkId,TableName,ColumnName,OldValue,NewValue,UpdtUser)
				VALUES (@MitigationDetailsId,'tb_erm_mitigation_details','CDM Project Number',@OLDCDMProjectNumber,@NEWCDMProjectNumber,@UPDTUSER)
			END
		END
		ELSE IF(@OLDCDMProjectNumber IS NULL AND @NEWCDMProjectNumber IS NOT NULL)
		BEGIN
			IF NOT (@OLDCDMProjectNumber = @NEWCDMProjectNumber)
			BEGIN
				INSERT INTO tb_erm_audit_log(PkId,TableName,ColumnName,OldValue,NewValue,UpdtUser)
				VALUES (@MitigationDetailsId,'tb_erm_mitigation_details','CDM Project Number','',@NEWCDMProjectNumber,@UPDTUSER)
            END
		END

	END
        RETURN
		ERROR:
		RAISERROR @ERRNO @ERRMSG
		ROLLBACK TRANSACTION
	END

GO
ALTER TABLE [dbo].[tb_erm_mitigation_details] ENABLE TRIGGER [tU_tb_erm_mitigation_details]
GO
/****** Object:  Trigger [dbo].[tI_tb_erm_Mitigation_Emissions_Data]    Script Date: 2018/12/03 07:46:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tI_tb_erm_Mitigation_Emissions_Data] ON [dbo].[tb_erm_Mitigation_Emissions_Data] FOR INSERT AS
	BEGIN
		DECLARE @NUMROWS INT,
		@NULLCNT INT,
		@VALIDCNT INT,
		@ERRNO   INT,
		@ERRMSG  NVARCHAR(255),
		@USRID NVARCHAR(255)

		SELECT @NUMROWS = @@ROWCOUNT
		/* UPDATE USER NAME AND TIME */
		UPDATE tb_erm_Mitigation_Emissions_Data SET  UpdtTime = GETDATE()
		FROM tb_erm_Mitigation_Emissions_Data, INSERTED WHERE tb_erm_Mitigation_Emissions_Data.MitigationEmissionsDataId = INSERTED.MitigationEmissionsDataId
		RETURN
		ERROR:
		RAISERROR @ERRNO @ERRMSG
		ROLLBACK TRANSACTION
	END
GO
ALTER TABLE [dbo].[tb_erm_Mitigation_Emissions_Data] ENABLE TRIGGER [tI_tb_erm_Mitigation_Emissions_Data]
GO
/****** Object:  Trigger [dbo].[tU_tb_erm_Mitigation_Emissions_Data]    Script Date: 2018/12/03 07:46:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tU_tb_erm_Mitigation_Emissions_Data] ON [dbo].[tb_erm_Mitigation_Emissions_Data] FOR UPDATE AS
BEGIN
		DECLARE @NUMROWS INT,
		@NULLCNT INT,
		@VALIDCNT INT,
		@ERRNO   INT,
		@ERRMSG  NVARCHAR(255),
		@COUNT   INT,
		@MitigationEmissionsDataId int,
		@ProjectLocationDataId INT,
		@UPDTUSER nvarchar(50),
		@Old_Year int,
		@New_Year int,
		@Old_CO2 varchar(250),
		@New_CO2 varchar(250),
		@Old_CH4 varchar(250),
		@New_CH4 varchar(250),
		@Old_CH4_CO2e varchar(250),
		@New_CH4_CO2e varchar(250),
		@Old_N2O varchar(250),
		@New_N2O varchar(250),
		@Old_N2O_CO2e varchar(250),
		@New_N2O_CO2e varchar(250),
		@Old_HFC varchar(250),
		@New_HFC varchar(250),
		@Old_HFC_CO2e varchar(250),
		@New_HFC_CO2e varchar(250),
		@Old_PFC varchar(250),
		@New_PFC varchar(250),
		@Old_PFC_CO2e varchar(250),
		@New_PFC_CO2e varchar(250),
		@Old_SF6 varchar(250),
		@New_SF6 varchar(250),
		@Old_SF6_CO2e varchar(250),
		@New_SF6_CO2e varchar(250),
		@Old_Hydro varchar(250),
		@New_Hydro varchar(250),
		@Old_Tidal varchar(250),
		@New_Tidal varchar(250),
		@Old_Wind varchar(250),
		@New_Wind varchar(250),
		@Old_Solar varchar(250),
		@New_Solar varchar(250),
		@Old_FossilFuelElecRed varchar(250),
		@New_FossilFuelElecRed varchar(250),
		@Old_BioWaste varchar(250),
		@New_BioWaste varchar(250),
		@Old_BioWaste_CO2e varchar(250),
		@New_BioWaste_CO2e varchar(250),
		@Old_Geothermal varchar(250),
		@New_Geothermal varchar(250),
		@Old_Geothermal_CO2e varchar(250),
		@New_Geothermal_CO2e varchar(250),
		@Old_Hydro_CO2e varchar(250),
		@New_Hydro_CO2e varchar(250),
		@Old_Solar_CO2e varchar(250),
		@New_Solar_CO2e varchar(250),
		@Old_Tidal_CO2e varchar(250),
		@New_Tidal_CO2e varchar(250),
		@Old_Wind_CO2e varchar(250),
		@New_Wind_CO2e varchar(250)

		SELECT @NUMROWS = @@ROWCOUNT
		UPDATE tb_erm_Mitigation_Emissions_Data SET
			UPDTTIME = GETDATE()
		FROM tb_erm_Mitigation_Emissions_Data, INSERTED WHERE tb_erm_Mitigation_Emissions_Data.MitigationEmissionsDataId  = INSERTED.MitigationEmissionsDataId

		select @UPDTUSER = inserted.UpdtUser, @MitigationEmissionsDataId = deleted.MitigationEmissionsDataId, @ProjectLocationDataId = deleted.ProjectLocationDataId,
		@Old_Year = deleted.[Year], @New_Year = inserted.[Year],
		@Old_CO2 = CAST( deleted.CO2 AS bigint), @New_CO2 = CAST( inserted.CO2 AS bigint),
		@Old_CH4 =CAST(  deleted.CH4 AS bigint), @New_CH4 = CAST( inserted.CH4 AS bigint),
		@Old_CH4_CO2e = CAST( deleted.CH4_CO2e AS bigint), @New_CH4_CO2e = CAST( inserted.CH4_CO2e AS bigint),
		@Old_N2O = CAST( deleted.N2O AS bigint), @New_N2O = CAST( inserted.N2O AS bigint),
		@Old_N2O_CO2e = CAST( deleted.N2O_CO2e AS bigint), @New_N2O_CO2e = CAST( inserted.N2O_CO2e AS bigint),
		@Old_HFC = CAST( deleted.HFC AS bigint), @New_HFC = CAST( inserted.HFC AS bigint),
		@Old_HFC_CO2e =CAST(  deleted.HFC_CO2e AS bigint), @New_HFC_CO2e = CAST( inserted.HFC_CO2e AS bigint),
		@Old_PFC = CAST( deleted.PFC AS bigint), @New_PFC = CAST( inserted.PFC AS bigint),
		@Old_PFC_CO2e = CAST( deleted.PFC_CO2e AS bigint), @New_PFC_CO2e = CAST(inserted.PFC_CO2e AS bigint),
		@Old_SF6 = CAST( deleted.SF6 AS bigint) , @New_SF6 = CAST( inserted.SF6 AS bigint) ,
		@Old_SF6_CO2e =   CAST(deleted.SF6_CO2e   AS bigint) , @New_SF6_CO2e = CAST( inserted.SF6_CO2e  AS bigint ) ,
		@Old_Hydro = CAST( deleted.Hydro AS bigint), @New_Hydro = CAST( inserted.Hydro AS bigint),
		@Old_Tidal = CAST( deleted.Tidal AS bigint), @New_Tidal = CAST( inserted.Tidal AS bigint),
		@Old_Wind = CAST( deleted.Wind AS bigint), @New_Wind = CAST( inserted.Wind AS bigint),
		@Old_Solar = CAST( deleted.Solar AS bigint), @New_Solar = CAST( inserted.Solar AS bigint),
		@Old_FossilFuelElecRed = CAST( deleted.FossilFuelElecRed AS bigint), @New_FossilFuelElecRed = CAST( inserted.FossilFuelElecRed AS bigint),
		@Old_BioWaste = CAST( deleted.BioWaste AS bigint), @New_BioWaste = CAST( inserted.BioWaste AS bigint),
		@Old_BioWaste_CO2e = CAST( deleted.BioWaste_CO2e AS bigint), @New_BioWaste_CO2e = CAST( inserted.BioWaste_CO2e AS bigint),
		@Old_Geothermal = CAST( deleted.Geothermal AS bigint), @New_Geothermal = CAST( inserted.Geothermal AS bigint),
		@Old_Geothermal_CO2e = CAST( deleted.Geothermal_CO2e AS bigint), @New_Geothermal_CO2e = CAST( inserted.Geothermal_CO2e AS bigint),
		@Old_Hydro_CO2e = CAST( deleted.Hydro_CO2e AS bigint), @New_Hydro_CO2e = CAST( inserted.Hydro_CO2e AS bigint),
		@Old_Solar_CO2e = CAST( deleted.Solar_CO2e AS bigint), @New_Solar_CO2e = CAST( inserted.Solar_CO2e AS bigint),
		@Old_Tidal_CO2e = CAST( deleted.Tidal_CO2e AS bigint), @New_Tidal_CO2e = CAST( inserted.Tidal_CO2e AS bigint),
		@Old_Wind_CO2e = CAST( deleted.Wind_CO2e AS bigint), @New_Wind_CO2e = CAST( inserted.Wind_CO2e AS bigint)
		from inserted, deleted

		IF EXISTS(select * from tb_erm_project_details where validationstatus in 
		(select itemnum from tb_erm_picklist_value where listid in 
		(select listid from tb_erm_picklist where listname like 'DEAT Validation Status') 
		and Itemdisplay like 'Accepted' and	projectdetailsid in 
		(select projectdetailsid from tb_erm_Project_Location_Data where ProjectLocationDataId = @ProjectLocationDataId)))
		BEGIN

			IF EXISTS(select * from tb_erm_project_details where 
			startyear <= (select itemnum from tb_erm_picklist_value where listid in 
			(select listid from tb_erm_picklist where listname like 'Year') and itemdisplay like @New_Year)
			and endyear >= (select itemnum from tb_erm_picklist_value where listid in 
			(select listid from tb_erm_picklist where listname like 'Year') and itemdisplay like @New_Year)
			and ProjectDetailsId IN (Select ProjectDetailsId from tb_erm_Project_Location_Data where 
			ProjectLocationDataId = @ProjectLocationDataId))
			BEGIN

				--Year
				IF(@Old_Year IS NULL AND @New_Year IS NOT NULL)
				BEGIN
					INSERT INTO tb_erm_audit_log(PkId,TableName,ColumnName,OldValue,NewValue,UpdtUser)
					VALUES (@MitigationEmissionsDataId,'tb_erm_Mitigation_Emissions_Data','Year','',CONVERT(nvarchar(100),@New_Year),@UPDTUSER)
				END
				ELSE IF(@Old_Year IS NOT NULL AND @New_Year IS NOT NULL)
				BEGIN
					IF NOT(@Old_Year = @New_Year)
					BEGIN
						INSERT INTO tb_erm_audit_log(PkId,TableName,ColumnName,OldValue,NewValue,UpdtUser)
						VALUES (@MitigationEmissionsDataId,'tb_erm_Mitigation_Emissions_Data','Year',CONVERT(nvarchar(100),@Old_Year),CONVERT(nvarchar(100),@New_Year),@UPDTUSER)
					END
				END
				ELSE IF(@Old_Year IS NOT NULL AND @New_Year IS NULL)
				BEGIN
					INSERT INTO tb_erm_audit_log(PkId,TableName,ColumnName,OldValue,NewValue,UpdtUser)
					VALUES (@MitigationEmissionsDataId,'tb_erm_Mitigation_Emissions_Data','Year',CONVERT(nvarchar(100),@Old_Year),'',@UPDTUSER)
				END

				--CO2
				IF(@Old_CO2 IS NULL AND @New_CO2 IS NOT NULL)
				BEGIN
					INSERT INTO tb_erm_audit_log(PkId,TableName,ColumnName,OldValue,NewValue,UpdtUser)
					VALUES (@MitigationEmissionsDataId,'tb_erm_Mitigation_Emissions_Data','CO2(' + CONVERT(nvarchar(250),@New_Year) + ')','',CONVERT(nvarchar(250),@New_CO2),@UPDTUSER)
				END
				ELSE IF(@Old_CO2 IS NOT NULL AND @New_CO2 IS NOT NULL)
				BEGIN
					IF NOT(@Old_CO2 = @New_CO2)
					BEGIN
						INSERT INTO tb_erm_audit_log(PkId,TableName,ColumnName,OldValue,NewValue,UpdtUser)
						VALUES (@MitigationEmissionsDataId,'tb_erm_Mitigation_Emissions_Data','CO2(' + CONVERT(nvarchar(250),@New_Year) + ')',CONVERT(nvarchar(250),@Old_CO2),CONVERT(nvarchar(250),@New_CO2),@UPDTUSER)
					END
				END
				ELSE IF(@Old_CO2 IS NOT NULL AND @New_CO2 IS NULL)
				BEGIN
					INSERT INTO tb_erm_audit_log(PkId,TableName,ColumnName,OldValue,NewValue,UpdtUser)
					VALUES (@MitigationEmissionsDataId,'tb_erm_Mitigation_Emissions_Data','CO2(' + CONVERT(nvarchar(250),@New_Year) + ')',CONVERT(nvarchar(250),@Old_CO2),'',@UPDTUSER)
				END
			
				--CH4
				IF(@Old_CH4 IS NULL AND @New_CH4 IS NOT NULL)
				BEGIN
					INSERT INTO tb_erm_audit_log(PkId,TableName,ColumnName,OldValue,NewValue,UpdtUser)
					VALUES (@MitigationEmissionsDataId,'tb_erm_Mitigation_Emissions_Data','CH4(' + CONVERT(nvarchar(250),@New_Year) + ')','',CONVERT(nvarchar(250),@New_CH4),@UPDTUSER)
				END
				ELSE IF(@Old_CH4 IS NOT NULL AND @New_CH4 IS NOT NULL)
				BEGIN
					IF NOT(@Old_CH4 = @New_CH4)
					BEGIN
						INSERT INTO tb_erm_audit_log(PkId,TableName,ColumnName,OldValue,NewValue,UpdtUser)
						VALUES (@MitigationEmissionsDataId,'tb_erm_Mitigation_Emissions_Data','CH4(' + CONVERT(nvarchar(250),@New_Year) + ')',CONVERT(nvarchar(250),@Old_CH4),CONVERT(nvarchar(250),@New_CH4),@UPDTUSER)
					END
				END
				ELSE IF(@Old_CH4 IS NOT NULL AND @New_CH4 IS NULL)
				BEGIN
					INSERT INTO tb_erm_audit_log(PkId,TableName,ColumnName,OldValue,NewValue,UpdtUser)
					VALUES (@MitigationEmissionsDataId,'tb_erm_Mitigation_Emissions_Data','CH4(' + CONVERT(nvarchar(250),@New_Year) + ')',CONVERT(nvarchar(250),@Old_CH4),'',@UPDTUSER)
				END
			
				--CH4_CO2e
				IF(@Old_CH4_CO2e IS NULL AND @New_CH4_CO2e IS NOT NULL)
				BEGIN
					INSERT INTO tb_erm_audit_log(PkId,TableName,ColumnName,OldValue,NewValue,UpdtUser)
					VALUES (@MitigationEmissionsDataId,'tb_erm_Mitigation_Emissions_Data','CH4-CO2e(' + CONVERT(nvarchar(250),@New_Year) + ')','',CONVERT(nvarchar(250),@New_CH4_CO2e),@UPDTUSER)
				END
				ELSE IF(@Old_CH4_CO2e IS NOT NULL AND @New_CH4_CO2e IS NOT NULL)
				BEGIN
					IF NOT(@Old_CH4_CO2e = @New_CH4_CO2e)
					BEGIN
						INSERT INTO tb_erm_audit_log(PkId,TableName,ColumnName,OldValue,NewValue,UpdtUser)
						VALUES (@MitigationEmissionsDataId,'tb_erm_Mitigation_Emissions_Data','CH4-CO2e(' + CONVERT(nvarchar(250),@New_Year) + ')',CONVERT(nvarchar(250),@Old_CH4_CO2e),CONVERT(nvarchar(250),@New_CH4_CO2e),@UPDTUSER)
					END
				END
				ELSE IF(@Old_CH4_CO2e IS NOT NULL AND @New_CH4_CO2e IS NULL)
				BEGIN
					INSERT INTO tb_erm_audit_log(PkId,TableName,ColumnName,OldValue,NewValue,UpdtUser)
					VALUES (@MitigationEmissionsDataId,'tb_erm_Mitigation_Emissions_Data','CH4-CO2e(' + CONVERT(nvarchar(250),@New_Year) + ')',CONVERT(nvarchar(250),@Old_CH4_CO2e),'',@UPDTUSER)
				END
			
				--N2O
				IF(@Old_N2O IS NULL AND @New_N2O IS NOT NULL)
				BEGIN
					INSERT INTO tb_erm_audit_log(PkId,TableName,ColumnName,OldValue,NewValue,UpdtUser)
					VALUES (@MitigationEmissionsDataId,'tb_erm_Mitigation_Emissions_Data','N2O(' + CONVERT(nvarchar(250),@New_Year) + ')','',CONVERT(nvarchar(250),@New_N2O),@UPDTUSER)
				END
				ELSE IF(@Old_N2O IS NOT NULL AND @New_N2O IS NOT NULL)
				BEGIN
					IF NOT(@Old_N2O = @New_N2O)
					BEGIN
						INSERT INTO tb_erm_audit_log(PkId,TableName,ColumnName,OldValue,NewValue,UpdtUser)
						VALUES (@MitigationEmissionsDataId,'tb_erm_Mitigation_Emissions_Data','N2O(' + CONVERT(nvarchar(250),@New_Year) + ')',CONVERT(nvarchar(250),@Old_N2O),CONVERT(nvarchar(250),@New_N2O),@UPDTUSER)
					END
				END
				ELSE IF(@Old_N2O IS NOT NULL AND @New_N2O IS NULL)
				BEGIN
					INSERT INTO tb_erm_audit_log(PkId,TableName,ColumnName,OldValue,NewValue,UpdtUser)
					VALUES (@MitigationEmissionsDataId,'tb_erm_Mitigation_Emissions_Data','N2O(' + CONVERT(nvarchar(250),@New_Year) + ')',CONVERT(nvarchar(250),@Old_N2O),'',@UPDTUSER)
				END

				--N2O_CO2e
				IF(@Old_N2O_CO2e IS NULL AND @New_N2O_CO2e IS NOT NULL)
				BEGIN
					INSERT INTO tb_erm_audit_log(PkId,TableName,ColumnName,OldValue,NewValue,UpdtUser)
					VALUES (@MitigationEmissionsDataId,'tb_erm_Mitigation_Emissions_Data','N2O-CO2e(' + CONVERT(nvarchar(250),@New_Year) + ')','',CONVERT(nvarchar(250),@New_N2O_CO2e),@UPDTUSER)
				END
				ELSE IF(@Old_N2O_CO2e IS NOT NULL AND @New_N2O_CO2e IS NOT NULL)
				BEGIN
					IF NOT(@Old_N2O_CO2e = @New_N2O_CO2e)
					BEGIN
						INSERT INTO tb_erm_audit_log(PkId,TableName,ColumnName,OldValue,NewValue,UpdtUser)
						VALUES (@MitigationEmissionsDataId,'tb_erm_Mitigation_Emissions_Data','N2O-CO2e(' + CONVERT(nvarchar(250),@New_Year) + ')',CONVERT(nvarchar(250),@Old_N2O_CO2e),CONVERT(nvarchar(250),@New_N2O_CO2e),@UPDTUSER)
					END
				END
				ELSE IF(@Old_N2O_CO2e IS NOT NULL AND @New_N2O_CO2e IS NULL)
				BEGIN
					INSERT INTO tb_erm_audit_log(PkId,TableName,ColumnName,OldValue,NewValue,UpdtUser)
					VALUES (@MitigationEmissionsDataId,'tb_erm_Mitigation_Emissions_Data','N2O-CO2e(' + CONVERT(nvarchar(250),@New_Year) + ')',CONVERT(nvarchar(250),@Old_N2O_CO2e),'',@UPDTUSER)
				END

				--HFC
				IF(@Old_HFC IS NULL AND @New_HFC IS NOT NULL)
				BEGIN
					INSERT INTO tb_erm_audit_log(PkId,TableName,ColumnName,OldValue,NewValue,UpdtUser)
					VALUES (@MitigationEmissionsDataId,'tb_erm_Mitigation_Emissions_Data','HFC(' + CONVERT(nvarchar(250),@New_Year) + ')','',CONVERT(nvarchar(250),@New_HFC),@UPDTUSER)
				END
				ELSE IF(@Old_HFC IS NOT NULL AND @New_HFC IS NOT NULL)
				BEGIN
					IF NOT(@Old_HFC = @New_HFC)
					BEGIN
						INSERT INTO tb_erm_audit_log(PkId,TableName,ColumnName,OldValue,NewValue,UpdtUser)
						VALUES (@MitigationEmissionsDataId,'tb_erm_Mitigation_Emissions_Data','HFC(' + CONVERT(nvarchar(250),@New_Year) + ')',CONVERT(nvarchar(250),@Old_HFC),CONVERT(nvarchar(250),@New_HFC),@UPDTUSER)
					END
				END
				ELSE IF(@Old_HFC IS NOT NULL AND @New_HFC IS NULL)
				BEGIN
					INSERT INTO tb_erm_audit_log(PkId,TableName,ColumnName,OldValue,NewValue,UpdtUser)
					VALUES (@MitigationEmissionsDataId,'tb_erm_Mitigation_Emissions_Data','HFC(' + CONVERT(nvarchar(250),@New_Year) + ')',CONVERT(nvarchar(250),@Old_HFC),'',@UPDTUSER)
				END

				--HFC_CO2e
				IF(@Old_HFC_CO2e IS NULL AND @New_HFC_CO2e IS NOT NULL)
				BEGIN
					INSERT INTO tb_erm_audit_log(PkId,TableName,ColumnName,OldValue,NewValue,UpdtUser)
					VALUES (@MitigationEmissionsDataId,'tb_erm_Mitigation_Emissions_Data','HFC-CO2e(' + CONVERT(nvarchar(250),@New_Year) + ')','',CONVERT(nvarchar(250),@New_HFC_CO2e),@UPDTUSER)
				END
				ELSE IF(@Old_HFC_CO2e IS NOT NULL AND @New_HFC_CO2e IS NOT NULL)
				BEGIN
					IF NOT(@Old_HFC_CO2e = @New_HFC_CO2e)
					BEGIN
						INSERT INTO tb_erm_audit_log(PkId,TableName,ColumnName,OldValue,NewValue,UpdtUser)
						VALUES (@MitigationEmissionsDataId,'tb_erm_Mitigation_Emissions_Data','HFC-CO2e(' + CONVERT(nvarchar(250),@New_Year) + ')',CONVERT(nvarchar(250),@Old_HFC_CO2e),CONVERT(nvarchar(250),@New_HFC_CO2e),@UPDTUSER)
					END
				END
				ELSE IF(@Old_HFC_CO2e IS NOT NULL AND @New_HFC_CO2e IS NULL)
				BEGIN
					INSERT INTO tb_erm_audit_log(PkId,TableName,ColumnName,OldValue,NewValue,UpdtUser)
					VALUES (@MitigationEmissionsDataId,'tb_erm_Mitigation_Emissions_Data','HFC-CO2e(' + CONVERT(nvarchar(250),@New_Year) + ')',CONVERT(nvarchar(250),@Old_HFC_CO2e),'',@UPDTUSER)
				END
		
				--PFC
				IF(@Old_PFC IS NULL AND @New_PFC IS NOT NULL)
				BEGIN
					INSERT INTO tb_erm_audit_log(PkId,TableName,ColumnName,OldValue,NewValue,UpdtUser)
					VALUES (@MitigationEmissionsDataId,'tb_erm_Mitigation_Emissions_Data','PFC(' + CONVERT(nvarchar(250),@New_Year) + ')','',CONVERT(nvarchar(250),@New_PFC),@UPDTUSER)
				END
				ELSE IF(@Old_PFC IS NOT NULL AND @New_PFC IS NOT NULL)
				BEGIN
					IF NOT(@Old_PFC = @New_PFC)
					BEGIN
						INSERT INTO tb_erm_audit_log(PkId,TableName,ColumnName,OldValue,NewValue,UpdtUser)
						VALUES (@MitigationEmissionsDataId,'tb_erm_Mitigation_Emissions_Data','PFC(' + CONVERT(nvarchar(250),@New_Year) + ')',CONVERT(nvarchar(250),@Old_PFC),CONVERT(nvarchar(250),@New_PFC),@UPDTUSER)
					END
				END
				ELSE IF(@Old_PFC IS NOT NULL AND @New_PFC IS NULL)
				BEGIN
					INSERT INTO tb_erm_audit_log(PkId,TableName,ColumnName,OldValue,NewValue,UpdtUser)
					VALUES (@MitigationEmissionsDataId,'tb_erm_Mitigation_Emissions_Data','PFC(' + CONVERT(nvarchar(250),@New_Year) + ')',CONVERT(nvarchar(250),@Old_PFC),'',@UPDTUSER)
				END

				--PFC_CO2e
				IF(@Old_PFC_CO2e IS NULL AND @New_PFC_CO2e IS NOT NULL)
				BEGIN
					INSERT INTO tb_erm_audit_log(PkId,TableName,ColumnName,OldValue,NewValue,UpdtUser)
					VALUES (@MitigationEmissionsDataId,'tb_erm_Mitigation_Emissions_Data','PFC-CO2e(' + CONVERT(nvarchar(250),@New_Year) + ')','',CONVERT(nvarchar(250),@New_PFC_CO2e),@UPDTUSER)
				END
				ELSE IF(@Old_PFC_CO2e IS NOT NULL AND @New_PFC_CO2e IS NOT NULL)
				BEGIN
					IF NOT(@Old_PFC_CO2e = @New_PFC_CO2e)
					BEGIN
						INSERT INTO tb_erm_audit_log(PkId,TableName,ColumnName,OldValue,NewValue,UpdtUser)
						VALUES (@MitigationEmissionsDataId,'tb_erm_Mitigation_Emissions_Data','PFC-CO2e(' + CONVERT(nvarchar(250),@New_Year) + ')',CONVERT(nvarchar(250),@Old_PFC_CO2e),CONVERT(nvarchar(250),@New_PFC_CO2e),@UPDTUSER)
					END
				END
				ELSE IF(@Old_PFC_CO2e IS NOT NULL AND @New_PFC_CO2e IS NULL)
				BEGIN
					INSERT INTO tb_erm_audit_log(PkId,TableName,ColumnName,OldValue,NewValue,UpdtUser)
					VALUES (@MitigationEmissionsDataId,'tb_erm_Mitigation_Emissions_Data','PFC-CO2e(' + CONVERT(nvarchar(250),@New_Year) + ')',CONVERT(nvarchar(250),@Old_PFC_CO2e),'',@UPDTUSER)
				END

				--SF6
				IF(@Old_SF6 IS NULL AND @New_SF6 IS NOT NULL)
				BEGIN
					INSERT INTO tb_erm_audit_log(PkId,TableName,ColumnName,OldValue,NewValue,UpdtUser)
					VALUES (@MitigationEmissionsDataId,'tb_erm_Mitigation_Emissions_Data','SF6(' + CONVERT(nvarchar(250),@New_Year) + ')','',@New_SF6,@UPDTUSER)
				END
				ELSE IF(@Old_SF6 IS NOT NULL AND @New_SF6 IS NOT NULL)
				BEGIN
					IF NOT(@Old_SF6 = @New_SF6)
					BEGIN
						INSERT INTO tb_erm_audit_log(PkId,TableName,ColumnName,OldValue,NewValue,UpdtUser)
						VALUES (@MitigationEmissionsDataId,'tb_erm_Mitigation_Emissions_Data','SF6(' + CONVERT(nvarchar(250),@New_Year) + ')',@Old_SF6,@New_SF6,@UPDTUSER)
					END
				END
				ELSE IF(@Old_SF6 IS NOT NULL AND @New_SF6 IS NULL)
				BEGIN
					INSERT INTO tb_erm_audit_log(PkId,TableName,ColumnName,OldValue,NewValue,UpdtUser)
					VALUES (@MitigationEmissionsDataId,'tb_erm_Mitigation_Emissions_Data','SF6(' + CONVERT(nvarchar(250),@New_Year) + ')',@Old_SF6,'',@UPDTUSER)
				END

				--SF6_CO2e
				IF(@Old_SF6_CO2e IS NULL AND @New_SF6_CO2e IS NOT NULL)
				BEGIN
					INSERT INTO tb_erm_audit_log(PkId,TableName,ColumnName,OldValue,NewValue,UpdtUser)
					VALUES (@MitigationEmissionsDataId,'tb_erm_Mitigation_Emissions_Data','SF6-CO2e(' + CONVERT(nvarchar(250),@New_Year) + ')','',@New_SF6_CO2e,@UPDTUSER)
				END
				ELSE IF(@Old_SF6_CO2e IS NOT NULL AND @New_SF6_CO2e IS NOT NULL)
				BEGIN
					IF NOT(@Old_SF6_CO2e = @New_SF6_CO2e)
					BEGIN
						INSERT INTO tb_erm_audit_log(PkId,TableName,ColumnName,OldValue,NewValue,UpdtUser)
						--SELECT @MitigationEmissionsDataId,'tb_erm_Mitigation_Emissions_Data','SF6-CO2e(' + CONVERT(nvarchar(250),@New_Year) + ')',(SELECT SF6_CO2e FROM deleted) AS DEL, (SELECT SF6_CO2e FROM inserted) AS INS, @UPDTUSER
						VALUES (@MitigationEmissionsDataId,'tb_erm_Mitigation_Emissions_Data','SF6-CO2e(' + CONVERT(nvarchar(250),@New_Year) + ')', @Old_SF6_CO2e, @New_SF6_CO2e,@UPDTUSER)
					END
				END
				ELSE IF(@Old_SF6_CO2e IS NOT NULL AND @New_SF6_CO2e IS NULL)
				BEGIN
					INSERT INTO tb_erm_audit_log(PkId,TableName,ColumnName,OldValue,NewValue,UpdtUser)
					VALUES (@MitigationEmissionsDataId,'tb_erm_Mitigation_Emissions_Data','SF6-CO2e(' + CONVERT(nvarchar(250),@New_Year) + ')',@Old_SF6_CO2e,'',@UPDTUSER)
				END

				--Hydro
				IF(@Old_Hydro IS NULL AND @New_Hydro IS NOT NULL)
				BEGIN
					INSERT INTO tb_erm_audit_log(PkId,TableName,ColumnName,OldValue,NewValue,UpdtUser)
					VALUES (@MitigationEmissionsDataId,'tb_erm_Mitigation_Emissions_Data','Hydro(' + CONVERT(nvarchar(250),@New_Year) + ')','',CONVERT(nvarchar(250),@New_Hydro),@UPDTUSER)
				END
				ELSE IF(@Old_Hydro IS NOT NULL AND @New_Hydro IS NOT NULL)
				BEGIN
					IF NOT(@Old_Hydro = @New_Hydro)
					BEGIN
						INSERT INTO tb_erm_audit_log(PkId,TableName,ColumnName,OldValue,NewValue,UpdtUser)
						VALUES (@MitigationEmissionsDataId,'tb_erm_Mitigation_Emissions_Data','Hydro(' + CONVERT(nvarchar(250),@New_Year) + ')',CONVERT(nvarchar(250),@Old_Hydro),CONVERT(nvarchar(250),@New_Hydro),@UPDTUSER)
					END
				END
				ELSE IF(@Old_Hydro IS NOT NULL AND @New_Hydro IS NULL)
				BEGIN
					INSERT INTO tb_erm_audit_log(PkId,TableName,ColumnName,OldValue,NewValue,UpdtUser)
					VALUES (@MitigationEmissionsDataId,'tb_erm_Mitigation_Emissions_Data','Hydro(' + CONVERT(nvarchar(250),@New_Year) + ')',CONVERT(nvarchar(250),@Old_Hydro),'',@UPDTUSER)
				END

				--Tidal
				IF(@Old_Tidal IS NULL AND @New_Tidal IS NOT NULL)
				BEGIN
					INSERT INTO tb_erm_audit_log(PkId,TableName,ColumnName,OldValue,NewValue,UpdtUser)
					VALUES (@MitigationEmissionsDataId,'tb_erm_Mitigation_Emissions_Data','Tidal(' + CONVERT(nvarchar(250),@New_Year) + ')','',CONVERT(nvarchar(250),@New_Tidal),@UPDTUSER)
				END
				ELSE IF(@Old_Tidal IS NOT NULL AND @New_Tidal IS NOT NULL)
				BEGIN
					IF NOT(@Old_Tidal = @New_Tidal)
					BEGIN
						INSERT INTO tb_erm_audit_log(PkId,TableName,ColumnName,OldValue,NewValue,UpdtUser)
						VALUES (@MitigationEmissionsDataId,'tb_erm_Mitigation_Emissions_Data','Tidal(' + CONVERT(nvarchar(250),@New_Year) + ')',CONVERT(nvarchar(250),@Old_Tidal),CONVERT(nvarchar(250),@New_Tidal),@UPDTUSER)
					END
				END
				ELSE IF(@Old_Tidal IS NOT NULL AND @New_Tidal IS NULL)
				BEGIN
					INSERT INTO tb_erm_audit_log(PkId,TableName,ColumnName,OldValue,NewValue,UpdtUser)
					VALUES (@MitigationEmissionsDataId,'tb_erm_Mitigation_Emissions_Data','Tidal(' + CONVERT(nvarchar(250),@New_Year) + ')',CONVERT(nvarchar(250),@Old_Tidal),'',@UPDTUSER)
				END

				--Wind
				IF(@Old_Wind IS NULL AND @New_Wind IS NOT NULL)
				BEGIN
					INSERT INTO tb_erm_audit_log(PkId,TableName,ColumnName,OldValue,NewValue,UpdtUser)
					VALUES (@MitigationEmissionsDataId,'tb_erm_Mitigation_Emissions_Data','Wind(' + CONVERT(nvarchar(250),@New_Year) + ')','',CONVERT(nvarchar(250),@New_Wind),@UPDTUSER)
				END
				ELSE IF(@Old_Wind IS NOT NULL AND @New_Wind IS NOT NULL)
				BEGIN
					IF NOT(@Old_Wind = @New_Wind)
					BEGIN
						INSERT INTO tb_erm_audit_log(PkId,TableName,ColumnName,OldValue,NewValue,UpdtUser)
						VALUES (@MitigationEmissionsDataId,'tb_erm_Mitigation_Emissions_Data','Wind(' + CONVERT(nvarchar(250),@New_Year) + ')',CONVERT(nvarchar(250),@Old_Wind),CONVERT(nvarchar(250),@New_Wind),@UPDTUSER)
					END
				END
				ELSE IF(@Old_Wind IS NOT NULL AND @New_Wind IS NULL)
				BEGIN
					INSERT INTO tb_erm_audit_log(PkId,TableName,ColumnName,OldValue,NewValue,UpdtUser)
					VALUES (@MitigationEmissionsDataId,'tb_erm_Mitigation_Emissions_Data','Wind(' + CONVERT(nvarchar(250),@New_Year) + ')',CONVERT(nvarchar(250),@Old_Wind),'',@UPDTUSER)
				END

				--Solar
				IF(@Old_Solar IS NULL AND @New_Solar IS NOT NULL)
				BEGIN
					INSERT INTO tb_erm_audit_log(PkId,TableName,ColumnName,OldValue,NewValue,UpdtUser)
					VALUES (@MitigationEmissionsDataId,'tb_erm_Mitigation_Emissions_Data','Solar(' + CONVERT(nvarchar(250),@New_Year) + ')','',CONVERT(nvarchar(250),@New_Solar),@UPDTUSER)
				END
				ELSE IF(@Old_Solar IS NOT NULL AND @New_Solar IS NOT NULL)
				BEGIN
					IF NOT(@Old_Solar = @New_Solar)
					BEGIN
						INSERT INTO tb_erm_audit_log(PkId,TableName,ColumnName,OldValue,NewValue,UpdtUser)
						VALUES (@MitigationEmissionsDataId,'tb_erm_Mitigation_Emissions_Data','Solar(' + CONVERT(nvarchar(250),@New_Year) + ')',CONVERT(nvarchar(250),@Old_Solar),CONVERT(nvarchar(250),@New_Solar),@UPDTUSER)
					END
				END
				ELSE IF(@Old_Solar IS NOT NULL AND @New_Solar IS NULL)
				BEGIN
					INSERT INTO tb_erm_audit_log(PkId,TableName,ColumnName,OldValue,NewValue,UpdtUser)
					VALUES (@MitigationEmissionsDataId,'tb_erm_Mitigation_Emissions_Data','Solar(' + CONVERT(nvarchar(250),@New_Year) + ')',CONVERT(nvarchar(250),@Old_Solar),'',@UPDTUSER)
				END

				--FossilFuelElecRed
				IF(@Old_FossilFuelElecRed IS NULL AND @New_FossilFuelElecRed IS NOT NULL)
				BEGIN
					INSERT INTO tb_erm_audit_log(PkId,TableName,ColumnName,OldValue,NewValue,UpdtUser)
					VALUES (@MitigationEmissionsDataId,'tb_erm_Mitigation_Emissions_Data','Annual Reduction(' + CONVERT(nvarchar(250),@New_Year) + ')','',CONVERT(nvarchar(250),@New_FossilFuelElecRed),@UPDTUSER)
				END
				ELSE IF(@Old_FossilFuelElecRed IS NOT NULL AND @New_FossilFuelElecRed IS NOT NULL)
				BEGIN
					IF NOT(@Old_FossilFuelElecRed = @New_FossilFuelElecRed)
					BEGIN
						INSERT INTO tb_erm_audit_log(PkId,TableName,ColumnName,OldValue,NewValue,UpdtUser)
						VALUES (@MitigationEmissionsDataId,'tb_erm_Mitigation_Emissions_Data','Annual Reduction(' + CONVERT(nvarchar(250),@New_Year) + ')',CONVERT(nvarchar(250),@Old_FossilFuelElecRed),CONVERT(nvarchar(250),@New_FossilFuelElecRed),@UPDTUSER)
					END
				END
				ELSE IF(@Old_FossilFuelElecRed IS NOT NULL AND @New_FossilFuelElecRed IS NULL)
				BEGIN
					INSERT INTO tb_erm_audit_log(PkId,TableName,ColumnName,OldValue,NewValue,UpdtUser)
					VALUES (@MitigationEmissionsDataId,'tb_erm_Mitigation_Emissions_Data','Annual Reduction(' + CONVERT(nvarchar(250),@New_Year) + ')',CONVERT(nvarchar(250),@Old_FossilFuelElecRed),'',@UPDTUSER)
				END

				--BioWaste
				IF(@Old_BioWaste IS NULL AND @New_BioWaste IS NOT NULL)
				BEGIN
					INSERT INTO tb_erm_audit_log(PkId,TableName,ColumnName,OldValue,NewValue,UpdtUser)
					VALUES (@MitigationEmissionsDataId,'tb_erm_Mitigation_Emissions_Data','Bio/Waste Gas(' + CONVERT(nvarchar(250),@New_Year) + ')','',CONVERT(nvarchar(250),@New_BioWaste),@UPDTUSER)
				END
				ELSE IF(@Old_BioWaste IS NOT NULL AND @New_BioWaste IS NOT NULL)
				BEGIN
					IF NOT(@Old_BioWaste = @New_BioWaste)
					BEGIN
						INSERT INTO tb_erm_audit_log(PkId,TableName,ColumnName,OldValue,NewValue,UpdtUser)
						VALUES (@MitigationEmissionsDataId,'tb_erm_Mitigation_Emissions_Data','Bio/Waste Gas(' + CONVERT(nvarchar(250),@New_Year) + ')',CONVERT(nvarchar(250),@Old_BioWaste),CONVERT(nvarchar(250),@New_BioWaste),@UPDTUSER)
					END
				END
				ELSE IF(@Old_BioWaste IS NOT NULL AND @New_BioWaste IS NULL)
				BEGIN
					INSERT INTO tb_erm_audit_log(PkId,TableName,ColumnName,OldValue,NewValue,UpdtUser)
					VALUES (@MitigationEmissionsDataId,'tb_erm_Mitigation_Emissions_Data','Bio/Waste Gas(' + CONVERT(nvarchar(250),@New_Year) + ')',CONVERT(nvarchar(250),@Old_BioWaste),'',@UPDTUSER)
				END

				--BioWaste_CO2e
				IF(@Old_BioWaste_CO2e IS NULL AND @New_BioWaste_CO2e IS NOT NULL)
				BEGIN
					INSERT INTO tb_erm_audit_log(PkId,TableName,ColumnName,OldValue,NewValue,UpdtUser)
					VALUES (@MitigationEmissionsDataId,'tb_erm_Mitigation_Emissions_Data','Bio/Waste Gas-CO2e(' + CONVERT(nvarchar(250),@New_Year) + ')','',CONVERT(nvarchar(250),@New_BioWaste_CO2e),@UPDTUSER)
				END
				ELSE IF(@Old_BioWaste_CO2e IS NOT NULL AND @New_BioWaste_CO2e IS NOT NULL)
				BEGIN
					IF NOT(@Old_BioWaste_CO2e = @New_BioWaste_CO2e)
					BEGIN
						INSERT INTO tb_erm_audit_log(PkId,TableName,ColumnName,OldValue,NewValue,UpdtUser)
						VALUES (@MitigationEmissionsDataId,'tb_erm_Mitigation_Emissions_Data','Bio/Waste Gas-CO2e(' + CONVERT(nvarchar(250),@New_Year) + ')',CONVERT(nvarchar(250),@Old_BioWaste_CO2e),CONVERT(nvarchar(250),@New_BioWaste_CO2e),@UPDTUSER)
					END
				END
				ELSE IF(@Old_BioWaste_CO2e IS NOT NULL AND @New_BioWaste_CO2e IS NULL)
				BEGIN
					INSERT INTO tb_erm_audit_log(PkId,TableName,ColumnName,OldValue,NewValue,UpdtUser)
					VALUES (@MitigationEmissionsDataId,'tb_erm_Mitigation_Emissions_Data','Bio/Waste Gas-CO2e(' + CONVERT(nvarchar(250),@New_Year) + ')',CONVERT(nvarchar(250),@Old_BioWaste_CO2e),'',@UPDTUSER)
				END

				--Geothermal
				IF(@Old_Geothermal IS NULL AND @New_Geothermal IS NOT NULL)
				BEGIN
					INSERT INTO tb_erm_audit_log(PkId,TableName,ColumnName,OldValue,NewValue,UpdtUser)
					VALUES (@MitigationEmissionsDataId,'tb_erm_Mitigation_Emissions_Data','Geothermal(' + CONVERT(nvarchar(250),@New_Year) + ')','',CONVERT(nvarchar(250),@New_Geothermal),@UPDTUSER)
				END
				ELSE IF(@Old_Geothermal IS NOT NULL AND @New_Geothermal IS NOT NULL)
				BEGIN
					IF NOT(@Old_Geothermal = @New_Geothermal)
					BEGIN
						INSERT INTO tb_erm_audit_log(PkId,TableName,ColumnName,OldValue,NewValue,UpdtUser)
						VALUES (@MitigationEmissionsDataId,'tb_erm_Mitigation_Emissions_Data','Geothermal(' + CONVERT(nvarchar(250),@New_Year) + ')',CONVERT(nvarchar(250),@Old_Geothermal),CONVERT(nvarchar(250),@New_Geothermal),@UPDTUSER)
					END
				END
				ELSE IF(@Old_Geothermal IS NOT NULL AND @New_Geothermal IS NULL)
				BEGIN
					INSERT INTO tb_erm_audit_log(PkId,TableName,ColumnName,OldValue,NewValue,UpdtUser)
					VALUES (@MitigationEmissionsDataId,'tb_erm_Mitigation_Emissions_Data','Geothermal(' + CONVERT(nvarchar(250),@New_Year) + ')',CONVERT(nvarchar(250),@Old_Geothermal),'',@UPDTUSER)
				END

				--Geothermal_CO2e
				IF(@Old_Geothermal_CO2e IS NULL AND @New_Geothermal_CO2e IS NOT NULL)
				BEGIN
					INSERT INTO tb_erm_audit_log(PkId,TableName,ColumnName,OldValue,NewValue,UpdtUser)
					VALUES (@MitigationEmissionsDataId,'tb_erm_Mitigation_Emissions_Data','Geothermal-CO2e(' + CONVERT(nvarchar(250),@New_Year) + ')','',CONVERT(nvarchar(250),@New_Geothermal_CO2e),@UPDTUSER)
				END
				ELSE IF(@Old_Geothermal_CO2e IS NOT NULL AND @New_Geothermal_CO2e IS NOT NULL)
				BEGIN
					IF NOT(@Old_Geothermal_CO2e = @New_Geothermal_CO2e)
					BEGIN
						INSERT INTO tb_erm_audit_log(PkId,TableName,ColumnName,OldValue,NewValue,UpdtUser)
						VALUES (@MitigationEmissionsDataId,'tb_erm_Mitigation_Emissions_Data','Geothermal-CO2e(' + CONVERT(nvarchar(250),@New_Year) + ')',CONVERT(nvarchar(250),@Old_Geothermal_CO2e),CONVERT(nvarchar(250),@New_Geothermal_CO2e),@UPDTUSER)
					END
				END
				ELSE IF(@Old_Geothermal_CO2e IS NOT NULL AND @New_Geothermal_CO2e IS NULL)
				BEGIN
					INSERT INTO tb_erm_audit_log(PkId,TableName,ColumnName,OldValue,NewValue,UpdtUser)
					VALUES (@MitigationEmissionsDataId,'tb_erm_Mitigation_Emissions_Data','Geothermal-CO2e(' + CONVERT(nvarchar(250),@New_Year) + ')',CONVERT(nvarchar(250),@Old_Geothermal_CO2e),'',@UPDTUSER)
				END

				--Hydro_CO2e
				IF(@Old_Hydro_CO2e IS NULL AND @New_Hydro_CO2e IS NOT NULL)
				BEGIN
					INSERT INTO tb_erm_audit_log(PkId,TableName,ColumnName,OldValue,NewValue,UpdtUser)
					VALUES (@MitigationEmissionsDataId,'tb_erm_Mitigation_Emissions_Data','Hydro-CO2e(' + CONVERT(nvarchar(250),@New_Year) + ')','',CONVERT(nvarchar(250),@New_Hydro_CO2e),@UPDTUSER)
				END
				ELSE IF(@Old_Hydro_CO2e IS NOT NULL AND @New_Hydro_CO2e IS NOT NULL)
				BEGIN
					IF NOT(@Old_Hydro_CO2e = @New_Hydro_CO2e)
					BEGIN
						INSERT INTO tb_erm_audit_log(PkId,TableName,ColumnName,OldValue,NewValue,UpdtUser)
						VALUES (@MitigationEmissionsDataId,'tb_erm_Mitigation_Emissions_Data','Hydro-CO2e(' + CONVERT(nvarchar(250),@New_Year) + ')',CONVERT(nvarchar(250),@Old_Hydro_CO2e),CONVERT(nvarchar(250),@New_Hydro_CO2e),@UPDTUSER)
					END
				END
				ELSE IF(@Old_Hydro_CO2e IS NOT NULL AND @New_Hydro_CO2e IS NULL)
				BEGIN
					INSERT INTO tb_erm_audit_log(PkId,TableName,ColumnName,OldValue,NewValue,UpdtUser)
					VALUES (@MitigationEmissionsDataId,'tb_erm_Mitigation_Emissions_Data','Hydro-CO2e(' + CONVERT(nvarchar(250),@New_Year) + ')',CONVERT(nvarchar(250),@Old_Hydro_CO2e),'',@UPDTUSER)
				END

				--Solar_CO2e
				IF(@Old_Solar_CO2e IS NULL AND @New_Solar_CO2e IS NOT NULL)
				BEGIN
					INSERT INTO tb_erm_audit_log(PkId,TableName,ColumnName,OldValue,NewValue,UpdtUser)
					VALUES (@MitigationEmissionsDataId,'tb_erm_Mitigation_Emissions_Data','Solar-CO2e(' + CONVERT(nvarchar(250),@New_Year) + ')','',CONVERT(nvarchar(250),@New_Solar_CO2e),@UPDTUSER)
				END
				ELSE IF(@Old_Solar_CO2e IS NOT NULL AND @New_Solar_CO2e IS NOT NULL)
				BEGIN
					IF NOT(@Old_Solar_CO2e = @New_Solar_CO2e)
					BEGIN
						INSERT INTO tb_erm_audit_log(PkId,TableName,ColumnName,OldValue,NewValue,UpdtUser)
						VALUES (@MitigationEmissionsDataId,'tb_erm_Mitigation_Emissions_Data','Solar-CO2e(' + CONVERT(nvarchar(250),@New_Year) + ')',CONVERT(nvarchar(250),@Old_Solar_CO2e),CONVERT(nvarchar(250),@New_Solar_CO2e),@UPDTUSER)
					END
				END
				ELSE IF(@Old_Solar_CO2e IS NOT NULL AND @New_Solar_CO2e IS NULL)
				BEGIN
					INSERT INTO tb_erm_audit_log(PkId,TableName,ColumnName,OldValue,NewValue,UpdtUser)
					VALUES (@MitigationEmissionsDataId,'tb_erm_Mitigation_Emissions_Data','Solar-CO2e(' + CONVERT(nvarchar(250),@New_Year) + ')',CONVERT(nvarchar(250),@Old_Solar_CO2e),'',@UPDTUSER)
				END
				
				--Tidal_CO2e
				IF(@Old_Tidal_CO2e IS NULL AND @New_Tidal_CO2e IS NOT NULL)
				BEGIN
					INSERT INTO tb_erm_audit_log(PkId,TableName,ColumnName,OldValue,NewValue,UpdtUser)
					VALUES (@MitigationEmissionsDataId,'tb_erm_Mitigation_Emissions_Data','Tidal-CO2e(' + CONVERT(nvarchar(250),@New_Year) + ')','',CONVERT(nvarchar(250),@New_Tidal_CO2e),@UPDTUSER)
				END
				ELSE IF(@Old_Tidal_CO2e IS NOT NULL AND @New_Tidal_CO2e IS NOT NULL)
				BEGIN
					IF NOT(@Old_Tidal_CO2e = @New_Tidal_CO2e)
					BEGIN
						INSERT INTO tb_erm_audit_log(PkId,TableName,ColumnName,OldValue,NewValue,UpdtUser)
						VALUES (@MitigationEmissionsDataId,'tb_erm_Mitigation_Emissions_Data','Tidal-CO2e(' + CONVERT(nvarchar(250),@New_Year) + ')',CONVERT(nvarchar(250),@Old_Tidal_CO2e),CONVERT(nvarchar(250),@New_Tidal_CO2e),@UPDTUSER)
					END
				END
				ELSE IF(@Old_Tidal_CO2e IS NOT NULL AND @New_Tidal_CO2e IS NULL)
				BEGIN
					INSERT INTO tb_erm_audit_log(PkId,TableName,ColumnName,OldValue,NewValue,UpdtUser)
					VALUES (@MitigationEmissionsDataId,'tb_erm_Mitigation_Emissions_Data','Tidal-CO2e(' + CONVERT(nvarchar(250),@New_Year) + ')',CONVERT(nvarchar(250),@Old_Tidal_CO2e),'',@UPDTUSER)
				END

				--Wind_CO2e
				IF(@Old_Wind_CO2e IS NULL AND @New_Wind_CO2e IS NOT NULL)
				BEGIN
					INSERT INTO tb_erm_audit_log(PkId,TableName,ColumnName,OldValue,NewValue,UpdtUser)
					VALUES (@MitigationEmissionsDataId,'tb_erm_Mitigation_Emissions_Data','Wind-CO2e(' + CONVERT(nvarchar(250),@New_Year) + ')','',CONVERT(nvarchar(250),@New_Wind_CO2e),@UPDTUSER)
				END
				ELSE IF(@Old_Wind_CO2e IS NOT NULL AND @New_Wind_CO2e IS NOT NULL)
				BEGIN
					IF NOT(@Old_Wind_CO2e = @New_Wind_CO2e)
					BEGIN
						INSERT INTO tb_erm_audit_log(PkId,TableName,ColumnName,OldValue,NewValue,UpdtUser)
						VALUES (@MitigationEmissionsDataId,'tb_erm_Mitigation_Emissions_Data','Wind-CO2e(' + CONVERT(nvarchar(250),@New_Year) + ')',CONVERT(nvarchar(250),@Old_Wind_CO2e),CONVERT(nvarchar(250),@New_Wind_CO2e),@UPDTUSER)
					END
				END
				ELSE IF(@Old_Wind_CO2e IS NOT NULL AND @New_Wind_CO2e IS NULL)
				BEGIN
					INSERT INTO tb_erm_audit_log(PkId,TableName,ColumnName,OldValue,NewValue,UpdtUser)
					VALUES (@MitigationEmissionsDataId,'tb_erm_Mitigation_Emissions_Data','Wind-CO2e(' + CONVERT(nvarchar(250),@New_Year) + ')',CONVERT(nvarchar(250),@Old_Wind_CO2e),'',@UPDTUSER)
				END

			END

		END

		RETURN
		ERROR:
		RAISERROR @ERRNO @ERRMSG
		ROLLBACK TRANSACTION
	END
GO
ALTER TABLE [dbo].[tb_erm_Mitigation_Emissions_Data] ENABLE TRIGGER [tU_tb_erm_Mitigation_Emissions_Data]
GO
/****** Object:  Trigger [dbo].[tI_tb_erm_Mitigation_MainSubSector]    Script Date: 2018/12/03 07:46:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tI_tb_erm_Mitigation_MainSubSector] ON [dbo].[tb_erm_Mitigation_MainSubSector] FOR INSERT AS
	BEGIN
		DECLARE @NUMROWS INT,
		@NULLCNT INT,
		@VALIDCNT INT,
		@ERRNO   INT,
		@ERRMSG  NVARCHAR(255),
		@USRID NVARCHAR(255)

		SELECT @NUMROWS = @@ROWCOUNT
		/* UPDATE USER NAME AND TIME */
		UPDATE tb_erm_Mitigation_MainSubSector SET  UpdtTime = GETDATE()
		FROM tb_erm_Mitigation_MainSubSector, INSERTED WHERE tb_erm_Mitigation_MainSubSector.MainSubSectorId = INSERTED.MainSubSectorId
		RETURN
		ERROR:
		RAISERROR @ERRNO @ERRMSG
		ROLLBACK TRANSACTION
	END
GO
ALTER TABLE [dbo].[tb_erm_Mitigation_MainSubSector] ENABLE TRIGGER [tI_tb_erm_Mitigation_MainSubSector]
GO
/****** Object:  Trigger [dbo].[tU_tb_erm_Mitigation_MainSubSector]    Script Date: 2018/12/03 07:46:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tU_tb_erm_Mitigation_MainSubSector] ON [dbo].[tb_erm_Mitigation_MainSubSector] FOR UPDATE AS
	BEGIN
		DECLARE @NUMROWS INT,
		@NULLCNT INT,
		@VALIDCNT INT,
		@ERRNO   INT,
		@ERRMSG  NVARCHAR(255),
		@COUNT   INT

		SELECT @NUMROWS = @@ROWCOUNT
		UPDATE tb_erm_Mitigation_MainSubSector SET
			UPDTTIME = GETDATE()
		FROM tb_erm_Mitigation_MainSubSector, INSERTED WHERE tb_erm_Mitigation_MainSubSector.MainSubSectorId  = INSERTED.MainSubSectorId
		RETURN
		ERROR:
		RAISERROR @ERRNO @ERRMSG
		ROLLBACK TRANSACTION
	END

GO
ALTER TABLE [dbo].[tb_erm_Mitigation_MainSubSector] ENABLE TRIGGER [tU_tb_erm_Mitigation_MainSubSector]
GO
/****** Object:  Trigger [dbo].[tI_tb_erm_Mitigation_SubSector]    Script Date: 2018/12/03 07:46:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tI_tb_erm_Mitigation_SubSector] ON [dbo].[tb_erm_Mitigation_SubSector] FOR INSERT AS
	BEGIN
		DECLARE @NUMROWS INT,
		@NULLCNT INT,
		@VALIDCNT INT,
		@ERRNO   INT,
		@ERRMSG  NVARCHAR(255),
		@USRID NVARCHAR(255)

		SELECT @NUMROWS = @@ROWCOUNT
		/* UPDATE USER NAME AND TIME */
		UPDATE tb_erm_Mitigation_SubSector SET  UpdtTime = GETDATE()
		FROM tb_erm_Mitigation_SubSector, INSERTED WHERE tb_erm_Mitigation_SubSector.SubSectorId = INSERTED.SubSectorId
		RETURN
		ERROR:
		RAISERROR @ERRNO @ERRMSG
		ROLLBACK TRANSACTION
	END
GO
ALTER TABLE [dbo].[tb_erm_Mitigation_SubSector] ENABLE TRIGGER [tI_tb_erm_Mitigation_SubSector]
GO
/****** Object:  Trigger [dbo].[tU_tb_erm_Mitigation_SubSector]    Script Date: 2018/12/03 07:46:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tU_tb_erm_Mitigation_SubSector] ON [dbo].[tb_erm_Mitigation_SubSector] FOR UPDATE AS
	BEGIN
		DECLARE @NUMROWS INT,
		@NULLCNT INT,
		@VALIDCNT INT,
		@ERRNO   INT,
		@ERRMSG  NVARCHAR(255),
		@COUNT   INT

		SELECT @NUMROWS = @@ROWCOUNT
		UPDATE tb_erm_Mitigation_SubSector SET
			UPDTTIME = GETDATE()
		FROM tb_erm_Mitigation_SubSector, INSERTED WHERE tb_erm_Mitigation_SubSector.SubSectorId  = INSERTED.SubSectorId
		RETURN
		ERROR:
		RAISERROR @ERRNO @ERRMSG
		ROLLBACK TRANSACTION
	END

GO
ALTER TABLE [dbo].[tb_erm_Mitigation_SubSector] ENABLE TRIGGER [tU_tb_erm_Mitigation_SubSector]
GO
/****** Object:  Trigger [dbo].[tI_tb_erm_navigation_module]    Script Date: 2018/12/03 07:46:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tI_tb_erm_navigation_module] ON [dbo].[tb_erm_navigation_module] FOR INSERT AS
	BEGIN
		DECLARE  @NUMROWS INT,
		@NULLCNT INT,
		@VALIDCNT INT,
		@ERRNO   INT,
		@ERRMSG  NVARCHAR(255),
		@USRID NVARCHAR(255)

		SELECT @NUMROWS = @@ROWCOUNT
		/* UPDATE USER NAME AND TIME */
		UPDATE tb_erm_navigation_module SET /* UpdtUser = SUSER_SNAME(), */ UpdtTime = GETDATE()
		FROM tb_erm_navigation_module, INSERTED WHERE tb_erm_navigation_module.NavigationModuleID = INSERTED.NavigationModuleID
		RETURN
		ERROR:
		RAISERROR @ERRNO @ERRMSG
		ROLLBACK TRANSACTION
	END
GO
ALTER TABLE [dbo].[tb_erm_navigation_module] ENABLE TRIGGER [tI_tb_erm_navigation_module]
GO
/****** Object:  Trigger [dbo].[tU_tb_erm_navigation_module]    Script Date: 2018/12/03 07:46:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tU_tb_erm_navigation_module] ON [dbo].[tb_erm_navigation_module] FOR UPDATE AS
	BEGIN
		DECLARE @NUMROWS INT,
		@NULLCNT INT,
		@VALIDCNT INT,
		@ERRNO   INT,
		@ERRMSG  NVARCHAR(255),
		@COUNT   INT

		SELECT @NUMROWS = @@ROWCOUNT
		/* UPDATE USER NAME AND TIME */
		UPDATE tb_erm_navigation_module SET
		/*UPDTUSER = suser_sname(),*/
		UPDTTIME = GETDATE()
		FROM tb_erm_navigation_module, INSERTED WHERE tb_erm_navigation_module.NAVIGATIONMODULEID  = INSERTED.NAVIGATIONMODULEID
		RETURN
		ERROR:
		RAISERROR @ERRNO @ERRMSG
		ROLLBACK TRANSACTION
	END
	
GO
ALTER TABLE [dbo].[tb_erm_navigation_module] ENABLE TRIGGER [tU_tb_erm_navigation_module]
GO
/****** Object:  Trigger [dbo].[tI_tb_erm_navtree]    Script Date: 2018/12/03 07:46:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tI_tb_erm_navtree] ON [dbo].[tb_erm_navtree] FOR INSERT AS
	BEGIN
		DECLARE @NUMROWS INT,
		@NULLCNT INT,
		@VALIDCNT INT,
		@ERRNO   INT,
		@ERRMSG  NVARCHAR(255),
		@USRID NVARCHAR(255)

		SELECT @NUMROWS = @@ROWCOUNT
		/* UPDATE USER NAME AND TIME */
		UPDATE tb_erm_navtree SET /* UpdtUsr = SUSER_SNAME(), */ UpdtTime = GETDATE()
		FROM tb_erm_navtree, INSERTED WHERE tb_erm_navtree.NavTreeID = INSERTED.NavTreeID
		RETURN
		ERROR:
		RAISERROR @ERRNO @ERRMSG
		ROLLBACK TRANSACTION
	END
GO
ALTER TABLE [dbo].[tb_erm_navtree] ENABLE TRIGGER [tI_tb_erm_navtree]
GO
/****** Object:  Trigger [dbo].[tU_tb_erm_navtree]    Script Date: 2018/12/03 07:46:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tU_tb_erm_navtree] ON [dbo].[tb_erm_navtree] FOR UPDATE AS
	BEGIN
		DECLARE @NUMROWS INT,
		@NULLCNT INT,
		@VALIDCNT INT,
		@ERRNO   INT,
		@ERRMSG  NVARCHAR(255),
		@COUNT   INT

		SELECT @NUMROWS = @@ROWCOUNT
		/* UPDATE USER NAME AND TIME */
		UPDATE tb_erm_navtree SET
		/*UPDTUSER = suser_sname(),*/
		UPDTTIME = GETDATE()
		FROM tb_erm_navtree, INSERTED WHERE tb_erm_navtree.NavTreeID  = INSERTED.NavTreeID
		RETURN
		ERROR:
		RAISERROR @ERRNO @ERRMSG
		ROLLBACK TRANSACTION
	END
	
GO
ALTER TABLE [dbo].[tb_erm_navtree] ENABLE TRIGGER [tU_tb_erm_navtree]
GO
/****** Object:  Trigger [dbo].[tI_tb_erm_obj]    Script Date: 2018/12/03 07:46:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tI_tb_erm_obj] ON [dbo].[tb_erm_obj] FOR INSERT AS
	BEGIN
		DECLARE @NUMROWS INT,
		@NULLCNT INT,
		@VALIDCNT INT,
		@ERRNO   INT,
		@ERRMSG  NVARCHAR(255),
		@USRID NVARCHAR(255),
		@ObjID INT

		SELECT @NUMROWS = @@ROWCOUNT
		/* UPDATE USER NAME AND TIME */
		UPDATE tb_erm_obj SET /* UpdtUsr = SUSER_SNAME(), */ UpdtTime = GETDATE()
		FROM tb_erm_obj, INSERTED WHERE tb_erm_obj.ObjID = INSERTED.ObjID
		SET @ObjID = (SELECT ObjID FROM INSERTED)
		EXEC sp_insert_obj_roles @ObjID
		RETURN
		ERROR:
		RAISERROR @ERRNO @ERRMSG
		ROLLBACK TRANSACTION
	END
GO
ALTER TABLE [dbo].[tb_erm_obj] ENABLE TRIGGER [tI_tb_erm_obj]
GO
/****** Object:  Trigger [dbo].[tU_tb_erm_obj]    Script Date: 2018/12/03 07:46:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tU_tb_erm_obj] ON [dbo].[tb_erm_obj] FOR UPDATE AS
	BEGIN
		DECLARE @NUMROWS INT,
		@NULLCNT INT,
		@VALIDCNT INT,
		@ERRNO   INT,
		@ERRMSG  NVARCHAR(255),
		@COUNT   INT

		SELECT @NUMROWS = @@ROWCOUNT
		/* UPDATE USER NAME AND TIME */
		UPDATE tb_erm_obj SET
		/*UPDTUSER = suser_sname(),*/
		UPDTTIME = GETDATE()
		FROM tb_erm_obj, INSERTED WHERE tb_erm_obj.ObjID = INSERTED.ObjID		
		RETURN
		ERROR:
		RAISERROR @ERRNO @ERRMSG
		ROLLBACK TRANSACTION
	END
	
GO
ALTER TABLE [dbo].[tb_erm_obj] ENABLE TRIGGER [tU_tb_erm_obj]
GO
/****** Object:  Trigger [dbo].[tI_tb_erm_obj_roles]    Script Date: 2018/12/03 07:46:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tI_tb_erm_obj_roles] ON [dbo].[tb_erm_obj_roles] FOR INSERT AS
	BEGIN
		DECLARE @NUMROWS INT,
		@NULLCNT INT,
		@VALIDCNT INT,
		@ERRNO   INT,
		@ERRMSG  NVARCHAR(255),
		@USRID NVARCHAR(255)

		SELECT @NUMROWS = @@ROWCOUNT
		/* UPDATE USER NAME AND TIME */
		UPDATE tb_erm_obj_roles SET /* UpdtUser = SUSER_SNAME(), */ UpdtTime = GETDATE()
		FROM tb_erm_obj_roles, INSERTED WHERE tb_erm_obj_roles.OBJROLEID = INSERTED.OBJROLEID	
		RETURN
		ERROR:
		RAISERROR @ERRNO @ERRMSG
		ROLLBACK TRANSACTION
	END
GO
ALTER TABLE [dbo].[tb_erm_obj_roles] ENABLE TRIGGER [tI_tb_erm_obj_roles]
GO
/****** Object:  Trigger [dbo].[tU_tb_erm_obj_roles]    Script Date: 2018/12/03 07:46:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tU_tb_erm_obj_roles] ON [dbo].[tb_erm_obj_roles] FOR UPDATE AS
	BEGIN
		DECLARE @NUMROWS INT,
		@NULLCNT INT,
		@VALIDCNT INT,
		@ERRNO   INT,
		@ERRMSG  NVARCHAR(255),
		@COUNT   INT

		SELECT @NUMROWS = @@ROWCOUNT
		/* UPDATE USER NAME AND TIME */
		UPDATE tb_erm_obj_roles SET
		/*UPDTUSER = suser_sname(),*/
		UPDTTIME = GETDATE()
		FROM tb_erm_obj_roles, INSERTED WHERE tb_erm_obj_roles.ObjRoleID = INSERTED.ObjRoleID
		RETURN
		ERROR:
		RAISERROR @ERRNO @ERRMSG
		ROLLBACK TRANSACTION
	END
	
GO
ALTER TABLE [dbo].[tb_erm_obj_roles] ENABLE TRIGGER [tU_tb_erm_obj_roles]
GO
/****** Object:  Trigger [dbo].[tI_tb_erm_picklist]    Script Date: 2018/12/03 07:46:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tI_tb_erm_picklist] ON [dbo].[tb_erm_picklist] FOR INSERT AS
	BEGIN
		DECLARE @NUMROWS INT,
		@NULLCNT INT,
		@VALIDCNT INT,
		@ERRNO   INT,
		@ERRMSG  NVARCHAR(255),
		@USRID NVARCHAR(255)

		SELECT @NUMROWS = @@ROWCOUNT
		/* UPDATE USER NAME AND TIME */
		UPDATE tb_erm_picklist SET /* UpdtUsr = SUSER_SNAME(), */ UpdtTime = GETDATE()
		FROM tb_erm_picklist, INSERTED WHERE tb_erm_picklist.ListId = INSERTED.ListId
		RETURN
		ERROR:
		RAISERROR @ERRNO @ERRMSG
		ROLLBACK TRANSACTION
	END
GO
ALTER TABLE [dbo].[tb_erm_picklist] ENABLE TRIGGER [tI_tb_erm_picklist]
GO
/****** Object:  Trigger [dbo].[tU_tb_erm_picklist]    Script Date: 2018/12/03 07:46:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tU_tb_erm_picklist] ON [dbo].[tb_erm_picklist] FOR UPDATE AS
	BEGIN
		DECLARE @NUMROWS INT,
		@NULLCNT INT,
		@VALIDCNT INT,
		@ERRNO   INT,
		@ERRMSG  NVARCHAR(255),
		@COUNT   INT

		SELECT @NUMROWS = @@ROWCOUNT
		/* UPDATE USER NAME AND TIME */
		UPDATE tb_erm_picklist SET
		/*UPDTUSER = suser_sname(),*/
		UPDTTIME = GETDATE()
		FROM tb_erm_picklist, INSERTED WHERE tb_erm_picklist.ListId  = INSERTED.ListId
		RETURN
		ERROR:
		RAISERROR @ERRNO @ERRMSG
		ROLLBACK TRANSACTION
	END
	
GO
ALTER TABLE [dbo].[tb_erm_picklist] ENABLE TRIGGER [tU_tb_erm_picklist]
GO
/****** Object:  Trigger [dbo].[tI_tb_erm_picklist_value]    Script Date: 2018/12/03 07:46:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tI_tb_erm_picklist_value] ON [dbo].[tb_erm_picklist_value] FOR INSERT AS
	BEGIN
		DECLARE @NUMROWS INT,
		@NULLCNT INT,
		@VALIDCNT INT,
		@ERRNO   INT,
		@ERRMSG  NVARCHAR(255)

		SELECT @NUMROWS = @@ROWCOUNT
		/* UPDATE USER NAME AND TIME */
		UPDATE tb_erm_picklist_value SET
		/*UPDTUSER = suser_sname(),*/
		UPDTTIME = GETDATE()
		FROM tb_erm_picklist_value, INSERTED WHERE tb_erm_picklist_value.PickListId = INSERTED.PickListId
		
		RETURN
		ERROR:
		RAISERROR @ERRNO @ERRMSG
		ROLLBACK TRANSACTION
	END
GO
ALTER TABLE [dbo].[tb_erm_picklist_value] ENABLE TRIGGER [tI_tb_erm_picklist_value]
GO
/****** Object:  Trigger [dbo].[tU_tb_erm_picklist_value]    Script Date: 2018/12/03 07:46:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tU_tb_erm_picklist_value] ON [dbo].[tb_erm_picklist_value] FOR UPDATE AS
	BEGIN
		DECLARE @NUMROWS INT,
		@NULLCNT INT,
		@VALIDCNT INT,
		@ERRNO   INT,
		@ERRMSG  NVARCHAR(255)
		
		SELECT @NUMROWS = @@ROWCOUNT
		/* UPDATE USER NAME AND TIME */
		UPDATE tb_erm_picklist_value SET
		/*UPDTUSER = suser_sname(),*/
		UPDTTIME = GETDATE()
		FROM tb_erm_picklist_value, INSERTED WHERE tb_erm_picklist_value.PickListId = INSERTED.PickListId
			
		RETURN
		ERROR:
		RAISERROR @ERRNO @ERRMSG
		ROLLBACK TRANSACTION
	END
	
GO
ALTER TABLE [dbo].[tb_erm_picklist_value] ENABLE TRIGGER [tU_tb_erm_picklist_value]
GO
/****** Object:  Trigger [dbo].[td_tb_erm_Project_Adaptation_Data]    Script Date: 2018/12/03 07:46:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[td_tb_erm_Project_Adaptation_Data] ON [dbo].[tb_erm_Project_Adaptation_Data]  AFTER DELETE  AS
BEGIN	
declare @Id int
select @Id=ProjectAdaptationDataId from Deleted
delete from dbo.tb_erm_audit_log where PkId=@id and TableName='tb_erm_Project_Adaptation_Data'
END
GO
ALTER TABLE [dbo].[tb_erm_Project_Adaptation_Data] ENABLE TRIGGER [td_tb_erm_Project_Adaptation_Data]
GO
/****** Object:  Trigger [dbo].[tI_tb_erm_Project_Adaptation_Data]    Script Date: 2018/12/03 07:46:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tI_tb_erm_Project_Adaptation_Data] ON [dbo].[tb_erm_Project_Adaptation_Data] FOR INSERT AS
	BEGIN
		DECLARE @NUMROWS INT,
		@NULLCNT INT,
		@VALIDCNT INT,
		@ERRNO   INT,
		@ERRMSG  NVARCHAR(255),
		@USRID NVARCHAR(255)

		SELECT @NUMROWS = @@ROWCOUNT
		/* UPDATE USER NAME AND TIME */
		UPDATE tb_erm_Project_Adaptation_Data SET  UpdtTime = GETDATE()
		FROM tb_erm_Project_Adaptation_Data, INSERTED WHERE tb_erm_Project_Adaptation_Data.ProjectAdaptationDataId = INSERTED.ProjectAdaptationDataId
		

      --to update time in project details table
        UPDATE tb_erm_project_details  SET  UpdtTime = GETDATE()
		FROM tb_erm_Project_Adaptation_Data, INSERTED WHERE tb_erm_project_details.ProjectDetailsId = INSERTED.ProjectDetailsId
   


        RETURN
		ERROR:
		RAISERROR @ERRNO @ERRMSG
		ROLLBACK TRANSACTION
	END
GO
ALTER TABLE [dbo].[tb_erm_Project_Adaptation_Data] ENABLE TRIGGER [tI_tb_erm_Project_Adaptation_Data]
GO
/****** Object:  Trigger [dbo].[tU_tb_erm_Project_Adaptation_Data]    Script Date: 2018/12/03 07:46:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tU_tb_erm_Project_Adaptation_Data] ON [dbo].[tb_erm_Project_Adaptation_Data] FOR UPDATE AS
	BEGIN
		DECLARE @NUMROWS INT,
		@NULLCNT INT,
		@VALIDCNT INT,
		@ERRNO   INT,
		@ERRMSG  NVARCHAR(255),
		@COUNT   INT,
		@PROJECTDETAILSID INT,
		@UPDTUSER nvarchar(50),
		@ProjectAdaptationDataId int,
		@Old_Province int,
		@New_Province int,
		@Old_ItemDisplay nvarchar(255),
		@New_ItemDisplay nvarchar(255),
		@Old_Municipality int,
		@New_Municipality int,
		@Old_LocalMunicipality int,
		@New_LocalMunicipality int,
		@Old_City int,
		@New_City int,
		@Old_LatDegree float,
		@New_LatDegree float,
		@Old_LatMinutes float,
		@New_LatMinutes float,
		@Old_LatSeconds float,
		@New_LatSeconds float,
		@Old_LatCalculated float,
		@New_LatCalculated float,
		@Old_LonDegree float,
		@New_LonDegree float,
		@Old_LonMinutes float,
		@New_LonMinutes float,
		@Old_LonSeconds float,
		@New_LonSeconds float,
		@Old_LonCalculated float,
		@New_LonCalculated float,
		@Old_HostSector int,
		@New_HostSector int,
		@Old_PurposeOfAdaptation int,
		@New_PurposeOfAdaptation int

		SELECT @NUMROWS = @@ROWCOUNT
		UPDATE tb_erm_Project_Adaptation_Data SET
			UPDTTIME = GETDATE()
		FROM tb_erm_Project_Adaptation_Data, INSERTED WHERE tb_erm_Project_Adaptation_Data.ProjectAdaptationDataId  = INSERTED.ProjectAdaptationDataId
		

       -- UPDATE TIME IN PROJECT DETAILS TABLE
        UPDATE tb_erm_project_details  SET  UpdtTime = GETDATE()
		FROM tb_erm_Project_Adaptation_Data, INSERTED WHERE tb_erm_project_details.ProjectDetailsId = INSERTED.ProjectDetailsId
   


		SELECT @PROJECTDETAILSID = inserted.ProjectDetailsId, @ProjectAdaptationDataId = deleted.ProjectAdaptationDataId, @UPDTUSER = inserted.UpdtUser, 
		@Old_Province = deleted.Province, @New_Province = inserted.Province,
		@Old_Municipality = deleted.Municipality, @New_Municipality = inserted.Municipality,
		@Old_LocalMunicipality = deleted.LocalMunicipality, @New_LocalMunicipality = inserted.LocalMunicipality,
		@Old_City = deleted.City, @New_City = inserted.City,
		@Old_LatDegree = deleted.LatDegree, @New_LatDegree = inserted.LatDegree,
		@Old_LatMinutes = deleted.LatMinutes, @New_LatMinutes = inserted.LatMinutes,
		@Old_LatSeconds = deleted.LatSeconds, @New_LatSeconds = inserted.LatSeconds,
		@Old_LatCalculated = deleted.LatCalculated, @New_LatCalculated = inserted.LatCalculated,
		@Old_LonDegree = deleted.LonDegree, @New_LonDegree = inserted.LonDegree,
		@Old_LonMinutes = deleted.LonMinutes, @New_LonMinutes = inserted.LonMinutes,
		@Old_LonSeconds = deleted.LonSeconds, @New_LonSeconds = inserted.LonSeconds,
		@Old_LonCalculated = deleted.LonCalculated, @New_LonCalculated = inserted.LonCalculated,
		@Old_HostSector = deleted.HostSector, @New_HostSector = inserted.HostSector,
		@Old_PurposeOfAdaptation = deleted.PurposeOfAdaptation, @New_PurposeOfAdaptation = inserted.PurposeOfAdaptation
		from inserted, deleted

     --to update time in project details table
        UPDATE tb_erm_project_details SET
			UPDTTIME = GETDATE()
		FROM tb_erm_Project_Adaptation_Data, INSERTED WHERE tb_erm_project_details.ProjectDetailsId  = INSERTED.ProjectDetailsId
		
		IF EXISTS(select * from tb_erm_project_details where validationstatus in 
		(select itemnum from tb_erm_picklist_value where listid in 
		(select listid from tb_erm_picklist where listname like 'DEAT Validation Status') and Itemdisplay like 'Accepted')
		and projectdetailsid = @PROJECTDETAILSID)
		BEGIN

			--Province
			SET @Old_ItemDisplay = ''
			SET @New_ItemDisplay = ''
			IF(@Old_Province IS NULL AND @New_Province IS NOT NULL)
			BEGIN
				Select @New_ItemDisplay = ProvinceName from tb_erm_Province Where ProvinceID = @New_Province
			
				INSERT INTO tb_erm_audit_log(PkId,TableName,ColumnName,OldValue,NewValue,UpdtUser)
				VALUES (@ProjectAdaptationDataId,'tb_erm_Project_Adaptation_Data','Province','',@New_ItemDisplay,@UPDTUSER)	
			END
			ELSE IF(@Old_Province IS NOT NULL AND @New_Province IS NOT NULL)
			BEGIN
				IF NOT (@Old_Province = @New_Province)
				BEGIN
					Select @Old_ItemDisplay = ProvinceName from tb_erm_Province Where ProvinceID = @Old_Province
					Select @New_ItemDisplay = ProvinceName from tb_erm_Province Where ProvinceID = @New_Province

					INSERT INTO tb_erm_audit_log(PkId,TableName,ColumnName,OldValue,NewValue,UpdtUser)
					VALUES (@ProjectAdaptationDataId,'tb_erm_Project_Adaptation_Data','Province',@Old_ItemDisplay,@New_ItemDisplay,@UPDTUSER)
				END
			END
			ELSE IF(@Old_Province IS NOT NULL AND @New_Province IS NULL)
			BEGIN
				Select @Old_ItemDisplay = ProvinceName from tb_erm_Province Where ProvinceID = @Old_Province
				
				INSERT INTO tb_erm_audit_log(PkId,TableName,ColumnName,OldValue,NewValue,UpdtUser)
				VALUES (@ProjectAdaptationDataId,'tb_erm_Project_Adaptation_Data','Province',@Old_ItemDisplay,'',@UPDTUSER)		
			END

			--Municipality
			SET @Old_ItemDisplay = ''
			SET @New_ItemDisplay = ''
			IF(@Old_Municipality IS NULL AND @New_Municipality IS NOT NULL)
			BEGIN
				Select @New_ItemDisplay = MetroName from tb_erm_Metro_DistrictMunicipality Where MetroID = @New_Municipality
				
				INSERT INTO tb_erm_audit_log(PkId,TableName,ColumnName,OldValue,NewValue,UpdtUser)
				VALUES (@ProjectAdaptationDataId,'tb_erm_Project_Adaptation_Data','Metro/District Municipality','',@New_ItemDisplay,@UPDTUSER)	
			END
			ELSE IF(@Old_Municipality IS NOT NULL AND @New_Municipality IS NOT NULL)
			BEGIN
				IF NOT (@Old_Municipality = @New_Municipality)
				BEGIN
					Select @Old_ItemDisplay = MetroName from tb_erm_Metro_DistrictMunicipality Where MetroID = @Old_Municipality
					Select @New_ItemDisplay = MetroName from tb_erm_Metro_DistrictMunicipality Where MetroID = @New_Municipality

					INSERT INTO tb_erm_audit_log(PkId,TableName,ColumnName,OldValue,NewValue,UpdtUser)
					VALUES (@ProjectAdaptationDataId,'tb_erm_Project_Adaptation_Data','Metro/District Municipality',@Old_ItemDisplay,@New_ItemDisplay,@UPDTUSER)
				END
			END
			ELSE IF(@Old_Municipality IS NOT NULL AND @New_Municipality IS NULL)
			BEGIN
				Select @Old_ItemDisplay = MetroName from tb_erm_Metro_DistrictMunicipality Where MetroID = @Old_Municipality
				
				INSERT INTO tb_erm_audit_log(PkId,TableName,ColumnName,OldValue,NewValue,UpdtUser)
				VALUES (@ProjectAdaptationDataId,'tb_erm_Project_Adaptation_Data','Metro/District Municipality',@Old_ItemDisplay,'',@UPDTUSER)		
			END

			--LocalMunicipality
			SET @Old_ItemDisplay = ''
			SET @New_ItemDisplay = ''
			IF(@Old_LocalMunicipality IS NULL AND @New_LocalMunicipality IS NOT NULL)
			BEGIN			
				Select @New_ItemDisplay = LocalMunicipalityName from tb_erm_Local_Municipalities where LocalMunicipalityID = @New_LocalMunicipality

				INSERT INTO tb_erm_audit_log(PkId,TableName,ColumnName,OldValue,NewValue,UpdtUser)
				VALUES (@ProjectAdaptationDataId,'tb_erm_Project_Adaptation_Data','Local Municipality','',@New_ItemDisplay,@UPDTUSER)	
			END
			ELSE IF(@Old_LocalMunicipality IS NOT NULL AND @New_LocalMunicipality IS NOT NULL)
			BEGIN
				IF NOT (@Old_LocalMunicipality = @New_LocalMunicipality)
				BEGIN
					Select @Old_ItemDisplay = LocalMunicipalityName from tb_erm_Local_Municipalities where LocalMunicipalityID = @Old_LocalMunicipality
					Select @New_ItemDisplay = LocalMunicipalityName from tb_erm_Local_Municipalities where LocalMunicipalityID = @New_LocalMunicipality

					INSERT INTO tb_erm_audit_log(PkId,TableName,ColumnName,OldValue,NewValue,UpdtUser)
					VALUES (@ProjectAdaptationDataId,'tb_erm_Project_Adaptation_Data','Local Municipality',@Old_ItemDisplay,@New_ItemDisplay,@UPDTUSER)
				END
			END
			ELSE IF(@Old_LocalMunicipality IS NOT NULL AND @New_LocalMunicipality IS NULL)
			BEGIN
				Select @Old_ItemDisplay = LocalMunicipalityName from tb_erm_Local_Municipalities where LocalMunicipalityID = @Old_LocalMunicipality
				
				INSERT INTO tb_erm_audit_log(PkId,TableName,ColumnName,OldValue,NewValue,UpdtUser)
				VALUES (@ProjectAdaptationDataId,'tb_erm_Project_Adaptation_Data','Local Municipality',@Old_ItemDisplay,'',@UPDTUSER)		
			END

			--City
			SET @Old_ItemDisplay = ''
			SET @New_ItemDisplay = ''
			IF(@Old_City IS NULL AND @New_City IS NOT NULL)
			BEGIN			
				Select @New_ItemDisplay = TownName from tb_erm_Town where TownID = @New_City

				INSERT INTO tb_erm_audit_log(PkId,TableName,ColumnName,OldValue,NewValue,UpdtUser)
				VALUES (@ProjectAdaptationDataId,'tb_erm_Project_Adaptation_Data','City/Town','',@New_ItemDisplay,@UPDTUSER)	
			END
			ELSE IF(@Old_City IS NOT NULL AND @New_City IS NOT NULL)
			BEGIN
				IF NOT (@Old_City = @New_City)
				BEGIN
					Select @Old_ItemDisplay = TownName from tb_erm_Town where TownID = @Old_City
					Select @New_ItemDisplay = TownName from tb_erm_Town where TownID = @New_City

					INSERT INTO tb_erm_audit_log(PkId,TableName,ColumnName,OldValue,NewValue,UpdtUser)
					VALUES (@ProjectAdaptationDataId,'tb_erm_Project_Adaptation_Data','City/Town',@Old_ItemDisplay,@New_ItemDisplay,@UPDTUSER)
				END
			END
			ELSE IF(@Old_City IS NOT NULL AND @New_City IS NULL)
			BEGIN
				Select @Old_ItemDisplay = TownName from tb_erm_Town where TownID = @Old_City
				
				INSERT INTO tb_erm_audit_log(PkId,TableName,ColumnName,OldValue,NewValue,UpdtUser)
				VALUES (@ProjectAdaptationDataId,'tb_erm_Project_Adaptation_Data','City/Town',@Old_ItemDisplay,'',@UPDTUSER)		
			END

			--LatDegree
			IF(@Old_LatDegree IS NULL AND @New_LatDegree IS NOT NULL)
			BEGIN			
				INSERT INTO tb_erm_audit_log(PkId,TableName,ColumnName,OldValue,NewValue,UpdtUser)
				VALUES (@ProjectAdaptationDataId,'tb_erm_Project_Adaptation_Data','Latitude(Degree)','',CONVERT(nvarchar(100),@New_LatDegree),@UPDTUSER)	
			END
			ELSE IF(@Old_LatDegree IS NOT NULL AND @New_LatDegree IS NOT NULL)
			BEGIN
				IF NOT (@Old_LatDegree = @New_LatDegree)
				BEGIN				
					INSERT INTO tb_erm_audit_log(PkId,TableName,ColumnName,OldValue,NewValue,UpdtUser)
					VALUES (@ProjectAdaptationDataId,'tb_erm_Project_Adaptation_Data','Latitude(Degree)',CONVERT(nvarchar(100),@Old_LatDegree),Convert(nvarchar(100),@New_LatDegree),@UPDTUSER)
				END
			END
			ELSE IF(@Old_LatDegree IS NOT NULL AND @New_LatDegree IS NULL)
			BEGIN
				INSERT INTO tb_erm_audit_log(PkId,TableName,ColumnName,OldValue,NewValue,UpdtUser)
				VALUES (@ProjectAdaptationDataId,'tb_erm_Project_Adaptation_Data','Latitude(Degree)',CONVERT(nvarchar(100),@Old_LatDegree),'',@UPDTUSER)		
			END

			--LatMinutes
			IF(@Old_LatMinutes IS NULL AND @New_LatMinutes IS NOT NULL)
			BEGIN			
				INSERT INTO tb_erm_audit_log(PkId,TableName,ColumnName,OldValue,NewValue,UpdtUser)
				VALUES (@ProjectAdaptationDataId,'tb_erm_Project_Adaptation_Data','Latitude(Minutes)','',CONVERT(nvarchar(100),@New_LatMinutes),@UPDTUSER)	
			END
			ELSE IF(@Old_LatMinutes IS NOT NULL AND @New_LatMinutes IS NOT NULL)
			BEGIN
				IF NOT (@Old_LatMinutes = @New_LatMinutes)
				BEGIN				
					INSERT INTO tb_erm_audit_log(PkId,TableName,ColumnName,OldValue,NewValue,UpdtUser)
					VALUES (@ProjectAdaptationDataId,'tb_erm_Project_Adaptation_Data','Latitude(Minutes)',CONVERT(nvarchar(100),@Old_LatMinutes),Convert(nvarchar(100),@New_LatMinutes),@UPDTUSER)
				END
			END
			ELSE IF(@Old_LatMinutes IS NOT NULL AND @New_LatMinutes IS NULL)
			BEGIN
				INSERT INTO tb_erm_audit_log(PkId,TableName,ColumnName,OldValue,NewValue,UpdtUser)
				VALUES (@ProjectAdaptationDataId,'tb_erm_Project_Adaptation_Data','Latitude(Minutes)',CONVERT(nvarchar(100),@Old_LatMinutes),'',@UPDTUSER)		
			END

			--LatSeconds
			IF(@Old_LatSeconds IS NULL AND @New_LatSeconds IS NOT NULL)
			BEGIN			
				INSERT INTO tb_erm_audit_log(PkId,TableName,ColumnName,OldValue,NewValue,UpdtUser)
				VALUES (@ProjectAdaptationDataId,'tb_erm_Project_Adaptation_Data','Latitude(Seconds)','',CONVERT(nvarchar(100),@New_LatSeconds),@UPDTUSER)	
			END
			ELSE IF(@Old_LatSeconds IS NOT NULL AND @New_LatSeconds IS NOT NULL)
			BEGIN
				IF NOT (@Old_LatSeconds = @New_LatSeconds)
				BEGIN				
					INSERT INTO tb_erm_audit_log(PkId,TableName,ColumnName,OldValue,NewValue,UpdtUser)
					VALUES (@ProjectAdaptationDataId,'tb_erm_Project_Adaptation_Data','Latitude(Seconds)',CONVERT(nvarchar(100),@Old_LatSeconds),Convert(nvarchar(100),@New_LatSeconds),@UPDTUSER)
				END
			END
			ELSE IF(@Old_LatSeconds IS NOT NULL AND @New_LatSeconds IS NULL)
			BEGIN
				INSERT INTO tb_erm_audit_log(PkId,TableName,ColumnName,OldValue,NewValue,UpdtUser)
				VALUES (@ProjectAdaptationDataId,'tb_erm_Project_Adaptation_Data','Latitude(Seconds)',CONVERT(nvarchar(100),@Old_LatSeconds),'',@UPDTUSER)		
			END

			--LatCalculated
			/*IF(@Old_LatCalculated IS NULL AND @New_LatCalculated IS NOT NULL)
			BEGIN			
				INSERT INTO tb_erm_audit_log(PkId,TableName,ColumnName,OldValue,NewValue,UpdtUser)
				VALUES (@ProjectAdaptationDataId,'tb_erm_Project_Adaptation_Data','Latitude(Calculated)','',CONVERT(nvarchar(100),@New_LatCalculated),@UPDTUSER)	
			END
			ELSE IF(@Old_LatCalculated IS NOT NULL AND @New_LatCalculated IS NOT NULL)
			BEGIN
				IF NOT (@Old_LatCalculated = @New_LatCalculated)
				BEGIN				
					INSERT INTO tb_erm_audit_log(PkId,TableName,ColumnName,OldValue,NewValue,UpdtUser)
					VALUES (@ProjectAdaptationDataId,'tb_erm_Project_Adaptation_Data','Latitude(Calculated)',CONVERT(nvarchar(100),@Old_LatCalculated),Convert(nvarchar(100),@New_LatCalculated),@UPDTUSER)
				END
			END
			ELSE IF(@Old_LatCalculated IS NOT NULL AND @New_LatCalculated IS NULL)
			BEGIN
				INSERT INTO tb_erm_audit_log(PkId,TableName,ColumnName,OldValue,NewValue,UpdtUser)
				VALUES (@ProjectAdaptationDataId,'tb_erm_Project_Adaptation_Data','Latitude(Calculated)',CONVERT(nvarchar(100),@Old_LatCalculated),'',@UPDTUSER)		
			END*/

			--LonDegree
			IF(@Old_LonDegree IS NULL AND @New_LonDegree IS NOT NULL)
			BEGIN			
				INSERT INTO tb_erm_audit_log(PkId,TableName,ColumnName,OldValue,NewValue,UpdtUser)
				VALUES (@ProjectAdaptationDataId,'tb_erm_Project_Adaptation_Data','Longitude(Degree)','',CONVERT(nvarchar(100),@New_LonDegree),@UPDTUSER)	
			END
			ELSE IF(@Old_LonDegree IS NOT NULL AND @New_LonDegree IS NOT NULL)
			BEGIN
				IF NOT (@Old_LonDegree = @New_LonDegree)
				BEGIN				
					INSERT INTO tb_erm_audit_log(PkId,TableName,ColumnName,OldValue,NewValue,UpdtUser)
					VALUES (@ProjectAdaptationDataId,'tb_erm_Project_Adaptation_Data','Longitude(Degree)',CONVERT(nvarchar(100),@Old_LonDegree),Convert(nvarchar(100),@New_LonDegree),@UPDTUSER)
				END
			END
			ELSE IF(@Old_LonDegree IS NOT NULL AND @New_LonDegree IS NULL)
			BEGIN
				INSERT INTO tb_erm_audit_log(PkId,TableName,ColumnName,OldValue,NewValue,UpdtUser)
				VALUES (@ProjectAdaptationDataId,'tb_erm_Project_Adaptation_Data','Longitude(Degree)',CONVERT(nvarchar(100),@Old_LonDegree),'',@UPDTUSER)		
			END

			--LonMinutes
			IF(@Old_LonMinutes IS NULL AND @New_LonMinutes IS NOT NULL)
			BEGIN			
				INSERT INTO tb_erm_audit_log(PkId,TableName,ColumnName,OldValue,NewValue,UpdtUser)
				VALUES (@ProjectAdaptationDataId,'tb_erm_Project_Adaptation_Data','Longitude(Minutes)','',CONVERT(nvarchar(100),@New_LonMinutes),@UPDTUSER)	
			END
			ELSE IF(@Old_LonMinutes IS NOT NULL AND @New_LonMinutes IS NOT NULL)
			BEGIN
				IF NOT (@Old_LonMinutes = @New_LonMinutes)
				BEGIN				
					INSERT INTO tb_erm_audit_log(PkId,TableName,ColumnName,OldValue,NewValue,UpdtUser)
					VALUES (@ProjectAdaptationDataId,'tb_erm_Project_Adaptation_Data','Longitude(Minutes)',CONVERT(nvarchar(100),@Old_LonMinutes),Convert(nvarchar(100),@New_LonMinutes),@UPDTUSER)
				END
			END
			ELSE IF(@Old_LonMinutes IS NOT NULL AND @New_LonMinutes IS NULL)
			BEGIN
				INSERT INTO tb_erm_audit_log(PkId,TableName,ColumnName,OldValue,NewValue,UpdtUser)
				VALUES (@ProjectAdaptationDataId,'tb_erm_Project_Adaptation_Data','Longitude(Minutes)',CONVERT(nvarchar(100),@Old_LonMinutes),'',@UPDTUSER)		
			END

			--LonSeconds
			IF(@Old_LonSeconds IS NULL AND @New_LonSeconds IS NOT NULL)
			BEGIN			
				INSERT INTO tb_erm_audit_log(PkId,TableName,ColumnName,OldValue,NewValue,UpdtUser)
				VALUES (@ProjectAdaptationDataId,'tb_erm_Project_Adaptation_Data','Longitude(Seconds)','',CONVERT(nvarchar(100),@New_LonSeconds),@UPDTUSER)	
			END
			ELSE IF(@Old_LonSeconds IS NOT NULL AND @New_LonSeconds IS NOT NULL)
			BEGIN
				IF NOT (@Old_LonSeconds = @New_LonSeconds)
				BEGIN				
					INSERT INTO tb_erm_audit_log(PkId,TableName,ColumnName,OldValue,NewValue,UpdtUser)
					VALUES (@ProjectAdaptationDataId,'tb_erm_Project_Adaptation_Data','Longitude(Seconds)',CONVERT(nvarchar(100),@Old_LonSeconds),Convert(nvarchar(100),@New_LonSeconds),@UPDTUSER)
				END
			END
			ELSE IF(@Old_LonSeconds IS NOT NULL AND @New_LonSeconds IS NULL)
			BEGIN
				INSERT INTO tb_erm_audit_log(PkId,TableName,ColumnName,OldValue,NewValue,UpdtUser)
				VALUES (@ProjectAdaptationDataId,'tb_erm_Project_Adaptation_Data','Longitude(Seconds)',CONVERT(nvarchar(100),@Old_LonSeconds),'',@UPDTUSER)		
			END

			--LonCalculated
			/*IF(@Old_LonCalculated IS NULL AND @New_LonCalculated IS NOT NULL)
			BEGIN			
				INSERT INTO tb_erm_audit_log(PkId,TableName,ColumnName,OldValue,NewValue,UpdtUser)
				VALUES (@ProjectAdaptationDataId,'tb_erm_Project_Adaptation_Data','Longitude(Calculated)','',CONVERT(nvarchar(100),@New_LonCalculated),@UPDTUSER)	
			END
			ELSE IF(@Old_LonCalculated IS NOT NULL AND @New_LonCalculated IS NOT NULL)
			BEGIN
				IF NOT (@Old_LonCalculated = @New_LonCalculated)
				BEGIN				
					INSERT INTO tb_erm_audit_log(PkId,TableName,ColumnName,OldValue,NewValue,UpdtUser)
					VALUES (@ProjectAdaptationDataId,'tb_erm_Project_Adaptation_Data','Longitude(Calculated)',CONVERT(nvarchar(100),@Old_LonCalculated),Convert(nvarchar(100),@New_LonCalculated),@UPDTUSER)
				END
			END
			ELSE IF(@Old_LonCalculated IS NOT NULL AND @New_LonCalculated IS NULL)
			BEGIN
				INSERT INTO tb_erm_audit_log(PkId,TableName,ColumnName,OldValue,NewValue,UpdtUser)
				VALUES (@ProjectAdaptationDataId,'tb_erm_Project_Adaptation_Data','Longitude(Calculated)',CONVERT(nvarchar(100),@Old_LonCalculated),'',@UPDTUSER)		
			END*/
			
			--HostSector
			SET @Old_ItemDisplay = ''
			SET @New_ItemDisplay = ''
			IF(@Old_HostSector IS NULL AND @New_HostSector IS NOT NULL)
			BEGIN
				Select @New_ItemDisplay = ItemDisplay from tb_erm_picklist_value where ListId IN (SELECT ListId from tb_erm_picklist where ListName like 'Adaptation Host Sector') and ItemNum = @New_HostSector
			
				INSERT INTO tb_erm_audit_log(PkId,TableName,ColumnName,OldValue,NewValue,UpdtUser)
				VALUES (@ProjectAdaptationDataId,'tb_erm_Project_Adaptation_Data','Host Sector','',@New_ItemDisplay,@UPDTUSER)	
			END
			ELSE IF(@Old_HostSector IS NOT NULL AND @New_HostSector IS NOT NULL)
			BEGIN
				IF NOT (@Old_HostSector = @New_HostSector)
				BEGIN
					Select @Old_ItemDisplay = ItemDisplay from tb_erm_picklist_value where ListId IN (SELECT ListId from tb_erm_picklist where ListName like 'Adaptation Host Sector') and ItemNum = @Old_HostSector
					Select @New_ItemDisplay = ItemDisplay from tb_erm_picklist_value where ListId IN (SELECT ListId from tb_erm_picklist where ListName like 'Adaptation Host Sector') and ItemNum = @New_HostSector

					INSERT INTO tb_erm_audit_log(PkId,TableName,ColumnName,OldValue,NewValue,UpdtUser)
					VALUES (@ProjectAdaptationDataId,'tb_erm_Project_Adaptation_Data','Host Sector',@Old_ItemDisplay,@New_ItemDisplay,@UPDTUSER)
				END
			END
			ELSE IF(@Old_HostSector IS NOT NULL AND @New_HostSector IS NULL)
			BEGIN
				Select @Old_ItemDisplay = ItemDisplay from tb_erm_picklist_value where ListId IN (SELECT ListId from tb_erm_picklist where ListName like 'Adaptation Host Sector') and ItemNum = @Old_HostSector
				
				INSERT INTO tb_erm_audit_log(PkId,TableName,ColumnName,OldValue,NewValue,UpdtUser)
				VALUES (@ProjectAdaptationDataId,'tb_erm_Project_Adaptation_Data','Host Sector', @Old_ItemDisplay,'',@UPDTUSER)		
			END

			--PurposeOfAdaptation
			SET @Old_ItemDisplay = ''
			SET @New_ItemDisplay = ''
			IF(@Old_PurposeOfAdaptation IS NULL AND @New_PurposeOfAdaptation IS NOT NULL)
			BEGIN
				Select @New_ItemDisplay = ItemDisplay from tb_erm_picklist_value where ListId IN (SELECT ListId from tb_erm_picklist where ListName like 'Purpose of adaptation') and ItemNum = @New_PurposeOfAdaptation
			
				INSERT INTO tb_erm_audit_log(PkId,TableName,ColumnName,OldValue,NewValue,UpdtUser)
				VALUES (@ProjectAdaptationDataId,'tb_erm_Project_Adaptation_Data','Purpose Of Adaptation','',@New_ItemDisplay,@UPDTUSER)	
			END
			ELSE IF(@Old_PurposeOfAdaptation IS NOT NULL AND @New_PurposeOfAdaptation IS NOT NULL)
			BEGIN
				IF NOT (@Old_PurposeOfAdaptation = @New_PurposeOfAdaptation)
				BEGIN
					Select @Old_ItemDisplay = ItemDisplay from tb_erm_picklist_value where ListId IN (SELECT ListId from tb_erm_picklist where ListName like 'Purpose of adaptation') and ItemNum = @Old_PurposeOfAdaptation
					Select @New_ItemDisplay = ItemDisplay from tb_erm_picklist_value where ListId IN (SELECT ListId from tb_erm_picklist where ListName like 'Purpose of adaptation') and ItemNum = @New_PurposeOfAdaptation

					INSERT INTO tb_erm_audit_log(PkId,TableName,ColumnName,OldValue,NewValue,UpdtUser)
					VALUES (@ProjectAdaptationDataId,'tb_erm_Project_Adaptation_Data','Purpose Of Adaptation',@Old_ItemDisplay,@New_ItemDisplay,@UPDTUSER)
				END
			END
			ELSE IF(@Old_PurposeOfAdaptation IS NOT NULL AND @New_PurposeOfAdaptation IS NULL)
			BEGIN
				Select @Old_ItemDisplay = ItemDisplay from tb_erm_picklist_value where ListId IN (SELECT ListId from tb_erm_picklist where ListName like 'Purpose of adaptation') and ItemNum = @Old_PurposeOfAdaptation
				
				INSERT INTO tb_erm_audit_log(PkId,TableName,ColumnName,OldValue,NewValue,UpdtUser)
				VALUES (@ProjectAdaptationDataId,'tb_erm_Project_Adaptation_Data','Purpose Of Adaptation', @Old_ItemDisplay,'',@UPDTUSER)		
			END

		END

        RETURN
		ERROR:
		RAISERROR @ERRNO @ERRMSG
		ROLLBACK TRANSACTION
	END

GO
ALTER TABLE [dbo].[tb_erm_Project_Adaptation_Data] ENABLE TRIGGER [tU_tb_erm_Project_Adaptation_Data]
GO
/****** Object:  Trigger [dbo].[td_tb_erm_project_details]    Script Date: 2018/12/03 07:46:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[td_tb_erm_project_details] ON [dbo].[tb_erm_project_details]  AFTER DELETE  AS
BEGIN	
declare @Id int
select @Id=ProjectDetailsId from Deleted
delete from dbo.tb_erm_audit_log where PkId=@id and TableName='tb_erm_project_details'
END
GO
ALTER TABLE [dbo].[tb_erm_project_details] ENABLE TRIGGER [td_tb_erm_project_details]
GO
/****** Object:  Trigger [dbo].[tI_tb_erm_project_details]    Script Date: 2018/12/03 07:46:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tI_tb_erm_project_details] ON [dbo].[tb_erm_project_details] FOR INSERT AS
	BEGIN
		DECLARE @NUMROWS INT,
		@NULLCNT INT,
		@VALIDCNT INT,
		@ERRNO   INT,
		@ERRMSG  NVARCHAR(255),
		@USRID NVARCHAR(255)

		SELECT @NUMROWS = @@ROWCOUNT
		/* UPDATE USER NAME AND TIME */
		UPDATE tb_erm_project_details SET  UpdtTime = GETDATE()
		FROM tb_erm_project_details, INSERTED WHERE tb_erm_project_details.ProjectDetailsId = INSERTED.ProjectDetailsId
		RETURN
		ERROR:
		RAISERROR @ERRNO @ERRMSG
		ROLLBACK TRANSACTION
	END
GO
ALTER TABLE [dbo].[tb_erm_project_details] DISABLE TRIGGER [tI_tb_erm_project_details]
GO
/****** Object:  Trigger [dbo].[tU_tb_erm_project_details]    Script Date: 2018/12/03 07:46:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tU_tb_erm_project_details] ON [dbo].[tb_erm_project_details] FOR UPDATE AS
	BEGIN
		DECLARE @NUMROWS INT,
		@NULLCNT INT,
		@VALIDCNT INT,
		@ERRNO   INT,
		@ERRMSG  NVARCHAR(255),
		@COUNT   INT,
		@PROJECTDETAILSID INT,
		@UPDTUSER nvarchar(50),
		@Old_ProjectTitle nvarchar(100),
		@New_ProjectTitle nvarchar(100),
		@Old_TypeOfProject int,
		@New_TypeOfProject int,
		@Old_TypeOfIntervention int,
		@New_TypeOfIntervention int,
		@Old_LeadAgent nvarchar(50),
		@New_LeadAgent nvarchar(50),
		@Old_HostPartner nvarchar(100),
		@New_HostPartner nvarchar(100),
		@Old_FundingOrganisation nvarchar(50),
		@New_FundingOrganisation nvarchar(50),
		@Old_FundingPartner nvarchar(100),
		@New_FundingPartner nvarchar(100),
		@Old_HostOrganisation nvarchar(50),
		@New_HostOrganisation nvarchar(50),
		@Old_FUNDINGSTATUS int,
		@New_FUNDINGSTATUS int,
		@Old_ItemDisplay nvarchar(255),
		@New_ItemDisplay nvarchar(255),
		@Old_Status int,
		@New_Status int,
		@Old_BudgetLower float,
		@New_BudgetLower float,
		@Old_BudgetUpper float,
		@New_BudgetUpper float,
		@Old_StartYear int,
		@New_StartYear int,
		@Old_EndYear int,
		@New_EndYear int,
		@Old_Description nvarchar(4000),
		@New_Description nvarchar(4000),
		@Old_Link nvarchar(100),
		@New_Link nvarchar(100),
		@Old_AlternativeContact nvarchar(150),
		@New_AlternativeContact nvarchar(150),
		@Old_AlternativeContactEmail nvarchar(150),
		@New_AlternativeContactEmail nvarchar(150),
		@Old_VALIDATIONCOMMENTS nvarchar(255),
		@New_VALIDATIONCOMMENTS nvarchar(255),
		@Old_ProjectManager int,
		@New_ProjectManager int,
		@Old_ValidationStatus int,
		@New_ValidationStatus int

		SELECT @NUMROWS = @@ROWCOUNT
		UPDATE tb_erm_project_details SET
			UPDTTIME = GETDATE()
		FROM tb_erm_project_details, INSERTED WHERE tb_erm_project_details.ProjectDetailsId  = INSERTED.ProjectDetailsId
		
  		select @UPDTUSER = inserted.UpdtUser, @PROJECTDETAILSID = deleted.ProjectDetailsId, @Old_ProjectTitle = deleted.ProjectTitle, @New_ProjectTitle = inserted.ProjectTitle,
		@Old_TypeOfProject = deleted.TypeOfProject, @New_TypeOfProject = inserted.TypeOfProject,
		@Old_TypeOfIntervention = deleted.TypeOfIntervention, @New_TypeOfIntervention = inserted.TypeOfIntervention,
		@Old_LeadAgent = deleted.LeadAgent, @New_LeadAgent = inserted.LeadAgent,
		@Old_HostPartner = deleted.HostPartner, @New_HostPartner = inserted.HostPartner,
		@Old_FundingOrganisation = deleted.FundingOrganisation, @New_FundingOrganisation = inserted.FundingOrganisation,
		@Old_FundingPartner = deleted.FundingPartner, @New_FundingPartner = inserted.FundingPartner,
		@Old_HostOrganisation = deleted.HostOrganisation, @New_HostOrganisation = inserted.HostOrganisation,
		@Old_FUNDINGSTATUS = deleted.FUNDINGSTATUS, @New_FUNDINGSTATUS = inserted.FUNDINGSTATUS,
		@Old_Status = deleted.Status, @New_Status = inserted.Status,
		@Old_BudgetLower = deleted.BudgetLower, @New_BudgetLower = inserted.BudgetLower,
		@Old_BudgetUpper = deleted.BudgetUpper, @New_BudgetUpper = inserted.BudgetUpper,
		@Old_StartYear = deleted.StartYear, @New_StartYear = inserted.StartYear,
		@Old_EndYear = deleted.EndYear, @New_EndYear = inserted.EndYear,
		@Old_Description = deleted.Description, @New_Description = inserted.Description,
		@Old_Link = deleted.Link, @New_Link = inserted.Link,
		@Old_AlternativeContact = deleted.AlternativeContact, @New_AlternativeContact = inserted.AlternativeContact,
		@Old_AlternativeContactEmail = deleted.AlternativeContactEmail, @New_AlternativeContactEmail = inserted.AlternativeContactEmail,
		@Old_VALIDATIONCOMMENTS = deleted.VALIDATIONCOMMENTS, @New_VALIDATIONCOMMENTS = inserted.VALIDATIONCOMMENTS,
		@Old_ProjectManager = deleted.ProjectManager, @New_ProjectManager = inserted.ProjectManager,
		@Old_ValidationStatus = deleted.ValidationStatus, @New_ValidationStatus = inserted.ValidationStatus
		from inserted,deleted

		IF EXISTS(select * from tb_erm_project_details where validationstatus in 
		(select itemnum from tb_erm_picklist_value where listid in 
		(select listid from tb_erm_picklist where listname like 'DEAT Validation Status') and Itemdisplay like 'Accepted')
		and projectdetailsid = @PROJECTDETAILSID)
		BEGIN
		
			--ProjectTitle
			IF NOT (@Old_ProjectTitle = @New_ProjectTitle)
			BEGIN
				INSERT INTO tb_erm_audit_log(PkId,TableName,ColumnName,OldValue,NewValue,UpdtUser)
				VALUES (@PROJECTDETAILSID,'tb_erm_project_details','Project Title',@Old_ProjectTitle,@New_ProjectTitle,@UPDTUSER)
			END

			--TypeOfProject
			IF NOT (@Old_TypeOfProject = @New_TypeOfProject)
			BEGIN
				IF (@New_TypeOfProject = 1)
				BEGIN
					INSERT INTO tb_erm_audit_log(PkId,TableName,ColumnName,OldValue,NewValue,UpdtUser)
					VALUES (@PROJECTDETAILSID,'tb_erm_project_details','Type Of Project','Research','Project',@UPDTUSER)
				END

				IF (@New_TypeOfProject = 2)
				BEGIN
					INSERT INTO tb_erm_audit_log(PkId,TableName,ColumnName,OldValue,NewValue,UpdtUser)
					VALUES (@PROJECTDETAILSID,'tb_erm_project_details','Type Of Project','Project','Research',@UPDTUSER)
				END
			END
	     
			--TypeOfIntervention
			IF NOT (@Old_TypeOfIntervention = @New_TypeOfIntervention)
			BEGIN
				IF (@New_TypeOfIntervention = 1)
				BEGIN
					INSERT INTO tb_erm_audit_log(PkId,TableName,ColumnName,OldValue,NewValue,UpdtUser)
					VALUES (@PROJECTDETAILSID,'tb_erm_project_details','Type Of Intervention','Adaptation','Mitigation',@UPDTUSER)
				END

				IF (@New_TypeOfIntervention = 2)
				BEGIN
					INSERT INTO tb_erm_audit_log(PkId,TableName,ColumnName,OldValue,NewValue,UpdtUser)
					VALUES (@PROJECTDETAILSID,'tb_erm_project_details','Type Of Intervention','Mitigation','Adaptation',@UPDTUSER)
				END
			END

			--LeadAgent
			IF NOT (@Old_LeadAgent = @New_LeadAgent)
			BEGIN
				INSERT INTO tb_erm_audit_log(PkId,TableName,ColumnName,OldValue,NewValue,UpdtUser)
				VALUES (@PROJECTDETAILSID,'tb_erm_project_details','Lead Organisation',@Old_LeadAgent,@New_LeadAgent,@UPDTUSER)
			END

			--HostPartner
			IF NOT (@Old_HostPartner = @New_HostPartner)
			BEGIN
				INSERT INTO tb_erm_audit_log(PkId,TableName,ColumnName,OldValue,NewValue,UpdtUser)
				VALUES (@PROJECTDETAILSID,'tb_erm_project_details','Lead Partner(s)',@Old_HostPartner,@New_HostPartner,@UPDTUSER)
			END

			--FundingOrganisation
			IF NOT (@Old_FundingOrganisation = @New_FundingOrganisation)
			BEGIN
				INSERT INTO tb_erm_audit_log(PkId,TableName,ColumnName,OldValue,NewValue,UpdtUser)
				VALUES (@PROJECTDETAILSID,'tb_erm_project_details','Funding Organisation',@Old_FundingOrganisation,@New_FundingOrganisation,@UPDTUSER)
			END

			--FundingPartner
			IF NOT (@Old_FundingPartner = @New_FundingPartner)
			BEGIN
				INSERT INTO tb_erm_audit_log(PkId,TableName,ColumnName,OldValue,NewValue,UpdtUser)
				VALUES (@PROJECTDETAILSID,'tb_erm_project_details','Funding Partner(s)',@Old_FundingPartner,@New_FundingPartner,@UPDTUSER)
			END

			--HostOrganisation
			IF NOT (@Old_HostOrganisation = @New_HostOrganisation)
			BEGIN
				INSERT INTO tb_erm_audit_log(PkId,TableName,ColumnName,OldValue,NewValue,UpdtUser)
				VALUES (@PROJECTDETAILSID,'tb_erm_project_details','Host Organisation',@Old_HostOrganisation,@New_HostOrganisation,@UPDTUSER)
			END
			
			--FUNDINGSTATUS
			SET @Old_ItemDisplay = ''
			SET @New_ItemDisplay = ''
			IF(@Old_FUNDINGSTATUS IS NULL AND @New_FUNDINGSTATUS IS NOT NULL)
			BEGIN
				Select @New_ItemDisplay = ItemDisplay from tb_erm_picklist_value where ListId IN (SELECT ListId from tb_erm_picklist where ListName like 'Funding Status') and ItemNum = @New_FUNDINGSTATUS
			
				INSERT INTO tb_erm_audit_log(PkId,TableName,ColumnName,OldValue,NewValue,UpdtUser)
				VALUES (@PROJECTDETAILSID,'tb_erm_project_details','Funding Status','',@New_ItemDisplay,@UPDTUSER)	
			END
			ELSE IF(@Old_FUNDINGSTATUS IS NOT NULL AND @New_FUNDINGSTATUS IS NOT NULL)
			BEGIN
				IF NOT (@Old_FUNDINGSTATUS = @New_FUNDINGSTATUS)
				BEGIN
					Select @Old_ItemDisplay = ItemDisplay from tb_erm_picklist_value where ListId IN (SELECT ListId from tb_erm_picklist where ListName like 'Funding Status') and ItemNum = @Old_FUNDINGSTATUS
					Select @New_ItemDisplay = ItemDisplay from tb_erm_picklist_value where ListId IN (SELECT ListId from tb_erm_picklist where ListName like 'Funding Status') and ItemNum = @New_FUNDINGSTATUS

					INSERT INTO tb_erm_audit_log(PkId,TableName,ColumnName,OldValue,NewValue,UpdtUser)
					VALUES (@PROJECTDETAILSID,'tb_erm_project_details','Funding Status',@Old_ItemDisplay,@New_ItemDisplay,@UPDTUSER)
				END
			END
			ELSE IF(@Old_FUNDINGSTATUS IS NOT NULL AND @New_FUNDINGSTATUS IS NULL)
			BEGIN
				Select @Old_ItemDisplay = ItemDisplay from tb_erm_picklist_value where ListId IN (SELECT ListId from tb_erm_picklist where ListName like 'Funding Status') and ItemNum = @Old_FUNDINGSTATUS
				
				INSERT INTO tb_erm_audit_log(PkId,TableName,ColumnName,OldValue,NewValue,UpdtUser)
				VALUES (@PROJECTDETAILSID,'tb_erm_project_details','Funding Status',@Old_ItemDisplay,'',@UPDTUSER)		
			END

			--Status
			SET @Old_ItemDisplay = ''
			SET @New_ItemDisplay = ''
			IF(@Old_Status IS NULL AND @New_Status IS NOT NULL)
			BEGIN
				Select @New_ItemDisplay = ItemDisplay from tb_erm_picklist_value where ListId IN (SELECT ListId from tb_erm_picklist where ListName like 'CDM Status') and ItemNum = @New_Status
			
				INSERT INTO tb_erm_audit_log(PkId,TableName,ColumnName,OldValue,NewValue,UpdtUser)
				VALUES (@PROJECTDETAILSID,'tb_erm_project_details','Status','',@New_ItemDisplay,@UPDTUSER)	
			END
			ELSE IF(@Old_Status IS NOT NULL AND @New_Status IS NOT NULL)
			BEGIN
				IF NOT (@Old_Status = @New_Status)
				BEGIN
					Select @Old_ItemDisplay = ItemDisplay from tb_erm_picklist_value where ListId IN (SELECT ListId from tb_erm_picklist where ListName like 'CDM Status') and ItemNum = @Old_Status
					Select @New_ItemDisplay = ItemDisplay from tb_erm_picklist_value where ListId IN (SELECT ListId from tb_erm_picklist where ListName like 'CDM Status') and ItemNum = @New_Status

					INSERT INTO tb_erm_audit_log(PkId,TableName,ColumnName,OldValue,NewValue,UpdtUser)
					VALUES (@PROJECTDETAILSID,'tb_erm_project_details','Status',@Old_ItemDisplay,@New_ItemDisplay,@UPDTUSER)
				END
			END
			ELSE IF(@Old_Status IS NOT NULL AND @New_Status IS NULL)
			BEGIN
				Select @Old_ItemDisplay = ItemDisplay from tb_erm_picklist_value where ListId IN (SELECT ListId from tb_erm_picklist where ListName like 'CDM Status') and ItemNum = @Old_Status
				
				INSERT INTO tb_erm_audit_log(PkId,TableName,ColumnName,OldValue,NewValue,UpdtUser)
				VALUES (@PROJECTDETAILSID,'tb_erm_project_details','Status', @Old_ItemDisplay,'',@UPDTUSER)		
			END

			--BudgetLower
			IF(@Old_BudgetLower IS NULL AND @New_BudgetLower IS NOT NULL)
			BEGIN
				INSERT INTO tb_erm_audit_log(PkId,TableName,ColumnName,OldValue,NewValue,UpdtUser)
				VALUES (@PROJECTDETAILSID,'tb_erm_project_details','Estimated Budget Range ZAR (Lower)','',CONVERT(NVARCHAR(100),@New_BudgetLower),@UPDTUSER)			
			END
			ELSE IF(@Old_BudgetLower IS NOT NULL AND @New_BudgetLower IS NOT NULL)
			BEGIN
				IF NOT (@Old_BudgetLower = @New_BudgetLower)
				BEGIN
					INSERT INTO tb_erm_audit_log(PkId,TableName,ColumnName,OldValue,NewValue,UpdtUser)
					VALUES (@PROJECTDETAILSID,'tb_erm_project_details','Estimated Budget Range ZAR (Lower)',CONVERT(NVARCHAR(100),@Old_BudgetLower),CONVERT(NVARCHAR(100),@New_BudgetLower),@UPDTUSER)
				END
			END
			ELSE IF(@Old_BudgetLower IS NOT NULL AND @New_BudgetLower IS NULL)
			BEGIN
				INSERT INTO tb_erm_audit_log(PkId,TableName,ColumnName,OldValue,NewValue,UpdtUser)
				VALUES (@PROJECTDETAILSID,'tb_erm_project_details','Estimated Budget Range ZAR (Lower)',CONVERT(NVARCHAR(100),@Old_BudgetLower),'',@UPDTUSER)		
			END

			--BudgetUpper
			IF(@Old_BudgetUpper IS NULL AND @New_BudgetUpper IS NOT NULL)
			BEGIN
				INSERT INTO tb_erm_audit_log(PkId,TableName,ColumnName,OldValue,NewValue,UpdtUser)
				VALUES (@PROJECTDETAILSID,'tb_erm_project_details','Estimated Budget Range ZAR (Upper)','',CONVERT(NVARCHAR(100),@New_BudgetUpper),@UPDTUSER)			
			END
			ELSE IF(@Old_BudgetUpper IS NOT NULL AND @New_BudgetUpper IS NOT NULL)
			BEGIN
				IF NOT (@Old_BudgetUpper = @New_BudgetUpper)
				BEGIN
					INSERT INTO tb_erm_audit_log(PkId,TableName,ColumnName,OldValue,NewValue,UpdtUser)
					VALUES (@PROJECTDETAILSID,'tb_erm_project_details','Estimated Budget Range ZAR (Upper)',CONVERT(NVARCHAR(100),@Old_BudgetUpper),CONVERT(NVARCHAR(100),@New_BudgetUpper),@UPDTUSER)
				END
			END
			ELSE IF(@Old_BudgetUpper IS NOT NULL AND @New_BudgetUpper IS NULL)
			BEGIN
				INSERT INTO tb_erm_audit_log(PkId,TableName,ColumnName,OldValue,NewValue,UpdtUser)
				VALUES (@PROJECTDETAILSID,'tb_erm_project_details','Estimated Budget Range ZAR (Upper)',CONVERT(NVARCHAR(100),@Old_BudgetUpper),'',@UPDTUSER)
			END

			--StartYear
			SET @Old_ItemDisplay = ''
			SET @New_ItemDisplay = ''
			IF(@Old_StartYear IS NULL AND @New_StartYear IS NOT NULL)
			BEGIN
				Select @New_ItemDisplay = ItemDisplay from tb_erm_picklist_value where ListId IN (SELECT ListId from tb_erm_picklist where ListName like 'Year') and ItemNum = @New_StartYear
			
				INSERT INTO tb_erm_audit_log(PkId,TableName,ColumnName,OldValue,NewValue,UpdtUser)
				VALUES (@PROJECTDETAILSID,'tb_erm_project_details','Start Year','',@New_ItemDisplay,@UPDTUSER)	
			END
			ELSE IF(@Old_StartYear IS NOT NULL AND @New_StartYear IS NOT NULL)
			BEGIN
				IF NOT (@Old_StartYear = @New_StartYear)
				BEGIN
					Select @Old_ItemDisplay = ItemDisplay from tb_erm_picklist_value where ListId IN (SELECT ListId from tb_erm_picklist where ListName like 'Year') and ItemNum = @Old_StartYear
					Select @New_ItemDisplay = ItemDisplay from tb_erm_picklist_value where ListId IN (SELECT ListId from tb_erm_picklist where ListName like 'Year') and ItemNum = @New_StartYear

					INSERT INTO tb_erm_audit_log(PkId,TableName,ColumnName,OldValue,NewValue,UpdtUser)
					VALUES (@PROJECTDETAILSID,'tb_erm_project_details','Start Year',@Old_ItemDisplay,@New_ItemDisplay,@UPDTUSER)
				END
			END
			ELSE IF(@Old_StartYear IS NOT NULL AND @New_StartYear IS NULL)
			BEGIN
				Select @Old_ItemDisplay = ItemDisplay from tb_erm_picklist_value where ListId IN (SELECT ListId from tb_erm_picklist where ListName like 'Year') and ItemNum = @Old_StartYear
				
				INSERT INTO tb_erm_audit_log(PkId,TableName,ColumnName,OldValue,NewValue,UpdtUser)
				VALUES (@PROJECTDETAILSID,'tb_erm_project_details','Start Year', @Old_ItemDisplay,'',@UPDTUSER)		
			END

			--EndYear
			SET @Old_ItemDisplay = ''
			SET @New_ItemDisplay = ''
			IF(@Old_EndYear IS NULL AND @New_EndYear IS NOT NULL)
			BEGIN
				Select @New_ItemDisplay = ItemDisplay from tb_erm_picklist_value where ListId IN (SELECT ListId from tb_erm_picklist where ListName like 'Year') and ItemNum = @New_EndYear
			
				INSERT INTO tb_erm_audit_log(PkId,TableName,ColumnName,OldValue,NewValue,UpdtUser)
				VALUES (@PROJECTDETAILSID,'tb_erm_project_details','End Year','',@New_ItemDisplay,@UPDTUSER)	
			END
			ELSE IF(@Old_EndYear IS NOT NULL AND @New_EndYear IS NOT NULL)
			BEGIN
				IF NOT (@Old_EndYear = @New_EndYear)
				BEGIN
					Select @Old_ItemDisplay = ItemDisplay from tb_erm_picklist_value where ListId IN (SELECT ListId from tb_erm_picklist where ListName like 'Year') and ItemNum = @Old_EndYear
					Select @New_ItemDisplay = ItemDisplay from tb_erm_picklist_value where ListId IN (SELECT ListId from tb_erm_picklist where ListName like 'Year') and ItemNum = @New_EndYear

					INSERT INTO tb_erm_audit_log(PkId,TableName,ColumnName,OldValue,NewValue,UpdtUser)
					VALUES (@PROJECTDETAILSID,'tb_erm_project_details','End Year',@Old_ItemDisplay,@New_ItemDisplay,@UPDTUSER)
				END
			END
			ELSE IF(@Old_EndYear IS NOT NULL AND @New_EndYear IS NULL)
			BEGIN
				Select @Old_ItemDisplay = ItemDisplay from tb_erm_picklist_value where ListId IN (SELECT ListId from tb_erm_picklist where ListName like 'Year') and ItemNum = @Old_EndYear
				
				INSERT INTO tb_erm_audit_log(PkId,TableName,ColumnName,OldValue,NewValue,UpdtUser)
				VALUES (@PROJECTDETAILSID,'tb_erm_project_details','End Year', @Old_ItemDisplay,'',@UPDTUSER)		
			END

			--Description
			IF NOT (@Old_Description = @New_Description)
			BEGIN
				INSERT INTO tb_erm_audit_log(PkId,TableName,ColumnName,OldValue,NewValue,UpdtUser)
				VALUES (@PROJECTDETAILSID,'tb_erm_project_details','Description', @Old_Description,@New_Description,@UPDTUSER)
			END

			--Link
			IF NOT (@Old_Link = @New_Link)
			BEGIN
				INSERT INTO tb_erm_audit_log(PkId,TableName,ColumnName,OldValue,NewValue,UpdtUser)
				VALUES (@PROJECTDETAILSID,'tb_erm_project_details','Web Link or Reference Source', @Old_Link,@New_Link,@UPDTUSER)
			END

			--AlternativeContactEmail
			IF(@Old_AlternativeContact IS NULL AND @New_AlternativeContact IS NOT NULL)
			BEGIN
				INSERT INTO tb_erm_audit_log(PkId,TableName,ColumnName,OldValue,NewValue,UpdtUser)
				VALUES (@PROJECTDETAILSID,'tb_erm_project_details','Contact Name','',@New_AlternativeContact,@UPDTUSER)	
			END
			ELSE IF(@Old_AlternativeContact IS NOT NULL AND @New_AlternativeContact IS NOT NULL)
			BEGIN
				IF NOT (@Old_AlternativeContact = @New_AlternativeContact)
				BEGIN
					INSERT INTO tb_erm_audit_log(PkId,TableName,ColumnName,OldValue,NewValue,UpdtUser)
					VALUES (@PROJECTDETAILSID,'tb_erm_project_details','Contact Name',@Old_AlternativeContact,@New_AlternativeContact,@UPDTUSER)
				END
			END
			ELSE IF(@Old_AlternativeContact IS NOT NULL AND @New_AlternativeContact IS NULL)
			BEGIN
				INSERT INTO tb_erm_audit_log(PkId,TableName,ColumnName,OldValue,NewValue,UpdtUser)
				VALUES (@PROJECTDETAILSID,'tb_erm_project_details','Contact Name', @Old_AlternativeContact,'',@UPDTUSER)		
			END

			--AlternativeContactEmail
			IF(@Old_AlternativeContactEmail IS NULL AND @New_AlternativeContactEmail IS NOT NULL)
			BEGIN
				INSERT INTO tb_erm_audit_log(PkId,TableName,ColumnName,OldValue,NewValue,UpdtUser)
				VALUES (@PROJECTDETAILSID,'tb_erm_project_details','Contact Email','',@New_AlternativeContactEmail,@UPDTUSER)	
			END
			ELSE IF(@Old_AlternativeContactEmail IS NOT NULL AND @New_AlternativeContactEmail IS NOT NULL)
			BEGIN
				IF NOT (@Old_AlternativeContactEmail = @New_AlternativeContactEmail)
				BEGIN
					INSERT INTO tb_erm_audit_log(PkId,TableName,ColumnName,OldValue,NewValue,UpdtUser)
					VALUES (@PROJECTDETAILSID,'tb_erm_project_details','Contact Email',@Old_AlternativeContactEmail,@New_AlternativeContactEmail,@UPDTUSER)
				END
			END
			ELSE IF(@Old_AlternativeContactEmail IS NOT NULL AND @New_AlternativeContactEmail IS NULL)
			BEGIN
				INSERT INTO tb_erm_audit_log(PkId,TableName,ColumnName,OldValue,NewValue,UpdtUser)
				VALUES (@PROJECTDETAILSID,'tb_erm_project_details','Contact Email', @Old_AlternativeContactEmail,'',@UPDTUSER)		
			END

			--VALIDATIONCOMMENTS
			IF(@Old_VALIDATIONCOMMENTS IS NULL AND @New_VALIDATIONCOMMENTS IS NOT NULL)
			BEGIN
				INSERT INTO tb_erm_audit_log(PkId,TableName,ColumnName,OldValue,NewValue,UpdtUser)
				VALUES (@PROJECTDETAILSID,'tb_erm_project_details','Comments','',@New_VALIDATIONCOMMENTS,@UPDTUSER)	
			END
			ELSE IF(@Old_VALIDATIONCOMMENTS IS NOT NULL AND @New_VALIDATIONCOMMENTS IS NOT NULL)
			BEGIN
				IF NOT (@Old_VALIDATIONCOMMENTS = @New_VALIDATIONCOMMENTS)
				BEGIN
					INSERT INTO tb_erm_audit_log(PkId,TableName,ColumnName,OldValue,NewValue,UpdtUser)
					VALUES (@PROJECTDETAILSID,'tb_erm_project_details','Comments',@Old_VALIDATIONCOMMENTS,@New_VALIDATIONCOMMENTS,@UPDTUSER)
				END
			END
			ELSE IF(@Old_VALIDATIONCOMMENTS IS NOT NULL AND @New_VALIDATIONCOMMENTS IS NULL)
			BEGIN
				INSERT INTO tb_erm_audit_log(PkId,TableName,ColumnName,OldValue,NewValue,UpdtUser)
				VALUES (@PROJECTDETAILSID,'tb_erm_project_details','Comments', @Old_VALIDATIONCOMMENTS,'',@UPDTUSER)
			END

			--ProjectManager
			SET @Old_ItemDisplay = ''
			SET @New_ItemDisplay = ''
			IF NOT (@Old_ProjectManager = @New_ProjectManager)
			BEGIN
				SELECT @Old_ItemDisplay = AppUserName FROM tb_erm_appusers where AppUserID = @Old_ProjectManager
				SELECT @New_ItemDisplay = AppUserName FROM tb_erm_appusers where AppUserID = @New_ProjectManager

				INSERT INTO tb_erm_audit_log(PkId,TableName,ColumnName,OldValue,NewValue,UpdtUser)
				VALUES (@PROJECTDETAILSID,'tb_erm_project_details','Project Manager',@Old_ItemDisplay,@New_ItemDisplay,@UPDTUSER)
			END

			--ValidationStatus
			SET @Old_ItemDisplay = ''
			SET @New_ItemDisplay = ''
			IF(@Old_ValidationStatus IS NULL AND @New_ValidationStatus IS NOT NULL)
			BEGIN
				Select @New_ItemDisplay = ItemDisplay from tb_erm_picklist_value where ListId IN (SELECT ListId from tb_erm_picklist where ListName like 'DEAT Validation Status') and ItemNum = @New_ValidationStatus
			
				INSERT INTO tb_erm_audit_log(PkId,TableName,ColumnName,OldValue,NewValue,UpdtUser)
				VALUES (@PROJECTDETAILSID,'tb_erm_project_details','Acceptance Status','',@New_ItemDisplay,@UPDTUSER)	
			END
			ELSE IF(@Old_ValidationStatus IS NOT NULL AND @New_ValidationStatus IS NOT NULL)
			BEGIN
				IF NOT (@Old_ValidationStatus = @New_ValidationStatus)
				BEGIN
					Select @Old_ItemDisplay = ItemDisplay from tb_erm_picklist_value where ListId IN (SELECT ListId from tb_erm_picklist where ListName like 'DEAT Validation Status') and ItemNum = @Old_ValidationStatus
					Select @New_ItemDisplay = ItemDisplay from tb_erm_picklist_value where ListId IN (SELECT ListId from tb_erm_picklist where ListName like 'DEAT Validation Status') and ItemNum = @New_ValidationStatus

					INSERT INTO tb_erm_audit_log(PkId,TableName,ColumnName,OldValue,NewValue,UpdtUser)
					VALUES (@PROJECTDETAILSID,'tb_erm_project_details','Acceptance Status',@Old_ItemDisplay,@New_ItemDisplay,@UPDTUSER)
				END
			END
			ELSE IF(@Old_ValidationStatus IS NOT NULL AND @New_ValidationStatus IS NULL)
			BEGIN
				Select @Old_ItemDisplay = ItemDisplay from tb_erm_picklist_value where ListId IN (SELECT ListId from tb_erm_picklist where ListName like 'DEAT Validation Status') and ItemNum = @Old_ValidationStatus
				
				INSERT INTO tb_erm_audit_log(PkId,TableName,ColumnName,OldValue,NewValue,UpdtUser)
				VALUES (@PROJECTDETAILSID,'tb_erm_project_details','Acceptance Status', @Old_ItemDisplay,'',@UPDTUSER)		
			END
		
		END

        RETURN
		ERROR:
		RAISERROR @ERRNO @ERRMSG
		ROLLBACK TRANSACTION
	END

GO
ALTER TABLE [dbo].[tb_erm_project_details] ENABLE TRIGGER [tU_tb_erm_project_details]
GO
/****** Object:  Trigger [dbo].[td_tb_erm_Project_Location_Data]    Script Date: 2018/12/03 07:46:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[td_tb_erm_Project_Location_Data] ON [dbo].[tb_erm_Project_Location_Data]  AFTER DELETE  AS
BEGIN	
declare @Id int
select @Id=ProjectLocationDataId from Deleted
delete from dbo.tb_erm_audit_log where PkId in (select MitigationEmissionsDataId from tb_erm_Mitigation_Emissions_Data where ProjectLocationDataId=@Id ) 
and TableName='tb_erm_Mitigation_Emissions_Data'
delete from dbo.tb_erm_Mitigation_Emissions_Data where ProjectLocationDataId=@id
delete from dbo.tb_erm_audit_log where PkId=@id and TableName='tb_erm_Project_Location_Data'
END
GO
ALTER TABLE [dbo].[tb_erm_Project_Location_Data] ENABLE TRIGGER [td_tb_erm_Project_Location_Data]
GO
/****** Object:  Trigger [dbo].[tI_tb_erm_Project_Location_Data]    Script Date: 2018/12/03 07:46:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tI_tb_erm_Project_Location_Data] ON [dbo].[tb_erm_Project_Location_Data] FOR INSERT AS
	BEGIN
		DECLARE @NUMROWS INT,
		@NULLCNT INT,
		@VALIDCNT INT,
		@ERRNO   INT,
		@ERRMSG  NVARCHAR(255),
		@USRID NVARCHAR(255)

		SELECT @NUMROWS = @@ROWCOUNT
		/* UPDATE USER NAME AND TIME */
		UPDATE tb_erm_Project_Location_Data SET  UpdtTime = GETDATE()
		FROM tb_erm_Project_Location_Data, INSERTED WHERE tb_erm_Project_Location_Data.ProjectLocationDataId = INSERTED.ProjectLocationDataId
		
       --to update time in project details table
        UPDATE tb_erm_project_details  SET  UpdtTime = GETDATE()
		FROM tb_erm_Project_Location_Data, INSERTED WHERE tb_erm_project_details.ProjectDetailsId = INSERTED.ProjectDetailsId
 

        RETURN
		ERROR:
		RAISERROR @ERRNO @ERRMSG
		ROLLBACK TRANSACTION
	END
GO
ALTER TABLE [dbo].[tb_erm_Project_Location_Data] ENABLE TRIGGER [tI_tb_erm_Project_Location_Data]
GO
/****** Object:  Trigger [dbo].[tU_tb_erm_Project_Location_Data]    Script Date: 2018/12/03 07:46:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tU_tb_erm_Project_Location_Data] ON [dbo].[tb_erm_Project_Location_Data] FOR UPDATE AS
	BEGIN
		DECLARE @NUMROWS INT,
		@NULLCNT INT,
		@VALIDCNT INT,
		@ERRNO   INT,
		@ERRMSG  NVARCHAR(255),
		@COUNT   INT,
		@ProjectLocationDataId int,
		@PROJECTDETAILSID INT,
		@UPDTUSER nvarchar(50),
		@Old_ItemDisplay nvarchar(255),
		@New_ItemDisplay nvarchar(255),
		@Old_Province int,
		@New_Province int,
		@Old_Metro int,
		@New_Metro int,
		@Old_LocalMunicipality int,
		@New_LocalMunicipality int,
		@Old_Town int,
		@New_Town int,
		@Old_LatDegree float,
		@New_LatDegree float,
		@Old_LatMinutes float,
		@New_LatMinutes float,
		@Old_LatSeconds float,
		@New_LatSeconds float,
		@Old_LonDegree float,
		@New_LonDegree float,
		@Old_LonMinutes float,
		@New_LonMinutes float,
		@Old_LonSeconds float,
		@New_LonSeconds float,
		@Old_Comments nvarchar(4000),
		@New_Comments nvarchar(4000)

		SELECT @NUMROWS = @@ROWCOUNT
		UPDATE tb_erm_Project_Location_Data SET
			UPDTTIME = GETDATE()
		FROM tb_erm_Project_Location_Data, INSERTED WHERE tb_erm_Project_Location_Data.ProjectLocationDataId  = INSERTED.ProjectLocationDataId

         --UPDATE TIME IN PROJECT DETAILS TABLE
        UPDATE tb_erm_project_details SET
		UPDTTIME = GETDATE()
		FROM tb_erm_Project_Location_Data, INSERTED WHERE tb_erm_project_details.ProjectDetailsId  = INSERTED.ProjectDetailsId
		


		select @UPDTUSER = inserted.UpdtUser, @ProjectLocationDataId = deleted.ProjectLocationDataId, @PROJECTDETAILSID = deleted.ProjectDetailsId,
		@Old_Province = deleted.Province, @New_Province = inserted.Province,
		@Old_Metro = deleted.Metro, @New_Metro = inserted.Metro,
		@Old_LocalMunicipality = deleted.LocalMunicipality, @New_LocalMunicipality = inserted.LocalMunicipality,
		@Old_Town = deleted.Town, @New_Town = inserted.Town,
		@Old_LatDegree = deleted.LatDegree, @New_LatDegree = inserted.LatDegree,
		@Old_LatMinutes = deleted.LatMinutes, @New_LatMinutes = inserted.LatMinutes,
		@Old_LatSeconds = deleted.LatSeconds, @New_LatSeconds = inserted.LatSeconds,
		@Old_LonDegree = deleted.LonDegree, @New_LonDegree = inserted.LonDegree,
		@Old_LonMinutes = deleted.LonMinutes, @New_LonMinutes = inserted.LonMinutes,
		@Old_LonSeconds = deleted.LonSeconds, @New_LonSeconds = inserted.LonSeconds,
		@Old_Comments = deleted.Comments, @New_Comments = inserted.Comments
		from inserted, deleted

		IF EXISTS(select * from tb_erm_project_details where validationstatus in 
		(select itemnum from tb_erm_picklist_value where listid in 
		(select listid from tb_erm_picklist where listname like 'DEAT Validation Status') and Itemdisplay like 'Accepted')
		and projectdetailsid = @PROJECTDETAILSID)
		BEGIN

			--Province
			SET @Old_ItemDisplay = ''
			SET @New_ItemDisplay = ''
			IF(@Old_Province IS NULL AND @New_Province IS NOT NULL)
			BEGIN
				Select @New_ItemDisplay = ProvinceName from tb_erm_Province where ProvinceId = @New_Province
			
				INSERT INTO tb_erm_audit_log(PkId,TableName,ColumnName,OldValue,NewValue,UpdtUser)
				VALUES (@ProjectLocationDataId,'tb_erm_Project_Location_Data','Province','',@New_ItemDisplay,@UPDTUSER)	
			END
			ELSE IF(@Old_Province IS NOT NULL AND @New_Province IS NOT NULL)
			BEGIN
				IF NOT (@Old_Province = @New_Province)
				BEGIN
					Select @New_ItemDisplay = ProvinceName from tb_erm_Province where ProvinceId = @New_Province
					Select @Old_ItemDisplay = ProvinceName from tb_erm_Province where ProvinceId = @Old_Province

					INSERT INTO tb_erm_audit_log(PkId,TableName,ColumnName,OldValue,NewValue,UpdtUser)
					VALUES (@ProjectLocationDataId,'tb_erm_Project_Location_Data','Province',@Old_ItemDisplay,@New_ItemDisplay,@UPDTUSER)
				END
			END
			ELSE IF(@Old_Province IS NOT NULL AND @New_Province IS NULL)
			BEGIN
				Select @Old_ItemDisplay = ProvinceName from tb_erm_Province where ProvinceId = @Old_Province
				
				INSERT INTO tb_erm_audit_log(PkId,TableName,ColumnName,OldValue,NewValue,UpdtUser)
				VALUES (@ProjectLocationDataId,'tb_erm_Project_Location_Data','Province',@Old_ItemDisplay,'',@UPDTUSER)		
			END

			--Metro
			SET @Old_ItemDisplay = ''
			SET @New_ItemDisplay = ''
			IF(@Old_Metro IS NULL AND @New_Metro IS NOT NULL)
			BEGIN
				Select @New_ItemDisplay = MetroName from tb_erm_Metro_DistrictMunicipality where MetroID = @New_Metro
			
				INSERT INTO tb_erm_audit_log(PkId,TableName,ColumnName,OldValue,NewValue,UpdtUser)
				VALUES (@ProjectLocationDataId,'tb_erm_Project_Location_Data','Metro/District Municipality','',@New_ItemDisplay,@UPDTUSER)	
			END
			ELSE IF(@Old_Metro IS NOT NULL AND @New_Metro IS NOT NULL)
			BEGIN
				IF NOT (@Old_Metro = @New_Metro)
				BEGIN
					Select @New_ItemDisplay = MetroName from tb_erm_Metro_DistrictMunicipality where MetroID = @New_Metro
					Select @Old_ItemDisplay = MetroName from tb_erm_Metro_DistrictMunicipality where MetroID = @Old_Metro

					INSERT INTO tb_erm_audit_log(PkId,TableName,ColumnName,OldValue,NewValue,UpdtUser)
					VALUES (@ProjectLocationDataId,'tb_erm_Project_Location_Data','Metro/District Municipality',@Old_ItemDisplay,@New_ItemDisplay,@UPDTUSER)
				END
			END
			ELSE IF(@Old_Metro IS NOT NULL AND @New_Metro IS NULL)
			BEGIN
				Select @Old_ItemDisplay = MetroName from tb_erm_Metro_DistrictMunicipality where MetroID = @Old_Metro
				
				INSERT INTO tb_erm_audit_log(PkId,TableName,ColumnName,OldValue,NewValue,UpdtUser)
				VALUES (@ProjectLocationDataId,'tb_erm_Project_Location_Data','Metro/District Municipality',@Old_ItemDisplay,'',@UPDTUSER)		
			END

			--LocalMunicipality
			SET @Old_ItemDisplay = ''
			SET @New_ItemDisplay = ''
			IF(@Old_LocalMunicipality IS NULL AND @New_LocalMunicipality IS NOT NULL)
			BEGIN
				Select @New_ItemDisplay = LocalMunicipalityName from tb_erm_Local_Municipalities where LocalMunicipalityID = @New_LocalMunicipality
			
				INSERT INTO tb_erm_audit_log(PkId,TableName,ColumnName,OldValue,NewValue,UpdtUser)
				VALUES (@ProjectLocationDataId,'tb_erm_Project_Location_Data','Local Municipality','',@New_ItemDisplay,@UPDTUSER)	
			END
			ELSE IF(@Old_LocalMunicipality IS NOT NULL AND @New_LocalMunicipality IS NOT NULL)
			BEGIN
				IF NOT (@Old_LocalMunicipality = @New_LocalMunicipality)
				BEGIN
					Select @New_ItemDisplay = LocalMunicipalityName from tb_erm_Local_Municipalities where LocalMunicipalityID = @New_LocalMunicipality
					Select @Old_ItemDisplay = LocalMunicipalityName from tb_erm_Local_Municipalities where LocalMunicipalityID = @Old_LocalMunicipality

					INSERT INTO tb_erm_audit_log(PkId,TableName,ColumnName,OldValue,NewValue,UpdtUser)
					VALUES (@ProjectLocationDataId,'tb_erm_Project_Location_Data','Local Municipality',@Old_ItemDisplay,@New_ItemDisplay,@UPDTUSER)
				END
			END
			ELSE IF(@Old_LocalMunicipality IS NOT NULL AND @New_LocalMunicipality IS NULL)
			BEGIN
				Select @Old_ItemDisplay = LocalMunicipalityName from tb_erm_Local_Municipalities where LocalMunicipalityID = @Old_LocalMunicipality
				
				INSERT INTO tb_erm_audit_log(PkId,TableName,ColumnName,OldValue,NewValue,UpdtUser)
				VALUES (@ProjectLocationDataId,'tb_erm_Project_Location_Data','Local Municipality',@Old_ItemDisplay,'',@UPDTUSER)		
			END

			--Town
			SET @Old_ItemDisplay = ''
			SET @New_ItemDisplay = ''
			IF(@Old_Town IS NULL AND @New_Town IS NOT NULL)
			BEGIN
				Select @New_ItemDisplay = TownName from tb_erm_Town where TownID = @New_Town
			
				INSERT INTO tb_erm_audit_log(PkId,TableName,ColumnName,OldValue,NewValue,UpdtUser)
				VALUES (@ProjectLocationDataId,'tb_erm_Project_Location_Data','City/Town','',@New_ItemDisplay,@UPDTUSER)	
			END
			ELSE IF(@Old_Town IS NOT NULL AND @New_Town IS NOT NULL)
			BEGIN
				IF NOT (@Old_Town = @New_Town)
				BEGIN
					Select @New_ItemDisplay = TownName from tb_erm_Town where TownID = @New_Town
					Select @Old_ItemDisplay = TownName from tb_erm_Town where TownID = @Old_Town

					INSERT INTO tb_erm_audit_log(PkId,TableName,ColumnName,OldValue,NewValue,UpdtUser)
					VALUES (@ProjectLocationDataId,'tb_erm_Project_Location_Data','City/Town',@Old_ItemDisplay,@New_ItemDisplay,@UPDTUSER)
				END
			END
			ELSE IF(@Old_Town IS NOT NULL AND @New_Town IS NULL)
			BEGIN
				Select @Old_ItemDisplay = TownName from tb_erm_Town where TownID = @Old_Town
				
				INSERT INTO tb_erm_audit_log(PkId,TableName,ColumnName,OldValue,NewValue,UpdtUser)
				VALUES (@ProjectLocationDataId,'tb_erm_Project_Location_Data','City/Town',@Old_ItemDisplay,'',@UPDTUSER)		
			END

			--LatDegree
			IF(@Old_LatDegree IS NULL AND @New_LatDegree IS NOT NULL)
			BEGIN
				INSERT INTO tb_erm_audit_log(PkId,TableName,ColumnName,OldValue,NewValue,UpdtUser)
				VALUES (@ProjectLocationDataId,'tb_erm_Project_Location_Data','Latitude(Degree)','',CONVERT(NVARCHAR(100),@New_LatDegree),@UPDTUSER)			
			END
			ELSE IF(@Old_LatDegree IS NOT NULL AND @New_LatDegree IS NOT NULL)
			BEGIN
				IF NOT (@Old_LatDegree = @New_LatDegree)
				BEGIN
					INSERT INTO tb_erm_audit_log(PkId,TableName,ColumnName,OldValue,NewValue,UpdtUser)
					VALUES (@ProjectLocationDataId,'tb_erm_Project_Location_Data','Latitude(Degree)',CONVERT(NVARCHAR(100),@Old_LatDegree),CONVERT(NVARCHAR(100),@New_LatDegree),@UPDTUSER)
				END
			END
			ELSE IF(@Old_LatDegree IS NOT NULL AND @New_LatDegree IS NULL)
			BEGIN
				INSERT INTO tb_erm_audit_log(PkId,TableName,ColumnName,OldValue,NewValue,UpdtUser)
				VALUES (@ProjectLocationDataId,'tb_erm_Project_Location_Data','Latitude(Degree)',CONVERT(NVARCHAR(100),@Old_LatDegree),'',@UPDTUSER)		
			END

			--LatMinutes
			IF(@Old_LatMinutes IS NULL AND @New_LatMinutes IS NOT NULL)
			BEGIN
				INSERT INTO tb_erm_audit_log(PkId,TableName,ColumnName,OldValue,NewValue,UpdtUser)
				VALUES (@ProjectLocationDataId,'tb_erm_Project_Location_Data','Latitude(Minutes)','',CONVERT(NVARCHAR(100),@New_LatMinutes),@UPDTUSER)			
			END
			ELSE IF(@Old_LatMinutes IS NOT NULL AND @New_LatMinutes IS NOT NULL)
			BEGIN
				IF NOT (@Old_LatMinutes = @New_LatMinutes)
				BEGIN
					INSERT INTO tb_erm_audit_log(PkId,TableName,ColumnName,OldValue,NewValue,UpdtUser)
					VALUES (@ProjectLocationDataId,'tb_erm_Project_Location_Data','Latitude(Minutes)',CONVERT(NVARCHAR(100),@Old_LatMinutes),CONVERT(NVARCHAR(100),@New_LatMinutes),@UPDTUSER)
				END
			END
			ELSE IF(@Old_LatMinutes IS NOT NULL AND @New_LatMinutes IS NULL)
			BEGIN
				INSERT INTO tb_erm_audit_log(PkId,TableName,ColumnName,OldValue,NewValue,UpdtUser)
				VALUES (@ProjectLocationDataId,'tb_erm_Project_Location_Data','Latitude(Minutes)',CONVERT(NVARCHAR(100),@Old_LatMinutes),'',@UPDTUSER)		
			END

			--LatSeconds
			IF(@Old_LatSeconds IS NULL AND @New_LatSeconds IS NOT NULL)
			BEGIN
				INSERT INTO tb_erm_audit_log(PkId,TableName,ColumnName,OldValue,NewValue,UpdtUser)
				VALUES (@ProjectLocationDataId,'tb_erm_Project_Location_Data','Latitude(Seconds)','',CONVERT(NVARCHAR(100),@New_LatSeconds),@UPDTUSER)			
			END
			ELSE IF(@Old_LatSeconds IS NOT NULL AND @New_LatSeconds IS NOT NULL)
			BEGIN
				IF NOT (@Old_LatSeconds = @New_LatSeconds)
				BEGIN
					INSERT INTO tb_erm_audit_log(PkId,TableName,ColumnName,OldValue,NewValue,UpdtUser)
					VALUES (@ProjectLocationDataId,'tb_erm_Project_Location_Data','Latitude(Seconds)',CONVERT(NVARCHAR(100),@Old_LatSeconds),CONVERT(NVARCHAR(100),@New_LatSeconds),@UPDTUSER)
				END
			END
			ELSE IF(@Old_LatSeconds IS NOT NULL AND @New_LatSeconds IS NULL)
			BEGIN
				INSERT INTO tb_erm_audit_log(PkId,TableName,ColumnName,OldValue,NewValue,UpdtUser)
				VALUES (@ProjectLocationDataId,'tb_erm_Project_Location_Data','Latitude(Seconds)',CONVERT(NVARCHAR(100),@Old_LatSeconds),'',@UPDTUSER)		
			END

			--LonDegree
			IF(@Old_LonDegree IS NULL AND @New_LonDegree IS NOT NULL)
			BEGIN
				INSERT INTO tb_erm_audit_log(PkId,TableName,ColumnName,OldValue,NewValue,UpdtUser)
				VALUES (@ProjectLocationDataId,'tb_erm_Project_Location_Data','Longitude(Degree)','',CONVERT(NVARCHAR(100),@New_LonDegree),@UPDTUSER)			
			END
			ELSE IF(@Old_LonDegree IS NOT NULL AND @New_LonDegree IS NOT NULL)
			BEGIN
				IF NOT (@Old_LonDegree = @New_LonDegree)
				BEGIN
					INSERT INTO tb_erm_audit_log(PkId,TableName,ColumnName,OldValue,NewValue,UpdtUser)
					VALUES (@ProjectLocationDataId,'tb_erm_Project_Location_Data','Longitude(Degree)',CONVERT(NVARCHAR(100),@Old_LonDegree),CONVERT(NVARCHAR(100),@New_LonDegree),@UPDTUSER)
				END
			END
			ELSE IF(@Old_LonDegree IS NOT NULL AND @New_LonDegree IS NULL)
			BEGIN
				INSERT INTO tb_erm_audit_log(PkId,TableName,ColumnName,OldValue,NewValue,UpdtUser)
				VALUES (@ProjectLocationDataId,'tb_erm_Project_Location_Data','Longitude(Degree)',CONVERT(NVARCHAR(100),@Old_LonDegree),'',@UPDTUSER)		
			END

			--LonMinutes
			IF(@Old_LonMinutes IS NULL AND @New_LonMinutes IS NOT NULL)
			BEGIN
				INSERT INTO tb_erm_audit_log(PkId,TableName,ColumnName,OldValue,NewValue,UpdtUser)
				VALUES (@ProjectLocationDataId,'tb_erm_Project_Location_Data','Longitude(Minutes)','',CONVERT(NVARCHAR(100),@New_LonMinutes),@UPDTUSER)			
			END
			ELSE IF(@Old_LonMinutes IS NOT NULL AND @New_LonMinutes IS NOT NULL)
			BEGIN
				IF NOT (@Old_LonMinutes = @New_LonMinutes)
				BEGIN
					INSERT INTO tb_erm_audit_log(PkId,TableName,ColumnName,OldValue,NewValue,UpdtUser)
					VALUES (@ProjectLocationDataId,'tb_erm_Project_Location_Data','Longitude(Minutes)',CONVERT(NVARCHAR(100),@Old_LonMinutes),CONVERT(NVARCHAR(100),@New_LonMinutes),@UPDTUSER)
				END
			END
			ELSE IF(@Old_LonMinutes IS NOT NULL AND @New_LonMinutes IS NULL)
			BEGIN
				INSERT INTO tb_erm_audit_log(PkId,TableName,ColumnName,OldValue,NewValue,UpdtUser)
				VALUES (@ProjectLocationDataId,'tb_erm_Project_Location_Data','Longitude(Minutes)',CONVERT(NVARCHAR(100),@Old_LonMinutes),'',@UPDTUSER)		
			END

			--LonSeconds
			IF(@Old_LonSeconds IS NULL AND @New_LonSeconds IS NOT NULL)
			BEGIN
				INSERT INTO tb_erm_audit_log(PkId,TableName,ColumnName,OldValue,NewValue,UpdtUser)
				VALUES (@ProjectLocationDataId,'tb_erm_Project_Location_Data','Longitude(Seconds)','',CONVERT(NVARCHAR(100),@New_LonSeconds),@UPDTUSER)			
			END
			ELSE IF(@Old_LonSeconds IS NOT NULL AND @New_LonSeconds IS NOT NULL)
			BEGIN
				IF NOT (@Old_LonSeconds = @New_LonSeconds)
				BEGIN
					INSERT INTO tb_erm_audit_log(PkId,TableName,ColumnName,OldValue,NewValue,UpdtUser)
					VALUES (@ProjectLocationDataId,'tb_erm_Project_Location_Data','Longitude(Seconds)',CONVERT(NVARCHAR(100),@Old_LonSeconds),CONVERT(NVARCHAR(100),@New_LonSeconds),@UPDTUSER)
				END
			END
			ELSE IF(@Old_LonSeconds IS NOT NULL AND @New_LonSeconds IS NULL)
			BEGIN
				INSERT INTO tb_erm_audit_log(PkId,TableName,ColumnName,OldValue,NewValue,UpdtUser)
				VALUES (@ProjectLocationDataId,'tb_erm_Project_Location_Data','Longitude(Seconds)',CONVERT(NVARCHAR(100),@Old_LonSeconds),'',@UPDTUSER)
			END

			--Comments
			IF(@Old_Comments IS NULL AND @New_Comments IS NOT NULL)
			BEGIN
				INSERT INTO tb_erm_audit_log(PkId,TableName,ColumnName,OldValue,NewValue,UpdtUser)
				VALUES (@ProjectLocationDataId,'tb_erm_Project_Location_Data','Comments','',@New_Comments,@UPDTUSER)			
			END
			ELSE IF(@Old_Comments IS NOT NULL AND @New_Comments IS NOT NULL)
			BEGIN
				IF NOT (@Old_Comments = @New_Comments)
				BEGIN
					INSERT INTO tb_erm_audit_log(PkId,TableName,ColumnName,OldValue,NewValue,UpdtUser)
					VALUES (@ProjectLocationDataId,'tb_erm_Project_Location_Data','Comments',@Old_Comments,@New_Comments,@UPDTUSER)
				END
			END
			ELSE IF(@Old_Comments IS NOT NULL AND @New_Comments IS NULL)
			BEGIN
				INSERT INTO tb_erm_audit_log(PkId,TableName,ColumnName,OldValue,NewValue,UpdtUser)
				VALUES (@ProjectLocationDataId,'tb_erm_Project_Location_Data','Comments',@Old_Comments,'',@UPDTUSER)
			END

		END

		RETURN
		ERROR:
		RAISERROR @ERRNO @ERRMSG
		ROLLBACK TRANSACTION
	END

GO
ALTER TABLE [dbo].[tb_erm_Project_Location_Data] ENABLE TRIGGER [tU_tb_erm_Project_Location_Data]
GO
/****** Object:  Trigger [dbo].[td_tb_erm_Project_Research_Data]    Script Date: 2018/12/03 07:46:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[td_tb_erm_Project_Research_Data] ON [dbo].[tb_erm_Project_Research_Data]  AFTER DELETE  AS
BEGIN	
declare @Id int
select @Id=ProjectResearchDataId from Deleted
delete from dbo.tb_erm_audit_log where PkId=@id and TableName='tb_erm_Project_Adaptation_Data'
END
GO
ALTER TABLE [dbo].[tb_erm_Project_Research_Data] ENABLE TRIGGER [td_tb_erm_Project_Research_Data]
GO
/****** Object:  Trigger [dbo].[tI_tb_erm_Project_Research_Data]    Script Date: 2018/12/03 07:46:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tI_tb_erm_Project_Research_Data] ON [dbo].[tb_erm_Project_Research_Data] FOR INSERT AS
	BEGIN
		DECLARE @NUMROWS INT,
		@NULLCNT INT,
		@VALIDCNT INT,
		@ERRNO   INT,
		@ERRMSG  NVARCHAR(255),
		@USRID NVARCHAR(255)

		SELECT @NUMROWS = @@ROWCOUNT
		/* UPDATE USER NAME AND TIME */
		UPDATE tb_erm_Project_Research_Data SET  UpdtTime = GETDATE()
		FROM tb_erm_Project_Research_Data, INSERTED WHERE tb_erm_Project_Research_Data.ProjectResearchDataId = INSERTED.ProjectResearchDataId
		
      --to update time in project details table
	   UPDATE tb_erm_project_details  SET  UpdtTime = GETDATE()
		FROM tb_erm_Project_Research_Data, INSERTED WHERE tb_erm_project_details.ProjectDetailsId = INSERTED.ProjectDetailsId
     RETURN
		ERROR:
		RAISERROR @ERRNO @ERRMSG
		ROLLBACK TRANSACTION
	END
GO
ALTER TABLE [dbo].[tb_erm_Project_Research_Data] ENABLE TRIGGER [tI_tb_erm_Project_Research_Data]
GO
/****** Object:  Trigger [dbo].[tU_tb_erm_Project_Research_Data]    Script Date: 2018/12/03 07:46:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tU_tb_erm_Project_Research_Data] ON [dbo].[tb_erm_Project_Research_Data] FOR UPDATE AS
	BEGIN
		DECLARE @NUMROWS INT,
		@NULLCNT INT,
		@VALIDCNT INT,
		@ERRNO   INT,
		@ERRMSG  NVARCHAR(255),
		@COUNT   INT,
		@ProjectResearchDataId INT,
		@UPDTUSER nvarchar(50),
		@UPDTTIME nvarchar(50),
		
		@Old_Province nvarchar(100),
		@New_Province nvarchar(100),

		@Old_City nvarchar(100),
		@New_City nvarchar(100),

		@Old_Municipality nvarchar(100),
		@New_Municipality nvarchar(100),

		@Old_LocalMunicipality nvarchar(100),
		@New_LocalMunicipality nvarchar(100),

		@Old_TypeOfResearch nvarchar(100),
		@New_TypeOfResearch nvarchar(100),

		@Old_TargetAudience nvarchar(100),
		@New_TargetAudience nvarchar(100),

		@Old_Author nvarchar(100),
		@New_Author nvarchar(100),

		@Old_Paper nvarchar(100),
		@New_Paper nvarchar(100),

		@Old_LatDegree nvarchar(100),
		@New_LatDegree nvarchar(100),

		@Old_LatMinutes nvarchar(100),
		@New_LatMinutes nvarchar(100),

		@Old_LatSeconds nvarchar(100),
		@New_LatSeconds nvarchar(100),

		@Old_LatDirection nvarchar(100),
		@New_LatDirection nvarchar(100),

		@Old_LatCalculated nvarchar(100),
		@New_LatCalculated nvarchar(100),

		@Old_LonDegree nvarchar(100),
		@New_LonDegree nvarchar(100),

		@Old_LonMinutes nvarchar(100),
		@New_LonMinutes nvarchar(100),

		@Old_LonSeconds nvarchar(100),
		@New_LonSeconds nvarchar(100),

		@Old_LonDirection nvarchar(100),
		@New_LonDirection nvarchar(100),

		@Old_LonCalculated nvarchar(100),
		@New_LonCalculated nvarchar(100),

		@OLDVALUE VARCHAR(100),
		@NEWVALUE VARCHAR(100),

		@ProjectDetailsId INT
		
		SELECT @NUMROWS = @@ROWCOUNT
		UPDATE tb_erm_Project_Research_Data SET
			UPDTTIME = GETDATE()
		FROM tb_erm_Project_Research_Data, INSERTED WHERE tb_erm_Project_Research_Data.ProjectResearchDataId  = INSERTED.ProjectResearchDataId
		

        -- UPDATE TIME IN PROJECT DETAILS TABLE
	   UPDATE tb_erm_project_details  SET  UpdtTime = GETDATE()
		FROM tb_erm_Project_Research_Data, INSERTED WHERE tb_erm_project_details.ProjectDetailsId = INSERTED.ProjectDetailsId


  		select @UPDTTIME= GETDATE(),@UPDTUSER = inserted.UpdtUser, @ProjectResearchDataId = deleted.ProjectResearchDataId,@ProjectDetailsId=deleted.ProjectDetailsId, 
			@Old_Province = deleted.Province, @New_Province = inserted.Province,
			@Old_City = deleted.City, @New_City = inserted.City,
			@Old_Municipality = deleted.Municipality, @New_Municipality = inserted.Municipality,
			@Old_LocalMunicipality = deleted.LocalMunicipality, @New_LocalMunicipality = inserted.LocalMunicipality,
			@Old_TypeOfResearch = deleted.TypeOfResearch, @New_TypeOfResearch = inserted.TypeOfResearch,
			@Old_TargetAudience = deleted.TargetAudience, @New_TargetAudience = inserted.TargetAudience,
			@Old_Author = deleted.Author, @New_Author = inserted.Author,
			@Old_Paper = deleted.Paper, @New_Paper = inserted.Paper,			
			@Old_LatDegree= deleted.LatDegree, @New_LatDegree = inserted.LatDegree,
			@Old_LatMinutes = deleted.LatMinutes, @New_LatMinutes = inserted.LatMinutes,
			@Old_LatSeconds = deleted.LatSeconds, @New_LatSeconds = inserted.LatSeconds,
			@Old_LatDirection = deleted.LatDirection, @New_LatDirection = inserted.LatDirection,
			@Old_LonDegree= deleted.LonDegree, @New_LonDegree = inserted.LonDegree,
			@Old_LonMinutes = deleted.LonMinutes, @New_LonMinutes = inserted.LonMinutes,
			@Old_LonSeconds = deleted.LonSeconds, @New_LonSeconds = inserted.LonSeconds,
			@Old_LonDirection = deleted.LonDirection, @New_LonDirection = inserted.LonDirection
			
		from inserted,deleted
		
				
	IF EXISTS(select * from tb_erm_project_details where validationstatus in (select itemnum from tb_erm_picklist_value where listid in 
		(select listid from tb_erm_picklist where listname like 'DEAT Validation Status') and Itemdisplay like 'Accepted') and ProjectDetailsId= @ProjectDetailsId)
		BEGIN
			--PROVINCE
			IF NOT (@Old_Province = @New_Province)
			begin
			IF(@Old_Province is null)	
			BEGIN
				SET @OLDVALUE=''
			END
			ELSE
			BEGIN
				SET @OLDVALUE=(Select ProvinceName from tb_erm_Province where ProvinceID=@Old_Province)
			END
		

			IF(@New_Province is null)
			BEGIN
				SET @NEWVALUE=''
			END
			ELSE
			BEGIN
				SET @NEWVALUE=(Select ProvinceName from tb_erm_Province where ProvinceID=@New_Province)
				
			END			

			INSERT INTO tb_erm_audit_log(PkId,TableName,ColumnName,OldValue,NewValue,UpdtUser,UpdtTime)
            VALUES (@ProjectResearchDataId,'tb_erm_Project_Research_Data','Province',@OLDVALUE,@NEWVALUE,@UPDTUSER,@UPDTTIME)
			end

			--CITY
			IF NOT (@Old_City = @New_City)
			begin
			IF(@Old_City is null)	
			BEGIN
				SET @OLDVALUE=''
			END
			ELSE
			BEGIN
				SET @OLDVALUE=(Select TownName from tb_erm_Town where TownID=@Old_City)
			END
		

			IF(@New_City is null)
			BEGIN
				SET @NEWVALUE=''
			END
			ELSE
			BEGIN
				SET @NEWVALUE=(Select TownName from tb_erm_Town where TownID=@New_City)
			END			

			INSERT INTO tb_erm_audit_log(PkId,TableName,ColumnName,OldValue,NewValue,UpdtUser,UpdtTime)
            VALUES (@ProjectResearchDataId,'tb_erm_Project_Research_Data','City/Town',@OLDVALUE,@NEWVALUE,@UPDTUSER,@UPDTTIME)
			end

			--MUNCIPALITY
			IF NOT (@Old_Municipality = @New_Municipality)
			begin
			IF(@Old_Municipality is null)	
			BEGIN
				SET @OLDVALUE=''
			END
			ELSE
			BEGIN
				SET @OLDVALUE=(Select MetroName from tb_erm_Metro_DistrictMunicipality where MetroID=@Old_Municipality)
			END
		

			IF(@New_Municipality is null)
			BEGIN
				SET @NEWVALUE=''
			END
			ELSE
			BEGIN
				SET @NEWVALUE=(Select MetroName from tb_erm_Metro_DistrictMunicipality where MetroID=@New_Municipality)
			END			

			INSERT INTO tb_erm_audit_log(PkId,TableName,ColumnName,OldValue,NewValue,UpdtUser,UpdtTime)
            VALUES (@ProjectResearchDataId,'tb_erm_Project_Research_Data','Metro/District Municipality',@OLDVALUE,@NEWVALUE,@UPDTUSER,@UPDTTIME)
			end

			--LOCAL MUNCIPALITY
			IF NOT (@Old_LocalMunicipality = @New_LocalMunicipality)
			begin
			IF(@Old_LocalMunicipality is null)	
			BEGIN
				SET @OLDVALUE=''
			END
			ELSE
			BEGIN
				SET @OLDVALUE=(Select LocalMunicipalityName from tb_erm_Local_Municipalities where LocalMunicipalityID=@Old_LocalMunicipality)
			END
		

			IF(@New_LocalMunicipality is null)
			BEGIN
				SET @NEWVALUE=''
			END
			ELSE
			BEGIN
				SET @NEWVALUE=(Select LocalMunicipalityName from tb_erm_Local_Municipalities where LocalMunicipalityID=@New_LocalMunicipality)
			END			

			INSERT INTO tb_erm_audit_log(PkId,TableName,ColumnName,OldValue,NewValue,UpdtUser,UpdtTime)
            VALUES (@ProjectResearchDataId,'tb_erm_Project_Research_Data','Local Municipality',@OLDVALUE,@NEWVALUE,@UPDTUSER,@UPDTTIME)
			end

			--TYPEOFRESEARCH
			IF NOT (@Old_TypeOfResearch = @New_TypeOfResearch)
			begin
			IF(@Old_TypeOfResearch is null)	
			BEGIN
				SET @OLDVALUE=''
			END
			ELSE
			BEGIN
				SET @OLDVALUE=(SELECT ITEMDISPLAY FROM TB_ERM_PICKLIST_VALUE WHERE LISTID=(SELECT LISTID FROM TB_ERM_PICKLIST WHERE LISTNAME='Type of research') AND ITEMNUM=@Old_TypeOfResearch)
			END
		

			IF(@New_TypeOfResearch is null)
			BEGIN
				SET @NEWVALUE=''
			END
			ELSE
			BEGIN
				SET @NEWVALUE=(SELECT ITEMDISPLAY FROM TB_ERM_PICKLIST_VALUE WHERE LISTID=(SELECT LISTID FROM TB_ERM_PICKLIST WHERE LISTNAME='Type of research') AND ITEMNUM=@New_TypeOfResearch)
			END			

			INSERT INTO tb_erm_audit_log(PkId,TableName,ColumnName,OldValue,NewValue,UpdtUser,UpdtTime)
            VALUES (@ProjectResearchDataId,'tb_erm_Project_Research_Data','Type of Research',@OLDVALUE,@NEWVALUE,@UPDTUSER,@UPDTTIME)
			end

			--TARGETAUDIENCE
			IF NOT (@Old_TargetAudience = @New_TargetAudience)
			begin
			IF(@Old_TargetAudience is null)	
			BEGIN
				SET @OLDVALUE=''
			END
			ELSE
			BEGIN
				SET @OLDVALUE=(SELECT ITEMDISPLAY FROM TB_ERM_PICKLIST_VALUE WHERE LISTID=(SELECT LISTID FROM TB_ERM_PICKLIST WHERE LISTNAME='Target audience') AND ITEMNUM=@Old_TargetAudience)
			END
		

			IF(@New_TargetAudience is null)
			BEGIN
				SET @NEWVALUE=''
			END
			ELSE
			BEGIN
				SET @NEWVALUE=(SELECT ITEMDISPLAY FROM TB_ERM_PICKLIST_VALUE WHERE LISTID=(SELECT LISTID FROM TB_ERM_PICKLIST WHERE LISTNAME='Target audience') AND ITEMNUM=@New_TargetAudience)
			END			

			INSERT INTO tb_erm_audit_log(PkId,TableName,ColumnName,OldValue,NewValue,UpdtUser,UpdtTime)
            VALUES (@ProjectResearchDataId,'tb_erm_Project_Research_Data','Target Audience',@OLDVALUE,@NEWVALUE,@UPDTUSER,@UPDTTIME)
			end

			--AUTHOR
			IF NOT (@Old_Author = @New_Author)
			begin
			IF(@Old_Author is null)	
			BEGIN
				SET @OLDVALUE=''
			END
			ELSE
			BEGIN
				SET @OLDVALUE=@Old_Author
			END
		

			IF(@New_Author is null)
			BEGIN
				SET @NEWVALUE=''
			END
			ELSE
			BEGIN
				SET @NEWVALUE=@New_Author
			END			

			INSERT INTO tb_erm_audit_log(PkId,TableName,ColumnName,OldValue,NewValue,UpdtUser,UpdtTime)
            VALUES (@ProjectResearchDataId,'tb_erm_Project_Research_Data','Author(s)',@OLDVALUE,@NEWVALUE,@UPDTUSER,@UPDTTIME)
			end
			
			--OLDPAPER
			IF NOT (@Old_Paper = @New_Paper)
			begin
			IF(@Old_Paper is null)	
			BEGIN
				SET @OLDVALUE=''
			END
			ELSE
			BEGIN
				SET @OLDVALUE=@Old_Paper
			END
		

			IF(@New_Paper is null)
			BEGIN
				SET @NEWVALUE=''
			END
			ELSE
			BEGIN
				SET @NEWVALUE=@New_Paper
			END			

			INSERT INTO tb_erm_audit_log(PkId,TableName,ColumnName,OldValue,NewValue,UpdtUser,UpdtTime)
            VALUES (@ProjectResearchDataId,'tb_erm_Project_Research_Data','Link to Paper or Project Website',@OLDVALUE,@NEWVALUE,@UPDTUSER,@UPDTTIME)
			end

			--LATDEGREE
			IF NOT (@Old_LatDegree = @New_LatDegree)
			begin
			IF(@Old_LatDegree is null)	
			BEGIN
				SET @OLDVALUE=''
			END
			ELSE
			BEGIN
				SET @OLDVALUE=@Old_LatDegree
			END
		

			IF(@New_LatDegree is null)
			BEGIN
				SET @NEWVALUE=''
			END
			ELSE
			BEGIN
				SET @NEWVALUE=@New_LatDegree
			END			

			INSERT INTO tb_erm_audit_log(PkId,TableName,ColumnName,OldValue,NewValue,UpdtUser,UpdtTime)
            VALUES (@ProjectResearchDataId,'tb_erm_Project_Research_Data','Latitude(Degree)',@OLDVALUE,@NEWVALUE,@UPDTUSER,@UPDTTIME)
			end

			--LATMINUTES
			IF NOT (@Old_LatMinutes = @New_LatMinutes)
			begin
			IF(@Old_LatMinutes is null)	
			BEGIN
				SET @OLDVALUE=''
			END
			ELSE
			BEGIN
				SET @OLDVALUE=@Old_LatMinutes
			END
		

			IF(@New_LatMinutes is null)
			BEGIN
				SET @NEWVALUE=''
			END
			ELSE
			BEGIN
				SET @NEWVALUE=@New_LatMinutes
			END			

			INSERT INTO tb_erm_audit_log(PkId,TableName,ColumnName,OldValue,NewValue,UpdtUser,UpdtTime)
            VALUES (@ProjectResearchDataId,'tb_erm_Project_Research_Data','Latitude(Minutes)',@OLDVALUE,@NEWVALUE,@UPDTUSER,@UPDTTIME)
			end

			--LATSECONDS
			IF NOT (@Old_LatSeconds = @New_LatSeconds)
			begin
			IF(@Old_LatSeconds is null)	
			BEGIN
				SET @OLDVALUE=''
			END
			ELSE
			BEGIN
				SET @OLDVALUE=@Old_LatSeconds
			END
		

			IF(@New_LatSeconds is null)
			BEGIN
				SET @NEWVALUE=''
			END
			ELSE
			BEGIN
				SET @NEWVALUE=@New_LatSeconds
			END			

			INSERT INTO tb_erm_audit_log(PkId,TableName,ColumnName,OldValue,NewValue,UpdtUser,UpdtTime)
            VALUES (@ProjectResearchDataId,'tb_erm_Project_Research_Data','Latitude(Seconds)',@OLDVALUE,@NEWVALUE,@UPDTUSER,@UPDTTIME)
			end

			--LATDIRECTION
			IF NOT (@Old_LatDirection = @New_LatDirection)
			begin
			IF(@Old_LatDirection is null)	
			BEGIN
				SET @OLDVALUE=''
			END
			ELSE
			BEGIN
				SET @OLDVALUE=@Old_LatDirection
			END
		

			IF(@New_LatDirection is null)
			BEGIN
				SET @NEWVALUE=''
			END
			ELSE
			BEGIN
				SET @NEWVALUE=@New_LatDirection
			END			

			INSERT INTO tb_erm_audit_log(PkId,TableName,ColumnName,OldValue,NewValue,UpdtUser,UpdtTime)
            VALUES (@ProjectResearchDataId,'tb_erm_Project_Research_Data','Latitude(Direction)',@OLDVALUE,@NEWVALUE,@UPDTUSER,@UPDTTIME)
			end

			--LATCALCULATED
			IF NOT (@Old_LatCalculated = @New_LatCalculated)
			begin
			IF(@Old_LatCalculated is null)	
			BEGIN
				SET @OLDVALUE=''
			END
			ELSE
			BEGIN
				SET @OLDVALUE=@Old_LatCalculated
			END
		

			IF(@New_LatCalculated is null)
			BEGIN
				SET @NEWVALUE=''
			END
			ELSE
			BEGIN
				SET @NEWVALUE=@New_LatCalculated
			END			

			INSERT INTO tb_erm_audit_log(PkId,TableName,ColumnName,OldValue,NewValue,UpdtUser,UpdtTime)
            VALUES (@ProjectResearchDataId,'tb_erm_Project_Research_Data','Latitude(Calculated)',@OLDVALUE,@NEWVALUE,@UPDTUSER,@UPDTTIME)
			end

			--LONDEGREE
			IF NOT (@Old_LonDegree = @New_LonDegree)
			begin
			IF(@Old_LonDegree is null)	
			BEGIN
				SET @OLDVALUE=''
			END
			ELSE
			BEGIN
				SET @OLDVALUE=@Old_LonDegree
			END
		

			IF(@New_LonDegree is null)
			BEGIN
				SET @NEWVALUE=''
			END
			ELSE
			BEGIN
				SET @NEWVALUE=@New_LonDegree
			END			

			INSERT INTO tb_erm_audit_log(PkId,TableName,ColumnName,OldValue,NewValue,UpdtUser,UpdtTime)
            VALUES (@ProjectResearchDataId,'tb_erm_Project_Research_Data','Longitude(Degree)',@OLDVALUE,@NEWVALUE,@UPDTUSER,@UPDTTIME)
			end

			--LONMINUTES
			IF NOT (@Old_LonMinutes = @New_LonMinutes)
			begin
			IF(@Old_LonMinutes is null)	
			BEGIN
				SET @OLDVALUE=''
			END
			ELSE
			BEGIN
				SET @OLDVALUE=@Old_LonMinutes
			END
		

			IF(@New_LonMinutes is null)
			BEGIN
				SET @NEWVALUE=''
			END
			ELSE
			BEGIN
				SET @NEWVALUE=@New_LonMinutes
			END			

			INSERT INTO tb_erm_audit_log(PkId,TableName,ColumnName,OldValue,NewValue,UpdtUser,UpdtTime)
            VALUES (@ProjectResearchDataId,'tb_erm_Project_Research_Data','Longitude(Minutes)',@OLDVALUE,@NEWVALUE,@UPDTUSER,@UPDTTIME)
			end
			
			--LONSECONDS
			IF NOT (@Old_LonSeconds = @New_LonSeconds)
			begin
			IF(@Old_LonSeconds is null)	
			BEGIN
				SET @OLDVALUE=''
			END
			ELSE
			BEGIN
				SET @OLDVALUE=@Old_LonSeconds
			END
		

			IF(@New_LonSeconds is null)
			BEGIN
				SET @NEWVALUE=''
			END
			ELSE
			BEGIN
				SET @NEWVALUE=@New_LonSeconds
			END			

			INSERT INTO tb_erm_audit_log(PkId,TableName,ColumnName,OldValue,NewValue,UpdtUser,UpdtTime)
            VALUES (@ProjectResearchDataId,'tb_erm_Project_Research_Data','Longitude(Seconds)',@OLDVALUE,@NEWVALUE,@UPDTUSER,@UPDTTIME)
			end
			
			--LONDIRECTION
			IF NOT (@Old_LonDirection = @New_LonDirection)
			begin
			IF(@Old_LonDirection is null)	
			BEGIN
				SET @OLDVALUE=''
			END
			ELSE
			BEGIN
				SET @OLDVALUE=@Old_LonDirection
			END
		

			IF(@New_LonDirection is null)
			BEGIN
				SET @NEWVALUE=''
			END
			ELSE
			BEGIN
				SET @NEWVALUE=@New_LonDirection
			END			

			INSERT INTO tb_erm_audit_log(PkId,TableName,ColumnName,OldValue,NewValue,UpdtUser,UpdtTime)
            VALUES (@ProjectResearchDataId,'tb_erm_Project_Research_Data','Longitude(Direction)',@OLDVALUE,@NEWVALUE,@UPDTUSER,@UPDTTIME)
			end
			
			--LONCALCULATED
			IF NOT (@Old_LonCalculated = @New_LonCalculated)
			begin
			IF(@Old_LonCalculated is null)	
			BEGIN
				SET @OLDVALUE=''
			END
			ELSE
			BEGIN
				SET @OLDVALUE=@Old_LonCalculated
			END
		

			IF(@New_LonCalculated is null)
			BEGIN
				SET @NEWVALUE=''
			END
			ELSE
			BEGIN
				SET @NEWVALUE=@New_LonCalculated
			END			

			INSERT INTO tb_erm_audit_log(PkId,TableName,ColumnName,OldValue,NewValue,UpdtUser,UpdtTime)
            VALUES (@ProjectResearchDataId,'tb_erm_Project_Research_Data','Longitude(Calculated)',@OLDVALUE,@NEWVALUE,@UPDTUSER,@UPDTTIME)
			end
	END
		RETURN
		ERROR:
		RAISERROR @ERRNO @ERRMSG
		ROLLBACK TRANSACTION
	END
GO
ALTER TABLE [dbo].[tb_erm_Project_Research_Data] ENABLE TRIGGER [tU_tb_erm_Project_Research_Data]
GO
/****** Object:  Trigger [dbo].[tI_tb_erm_Project_SubType]    Script Date: 2018/12/03 07:46:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tI_tb_erm_Project_SubType] ON [dbo].[tb_erm_Project_SubType] FOR INSERT AS
	BEGIN
		DECLARE @NUMROWS INT,
		@NULLCNT INT,
		@VALIDCNT INT,
		@ERRNO   INT,
		@ERRMSG  NVARCHAR(255),
		@USRID NVARCHAR(255)

		SELECT @NUMROWS = @@ROWCOUNT
		/* UPDATE USER NAME AND TIME */
		UPDATE tb_erm_Project_SubType SET  UpdtTime = GETDATE()
		FROM tb_erm_Project_SubType, INSERTED WHERE tb_erm_Project_SubType.ProjectSubTypeId = INSERTED.ProjectSubTypeId
		RETURN
		ERROR:
		RAISERROR @ERRNO @ERRMSG
		ROLLBACK TRANSACTION
	END
GO
ALTER TABLE [dbo].[tb_erm_Project_SubType] ENABLE TRIGGER [tI_tb_erm_Project_SubType]
GO
/****** Object:  Trigger [dbo].[tU_tb_erm_Project_SubType]    Script Date: 2018/12/03 07:46:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tU_tb_erm_Project_SubType] ON [dbo].[tb_erm_Project_SubType] FOR UPDATE AS
	BEGIN
		DECLARE @NUMROWS INT,
		@NULLCNT INT,
		@VALIDCNT INT,
		@ERRNO   INT,
		@ERRMSG  NVARCHAR(255),
		@COUNT   INT

		SELECT @NUMROWS = @@ROWCOUNT
		UPDATE tb_erm_Project_SubType SET
			UPDTTIME = GETDATE()
		FROM tb_erm_Project_SubType, INSERTED WHERE tb_erm_Project_SubType.ProjectSubTypeId  = INSERTED.ProjectSubTypeId
		RETURN
		ERROR:
		RAISERROR @ERRNO @ERRMSG
		ROLLBACK TRANSACTION
	END

GO
ALTER TABLE [dbo].[tb_erm_Project_SubType] ENABLE TRIGGER [tU_tb_erm_Project_SubType]
GO
/****** Object:  Trigger [dbo].[tI_tb_erm_Province]    Script Date: 2018/12/03 07:46:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

	CREATE TRIGGER [dbo].[tI_tb_erm_Province] ON [dbo].[tb_erm_Province] FOR INSERT AS
	BEGIN
		DECLARE @NUMROWS INT,
		@NULLCNT INT,
		@VALIDCNT INT,
		@ERRNO   INT,
		@ERRMSG  NVARCHAR(255),
		@usrid nvarchar(255)
		
		SELECT @NUMROWS = @@ROWCOUNT
		/* UPDATE USER NAME AND TIME */
		UPDATE tb_erm_Province SET /* UpdtUsr = SUSER_SNAME(), */ UpdtTime = GETDATE()
		FROM tb_erm_Province, INSERTED WHERE tb_erm_Province.ProvinceID = INSERTED.ProvinceID
		RETURN
		ERROR:
		RAISERROR @ERRNO @ERRMSG
		ROLLBACK TRANSACTION
	END
GO
ALTER TABLE [dbo].[tb_erm_Province] ENABLE TRIGGER [tI_tb_erm_Province]
GO
/****** Object:  Trigger [dbo].[tU_tb_erm_Province]    Script Date: 2018/12/03 07:46:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

	CREATE TRIGGER [dbo].[tU_tb_erm_Province] ON [dbo].[tb_erm_Province] FOR UPDATE AS 
	BEGIN
		DECLARE @NUMROWS INT,
		@NULLCNT INT,
		@VALIDCNT INT,
		@ERRNO   INT,
		@ERRMSG  NVARCHAR(255),
		@COUNT   INT

		SELECT @NUMROWS = @@ROWCOUNT
		/* UPDATE USER NAME AND TIME */
		UPDATE tb_erm_Province SET
		/*UPDTUSER = suser_sname(),*/
		UPDTTIME = GETDATE()
		FROM tb_erm_Province, INSERTED WHERE tb_erm_Province.ProvinceID = INSERTED.ProvinceID
		RETURN
		ERROR:
		RAISERROR @ERRNO @ERRMSG
		ROLLBACK TRANSACTION
	END	
GO
ALTER TABLE [dbo].[tb_erm_Province] ENABLE TRIGGER [tU_tb_erm_Province]
GO
/****** Object:  Trigger [dbo].[tI_tb_erm_roles]    Script Date: 2018/12/03 07:46:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tI_tb_erm_roles] ON [dbo].[tb_erm_roles] FOR INSERT AS
	BEGIN
		DECLARE @NUMROWS INT,
		@NULLCNT INT,
		@VALIDCNT INT,
		@ERRNO   INT,
		@ERRMSG  NVARCHAR(255),
		@USRID NVARCHAR(255)

		SELECT @NUMROWS = @@ROWCOUNT
		/* UPDATE USER NAME AND TIME */
		UPDATE tb_erm_roles SET /* UpdtUsr = SUSER_SNAME(), */ UpdtTime = GETDATE()
		FROM tb_erm_roles, INSERTED WHERE tb_erm_roles.RoleID = INSERTED.RoleID
		RETURN
		ERROR:
		RAISERROR @ERRNO @ERRMSG
		ROLLBACK TRANSACTION
	END
GO
ALTER TABLE [dbo].[tb_erm_roles] ENABLE TRIGGER [tI_tb_erm_roles]
GO
/****** Object:  Trigger [dbo].[tU_tb_erm_roles]    Script Date: 2018/12/03 07:46:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tU_tb_erm_roles] ON [dbo].[tb_erm_roles] FOR UPDATE AS
	BEGIN
		DECLARE @NUMROWS INT,
		@NULLCNT INT,
		@VALIDCNT INT,
		@ERRNO   INT,
		@ERRMSG  NVARCHAR(255),
		@COUNT   INT

		SELECT @NUMROWS = @@ROWCOUNT
		/* UPDATE USER NAME AND TIME */
		UPDATE tb_erm_roles SET
		/*UPDTUSER = suser_sname(),*/
		UPDTTIME = GETDATE()
		FROM tb_erm_roles, INSERTED WHERE tb_erm_roles.RoleID = INSERTED.RoleID
		RETURN
		ERROR:
		RAISERROR @ERRNO @ERRMSG
		ROLLBACK TRANSACTION
	END
	
GO
ALTER TABLE [dbo].[tb_erm_roles] ENABLE TRIGGER [tU_tb_erm_roles]
GO
/****** Object:  Trigger [dbo].[tI_tb_erm_Town]    Script Date: 2018/12/03 07:46:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

	CREATE TRIGGER [dbo].[tI_tb_erm_Town] ON [dbo].[tb_erm_Town] FOR INSERT AS
	BEGIN
		DECLARE @NUMROWS INT,
		@NULLCNT INT,
		@VALIDCNT INT,
		@ERRNO   INT,
		@ERRMSG  NVARCHAR(255),
		@usrid nvarchar(255)
		
		SELECT @NUMROWS = @@ROWCOUNT
		/* UPDATE USER NAME AND TIME */
		UPDATE tb_erm_Town SET /* UpdtUsr = SUSER_SNAME(), */ UpdtTime = GETDATE()
		FROM tb_erm_Town, INSERTED WHERE tb_erm_Town.TownID = INSERTED.TownID
		RETURN
		ERROR:
		RAISERROR @ERRNO @ERRMSG
		ROLLBACK TRANSACTION
	END
GO
ALTER TABLE [dbo].[tb_erm_Town] ENABLE TRIGGER [tI_tb_erm_Town]
GO
/****** Object:  Trigger [dbo].[tU_tb_erm_Town]    Script Date: 2018/12/03 07:46:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

	CREATE TRIGGER [dbo].[tU_tb_erm_Town] ON [dbo].[tb_erm_Town] FOR UPDATE AS 
	BEGIN
		DECLARE @NUMROWS INT,
		@NULLCNT INT,
		@VALIDCNT INT,
		@ERRNO   INT,
		@ERRMSG  NVARCHAR(255),
		@COUNT   INT

		SELECT @NUMROWS = @@ROWCOUNT
		/* UPDATE USER NAME AND TIME */
		UPDATE tb_erm_Town SET
		/*UPDTUSER = suser_sname(),*/
		UPDTTIME = GETDATE()
		FROM tb_erm_Town, INSERTED WHERE tb_erm_Town.TownID = INSERTED.TownID
		RETURN
		ERROR:
		RAISERROR @ERRNO @ERRMSG
		ROLLBACK TRANSACTION
	END	
GO
ALTER TABLE [dbo].[tb_erm_Town] ENABLE TRIGGER [tU_tb_erm_Town]
GO
/****** Object:  Trigger [dbo].[tI_tb_erm_version_history]    Script Date: 2018/12/03 07:46:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tI_tb_erm_version_history] ON [dbo].[tb_erm_version_history] FOR INSERT AS
	BEGIN
		DECLARE @NUMROWS INT,
		@NULLCNT INT,
		@VALIDCNT INT,
		@ERRNO   INT,
		@ERRMSG  NVARCHAR(255),
		@USRID NVARCHAR(255)

		SELECT @NUMROWS = @@ROWCOUNT
		/* UPDATE USER NAME AND TIME */
		UPDATE tb_erm_version_history SET /* UpdtUsr = SUSER_SNAME(), */ UpdtTime = GETDATE()
		FROM tb_erm_version_history, INSERTED WHERE tb_erm_version_history.HistId = INSERTED.HistId
		RETURN
		ERROR:
		RAISERROR @ERRNO @ERRMSG
		ROLLBACK TRANSACTION
	END
GO
ALTER TABLE [dbo].[tb_erm_version_history] ENABLE TRIGGER [tI_tb_erm_version_history]
GO
/****** Object:  Trigger [dbo].[tU_tb_erm_version_history]    Script Date: 2018/12/03 07:46:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tU_tb_erm_version_history] ON [dbo].[tb_erm_version_history] FOR UPDATE AS
	BEGIN
		DECLARE @NUMROWS INT,
		@NULLCNT INT,
		@VALIDCNT INT,
		@ERRNO   INT,
		@ERRMSG  NVARCHAR(255),
		@COUNT   INT

		SELECT @NUMROWS = @@ROWCOUNT
		/* UPDATE USER NAME AND TIME */
		UPDATE tb_erm_version_history SET
		/*UPDTUSER = suser_sname(),*/
		UPDTTIME = GETDATE()
		FROM tb_erm_version_history, INSERTED WHERE tb_erm_version_history.HistId  = INSERTED.HistId
		RETURN
		ERROR:
		RAISERROR @ERRNO @ERRMSG
		ROLLBACK TRANSACTION
	END

GO
ALTER TABLE [dbo].[tb_erm_version_history] ENABLE TRIGGER [tU_tb_erm_version_history]
GO
USE [master]
GO
ALTER DATABASE [NCCRD] SET  READ_WRITE 
GO
