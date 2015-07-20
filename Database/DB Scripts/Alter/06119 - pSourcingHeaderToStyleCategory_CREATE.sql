IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pSourcingHeaderToStyleCategory]') AND type in (N'U'))
DROP TABLE [dbo].[pSourcingHeaderToStyleCategory]
GO

CREATE TABLE [dbo].[pSourcingHeaderToStyleCategory](
	[SourcingHeaderID] [uniqueidentifier] NOT NULL,
	[StyleCategoryID] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_pSourcingHeaderToStyleCategory] PRIMARY KEY CLUSTERED 
(
	[SourcingHeaderID] ASC,
	[StyleCategoryID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '06119', GetDate())
GO
