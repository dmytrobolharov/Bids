IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pDivisionStyleTypeFilter_FilterID]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pDivisionStyleTypeFilter] DROP CONSTRAINT [DF_pDivisionStyleTypeFilter_FilterID]
END
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pDivisionStyleTypeFilter]') AND type in (N'U'))
DROP TABLE [dbo].[pDivisionStyleTypeFilter]
GO


CREATE TABLE [dbo].[pDivisionStyleTypeFilter](
	[FilterID] [uniqueidentifier] NOT NULL,
	[WorkflowTemplateID] [uniqueidentifier] NOT NULL,
	[DivisionStyleTypeID] [uniqueidentifier] NOT NULL,
	[Filter] [int] NULL,
 CONSTRAINT [PK_pDivisionStyleTypeFilter] PRIMARY KEY CLUSTERED 
(
	[FilterID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[pDivisionStyleTypeFilter] ADD  CONSTRAINT [DF_pDivisionStyleTypeFilter_FilterID]  DEFAULT (newid()) FOR [FilterID]
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '08327', GetDate())
GO
