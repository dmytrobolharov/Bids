IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pColorFolderWorkflowPage_ColorFolderWorkflowPageID]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pColorFolderWorkflowPage] DROP CONSTRAINT [DF_pColorFolderWorkflowPage_ColorFolderWorkflowPageID]
END

GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pColorFolderWorkflowPage]') AND type in (N'U'))
DROP TABLE [dbo].[pColorFolderWorkflowPage]
GO

CREATE TABLE [dbo].[pColorFolderWorkflowPage](
	[ColorFolderWorkflowPageID] [uniqueidentifier] NOT NULL,
	[ColorFolderID] [uniqueidentifier] NULL,
	[ColorFolderWorkflowID] [uniqueidentifier] NULL,
	[WorkStart] [datetime] NULL,
	[WorkDue] [datetime] NULL,
	[WorkAssignedTo] [int] NULL,
	[WorkStatus] [int] NULL,
	[WorkStatusDate] [datetime] NULL,
	[ActualStart] [datetime] NULL,
	[ActualEnd] [datetime] NULL,
	[Sort] [nvarchar](4) NULL,
	[CUser] [nvarchar](200) NULL,
	[CDate] [datetime] NULL,
	[MUser] [nvarchar](200) NULL,
	[MDate] [datetime] NULL,
 CONSTRAINT [PK_pColorFolderWorkflowPage] PRIMARY KEY CLUSTERED 
(
	[ColorFolderWorkflowPageID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[pColorFolderWorkflowPage] ADD  CONSTRAINT [DF_pColorFolderWorkflowPage_ColorFolderWorkflowPageID]  DEFAULT (newid()) FOR [ColorFolderWorkflowPageID]
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '08489', GetDate())
GO
