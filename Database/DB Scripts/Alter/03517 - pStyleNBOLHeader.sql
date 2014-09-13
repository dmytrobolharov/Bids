IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pStyleNBOLHeader_StyleNBOLHeaderID]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pStyleNBOLHeader] DROP CONSTRAINT [DF_pStyleNBOLHeader_StyleNBOLHeaderID]
END
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pStyleNBOLHeader]') AND type in (N'U'))
DROP TABLE [dbo].[pStyleNBOLHeader]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[pStyleNBOLHeader](
	[StyleNBOLHeaderID] [uniqueidentifier] NOT NULL,
	[WorkflowID] [uniqueidentifier] NULL,
	[WorkFlowItemID] [uniqueidentifier] NULL,
	[StyleID] [uniqueidentifier] NULL,
	[StyleSet] [int] NULL,
	[TemplateID] [uniqueidentifier] NULL,
	[TemplateName] [nvarchar](200) NULL,
	[ImageID] [uniqueidentifier] NULL,
	[CUser] [nvarchar](200) NULL,
	[CDate] [datetime] NULL,
	[MUser] [nvarchar](200) NULL,
	[MDate] [datetime] NULL,
	[CustomField1] [nvarchar](200) NULL,
	[CustomField2] [nvarchar](200) NULL,
	[CustomField3] [nvarchar](200) NULL,
	[CustomField4] [nvarchar](200) NULL,
	[CustomField5] [decimal](18, 3) NULL,
 CONSTRAINT [PK_pStyleNBOLHeader] PRIMARY KEY CLUSTERED 
(
	[StyleNBOLHeaderID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[pStyleNBOLHeader] ADD  CONSTRAINT [DF_pStyleNBOLHeader_StyleNBOLHeaderID]  DEFAULT (newid()) FOR [StyleNBOLHeaderID]
GO



INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '03517', GetDate())
GO