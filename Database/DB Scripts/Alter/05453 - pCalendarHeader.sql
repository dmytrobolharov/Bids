IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pCalendarHeader_CalendarHeaderID]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pCalendarHeader] DROP CONSTRAINT [DF_pCalendarHeader_CalendarHeaderID]
END
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pCalendarHeader]') AND type in (N'U'))
DROP TABLE [dbo].[pCalendarHeader]
GO


CREATE TABLE [dbo].[pCalendarHeader](
	[CalendarHeaderID] [uniqueidentifier] NOT NULL,
	[CalendarName] [nvarchar](200) NULL,
	[MilestoneTemplateID] [uniqueidentifier] NULL,
	[StartDate] [datetime] NULL,
	[EndDate] [datetime] NULL,
	[SeasonYearID] [uniqueidentifier] NULL,
	[CustomField1] [nvarchar](200) NULL,
	[CustomField2] [nvarchar](200) NULL,
	[CustomField3] [nvarchar](200) NULL,
	[CustomField4] [nvarchar](200) NULL,
	[CustomField5] [nvarchar](200) NULL,
	[CustomField6] [nvarchar](200) NULL,
	[CustomField7] [decimal](18, 5) NULL,
	[CustomField8] [decimal](18, 5) NULL,
	[CustomField9] [int] NULL,
	[CustomField10] [int] NULL,
	[Active] [int] NULL,
	[Sort] [int] NULL,
	[CDate] [datetime] NULL,
	[CUser] [nvarchar](200) NULL,
	[MDate] [datetime] NULL,
	[MUser] [nvarchar](200) NULL,
 CONSTRAINT [PK_pCalendarHeader] PRIMARY KEY CLUSTERED 
(
	[CalendarHeaderID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[pCalendarHeader] ADD  CONSTRAINT [DF_pCalendarHeader_CalendarHeaderID]  DEFAULT (newid()) FOR [CalendarHeaderID]
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '05453', GetDate())
GO
