CREATE TABLE [dbo].[pStyleBOLException](
	[BOLExceptionId] [uniqueidentifier] NOT NULL,
	[StyleId] [uniqueidentifier] NULL,
	[StyleSet] [int] NULL,
	[BOLExceptionName] [nvarchar](200) NULL,
	[CUser] [nvarchar](200) NULL,
	[CDate] [datetime] NULL,
	[MUser] [nvarchar](200) NULL,
	[MDate] [datetime] NULL,
 CONSTRAINT [PK_pStyleBOLException] PRIMARY KEY CLUSTERED 
(
	[BOLExceptionId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

ALTER TABLE [dbo].[pStyleBOLException] ADD  CONSTRAINT [DF_pStyleBOLException_BOLExceptionId]  DEFAULT (newid()) FOR [BOLExceptionId]

GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='01814'))
BEGIN
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '01814', GetDate())
END

GO
