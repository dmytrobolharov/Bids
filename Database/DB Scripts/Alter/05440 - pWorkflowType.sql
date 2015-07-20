IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pWorkflowType_WorkflowTypeID]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pWorkflowType] DROP CONSTRAINT [DF_pWorkflowType_WorkflowTypeID]
END

GO

/****** Object:  Table [dbo].[pWorkflowType]    Script Date: 03/29/2013 13:29:19 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pWorkflowType]') AND type in (N'U'))
DROP TABLE [dbo].[pWorkflowType]
GO

/****** Object:  Table [dbo].[pWorkflowType]    Script Date: 03/29/2013 13:29:20 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[pWorkflowType](
	[WorkflowTypeID] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[WorkflowTypeName] [nvarchar](200) NULL,
 CONSTRAINT [PK_pWorkflowType] PRIMARY KEY CLUSTERED 
(
	[WorkflowTypeID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[pWorkflowType] ADD  CONSTRAINT [DF_pWorkflowType_WorkflowTypeID]  DEFAULT (newid()) FOR [WorkflowTypeID]
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '05440', GetDate())
GO
