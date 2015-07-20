/****** Object:  Table [dbo].[pYearCalendar]    Script Date: 04/02/2012 15:57:09 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pYearCalendar]') AND type in (N'U'))
DROP TABLE [dbo].[pYearCalendar]
GO

/****** Object:  Table [dbo].[pYearCalendar]    Script Date: 04/02/2012 15:57:10 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[pYearCalendar](
	[YearCalendarID] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[YearMonth1] [int] NULL,
	[YearMonth2] [int] NULL,
	[YearMonth3] [int] NULL,
	[YearMonth4] [int] NULL,
	[YearMonth5] [int] NULL,
	[YearMonth6] [int] NULL,
	[YearMonth7] [int] NULL,
	[YearMonth8] [int] NULL,
	[YearMonth9] [int] NULL,
	[YearMonth10] [int] NULL,
	[YearMonth11] [int] NULL,
	[YearMonth12] [int] NULL,
	[CUser] [nvarchar](200) NULL,
	[CDate] [datetime] NULL,
	[MUser] [nvarchar](200) NULL,
	[MDate] [datetime] NULL,
 CONSTRAINT [PK_pYearCalendar] PRIMARY KEY CLUSTERED 
(
	[YearCalendarID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[pYearCalendar] ADD  CONSTRAINT [DF_pYearCalendar_YearCalendarID]  DEFAULT (newsequentialid()) FOR [YearCalendarID]
GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='03288'))
BEGIN

	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '5.0.0000', '03288', GetDate())

END

GO