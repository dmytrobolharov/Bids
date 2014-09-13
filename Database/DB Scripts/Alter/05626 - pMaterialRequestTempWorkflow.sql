IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pMaterialRequestWorkflowTemp_MaterialRequestWorkflowTempID]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pMaterialRequestTempWorkflow] DROP CONSTRAINT [DF_pMaterialRequestWorkflowTemp_MaterialRequestWorkflowTempID]
END
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pMaterialRequestTempWorkflow]') AND type in (N'U'))
DROP TABLE [dbo].[pMaterialRequestTempWorkflow]
GO


CREATE TABLE [dbo].[pMaterialRequestTempWorkflow](
	[MaterialRequestTempWorkflowID] [uniqueidentifier] NOT NULL,
	[MaterialRequestGroupID] [uniqueidentifier] NULL,
	[MaterialRequestWorkflowTempID] [uniqueidentifier] NULL,
	[MaterialRequestWorkflowTemplateItemID] [uniqueidentifier] NULL,
	[MaterialRequestWorkflowID] [nvarchar](5) NULL,
	[AssignedTo] [int] NULL,
	[Days] [int] NULL,
	[RDays] [int] NULL,
	[DueDate] [datetime] NULL,
	[Alerts] [int] NULL,
	[Status] [int] NULL,
	[PartnerTypeID] [uniqueidentifier] NULL,
 CONSTRAINT [PK_pMaterialRequestTempWorkflow] PRIMARY KEY CLUSTERED 
(
	[MaterialRequestTempWorkflowID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[pMaterialRequestTempWorkflow] ADD  CONSTRAINT [DF_pMaterialRequestWorkflowTemp_MaterialRequestWorkflowTempID]  DEFAULT (newid()) FOR [MaterialRequestTempWorkflowID]
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '05626', GetDate())
GO
