/****** Object:  Table [dbo].[pStyleBOMDimension]    Script Date: 09/06/2011 09:45:02 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[pStyleBOMDimension](
	[StyleBOMDimensionID] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[WorkFlowID] [uniqueidentifier] NOT NULL,
	[WorkFlowItemID] [uniqueidentifier] NOT NULL,
	[StyleID] [uniqueidentifier] NOT NULL,
	[StyleSet] [int] NOT NULL,
	[ItemDim1TypeId] [uniqueidentifier] NULL,
	[ItemDim2TypeId] [uniqueidentifier] NULL,
	[ItemDim3TypeId] [uniqueidentifier] NULL,
	[ItemDim1TypeName] [nvarchar](50) NULL,
	[ItemDim2TypeName] [nvarchar](50) NULL,
	[ItemDim3TypeName] [nvarchar](50) NULL,
	[Comments] [nvarchar](510) NULL,
	[ImageId] [uniqueidentifier] NULL,
	[CDate] [datetime] NULL,
	[CUser] [nvarchar](200) NULL,
	[MDate] [datetime] NULL,
	[MUser] [nvarchar](200) NULL,
 CONSTRAINT [PK_pStyleBOMDimension] PRIMARY KEY CLUSTERED 
(
	[StyleBOMDimensionID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[pStyleBOMDimension] ADD  CONSTRAINT [DF_pStyleBOMDimension_StyleBOMDimensionID]  DEFAULT (newid()) FOR [StyleBOMDimensionID]
GO


IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='01852'))
	BEGIN
		INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
		VALUES     ('DB_Version', '4.1.0000', '01852', GetDate())
	END

	GO