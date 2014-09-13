IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pMaterialWorkflowPage_MaterialWorkflowPageID]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pMaterialWorkflowPage] DROP CONSTRAINT [DF_pMaterialWorkflowPage_MaterialWorkflowPageID]
END

GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pMaterialWorkflowPage]') AND type in (N'U'))
DROP TABLE [dbo].[pMaterialWorkflowPage]
GO

CREATE TABLE [dbo].[pMaterialWorkflowPage](
	[MaterialWorkflowPageID] [uniqueidentifier] NOT NULL,
	[MaterialID] [uniqueidentifier] NULL,
	[MaterialTemplateItemID] [uniqueidentifier] NULL,
	[MaterialTemplatePageID] [uniqueidentifier] NULL,
	[WorkStart] [datetime] NULL,
	[WorkDue] [datetime] NULL,
	[WorkAssignedTo] [int] NULL,
	[WorkStatus] [int] NULL,
	[WorkStatusDate] [datetime] NULL,
	[Sort] [nvarchar](4) NULL,
	[CUser] [nvarchar](200) NULL,
	[CDate] [datetime] NULL,
	[MUser] [nvarchar](200) NULL,
	[MDate] [datetime] NULL,
 CONSTRAINT [PK_pMaterialWorkflowPage] PRIMARY KEY CLUSTERED 
(
	[MaterialWorkflowPageID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[pMaterialWorkflowPage] ADD  CONSTRAINT [DF_pMaterialWorkflowPage_MaterialWorkflowPageID]  DEFAULT (newid()) FOR [MaterialWorkflowPageID]
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '08411', GetDate())
GO
