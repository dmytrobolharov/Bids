IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSavedSearchItem_SavedSearchItemID]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSavedSearchItem] DROP CONSTRAINT [DF_pSavedSearchItem_SavedSearchItemID]
END
GO


IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pSavedSearchItem]') AND type in (N'U'))
DROP TABLE [dbo].[pSavedSearchItem]
GO


SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[pSavedSearchItem](
	[SavedSearchItemID] [uniqueidentifier] NOT NULL,
	[SavedSearchID] [uniqueidentifier] NULL,
	[FieldName] [nvarchar](500) NULL,
	[FieldValue] [nvarchar](500) NULL,
	[TeamID] [uniqueidentifier] NULL,
 CONSTRAINT [PK_pSavedSearchItem] PRIMARY KEY CLUSTERED 
(
	[SavedSearchItemID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[pSavedSearchItem] ADD  CONSTRAINT [DF_pSavedSearchItem_SavedSearchItemID]  DEFAULT (newid()) FOR [SavedSearchItemID]
GO



INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '03934', GetDate())
GO
