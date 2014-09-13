
/****** Object:  Table [dbo].[pStyleDesignDetailMultigridConfig]    Script Date: 10/07/2011 11:10:46 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pStyleDesignDetailMultigridConfig]') AND type in (N'U'))
DROP TABLE [dbo].[pStyleDesignDetailMultigridConfig]
GO

CREATE TABLE [dbo].[pStyleDesignDetailMultigridConfig](
	[ConfigID] [uniqueidentifier] NOT NULL,
	[WorkflowId] [uniqueidentifier] NULL,
	[HeaderXML] [nvarchar](200) NULL,
	[HeaderTableName] [nvarchar](200) NULL,
	[XML1] [nvarchar](200) NULL,
	[TableName1] [nvarchar](200) NULL,
	[Line1] [int] NULL,
	[Order1] [int] NULL,
	[Size1] [int] NULL,
	[MaxRows1] [int] NULL,
	[XML2] [nvarchar](200) NULL,
	[TableName2] [nvarchar](200) NULL,
	[Line2] [int] NULL,
	[Order2] [int] NULL,
	[Size2] [int] NULL,
	[MaxRows2] [int] NULL,
	[XML3] [nvarchar](200) NULL,
	[TableName3] [nvarchar](200) NULL,
	[Line3] [int] NULL,
	[Order3] [int] NULL,
	[Size3] [int] NULL,
	[MaxRows3] [int] NULL,
	[XML4] [nvarchar](200) NULL,
	[TableName4] [nvarchar](200) NULL,
	[Line4] [int] NULL,
	[Order4] [int] NULL,
	[Size4] [int] NULL,
	[MaxRows4] [int] NULL,
 CONSTRAINT [PK_pDesignDetailMultigridConfig] PRIMARY KEY CLUSTERED 
(
	[ConfigID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[pStyleDesignDetailMultigridConfig] ADD  CONSTRAINT [DF_pDesignDetailMultigridConfig_ConfigID]  DEFAULT (newid()) FOR [ConfigID]
GO


IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='01995'))
BEGIN
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '01995', GetDate())
END	
GO