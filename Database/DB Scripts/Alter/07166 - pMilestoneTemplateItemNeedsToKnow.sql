IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pMilestoneTemplateItemNeedsToKnow]') AND type in (N'U'))
DROP TABLE [dbo].[pMilestoneTemplateItemNeedsToKnow]
GO

CREATE TABLE [dbo].[pMilestoneTemplateItemNeedsToKnow](
	[MilestoneTemplateItemID] [uniqueidentifier] NOT NULL,
	[NeedsToKnowID] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_pMilestoneTemplateItemNeedsToKnow] PRIMARY KEY CLUSTERED 
(
	[MilestoneTemplateItemID] ASC,
	[NeedsToKnowID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07166', GetDate())
GO
