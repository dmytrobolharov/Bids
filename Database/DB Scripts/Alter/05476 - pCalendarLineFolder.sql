/****** Object:  Table [dbo].[pCalendarLineFolder]    Script Date: 04/03/2013 14:55:04 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pCalendarLineFolder]') AND type in (N'U'))
DROP TABLE [dbo].[pCalendarLineFolder]
GO

CREATE TABLE [dbo].[pCalendarLineFolder](
	[CalendarHeaderID] [uniqueidentifier] NOT NULL,
	[LineFolderID] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_pCalendarLineFolder] PRIMARY KEY CLUSTERED 
(
	[CalendarHeaderID] ASC,
	[LineFolderID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '05476', GetDate())
GO
