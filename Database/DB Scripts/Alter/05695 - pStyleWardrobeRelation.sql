IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pStyleWardrobeRelation_StyleWardrobeRelationid]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pStyleWardrobeRelation] DROP CONSTRAINT [DF_pStyleWardrobeRelation_StyleWardrobeRelationid]
END

GO
/****** Object:  Table [dbo].[pStyleWardrobeRelation]    Script Date: 05/20/2013 14:58:01 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pStyleWardrobeRelation]') AND type in (N'U'))
DROP TABLE [dbo].[pStyleWardrobeRelation]
GO

/****** Object:  Table [dbo].[pStyleWardrobeRelation]    Script Date: 05/20/2013 14:58:01 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[pStyleWardrobeRelation](
	[StyleWardrobeRelationID] [uniqueidentifier] NOT NULL,
	[StyleID] [uniqueidentifier] NULL,
	[StyleRelationID] [uniqueidentifier] NULL,
	[SeasonYearID] [uniqueidentifier] NULL,
	[Sort] [nvarchar](4) NULL
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[pStyleWardrobeRelation] ADD  CONSTRAINT [DF_pStyleWardrobeRelation_StyleWardrobeRelationid]  DEFAULT (newid()) FOR [StyleWardrobeRelationID]
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '05695', GetDate())
GO


