IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pCalendarHeaderToDivision_CalendarToDivisionID]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pCalendarHeaderToDivision] DROP CONSTRAINT [DF_pCalendarHeaderToDivision_CalendarToDivisionID]
END
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pCalendarHeaderToDivision]') AND type in (N'U'))
DROP TABLE [dbo].[pCalendarHeaderToDivision]
GO


CREATE TABLE [dbo].[pCalendarHeaderToDivision](
	[CalendarHeaderToDivisionID] [uniqueidentifier] NOT NULL,
	[CalendarHeaderID] [uniqueidentifier] NULL,
	[DivisionID] [uniqueidentifier] NULL,
 CONSTRAINT [PK_pCalendarHeaderToDivision] PRIMARY KEY CLUSTERED 
(
	[CalendarHeaderToDivisionID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[pCalendarHeaderToDivision] ADD  CONSTRAINT [DF_pCalendarHeaderToDivision_CalendarToDivisionID]  DEFAULT (newid()) FOR [CalendarHeaderToDivisionID]
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '05454', GetDate())
GO
