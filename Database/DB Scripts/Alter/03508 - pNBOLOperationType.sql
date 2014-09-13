IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pNBOLOperationType_OperationTypeID]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pNBOLOperationType] DROP CONSTRAINT [DF_pNBOLOperationType_OperationTypeID]
END
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pNBOLOperationType]') AND type in (N'U'))
DROP TABLE [dbo].[pNBOLOperationType]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[pNBOLOperationType](
	[OperationTypeID] [uniqueidentifier] NOT NULL,
	[Code] [nvarchar](200) NULL,
	[Name] [nvarchar](200) NULL,
	[Comment] [nvarchar](200) NULL,
	[DefaultPrice] [decimal](18, 2) NULL,
	[CustomField1] [nvarchar](200) NULL,
	[CustomField2] [nvarchar](200) NULL,
	[CustomField3] [nvarchar](200) NULL,
	[CustomField4] [nvarchar](200) NULL,
	[CustomField5] [nvarchar](200) NULL,
	[CUser] [nvarchar](200) NULL,
	[CDate] [datetime] NULL,
	[MUser] [nvarchar](200) NULL,
	[MDate] [datetime] NULL,
	[Active] [int] NULL,
 CONSTRAINT [PK_pNBOLOperationType] PRIMARY KEY CLUSTERED 
(
	[OperationTypeID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[pNBOLOperationType] ADD  CONSTRAINT [DF_pNBOLOperationType_OperationTypeID]  DEFAULT (newid()) FOR [OperationTypeID]
GO





INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '03508', GetDate())
GO
