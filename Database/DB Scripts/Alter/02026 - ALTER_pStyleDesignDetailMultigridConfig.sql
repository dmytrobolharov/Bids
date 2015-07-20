
/****** Object:  Table [dbo].[pStyleDesignDetailMultigridConfig]    Script Date: 10/17/2011 15:09:48 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pStyleDesignDetailMultigridConfig]') AND type in (N'U'))
DROP TABLE [dbo].[pStyleDesignDetailMultigridConfig]
GO

CREATE TABLE [dbo].[pStyleDesignDetailMultigridConfig](
	[MultigridConfigID] [uniqueidentifier] NOT NULL,
	[WorkflowId] [uniqueidentifier] NULL,
	[HeaderXML] [nvarchar](200) NULL,
	[HeaderTableName] [nvarchar](200) NULL,
	[XML] [nvarchar](200) NULL,
	[TableName] [nvarchar](200) NULL,
	[Line] [int] NULL,
	[Order] [int] NULL,
	[Size] [int] NULL,
	[MaxRows] [int] NULL,
 CONSTRAINT [PK_pStyleDesignDetailMultigridConfig] PRIMARY KEY CLUSTERED 
(
	[MultigridConfigID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[pStyleDesignDetailMultigridConfig] ADD  CONSTRAINT [DF_pStyleDesignDetailMultigridConfig_MultigridConfigID]  DEFAULT (newid()) FOR [MultigridConfigID]
GO

ALTER TABLE [dbo].[pStyleDesignDetailMultigridConfig] ADD  CONSTRAINT [DF_pStyleDesignDetailMultigridConfig_MaxRows]  DEFAULT ((10)) FOR [MaxRows]
GO


IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='02026'))
BEGIN
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '02026', GetDate())
END	
GO