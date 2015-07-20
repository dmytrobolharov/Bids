CREATE TABLE [dbo].[pStyleBOLExceptionEntries](
	[BOLExceptionEntryId] [uniqueidentifier] NOT NULL,
	[BOLExceptionId] [uniqueidentifier] NULL,
	[PageOperationId] [uniqueidentifier] NULL,
	[isSet] [int] NULL,
 CONSTRAINT [PK_pStyleBOLExceptionEntries] PRIMARY KEY CLUSTERED 
(
	[BOLExceptionEntryId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
ALTER TABLE [dbo].[pStyleBOLExceptionEntries] ADD  CONSTRAINT [DF_pStyleBOLExceptionEntries_BOLExceptionEntryId]  DEFAULT (newid()) FOR [BOLExceptionEntryId]
GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='01815'))
BEGIN
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '01815', GetDate())
END

GO
