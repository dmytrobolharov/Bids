
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pStyleBOMMiscItem]') AND type in (N'U'))
DROP TABLE [dbo].[pStyleBOMMiscItem]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[pStyleBOMMiscItem](
	[StyleBOMMiscItemID] [uniqueidentifier] NOT NULL,
	[StyleBOMDimensionID] [uniqueidentifier] NOT NULL,
	[StyleBOMDimensionItemID] [uniqueidentifier] NOT NULL,
	[StyleMaterialMiscID] [uniqueidentifier] NULL,
	[StyleMaterialID] [uniqueidentifier] NOT NULL,
	[MaterialNo] [nvarchar](50) NULL,
	[MaterialName] [nvarchar](200) NULL,
	[Placement] [nvarchar](200) NULL,
	[SubMaterial] [int] NULL,
	[MiscColorId] [nvarchar](50) NULL,
	[Custom1] [nvarchar](200) NULL,
	[Custom2] [nvarchar](200) NULL,
	[Sort] [int] NULL,
	[CDate] [datetime] NULL,
	[CUser] [nvarchar](200) NULL,
	[MDate] [datetime] NULL,
	[MUser] [nvarchar](200) NULL,
 CONSTRAINT [PK_pStyleBOMMiscItem] PRIMARY KEY CLUSTERED 
(
	[StyleBOMMiscItemID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[pStyleBOMMiscItem] ADD  CONSTRAINT [DF_pStyleBOMMiscItem_StyleBOMMiscItemID]  DEFAULT (newid()) FOR [StyleBOMMiscItemID]
GO



INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '03629', GetDate())
GO