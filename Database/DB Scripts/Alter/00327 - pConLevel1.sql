
/****** Object:  Table [dbo].[pConLevel1]    Script Date: 07/16/2010 17:40:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[pConLevel1](
	[Level1ID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_pConLevel1_Level1ID]  DEFAULT (newid()),
	[Level1Desc] [nvarchar](100) NULL,
	[IsActive] [int] NOT NULL CONSTRAINT [DF_pConLevel1_IsActive]  DEFAULT ((-1)),
 CONSTRAINT [PK_pConLevel1] PRIMARY KEY CLUSTERED 
(
	[Level1ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
