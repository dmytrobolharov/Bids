IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pTACalHoliday_TACalHolidayId]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pTACalHoliday] DROP CONSTRAINT [DF_pTACalHoliday_TACalHolidayId]
END

GO
/****** Object:  Table [dbo].[pTACalHoliday]    Script Date: 06/12/2014 16:02:00 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pTACalHoliday]') AND type in (N'U'))
DROP TABLE [dbo].[pTACalHoliday]
GO

/****** Object:  Table [dbo].[pTACalHoliday]    Script Date: 06/12/2014 16:02:00 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[pTACalHoliday](
	[TACalHolidayId] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[TACalHolidayDate] [date] NULL,
	[TACalHolidayName] [nvarchar](100) NULL,
 CONSTRAINT [PK_pTACalHoliday] PRIMARY KEY CLUSTERED 
(
	[TACalHolidayId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[pTACalHoliday] ADD  CONSTRAINT [DF_pTACalHoliday_TACalHolidayId]  DEFAULT (newsequentialid()) FOR [TACalHolidayId]
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07997', GetDate())
GO