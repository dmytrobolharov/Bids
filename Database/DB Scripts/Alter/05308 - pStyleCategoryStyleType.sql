IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pStyleCategoryStyleType_StyleCategoryStyleTypeID]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pStyleCategoryStyleType] DROP CONSTRAINT [DF_pStyleCategoryStyleType_StyleCategoryStyleTypeID]
END
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pStyleCategoryStyleType]') AND type in (N'U'))
DROP TABLE [dbo].[pStyleCategoryStyleType]
GO


CREATE TABLE [dbo].[pStyleCategoryStyleType](
	[StyleCategoryStyleTypeID] [uniqueidentifier] NOT NULL,
	[StyleCategoryID] [uniqueidentifier] NOT NULL,
	[StyleTypeID] [int] NOT NULL,
 CONSTRAINT [PK_pStyleCategoryStyleType] PRIMARY KEY CLUSTERED 
(
	[StyleCategoryStyleTypeID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[pStyleCategoryStyleType] ADD  CONSTRAINT [DF_pStyleCategoryStyleType_StyleCategoryStyleTypeID]  DEFAULT (newid()) FOR [StyleCategoryStyleTypeID]
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '05308', GetDate())
GO
