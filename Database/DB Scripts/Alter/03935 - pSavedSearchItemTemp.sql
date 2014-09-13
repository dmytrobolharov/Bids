IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSavedSearchItemTemp_SavedSearchItemID]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSavedSearchItemTemp] DROP CONSTRAINT [DF_pSavedSearchItemTemp_SavedSearchItemID]
END
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pSavedSearchItemTemp]') AND type in (N'U'))
DROP TABLE [dbo].[pSavedSearchItemTemp]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[pSavedSearchItemTemp](
	[SavedSearchItemID] [uniqueidentifier] NOT NULL,
	[SavedSearchID] [uniqueidentifier] NULL,
	[FieldName] [nvarchar](500) NULL,
	[FieldValue] [nvarchar](500) NULL,
	[TeamID] [uniqueidentifier] NULL,
 CONSTRAINT [PK_pSavedSearchItemTemp] PRIMARY KEY CLUSTERED 
(
	[SavedSearchItemID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[pSavedSearchItemTemp] ADD  CONSTRAINT [DF_pSavedSearchItemTemp_SavedSearchItemID]  DEFAULT (newid()) FOR [SavedSearchItemID]
GO



INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '03935', GetDate())
GO
