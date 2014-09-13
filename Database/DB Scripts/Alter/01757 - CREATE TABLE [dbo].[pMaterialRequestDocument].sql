
/****** Object:  Table [dbo].[pMaterialRequestDocument]    Script Date: 08/16/2011 17:07:22 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[pMaterialRequestDocument](
	[MaterialRequestDocumentID] [uniqueidentifier] NOT NULL,
	[MaterialID] [uniqueidentifier] NULL,
	[MaterialTradePartnerID] [uniqueidentifier] NULL,
	[MaterialTradePartnerColorID] [uniqueidentifier] NULL,
	[MaterialRequestSubmitWorkflowID] [uniqueidentifier] NULL,
	[MaterialDocumentName] [varchar](500) NULL,
	[MaterialDocumentDescription] [nvarchar](4000) NULL,
	[MaterialDocumentExt] [varchar](5) NULL,
	[MaterialDocumentSize] [varchar](20) NULL,
	[MaterialDocumentShared] [int] NULL,
	[CUser] [nvarchar](200) NULL,
	[CDate] [datetime] NULL,
	[MUser] [nvarchar](200) NULL,
	[MDate] [datetime] NULL,
	[MChange] [int] NULL,
	[SystemServerStorageID] [uniqueidentifier] NULL,
 CONSTRAINT [PK_pMaterialRequestDocument] PRIMARY KEY CLUSTERED 
(
	[MaterialRequestDocumentID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

ALTER TABLE [dbo].[pMaterialRequestDocument] ADD  CONSTRAINT [DF_pMaterialRequestDocument_SystemServerStorageID]  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [SystemServerStorageID]
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.1.0000', '01757', GETDATE())
GO


