IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pImageWorkflowPage_ImageWorkflowPageID]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pImageWorkflowPage] DROP CONSTRAINT [DF_pImageWorkflowPage_ImageWorkflowPageID]
END

GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pImageWorkflowPage]') AND type in (N'U'))
DROP TABLE [dbo].[pImageWorkflowPage]
GO

CREATE TABLE [dbo].[pImageWorkflowPage](
	[ImageWorkflowPageID] [uniqueidentifier] NOT NULL,
	[ImageID] [uniqueidentifier] NULL,
	[ImageWorkflowTemplateItemID] [uniqueidentifier] NULL,
	[ImageWorkflowTemplateEntryID] [uniqueidentifier] NULL,
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
 CONSTRAINT [PK_pImageWorkflowPage] PRIMARY KEY CLUSTERED 
(
	[ImageWorkflowPageID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[pImageWorkflowPage] ADD  CONSTRAINT [DF_pImageWorkflowPage_ImageWorkflowPageID]  DEFAULT (newid()) FOR [ImageWorkflowPageID]
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '08433', GetDate())
GO
