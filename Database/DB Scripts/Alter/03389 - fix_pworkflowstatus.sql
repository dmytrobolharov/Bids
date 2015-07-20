IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pWorkflowStatusOld]') AND type in (N'U'))
DROP TABLE [dbo].[pWorkflowStatusOld]
GO


IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pWorkflowStatus_Active]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pWorkflowStatus] DROP CONSTRAINT [DF_pWorkflowStatus_Active]
END
GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pWorkflowStatus_WorkflowStatusRepId]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pWorkflowStatus] DROP CONSTRAINT [DF_pWorkflowStatus_WorkflowStatusRepId]
END
GO

EXEC sp_rename 'pWorkflowStatus', 'pWorkflowStatus3389';
GO



SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [pWorkflowStatus](
	[WorkflowStatusID] [int] NOT NULL,
	[WorkflowStatus] [nvarchar](100) NULL,
	[WorkflowStatusImage] [nvarchar](100) NULL,
	[Active] [bit] NULL,
	[WorkflowStatusRepId] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
 CONSTRAINT [PK__pWorkflowStatus__4924D839] PRIMARY KEY CLUSTERED 
(
	[WorkflowStatusID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[pWorkflowStatus] ADD  CONSTRAINT [DF_pWorkflowStatus_Active]  DEFAULT ((1)) FOR [Active]
GO

ALTER TABLE [dbo].[pWorkflowStatus] ADD  CONSTRAINT [DF_pWorkflowStatus_WorkflowStatusRepId]  DEFAULT (newid()) FOR [WorkflowStatusRepId]
GO


INSERT INTO pWorkflowStatus([WorkflowStatusID]
                           ,[WorkflowStatus]
                           ,[WorkflowStatusImage]
                           ,[Active]
                           ,[WorkflowStatusRepId])
SELECT [WorkflowStatusID]
      ,[WorkflowStatus]
      ,[WorkflowStatusImage]
      ,[Active]
      ,[WorkflowStatusRepId]
FROM pWorkflowStatus3389
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'pWorkflowStatus3389') AND type in (N'U'))
DROP TABLE pWorkflowStatus3389
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '03389', GetDate())
GO
