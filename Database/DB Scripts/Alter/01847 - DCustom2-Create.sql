
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_DCustom2_CustomID]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[DCustom2] DROP CONSTRAINT [DF_DCustom2_CustomID]
END

GO



/****** Object:  Table [dbo].[DCustom2]    Script Date: 08/11/2011 12:12:06 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DCustom2]') AND type in (N'U'))
DROP TABLE [dbo].[DCustom2]
GO


/****** Object:  Table [dbo].[DCustom2]    Script Date: 08/11/2011 12:12:06 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[DCustom2](
	[Custom] [nvarchar](200) NOT NULL,
	[CustomKey] [nvarchar](2) NULL,
	[Active] [bit] NULL,
	[CUser] [nvarchar](50) NULL,
	[CDate] [datetime] NULL,
	[MUser] [nvarchar](50) NULL,
	[MDate] [datetime] NULL,
	[CustomSort] [nvarchar](5) NULL,
	[CustomID] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
 CONSTRAINT [PK_DCustom2] PRIMARY KEY CLUSTERED 
(
	[CustomID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[DCustom2] ADD  CONSTRAINT [DF_DCustom2_CustomID]  DEFAULT (newid()) FOR [CustomID]
GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='01847'))
	BEGIN
		INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
		VALUES     ('DB_Version', '4.1.0000', '01847', GetDate())
	END

	GO