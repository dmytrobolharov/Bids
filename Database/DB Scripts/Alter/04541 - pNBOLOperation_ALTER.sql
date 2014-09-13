IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pNBOLOperation_OperationID]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pNBOLOperation] DROP CONSTRAINT [DF_pNBOLOperation_OperationID]
END
GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[PK_pNBOLOperation]') AND type = 'K')
BEGIN
ALTER TABLE [dbo].[pNBOLOperation] DROP CONSTRAINT [PK_pNBOLOperation]
END
GO


/****** Object:  Table [dbo].[pNBOLOperation]    Script Date: 12/05/2012 11:04:48 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pNBOLOperation]') AND type in (N'U'))
EXECUTE sp_rename pNBOLOperation, pNBOLOperationOld
GO

/****** Object:  Table [dbo].[pNBOLOperation]    Script Date: 12/05/2012 11:04:48 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[pNBOLOperation](
	[OperationID] [uniqueidentifier] NOT NULL,
	[OperationCode] [nvarchar](200) NULL,
	[OperationName] [nvarchar](200) NULL,
	[OperationTypeID] [uniqueidentifier] NULL,
	[Category] [varchar](max) NULL,
	[MachineID] [uniqueidentifier] NULL,
	[ImageID] [uniqueidentifier] NULL,
	[CUser] [nvarchar](200) NULL,
	[CDate] [datetime] NULL,
	[MUser] [nvarchar](200) NULL,
	[MDate] [datetime] NULL,
	[Active] [int] NULL,
	[CustomField1] [nvarchar](200) NULL,
	[CustomField2] [nvarchar](200) NULL,
	[CustomField3] [nvarchar](200) NULL,
	[CustomField4] [nvarchar](200) NULL,
	[CustomField5] [nvarchar](200) NULL,
 CONSTRAINT [PK_pNBOLOperation] PRIMARY KEY CLUSTERED 
(
	[OperationID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO

ALTER TABLE [dbo].[pNBOLOperation] ADD  CONSTRAINT [DF_pNBOLOperation_OperationID]  DEFAULT (newid()) FOR [OperationID]
GO


IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pNBOLOperationOld]') AND type in (N'U'))
INSERT INTO pNBOLOperation (OperationID, OperationCode, OperationName, Category, MachineID, ImageID,
CUser, CDate, MUser, MDate, Active, CustomField1, CustomField2, CustomField3, CustomField4, CustomField5)
SELECT OperationID, OperationCode, OperationName, Category, MachineID, ImageID,
CUser, CDate, MUser, MDate, Active, CustomField1, CustomField2, CustomField3, CustomField4, CustomField5
FROM pNBOLOperationOld

DROP TABLE [dbo].[pNBOLOperationOld]
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '04541', GetDate())
GO