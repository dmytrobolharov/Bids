IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pStyleNBOLExceptionEntries_ExceptionEntryID]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pStyleNBOLExceptionEntries] DROP CONSTRAINT [DF_pStyleNBOLExceptionEntries_ExceptionEntryID]
END

GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pStyleNBOLExceptionEntries]') AND type in (N'U'))
DROP TABLE [dbo].[pStyleNBOLExceptionEntries]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[pStyleNBOLExceptionEntries](
	[ExceptionEntryID] [uniqueidentifier] NOT NULL,
	[ExceptionID] [uniqueidentifier] NULL,
	[StyleNBOLItemID] [uniqueidentifier] NULL,
 CONSTRAINT [PK_pStyleNBOLExceptionEntries] PRIMARY KEY CLUSTERED 
(
	[ExceptionEntryID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[pStyleNBOLExceptionEntries] ADD  CONSTRAINT [DF_pStyleNBOLExceptionEntries_ExceptionEntryID]  DEFAULT (newid()) FOR [ExceptionEntryID]
GO



INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '03520', GetDate())
GO