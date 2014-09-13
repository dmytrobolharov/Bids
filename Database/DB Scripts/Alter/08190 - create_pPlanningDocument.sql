IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pPlanningDocument_PlanningDocumentID]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pPlanningDocument] DROP CONSTRAINT [DF_pPlanningDocument_PlanningDocumentID]
END

GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pPlanningDocument]') AND type in (N'U'))
DROP TABLE [dbo].[pPlanningDocument]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[pPlanningDocument](
	[PlanningDocumentID] [uniqueidentifier] NOT NULL,
	[PlanningID] [uniqueidentifier] NULL,
	[PlanningDocumentName] [nvarchar](500) NULL,
	[PlanningDocumentDescription] [nvarchar](4000) NULL,
	[PlanningDocumentExt] [nvarchar](5) NULL,
	[PlanningDocumentSize] [nvarchar](20) NULL,
	[CUser] [nvarchar](200) NULL,
	[CDate] [datetime] NULL,
	[MUser] [nvarchar](200) NULL,
	[MDate] [datetime] NULL,
	[MChange] [int] NULL,
	[SystemServerStorageID] [uniqueidentifier] NULL,
	[TeamID] [uniqueidentifier] NULL,
 CONSTRAINT [PK_pPlanningDocument] PRIMARY KEY CLUSTERED 
(
	[PlanningDocumentID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[pPlanningDocument] ADD  CONSTRAINT [DF_pPlanningDocument_PlanningDocumentID]  DEFAULT (newid()) FOR [PlanningDocumentID]
GO

GO
INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '08190', GetDate())

GO

