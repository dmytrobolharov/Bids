
/****** Object:  Table [dbo].[pConLevel2]    Script Date: 07/16/2010 17:40:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[pConLevel2](
	[Level2ID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_pConLevel2_Level2ID]  DEFAULT (newid()),
	[Level2Desc] [nvarchar](100) NULL,
	[IsActive] [int] NOT NULL CONSTRAINT [DF_pConLevel2_IsActive]  DEFAULT ((-1)),
 CONSTRAINT [PK_pConLevel2] PRIMARY KEY CLUSTERED 
(
	[Level2ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
