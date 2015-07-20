IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pControlStyleConfig_RestrictSize]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pControlStyleConfig] DROP CONSTRAINT [DF_pControlStyleConfig_RestrictSize]
END

GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pControlStyleConfig]') AND type in (N'U'))
DROP TABLE [dbo].[pControlStyleConfig]
GO

CREATE TABLE [dbo].[pControlStyleConfig](
	[DivisionID] [uniqueidentifier] NOT NULL,
	[StyleTypeID] [int] NOT NULL,
	[StyleCategoryID] [uniqueidentifier] NOT NULL,
	[RestrictSize] [bit] NOT NULL,
 CONSTRAINT [PK_pControlStyleConfig] PRIMARY KEY CLUSTERED 
(
	[DivisionID] ASC,
	[StyleTypeID] ASC,
	[StyleCategoryID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[pControlStyleConfig] ADD  CONSTRAINT [DF_pControlStyleConfig_RestrictSize]  DEFAULT ((0)) FOR [RestrictSize]
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '08013', GetDate())
GO