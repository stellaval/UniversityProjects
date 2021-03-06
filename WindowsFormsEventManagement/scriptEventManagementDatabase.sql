USE [master]
GO
/****** Object:  Database [EventManagement]    Script Date: 16.1.2015 г. 14:14:19 ******/
CREATE DATABASE [EventManagement]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'EventManagement', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER2012\MSSQL\DATA\EventManagement.mdf' , SIZE = 5120KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'EventManagement_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER2012\MSSQL\DATA\EventManagement_log.ldf' , SIZE = 2048KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [EventManagement] SET COMPATIBILITY_LEVEL = 110
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [EventManagement].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [EventManagement] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [EventManagement] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [EventManagement] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [EventManagement] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [EventManagement] SET ARITHABORT OFF 
GO
ALTER DATABASE [EventManagement] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [EventManagement] SET AUTO_CREATE_STATISTICS ON 
GO
ALTER DATABASE [EventManagement] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [EventManagement] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [EventManagement] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [EventManagement] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [EventManagement] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [EventManagement] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [EventManagement] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [EventManagement] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [EventManagement] SET  DISABLE_BROKER 
GO
ALTER DATABASE [EventManagement] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [EventManagement] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [EventManagement] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [EventManagement] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [EventManagement] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [EventManagement] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [EventManagement] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [EventManagement] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [EventManagement] SET  MULTI_USER 
GO
ALTER DATABASE [EventManagement] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [EventManagement] SET DB_CHAINING OFF 
GO
ALTER DATABASE [EventManagement] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [EventManagement] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
USE [EventManagement]
GO
/****** Object:  StoredProcedure [dbo].[deleteEvent]    Script Date: 16.1.2015 г. 14:14:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[deleteEvent]
( 
	@EventiD int,
	@e_id int=0 output
)
as

set nocount on
set @e_id=0
select @e_id=count(*)
from Events
where (EventID=@EventiD)
if @e_id>0
begin 
set nocount on
delete from Events
where (EventID=@EventiD)
end
return @e_id

GO
/****** Object:  StoredProcedure [dbo].[deleteTeam]    Script Date: 16.1.2015 г. 14:14:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[deleteTeam]
@id int=null
as
begin
declare @msg nvarchar(50),
		@exists int
select @exists= count (*) from Teams
where TeamID=@id
if @exists=0
	begin
	set @msg=N'Does not exist'
	raiserror(@msg, 16,1)
	return
	end
		begin try 
		delete from dbo.Teams
		where TeamID=@id
		end try
		begin catch
		set @msg=N'The record can not be deleted!'
		raiserror (@msg, 16, 1)
		return
		end catch
end



GO
/****** Object:  StoredProcedure [dbo].[EventsGuests]    Script Date: 16.1.2015 г. 14:14:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[EventsGuests]
@event varchar(50)=null,
@date varchar(50)=null,
@place varchar(50)=null
as
begin
declare @sqlString varchar(max)
set @sqlString = 'select * from EventGuest where 1=1'
if @event is not null
set @sqlString = @sqlString+'and EventName like''%'+@event+'%'''
if @date is not null
set @sqlString = @sqlString+'and Date like''%'+@date+'%'''
if @place is not null
set @sqlString = @sqlString+'and Place like''%'+@place+'%'''
exec(@sqlString)
end
GO
/****** Object:  StoredProcedure [dbo].[GuestNumber]    Script Date: 16.1.2015 г. 14:14:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[GuestNumber]
@number int=null,
@event varchar(50)=null,
@team varchar(50)=null
as 
begin
	declare @sqlString varchar(max)
	set @sqlString='select * from NumberOfGuestsForEvent where 1=1'
		if @number is not null
		set @sqlString = @sqlString+' and NumberOfGuests ='+ cast(@number as varchar(50))+''
		if @event is not null
		set @sqlString = @sqlString+' and EventName like''%'+@event+'%'''
		if @team is not null
		set @sqlString = @sqlString+' and TeamName like''%'+@team+'%'''
	exec(@sqlString)
end
GO
/****** Object:  StoredProcedure [dbo].[insertEmployee]    Script Date: 16.1.2015 г. 14:14:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[insertEmployee]
@EmpFirstName nvarchar(50)=null,
@EmplLastName nvarchar(50)=null,
@PhoneNumber numeric=null,
@Email nvarchar(50)=null,
@Team int=null
as
begin
declare @msg varchar(50)
begin try
 insert into Employees(EmpFirstName, EmplLastName, PhoneNumber, [E-mail], Team)
 values(@EmpFirstName, @EmplLastName, @PhoneNumber, @Email, @Team)
 end try
 begin catch
  set @msg=N'Can not be entered!'
  Raiserror (@msg,16,1)
  return
  end catch
end
GO
/****** Object:  StoredProcedure [dbo].[insertEvent]    Script Date: 16.1.2015 г. 14:14:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[insertEvent]
@EventName nvarchar(50)=null,
@EventType int=null,
@Team int=null,
@Client int=null,
@Place nvarchar(50)=null,
@Date date=null,
@Time time=null,
@Description nvarchar(50)=null
as
begin
declare @msg varchar(50)
begin try
 insert into Events(EventName, EventType, Team, Client, Place, Date, Time, Description)
 values(@EventName, @EventType, @Team, @Client, @Place, @Date, @Time, @Description)
 end try
 begin catch
  set @msg=N'Can not be entered!'
  Raiserror (@msg,16,1)
  return
  end catch
end

GO
/****** Object:  StoredProcedure [dbo].[insertGuests]    Script Date: 16.1.2015 г. 14:14:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[insertGuests]
@GuestFirstName nvarchar(50)=null,
@GuestLastName nvarchar(50)=null,
@Email nvarchar(50)=null,
@Event int=null
as
begin
declare @msg varchar(50)
begin try
 insert into Guests(GuestFirstName, GuestLastName, [E-mail], Event)
 values(@GuestFirstName, @GuestLastName, @Email, @Event)
 end try
 begin catch
  set @msg=N'Can not be entered!'
  Raiserror (@msg,16,1)
  return
  end catch
end


GO
/****** Object:  StoredProcedure [dbo].[insertUsers]    Script Date: 16.1.2015 г. 14:14:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[insertUsers]
@username nvarchar(50),
@password nvarchar(50)
as
begin 
insert into Users (UserName, Password)
values (@username, @password)
end

GO
/****** Object:  StoredProcedure [dbo].[Seminars2014]    Script Date: 16.1.2015 г. 14:14:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[Seminars2014]
@eventType varchar(50)=null,
@year int=null,
@team varchar(50)=null
as
begin
declare @sqlString varchar(max)
set @sqlString='select * from EventsInfo where 1=1'
if @eventType is not null
set @sqlString=@sqlString+'and TypeDescription like''%'+@eventType+'%'''
if @year is not null
set @sqlString = @sqlString+'and Year(Date)='+ cast (@year as varchar(50))+''
if @team is not null
set @sqlString = @sqlString+'and TeamName like''%'+@team+'%'';'
exec(@sqlString)
end
GO
/****** Object:  StoredProcedure [dbo].[updateEvent]    Script Date: 16.1.2015 г. 14:14:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[updateEvent] 
	-- Add the parameters for the stored procedure here
	@EventID int,
	@EventName nvarchar(50)=null,
	@EventType int=null,
	@Team int=null,
	@Client int=null,
	@Place nvarchar(50)=null,
	@Date date=null,
	@Time time=null,
	@Description nvarchar(50)=null
AS
BEGIN
    update Events 
	set	EventName=@EventName,
	 EventType=@EventType,
	  Team=@Team,
	   Client=@Client,
	    Place=@Place,
		 Date=@Date,
		  Time=@Time,
		   Description=@Description
		   where EventID=@EventID
END


GO
/****** Object:  UserDefinedFunction [dbo].[MatchUserPass]    Script Date: 16.1.2015 г. 14:14:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE function [dbo].[MatchUserPass](@usern nvarchar(50), @pass nvarchar(50))
returns bit
as 
begin
declare @b bit
declare @count int
select @count = count (*) from dbo.Users 
where UserName = @usern and Password = @pass

if (@count = 1) 
set @b=1
else if (@count = 0) 
set @b=0
return @b

end


GO
/****** Object:  Table [dbo].[ChangesRecords]    Script Date: 16.1.2015 г. 14:14:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ChangesRecords](
	[DateOfChange] [datetime] NULL,
	[Opertion] [varchar](10) NULL,
	[TableName] [varchar](10) NULL,
	[OldValues] [varchar](max) NULL,
	[NewValues] [varchar](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Clients]    Script Date: 16.1.2015 г. 14:14:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Clients](
	[ClientID] [int] NOT NULL,
	[ClientName] [nvarchar](max) NOT NULL,
	[ModificationDate] [datetime] NULL,
 CONSTRAINT [PK_Clients] PRIMARY KEY CLUSTERED 
(
	[ClientID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Employees]    Script Date: 16.1.2015 г. 14:14:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Employees](
	[EmployeeID] [int] IDENTITY(1,1) NOT NULL,
	[EmpFirstName] [varchar](50) NOT NULL,
	[EmplLastName] [varchar](50) NOT NULL,
	[PhoneNumber] [numeric](18, 0) NULL,
	[E-mail] [varchar](50) NOT NULL,
	[Team] [int] NULL,
	[ModificationDate] [datetime] NULL,
 CONSTRAINT [PK_Employees] PRIMARY KEY CLUSTERED 
(
	[EmployeeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Events]    Script Date: 16.1.2015 г. 14:14:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Events](
	[EventID] [int] IDENTITY(1,1) NOT NULL,
	[EventName] [varchar](50) NOT NULL,
	[EventType] [int] NOT NULL,
	[Team] [int] NULL,
	[Client] [int] NOT NULL,
	[Place] [varchar](max) NOT NULL,
	[Date] [date] NOT NULL,
	[Time] [time](7) NOT NULL,
	[Description] [nvarchar](max) NULL,
	[ModificationDate] [datetime] NULL,
 CONSTRAINT [PK_Events] PRIMARY KEY CLUSTERED 
(
	[EventID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[EventTypes]    Script Date: 16.1.2015 г. 14:14:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[EventTypes](
	[TypeID] [int] IDENTITY(1,1) NOT NULL,
	[TypeDescription] [varchar](50) NOT NULL,
	[ModificationDate] [datetime] NULL,
 CONSTRAINT [PK_EventTypes] PRIMARY KEY CLUSTERED 
(
	[TypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Guests]    Script Date: 16.1.2015 г. 14:14:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Guests](
	[GuestID] [int] IDENTITY(1,1) NOT NULL,
	[GuestFirstName] [nvarchar](50) NOT NULL,
	[GuestLastName] [nvarchar](50) NOT NULL,
	[E-mail] [nvarchar](50) NOT NULL,
	[Event] [int] NULL,
	[ModificationDate] [datetime] NULL,
 CONSTRAINT [PK_Guests] PRIMARY KEY CLUSTERED 
(
	[GuestID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Teams]    Script Date: 16.1.2015 г. 14:14:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Teams](
	[TeamID] [int] IDENTITY(1,1) NOT NULL,
	[TeamName] [varchar](50) NOT NULL,
	[Type] [int] NOT NULL,
	[ModificationDate] [datetime] NULL,
 CONSTRAINT [PK__Teams__123AE7B94228228C] PRIMARY KEY CLUSTERED 
(
	[TeamID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Users]    Script Date: 16.1.2015 г. 14:14:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[UserName] [nvarchar](50) NOT NULL,
	[Password] [nvarchar](50) NOT NULL
) ON [PRIMARY]

GO
/****** Object:  View [dbo].[EmployeeEventGuest]    Script Date: 16.1.2015 г. 14:14:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[EmployeeEventGuest]
as
select em.EmpFirstName, em.EmplLastName, ev.EventName, g.GuestFirstName, g.GuestLastName 
from Employees em inner join Events ev on em.Team=ev.Team
				  inner join Guests g on ev.EventID=g.Event
GO
/****** Object:  View [dbo].[EmployeesInTeams]    Script Date: 16.1.2015 г. 14:14:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE view [dbo].[EmployeesInTeams]
as
select EmpFirstname, EmplLastName
from Employees e 
where Team ='2' 
GO
/****** Object:  View [dbo].[EventGuest]    Script Date: 16.1.2015 г. 14:14:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE view [dbo].[EventGuest]
as
select e.EventName, g.GuestFirstName, g.GuestLastName, g.[E-mail], e.Place, e.Date
from Events e inner join Guests g on e.EventID=g.Event
group by EventName, GuestFirstName, GuestLastName, [E-mail], Place, Date

GO
/****** Object:  View [dbo].[EventsInfo]    Script Date: 16.1.2015 г. 14:14:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[EventsInfo]
as
select ev.EventName, et.TypeDescription, t.TeamName, c.ClientName, ev.Place, ev.Date, ev.Time, ev.Description
from Events ev inner join EventTypes et on ev.EventType=et.TypeID
               inner join Teams t on ev.Team=t.TeamID
			   inner join Clients c on ev.Client=c.ClientID
GO
/****** Object:  View [dbo].[IDs]    Script Date: 16.1.2015 г. 14:14:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[IDs]
as
select e.EventID, e.EventName, c.ClientID, c.ClientName, em.EmployeeID, em.EmplLastName,
       et.TypeID, et.TypeDescription, t.TeamID, t.TeamName   
from Events e, Clients c, Employees em, EventTypes et, Teams t
GO
/****** Object:  View [dbo].[NumberOfGuestsForEvent]    Script Date: 16.1.2015 г. 14:14:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE view [dbo].[NumberOfGuestsForEvent]
as
select e.EventName,  (select count (*) from Guests g
                    where g.Event=e.EventID)
					as NumberOfGuests, t.TeamName, e.Place
from Events e inner join Teams t on e.Team=t.TeamID

GO
/****** Object:  View [dbo].[ViewEventsNames]    Script Date: 16.1.2015 г. 14:14:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[ViewEventsNames]
AS
SELECT        dbo.Events.EventName, dbo.EventTypes.TypeDescription, dbo.Teams.TeamName, dbo.Clients.ClientName, dbo.Events.Place, dbo.Events.Date, dbo.Events.Time
FROM            dbo.Clients INNER JOIN
                         dbo.Events ON dbo.Clients.ClientID = dbo.Events.Client INNER JOIN
                         dbo.EventTypes ON dbo.Events.EventType = dbo.EventTypes.TypeID INNER JOIN
                         dbo.Guests ON dbo.Events.EventID = dbo.Guests.Event INNER JOIN
                         dbo.Teams ON dbo.Events.Team = dbo.Teams.TeamID AND dbo.EventTypes.TypeID = dbo.Teams.Type INNER JOIN
                         dbo.Employees ON dbo.Teams.TeamID = dbo.Employees.Team

GO
INSERT [dbo].[ChangesRecords] ([DateOfChange], [Opertion], [TableName], [OldValues], [NewValues]) VALUES (CAST(0x0000A3FB00E5C1D0 AS DateTime), N'Update', N'Clients', N'14;BusinessIn', N'14;Jimmy Choo')
INSERT [dbo].[ChangesRecords] ([DateOfChange], [Opertion], [TableName], [OldValues], [NewValues]) VALUES (CAST(0x0000A3FB0100C4AD AS DateTime), N'Update', N'Events', N'23;EmigrationLecture;91;1;13;UNWE;2014-09-30;18:00:00.0000000;', N'23;MoneyFlowsLetcture;91;1;13;UNWE;2014-09-30;18:00:00.0000000;')
INSERT [dbo].[ChangesRecords] ([DateOfChange], [Opertion], [TableName], [OldValues], [NewValues]) VALUES (CAST(0x0000A3FB011DF4B9 AS DateTime), N'Insert', N'Clients', NULL, N'16;Victoria Secret')
INSERT [dbo].[ChangesRecords] ([DateOfChange], [Opertion], [TableName], [OldValues], [NewValues]) VALUES (CAST(0x0000A3FB011E022F AS DateTime), N'Insert', N'Clients', NULL, N'17;DSK Bank')
INSERT [dbo].[ChangesRecords] ([DateOfChange], [Opertion], [TableName], [OldValues], [NewValues]) VALUES (CAST(0x0000A3FB011E2777 AS DateTime), N'Insert', N'Clients', NULL, N'18;Lukoil')
INSERT [dbo].[ChangesRecords] ([DateOfChange], [Opertion], [TableName], [OldValues], [NewValues]) VALUES (CAST(0x0000A3FB011F3C46 AS DateTime), N'Insert', N'Clients', NULL, N'19;Bahamas')
INSERT [dbo].[ChangesRecords] ([DateOfChange], [Opertion], [TableName], [OldValues], [NewValues]) VALUES (CAST(0x0000A3FB011FB966 AS DateTime), N'Insert', N'Clients', NULL, N'20;OMV')
INSERT [dbo].[ChangesRecords] ([DateOfChange], [Opertion], [TableName], [OldValues], [NewValues]) VALUES (CAST(0x0000A3FB012276A8 AS DateTime), N'Insert', N'Events', NULL, N'24;WhoWantsToBeRich;91;1;18;Radisson;2014-09-15;15:00:00.0000000;How to attrack money and be successful')
INSERT [dbo].[ChangesRecords] ([DateOfChange], [Opertion], [TableName], [OldValues], [NewValues]) VALUES (CAST(0x0000A3FB01230A93 AS DateTime), N'Insert', N'Events', NULL, N'25;AnniversaryDSK;94;2;17;Incanto;2014-08-12;21:30:00.0000000;')
INSERT [dbo].[ChangesRecords] ([DateOfChange], [Opertion], [TableName], [OldValues], [NewValues]) VALUES (CAST(0x0000A3FB0124C6F6 AS DateTime), N'Insert', N'Events', NULL, N'26;NewYearPartyBahamas;94;2;19;Bahamamama;2014-12-30;22:00:00.0000000;')
INSERT [dbo].[ChangesRecords] ([DateOfChange], [Opertion], [TableName], [OldValues], [NewValues]) VALUES (CAST(0x0000A3FB012559BA AS DateTime), N'Insert', N'Events', NULL, N'27;YoungMathematician;91;5;20;SMG;2013-03-02;09:00:00.0000000;')
INSERT [dbo].[ChangesRecords] ([DateOfChange], [Opertion], [TableName], [OldValues], [NewValues]) VALUES (CAST(0x0000A402013A1A5A AS DateTime), N'Insert', N'Clients', NULL, N'22;Johnny')
INSERT [dbo].[ChangesRecords] ([DateOfChange], [Opertion], [TableName], [OldValues], [NewValues]) VALUES (CAST(0x0000A40300BF6673 AS DateTime), N'Delete', N'Events', N'27;YoungMathematician;91;5;20;SMG;2013-03-02;09:00:00.0000000;', NULL)
INSERT [dbo].[ChangesRecords] ([DateOfChange], [Opertion], [TableName], [OldValues], [NewValues]) VALUES (CAST(0x0000A40300ED2610 AS DateTime), N'Insert', N'Clients', NULL, N'23;gdfhfdhgfh')
INSERT [dbo].[ChangesRecords] ([DateOfChange], [Opertion], [TableName], [OldValues], [NewValues]) VALUES (CAST(0x0000A42101430277 AS DateTime), N'Insert', N'Events', NULL, N'27;Bday;94;2;14;Club;2015-05-14;21:00:00.0000000;best party for Jimmy')
INSERT [dbo].[ChangesRecords] ([DateOfChange], [Opertion], [TableName], [OldValues], [NewValues]) VALUES (CAST(0x0000A422009FF92C AS DateTime), N'Update', N'Events', N'26;NewYearPartyBahamas;94;2;19;Bahamamama;2014-12-30;22:00:00.0000000;', N'26;NewYearPartyBahamas;94;2;19;Bahamamama;2014-12-30;22:00:00.0000000;haha')
INSERT [dbo].[ChangesRecords] ([DateOfChange], [Opertion], [TableName], [OldValues], [NewValues]) VALUES (CAST(0x0000A42200BE9967 AS DateTime), N'Insert', N'Events', NULL, N'28;party;94;2;17;disko;2015-05-14;22:00:00.0000000;super party')
INSERT [dbo].[ChangesRecords] ([DateOfChange], [Opertion], [TableName], [OldValues], [NewValues]) VALUES (CAST(0x0000A42200D3DFF5 AS DateTime), N'Insert', N'Events', NULL, N'29;zdrasti;93;7;18;parks;2015-06-06;19:00:00.0000000;')
INSERT [dbo].[ChangesRecords] ([DateOfChange], [Opertion], [TableName], [OldValues], [NewValues]) VALUES (CAST(0x0000A42200E96088 AS DateTime), N'Insert', N'Events', NULL, N'30;gfd;93;3;15;hgfd;2015-06-25;02:00:00.0000000;')
INSERT [dbo].[ChangesRecords] ([DateOfChange], [Opertion], [TableName], [OldValues], [NewValues]) VALUES (CAST(0x0000A40300ED2CE1 AS DateTime), N'Update', N'Clients', N'23;gdfhfdhgfh', N'23;pesho')
INSERT [dbo].[ChangesRecords] ([DateOfChange], [Opertion], [TableName], [OldValues], [NewValues]) VALUES (CAST(0x0000A40300ED312C AS DateTime), N'Delete', N'Clients', N'23;pesho', NULL)
INSERT [dbo].[Clients] ([ClientID], [ClientName], [ModificationDate]) VALUES (12, N'Sensa Ltd.', NULL)
INSERT [dbo].[Clients] ([ClientID], [ClientName], [ModificationDate]) VALUES (13, N'Progress Inc.', NULL)
INSERT [dbo].[Clients] ([ClientID], [ClientName], [ModificationDate]) VALUES (14, N'Jimmy Choo', CAST(0x0000A3FB00E5C1CD AS DateTime))
INSERT [dbo].[Clients] ([ClientID], [ClientName], [ModificationDate]) VALUES (15, N'Advice Profesional', CAST(0x0000A3FA0150E9AA AS DateTime))
INSERT [dbo].[Clients] ([ClientID], [ClientName], [ModificationDate]) VALUES (16, N'Victoria Secret', CAST(0x0000A3FB011DF49A AS DateTime))
INSERT [dbo].[Clients] ([ClientID], [ClientName], [ModificationDate]) VALUES (17, N'DSK Bank', CAST(0x0000A3FB011E022D AS DateTime))
INSERT [dbo].[Clients] ([ClientID], [ClientName], [ModificationDate]) VALUES (18, N'Lukoil', CAST(0x0000A3FB011E2775 AS DateTime))
INSERT [dbo].[Clients] ([ClientID], [ClientName], [ModificationDate]) VALUES (19, N'Bahamas', CAST(0x0000A3FB011F3C40 AS DateTime))
INSERT [dbo].[Clients] ([ClientID], [ClientName], [ModificationDate]) VALUES (20, N'OMV', CAST(0x0000A3FB011FB963 AS DateTime))
INSERT [dbo].[Clients] ([ClientID], [ClientName], [ModificationDate]) VALUES (22, N'Johnny', CAST(0x0000A402013A1A57 AS DateTime))
SET IDENTITY_INSERT [dbo].[Employees] ON 

INSERT [dbo].[Employees] ([EmployeeID], [EmpFirstName], [EmplLastName], [PhoneNumber], [E-mail], [Team], [ModificationDate]) VALUES (41, N'John', N'Smith', CAST(359879 AS Numeric(18, 0)), N'john@abv,bg', 1, NULL)
INSERT [dbo].[Employees] ([EmployeeID], [EmpFirstName], [EmplLastName], [PhoneNumber], [E-mail], [Team], [ModificationDate]) VALUES (42, N'Linda', N'Cornel', CAST(359899 AS Numeric(18, 0)), N'cornel@yahoo.com', 4, NULL)
INSERT [dbo].[Employees] ([EmployeeID], [EmpFirstName], [EmplLastName], [PhoneNumber], [E-mail], [Team], [ModificationDate]) VALUES (43, N'Teodor', N'Roosevelt', CAST(447895 AS Numeric(18, 0)), N'roose@gmail.com', 3, NULL)
INSERT [dbo].[Employees] ([EmployeeID], [EmpFirstName], [EmplLastName], [PhoneNumber], [E-mail], [Team], [ModificationDate]) VALUES (44, N'Donna', N'Karen', CAST(448569 AS Numeric(18, 0)), N'karen@gag.com', 2, NULL)
INSERT [dbo].[Employees] ([EmployeeID], [EmpFirstName], [EmplLastName], [PhoneNumber], [E-mail], [Team], [ModificationDate]) VALUES (45, N'Anna', N'Madej', CAST(485555 AS Numeric(18, 0)), N'anna@mail.pl', 2, NULL)
INSERT [dbo].[Employees] ([EmployeeID], [EmpFirstName], [EmplLastName], [PhoneNumber], [E-mail], [Team], [ModificationDate]) VALUES (46, N'Bill', N'Clinton', CAST(4566321 AS Numeric(18, 0)), N'bill@js.com', 1, CAST(0x0000A40300E95426 AS DateTime))
SET IDENTITY_INSERT [dbo].[Employees] OFF
SET IDENTITY_INSERT [dbo].[Events] ON 

INSERT [dbo].[Events] ([EventID], [EventName], [EventType], [Team], [Client], [Place], [Date], [Time], [Description], [ModificationDate]) VALUES (21, N'BI Team Buildig', 92, 4, 14, N'Bankya', CAST(0x91380B00 AS Date), CAST(0x0700A8E76F4B0000 AS Time), NULL, NULL)
INSERT [dbo].[Events] ([EventID], [EventName], [EventType], [Team], [Client], [Place], [Date], [Time], [Description], [ModificationDate]) VALUES (22, N'BusinessIdeaSeminar', 91, 1, 12, N'Hilton', CAST(0xBA380B00 AS Date), CAST(0x070080461C860000 AS Time), NULL, NULL)
INSERT [dbo].[Events] ([EventID], [EventName], [EventType], [Team], [Client], [Place], [Date], [Time], [Description], [ModificationDate]) VALUES (23, N'MoneyFlowsLetcture', 91, 1, 13, N'UNWE', CAST(0x11390B00 AS Date), CAST(0x070050CFDF960000 AS Time), NULL, CAST(0x0000A3FB0100C4A3 AS DateTime))
INSERT [dbo].[Events] ([EventID], [EventName], [EventType], [Team], [Client], [Place], [Date], [Time], [Description], [ModificationDate]) VALUES (24, N'WhoWantsToBeRich', 91, 1, 18, N'Radisson', CAST(0x02390B00 AS Date), CAST(0x07001882BA7D0000 AS Time), N'How to attrack money and be successful', CAST(0x0000A3FB012276A6 AS DateTime))
INSERT [dbo].[Events] ([EventID], [EventName], [EventType], [Team], [Client], [Place], [Date], [Time], [Description], [ModificationDate]) VALUES (25, N'AnniversaryDSK', 94, 2, 17, N'Incanto', CAST(0xE0380B00 AS Date), CAST(0x0700BCFE35B40000 AS Time), NULL, CAST(0x0000A3FB01230A8C AS DateTime))
INSERT [dbo].[Events] ([EventID], [EventName], [EventType], [Team], [Client], [Place], [Date], [Time], [Description], [ModificationDate]) VALUES (26, N'NewYearPartyBahamas', 94, 2, 19, N'Bahamamama', CAST(0x6C390B00 AS Date), CAST(0x0700F0E066B80000 AS Time), N'haha', CAST(0x0000A422009FF905 AS DateTime))
INSERT [dbo].[Events] ([EventID], [EventName], [EventType], [Team], [Client], [Place], [Date], [Time], [Description], [ModificationDate]) VALUES (27, N'Bday', 94, 2, 14, N'Club', CAST(0xF3390B00 AS Date), CAST(0x0700881C05B00000 AS Time), N'best party for Jimmy', CAST(0x0000A42101430271 AS DateTime))
INSERT [dbo].[Events] ([EventID], [EventName], [EventType], [Team], [Client], [Place], [Date], [Time], [Description], [ModificationDate]) VALUES (28, N'party', 94, 2, 17, N'disko', CAST(0xF3390B00 AS Date), CAST(0x0700F0E066B80000 AS Time), N'super party', CAST(0x0000A42200BE9960 AS DateTime))
INSERT [dbo].[Events] ([EventID], [EventName], [EventType], [Team], [Client], [Place], [Date], [Time], [Description], [ModificationDate]) VALUES (29, N'zdrasti', 93, 7, 18, N'parks', CAST(0x0A3A0B00 AS Date), CAST(0x0700B893419F0000 AS Time), N'', CAST(0x0000A42200D3DFEC AS DateTime))
INSERT [dbo].[Events] ([EventID], [EventName], [EventType], [Team], [Client], [Place], [Date], [Time], [Description], [ModificationDate]) VALUES (30, N'gfd', 93, 3, 15, N'hgfd', CAST(0x1D3A0B00 AS Date), CAST(0x0700D088C3100000 AS Time), N'', CAST(0x0000A42200E96080 AS DateTime))
SET IDENTITY_INSERT [dbo].[Events] OFF
SET IDENTITY_INSERT [dbo].[EventTypes] ON 

INSERT [dbo].[EventTypes] ([TypeID], [TypeDescription], [ModificationDate]) VALUES (91, N'Seminar', NULL)
INSERT [dbo].[EventTypes] ([TypeID], [TypeDescription], [ModificationDate]) VALUES (92, N'TeamBuilding', NULL)
INSERT [dbo].[EventTypes] ([TypeID], [TypeDescription], [ModificationDate]) VALUES (93, N' BusinessMeetings', NULL)
INSERT [dbo].[EventTypes] ([TypeID], [TypeDescription], [ModificationDate]) VALUES (94, N'Party', NULL)
SET IDENTITY_INSERT [dbo].[EventTypes] OFF
SET IDENTITY_INSERT [dbo].[Guests] ON 

INSERT [dbo].[Guests] ([GuestID], [GuestFirstName], [GuestLastName], [E-mail], [Event], [ModificationDate]) VALUES (31, N'Bambi', N'Markov', N'markov@mail.com', 22, CAST(0x0000A3FA0153DF65 AS DateTime))
INSERT [dbo].[Guests] ([GuestID], [GuestFirstName], [GuestLastName], [E-mail], [Event], [ModificationDate]) VALUES (32, N'Marta', N'Skiba', N'skiba@mail.com', 22, NULL)
INSERT [dbo].[Guests] ([GuestID], [GuestFirstName], [GuestLastName], [E-mail], [Event], [ModificationDate]) VALUES (33, N'Patritzia', N'Patison', N'pat@mail.com', 21, NULL)
INSERT [dbo].[Guests] ([GuestID], [GuestFirstName], [GuestLastName], [E-mail], [Event], [ModificationDate]) VALUES (34, N'Jacub', N'Dwordzak', N'dwordzak@mail.com', 21, NULL)
INSERT [dbo].[Guests] ([GuestID], [GuestFirstName], [GuestLastName], [E-mail], [Event], [ModificationDate]) VALUES (35, N'Jitse', N'Sophie', N'sophie@mail.com', 23, NULL)
INSERT [dbo].[Guests] ([GuestID], [GuestFirstName], [GuestLastName], [E-mail], [Event], [ModificationDate]) VALUES (36, N'George', N'Kernel', N'kern@mail.com', 23, CAST(0x0000A3FB012167C8 AS DateTime))
INSERT [dbo].[Guests] ([GuestID], [GuestFirstName], [GuestLastName], [E-mail], [Event], [ModificationDate]) VALUES (37, N'Magi ', N'Hen', N'hh@abv.bg', 21, CAST(0x0000A3FB0121A133 AS DateTime))
INSERT [dbo].[Guests] ([GuestID], [GuestFirstName], [GuestLastName], [E-mail], [Event], [ModificationDate]) VALUES (38, N'Jack', N'Sparrow', N'jackie@jack.com', 21, CAST(0x0000A3FB0121DE9E AS DateTime))
INSERT [dbo].[Guests] ([GuestID], [GuestFirstName], [GuestLastName], [E-mail], [Event], [ModificationDate]) VALUES (39, N'Julie', N'Buch', N'ju@gag.fr', 26, CAST(0x0000A3FB012597B4 AS DateTime))
INSERT [dbo].[Guests] ([GuestID], [GuestFirstName], [GuestLastName], [E-mail], [Event], [ModificationDate]) VALUES (40, N'Barbi', N'Bi', N'bb@gag.de', 26, CAST(0x0000A3FB0125D315 AS DateTime))
INSERT [dbo].[Guests] ([GuestID], [GuestFirstName], [GuestLastName], [E-mail], [Event], [ModificationDate]) VALUES (41, N'Gaga', N'Lill', N'gag@tri.bg', 26, CAST(0x0000A3FB012609E3 AS DateTime))
INSERT [dbo].[Guests] ([GuestID], [GuestFirstName], [GuestLastName], [E-mail], [Event], [ModificationDate]) VALUES (42, N'Lidia', N'Benet', N'lili@yahoo.co.uk', 26, CAST(0x0000A3FB01262554 AS DateTime))
INSERT [dbo].[Guests] ([GuestID], [GuestFirstName], [GuestLastName], [E-mail], [Event], [ModificationDate]) VALUES (43, N'Eli', N'Scherer', N'scherer@grab.de', 24, CAST(0x0000A3FB01264DBA AS DateTime))
INSERT [dbo].[Guests] ([GuestID], [GuestFirstName], [GuestLastName], [E-mail], [Event], [ModificationDate]) VALUES (44, N'Ivan', N'Ivanov', N'ivan@.com', NULL, CAST(0x0000A40300C56472 AS DateTime))
INSERT [dbo].[Guests] ([GuestID], [GuestFirstName], [GuestLastName], [E-mail], [Event], [ModificationDate]) VALUES (48, N'g', N'mn', N'dtjtd@nbb.com', 21, CAST(0x0000A40300E642E9 AS DateTime))
INSERT [dbo].[Guests] ([GuestID], [GuestFirstName], [GuestLastName], [E-mail], [Event], [ModificationDate]) VALUES (49, N'bari', N'mehmed', N'hgc@ed.com', NULL, CAST(0x0000A40300E67219 AS DateTime))
SET IDENTITY_INSERT [dbo].[Guests] OFF
SET IDENTITY_INSERT [dbo].[Teams] ON 

INSERT [dbo].[Teams] ([TeamID], [TeamName], [Type], [ModificationDate]) VALUES (1, N'SeminarExperts', 91, NULL)
INSERT [dbo].[Teams] ([TeamID], [TeamName], [Type], [ModificationDate]) VALUES (2, N'PartyExperts', 94, NULL)
INSERT [dbo].[Teams] ([TeamID], [TeamName], [Type], [ModificationDate]) VALUES (3, N'Business', 93, NULL)
INSERT [dbo].[Teams] ([TeamID], [TeamName], [Type], [ModificationDate]) VALUES (4, N'TeamBuilders', 92, NULL)
INSERT [dbo].[Teams] ([TeamID], [TeamName], [Type], [ModificationDate]) VALUES (6, N'EducationImporove', 91, CAST(0x0000A40300E5AD58 AS DateTime))
INSERT [dbo].[Teams] ([TeamID], [TeamName], [Type], [ModificationDate]) VALUES (7, N'NewTimes', 94, CAST(0x0000A40300E5C7E5 AS DateTime))
SET IDENTITY_INSERT [dbo].[Teams] OFF
INSERT [dbo].[Users] ([UserName], [Password]) VALUES (N'gancho', N'1234')
INSERT [dbo].[Users] ([UserName], [Password]) VALUES (N'kiro', N'5678')
INSERT [dbo].[Users] ([UserName], [Password]) VALUES (N'anka', N'9876')
INSERT [dbo].[Users] ([UserName], [Password]) VALUES (N'papi', N'1111')
INSERT [dbo].[Users] ([UserName], [Password]) VALUES (N'gancho', N'1234')
INSERT [dbo].[Users] ([UserName], [Password]) VALUES (N'mimi', N'4563')
INSERT [dbo].[Users] ([UserName], [Password]) VALUES (N'baba', N'1239')
INSERT [dbo].[Users] ([UserName], [Password]) VALUES (N'alq', N'123')
INSERT [dbo].[Users] ([UserName], [Password]) VALUES (N'kak', N'456')
INSERT [dbo].[Users] ([UserName], [Password]) VALUES (N'kaka', N'7896')
INSERT [dbo].[Users] ([UserName], [Password]) VALUES (N'babsi', N'357')
INSERT [dbo].[Users] ([UserName], [Password]) VALUES (N'bambi', N'987654')
INSERT [dbo].[Users] ([UserName], [Password]) VALUES (N'dadaa', N'687')
/****** Object:  Index [IX_EventTypes]    Script Date: 16.1.2015 г. 14:14:19 ******/
CREATE NONCLUSTERED INDEX [IX_EventTypes] ON [dbo].[EventTypes]
(
	[TypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Employees]  WITH CHECK ADD  CONSTRAINT [FK_Employees_Teams] FOREIGN KEY([Team])
REFERENCES [dbo].[Teams] ([TeamID])
GO
ALTER TABLE [dbo].[Employees] CHECK CONSTRAINT [FK_Employees_Teams]
GO
ALTER TABLE [dbo].[Events]  WITH CHECK ADD  CONSTRAINT [FK_Events_Clients] FOREIGN KEY([Client])
REFERENCES [dbo].[Clients] ([ClientID])
GO
ALTER TABLE [dbo].[Events] CHECK CONSTRAINT [FK_Events_Clients]
GO
ALTER TABLE [dbo].[Events]  WITH CHECK ADD  CONSTRAINT [FK_Events_EventTypes] FOREIGN KEY([EventType])
REFERENCES [dbo].[EventTypes] ([TypeID])
GO
ALTER TABLE [dbo].[Events] CHECK CONSTRAINT [FK_Events_EventTypes]
GO
ALTER TABLE [dbo].[Events]  WITH CHECK ADD  CONSTRAINT [FK_Events_Teams] FOREIGN KEY([Team])
REFERENCES [dbo].[Teams] ([TeamID])
GO
ALTER TABLE [dbo].[Events] CHECK CONSTRAINT [FK_Events_Teams]
GO
ALTER TABLE [dbo].[Guests]  WITH CHECK ADD  CONSTRAINT [FK_Guests_Events] FOREIGN KEY([Event])
REFERENCES [dbo].[Events] ([EventID])
GO
ALTER TABLE [dbo].[Guests] CHECK CONSTRAINT [FK_Guests_Events]
GO
ALTER TABLE [dbo].[Teams]  WITH CHECK ADD  CONSTRAINT [FK_Teams_EventTypes] FOREIGN KEY([Type])
REFERENCES [dbo].[EventTypes] ([TypeID])
GO
ALTER TABLE [dbo].[Teams] CHECK CONSTRAINT [FK_Teams_EventTypes]
GO
/****** Object:  Trigger [dbo].[client_modif_date]    Script Date: 16.1.2015 г. 14:14:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE trigger [dbo].[client_modif_date]
on [dbo].[Clients]
after insert, update
as 
begin
set nocount on;
disable trigger ClientsChanges on Clients;
update Clients
set ModificationDate=GETDATE()
where ClientID in (Select ClientID from inserted);
enable trigger ClientsChanges on Clients;
end

GO
/****** Object:  Trigger [dbo].[ClientsChanges]    Script Date: 16.1.2015 г. 14:14:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE trigger [dbo].[ClientsChanges]
on [dbo].[Clients]
after insert, update, delete
as
begin
set nocount on
declare @operation varchar(10)
set @operation = case
	when exists (select * from inserted ) and exists (select * from deleted)
	then 'Update'
	when exists (select * from inserted) 
	then 'Insert'
	when exists (select * from deleted)
	then 'Delete'
	else NULL
end
if @operation = 'Delete'
insert into ChangesRecords(DateOfChange, Opertion, TableName, OldValues)
select GETDATE(), @operation, 'Clients', ISNULL(convert(varchar(50), ClientID), '') +';'+ISNULL(ClientName, '') as oldValues
from deleted

if @operation = 'Insert'
insert into ChangesRecords(DateOfChange, Opertion, TableName, NewValues)
select GETDATE(),@operation,'Clients', ISNULL(convert(varchar(50),ClientID), '') +';'+ISNULL(ClientName, '') as newValues
from inserted

if @operation='Update'
insert into ChangesRecords(DateOfChange, Opertion, TableName, OldValues,NewValues)
select GETDATE(), @operation, 'Clients',ISNULL(convert(varchar(50),d.ClientID), '') +';'+ ISNULL(d.ClientName, '') as oldValues,
							            ISNULL(convert(varchar(50),d.ClientID), '') + ';' + ISNULL(i.ClientName, '') as newValues

from deleted d, inserted i
where d.ClientID = i.ClientID
end



GO
/****** Object:  Trigger [dbo].[employees_modif_date]    Script Date: 16.1.2015 г. 14:14:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create trigger [dbo].[employees_modif_date]
on [dbo].[Employees]
after insert, update
as
begin
set nocount on
update Employees
set ModificationDate = GETDATE()
where EmployeeID in (select EmployeeID from inserted)
end

GO
/****** Object:  Trigger [dbo].[events_modif_date]    Script Date: 16.1.2015 г. 14:14:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE trigger [dbo].[events_modif_date]
on [dbo].[Events]
after insert, update
as
begin
set nocount on;
disable trigger EventsChanges on Events;
update Events
set ModificationDate= GETDATE()
where EventID in (select EventID from inserted);
enable trigger EventsChanges on Events;
end

GO
/****** Object:  Trigger [dbo].[EventsChanges]    Script Date: 16.1.2015 г. 14:14:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create trigger [dbo].[EventsChanges]
on [dbo].[Events]
after insert, update, delete
as 
begin
set nocount on
declare @operationEv varchar(10)
set @operationEv = case
when exists (select * from inserted) and exists (select * from deleted)
then 'Update'
when exists (select * from inserted)
then 'Insert'
when exists (select * from deleted)
then 'Delete'
else NULL
end

if @operationEv = 'Delete'
	insert into ChangesRecords(DateOfChange, Opertion, TableName, OldValues)
	select GETDATE(), @operationEv, 'Events', 
			ISNULL(convert(varchar(50),EventID), '') + ';' + ISNULL(EventName, '') + ';' + Isnull(convert(varchar(50),EventType), '') + ';' + 
			ISNULL(convert(varchar(50),Team), '') + ';' + isnull(convert(varchar(50),Client), '') + ';' + isnull(Place, '') + ';' +
			ISNULL(convert(varchar(50),Date), '') + ';' + ISNULL(convert(varchar(50),Time), '') + ';' + ISNULL(Description, '') as oldValues
	from deleted

if @operationEv = 'Insert'
	insert into ChangesRecords(DateOfChange, Opertion, TableName, NewValues)
	select GETDATE(), @operationEv, 'Events', 
			ISNULL(convert(varchar(50),EventID), '') + ';' + ISNULL(EventName, '') + ';' + Isnull(convert(varchar(50),EventType), '') + ';' + 
			ISNULL(convert(varchar(50),Team), '') + ';' + isnull(convert(varchar(50),Client), '') + ';' + isnull(Place, '') + ';' +
			ISNULL(convert(varchar(50),Date), '') + ';' + ISNULL(convert(varchar(50),Time), '') + ';' + ISNULL(Description, '') as newValues
	from inserted

if @operationEv = 'Update'
	insert into ChangesRecords(DateOfChange, Opertion, TableName, OldValues, NewValues)
	select GETDATE(), @operationEv, 'Events', 
			ISNULL(convert(varchar(50),d.EventID), '') + ';' + ISNULL(d.EventName, '') + ';' + Isnull(convert(varchar(50),d.EventType), '') + ';' + 
			ISNULL(convert(varchar(50),d.Team), '') + ';' + isnull(convert(varchar(50),d.Client), '') + ';' + isnull(d.Place, '') + ';' +
			ISNULL(convert(varchar(50),d.Date), '') + ';' + ISNULL(convert(varchar(50),d.Time), '') + ';' + ISNULL(d.Description, '') as oldValues,
			ISNULL(convert(varchar(50),i.EventID), '') + ';' + ISNULL(i.EventName, '') + ';' + Isnull(convert(varchar(50),i.EventType), '') + ';' + 
			ISNULL(convert(varchar(50),i.Team), '') + ';' + isnull(convert(varchar(50),i.Client), '') + ';' + isnull(i.Place, '') + ';' +
			ISNULL(convert(varchar(50),i.Date), '') + ';' + ISNULL(convert(varchar(50),i.Time), '') + ';' + ISNULL(i.Description, '') as newValues
	from deleted d, inserted i
	where d.EventID = i.EventID
end

GO
/****** Object:  Trigger [dbo].[EventTypes_modif_date]    Script Date: 16.1.2015 г. 14:14:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create trigger [dbo].[EventTypes_modif_date]
on [dbo].[EventTypes]
after insert, update
as
begin
set nocount on
update EventTypes
set ModificationDate = GETDATE()
where TypeID in (select TypeID from inserted)
end

GO
/****** Object:  Trigger [dbo].[Guests_modif_date]    Script Date: 16.1.2015 г. 14:14:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create trigger [dbo].[Guests_modif_date]
on [dbo].[Guests]
after insert, update
as
begin
set nocount on
update Guests
set ModificationDate = GETDATE()
where GuestID in (select GuestID from inserted)
end

GO
/****** Object:  Trigger [dbo].[Teams_modif_date]    Script Date: 16.1.2015 г. 14:14:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create trigger [dbo].[Teams_modif_date]
on [dbo].[Teams]
after insert, update
as
begin
set nocount on
update Teams
set ModificationDate = GETDATE()
where TeamID in (select TeamID from inserted)
end

GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "e"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 136
               Right = 219
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "t"
            Begin Extent = 
               Top = 6
               Left = 257
               Bottom = 136
               Right = 438
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'EmployeesInTeams'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'EmployeesInTeams'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[19] 4[34] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = -211
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Clients"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 119
               Right = 219
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Events"
            Begin Extent = 
               Top = 6
               Left = 476
               Bottom = 136
               Right = 657
            End
            DisplayFlags = 280
            TopColumn = 6
         End
         Begin Table = "EventTypes"
            Begin Extent = 
               Top = 6
               Left = 695
               Bottom = 119
               Right = 876
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Guests"
            Begin Extent = 
               Top = 120
               Left = 38
               Bottom = 250
               Right = 219
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Teams"
            Begin Extent = 
               Top = 120
               Left = 695
               Bottom = 250
               Right = 876
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Employees"
            Begin Extent = 
               Top = 6
               Left = 257
               Bottom = 136
               Right = 438
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 2145
         Width = 1500
     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'ViewEventsNames'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N'    Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 2625
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'ViewEventsNames'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'ViewEventsNames'
GO
USE [master]
GO
ALTER DATABASE [EventManagement] SET  READ_WRITE 
GO
