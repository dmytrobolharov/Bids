IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pStyleCategorySubCategory_StyleCategorySubCategoryID]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pStyleCategorySubCategory] DROP CONSTRAINT [DF_pStyleCategorySubCategory_StyleCategorySubCategoryID]
END
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pStyleCategorySubCategory]') AND type in (N'U'))
DROP TABLE [dbo].[pStyleCategorySubCategory]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[pStyleCategorySubCategory](
	[StyleCategorySubCategoryID] [uniqueidentifier] NOT NULL,
	[StyleCategoryId] [uniqueidentifier] NULL,
	[SubCategoryId] [uniqueidentifier] NULL,
 CONSTRAINT [PK_pStyleCategorySubCategory] PRIMARY KEY CLUSTERED 
(
	[StyleCategorySubCategoryID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[pStyleCategorySubCategory] ADD  CONSTRAINT [DF_pStyleCategorySubCategory_StyleCategorySubCategoryID]  DEFAULT (newid()) FOR [StyleCategorySubCategoryID]
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07341', GetDate())
GO
