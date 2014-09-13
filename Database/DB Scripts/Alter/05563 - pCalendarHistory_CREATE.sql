IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pCalendarHistory_CalendarHeaderHistoryID]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pCalendarHistory] DROP CONSTRAINT [DF_pCalendarHistory_CalendarHeaderHistoryID]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pCalendarHistory_CDate]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pCalendarHistory] DROP CONSTRAINT [DF_pCalendarHistory_CDate]
END

GO

/****** Object:  Table [dbo].[pCalendarHistory]    Script Date: 04/15/2013 11:02:22 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pCalendarHistory]') AND type in (N'U'))
DROP TABLE [dbo].[pCalendarHistory]
GO


/****** Object:  Table [dbo].[pCalendarHistory]    Script Date: 04/15/2013 11:02:22 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[pCalendarHistory](
	[CalendarHeaderHistoryID] [uniqueidentifier] NOT NULL,
	[CalendarHeaderID] [uniqueidentifier] NULL,
	[TeamID] [uniqueidentifier] NULL,
	[CDate] [datetime] NULL,
 CONSTRAINT [PK_pCalendarHistory] PRIMARY KEY CLUSTERED 
(
	[CalendarHeaderHistoryID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[pCalendarHistory] ADD  CONSTRAINT [DF_pCalendarHistory_CalendarHeaderHistoryID]  DEFAULT (newid()) FOR [CalendarHeaderHistoryID]
GO

ALTER TABLE [dbo].[pCalendarHistory] ADD  CONSTRAINT [DF_pCalendarHistory_CDate]  DEFAULT (getdate()) FOR [CDate]
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '05563', GetDate())
GO
