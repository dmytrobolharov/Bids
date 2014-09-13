
/****** Object:  Table [dbo].[pMaterialRequestToChangeTable]    Script Date: 10/08/2012 13:59:55 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pMaterialRequestToChangeTable]') AND type in (N'U'))
DROP TABLE [dbo].[pMaterialRequestToChangeTable]
GO



/****** Object:  Table [dbo].[pMaterialRequestToChangeTable]    Script Date: 10/08/2012 13:59:55 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[pMaterialRequestToChangeTable](
	[MaterialRequestWorkflowID] [varchar](5) NOT NULL,
	[ChangeTableID] [uniqueidentifier] NOT NULL
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04125', GetDate())
GO
