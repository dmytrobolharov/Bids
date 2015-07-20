IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pStyleCopyTmp]') AND type in (N'U'))
DROP TABLE [dbo].[pStyleCopyTmp]
GO

CREATE TABLE [dbo].[pStyleCopyTmp](
	[StyleCopyTmpID] [uniqueidentifier] NOT NULL,
	[TransactionID] [uniqueidentifier] NULL,
	[StyleID] [uniqueidentifier] NULL,
	[Map] [uniqueidentifier] NULL,
	[WorkflowItemID] [uniqueidentifier] NULL,
	[TeamID] [uniqueidentifier] NULL,
	[CDate] [datetime] NULL,
 CONSTRAINT [PK_pStyleCopyTmp] PRIMARY KEY CLUSTERED 
(
	[StyleCopyTmpID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 75) ON [PRIMARY]
) ON [PRIMARY]

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '05111', GetDate())
GO
