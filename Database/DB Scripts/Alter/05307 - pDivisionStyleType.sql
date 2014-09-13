IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pDivisionStyleType_DivisionStyleTypeID]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pDivisionStyleType] DROP CONSTRAINT [DF_pDivisionStyleType_DivisionStyleTypeID]
END
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pDivisionStyleType]') AND type in (N'U'))
DROP TABLE [dbo].[pDivisionStyleType]
GO


CREATE TABLE [dbo].[pDivisionStyleType](
	[DivisionStyleTypeID] [uniqueidentifier] NOT NULL,
	[DivisionID] [uniqueidentifier] NOT NULL,
	[StyleTypeID] [int] NOT NULL,
 CONSTRAINT [PK_pDivisionStyleType] PRIMARY KEY CLUSTERED 
(
	[DivisionStyleTypeID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[pDivisionStyleType] ADD  CONSTRAINT [DF_pDivisionStyleType_DivisionStyleTypeID]  DEFAULT (newid()) FOR [DivisionStyleTypeID]
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '05307', GetDate())
GO
