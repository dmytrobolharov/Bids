IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pStyleCopyColorTmp]') AND type in (N'U'))
DROP TABLE [dbo].[pStyleCopyColorTmp]
GO

CREATE TABLE [dbo].[pStyleCopyColorTmp](
	[StyleCopyColorTmpID] [uniqueidentifier] NOT NULL,
	[TransactionID] [uniqueidentifier] NULL,
	[StyleColorID] [uniqueidentifier] NULL,
 CONSTRAINT [PK_pStyleCopyColorTmp] PRIMARY KEY CLUSTERED 
(
	[StyleCopyColorTmpID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 75) ON [PRIMARY]
) ON [PRIMARY]

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '05110', GetDate())
GO
