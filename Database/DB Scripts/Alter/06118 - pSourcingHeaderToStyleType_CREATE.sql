IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pSourcingHeaderToStyleType]') AND type in (N'U'))
DROP TABLE [dbo].[pSourcingHeaderToStyleType]
GO

CREATE TABLE [dbo].[pSourcingHeaderToStyleType](
	[SourcingHeaderID] [uniqueidentifier] NOT NULL,
	[StyleTypeID] [int] NOT NULL,
 CONSTRAINT [PK_pSourcingHeaderToStyleType] PRIMARY KEY CLUSTERED 
(
	[SourcingHeaderID] ASC,
	[StyleTypeID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '06118', GetDate())
GO
