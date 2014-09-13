IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pFlashEditQuickFillItemTemp_QuickFillTempItemID]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pFlashEditQuickFillItemTemp] DROP CONSTRAINT [DF_pFlashEditQuickFillItemTemp_QuickFillTempItemID]
END

GO

/****** Object:  Table [dbo].[pFlashEditQuickFillItemTemp]    Script Date: 03/27/2013 13:11:55 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pFlashEditQuickFillItemTemp]') AND type in (N'U'))
DROP TABLE [dbo].[pFlashEditQuickFillItemTemp]
GO

CREATE TABLE [dbo].[pFlashEditQuickFillItemTemp](
	[QuickFillTempItemID] [uniqueidentifier] NOT NULL,
	[QuickFillID] [uniqueidentifier] NULL,
	[QuickFillFieldName] [nvarchar](200) NULL,
	[QuickFillFieldValue] [nvarchar](500) NULL,
	[TeamID] [uniqueidentifier] NULL,
 CONSTRAINT [PK_pFlashEditQuickFillItemTemp] PRIMARY KEY CLUSTERED 
(
	[QuickFillTempItemID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[pFlashEditQuickFillItemTemp] ADD  CONSTRAINT [DF_pFlashEditQuickFillItemTemp_QuickFillTempItemID]  DEFAULT (newid()) FOR [QuickFillTempItemID]
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '05415', GetDate())
GO
