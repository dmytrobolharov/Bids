/****** Object:  Table [dbo].[pMaterialRequestSubmitWorkflowShare]    Script Date: 01/22/2013 15:38:12 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pMaterialRequestSubmitWorkflowShare]') AND type in (N'U'))
DROP TABLE [dbo].[pMaterialRequestSubmitWorkflowShare]
GO

/****** Object:  Table [dbo].[pMaterialRequestSubmitWorkflowShare]    Script Date: 01/22/2013 15:38:13 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[pMaterialRequestSubmitWorkflowShare](
	[TradePartnerID] [uniqueidentifier] NOT NULL,
	[MaterialRequestSubmitWorkflowID] [uniqueidentifier] NOT NULL,
	[MDate] [datetime] NULL,
	[MUser] [nvarchar](200) NULL,
 CONSTRAINT [PK_pMaterialRequestSubmitWorkflowShare] PRIMARY KEY CLUSTERED 
(
	[TradePartnerID] ASC,
	[MaterialRequestSubmitWorkflowID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04832', GetDate())
GO
