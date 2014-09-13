
/****** Object:  Table [dbo].[pConLevel3]    Script Date: 07/16/2010 17:40:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[pConLevel3](
	[Level3ID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_pConLevel3_Level3ID]  DEFAULT (newid()),
	[Level3Desc] [nvarchar](100) NULL,
	[Detail] [text] NULL,
	[ImageID] [uniqueidentifier] NULL CONSTRAINT [DF_pConLevel3_ImageID]  DEFAULT ('{00000000-0000-0000-0000-000000000000}'),
	[ImageVersion] [int] NULL CONSTRAINT [DF_pConLevel3_ImageVersion]  DEFAULT ((0)),
	[AuxField1] [nvarchar](100) NULL,
	[AuxField2] [nvarchar](100) NULL,
	[AuxField3] [nvarchar](100) NULL,
	[AuxField4] [nvarchar](100) NULL,
	[AuxField5] [nvarchar](100) NULL,
	[IsActive] [int] NOT NULL CONSTRAINT [DF_pConLevel3_IsActive]  DEFAULT ((-1)),
	[LastUpdated] [datetime] NULL,
 CONSTRAINT [PK_pConLevel3] PRIMARY KEY CLUSTERED 
(
	[Level3ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
