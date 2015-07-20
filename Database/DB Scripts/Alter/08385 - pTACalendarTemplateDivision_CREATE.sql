IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_Table_1_TACalTemplateDivision]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pTACalTemplateDivision] DROP CONSTRAINT [DF_Table_1_TACalTemplateDivision]
END

GO

/****** Object:  Table [dbo].[pTACalTemplateDivision]    Script Date: 07/22/2014 11:40:05 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pTACalTemplateDivision]') AND type in (N'U'))
DROP TABLE [dbo].[pTACalTemplateDivision]
GO

/****** Object:  Table [dbo].[pTACalTemplateDivision]    Script Date: 07/22/2014 11:40:05 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[pTACalTemplateDivision](
	[TACalTemplateDivisionID] [uniqueidentifier] NOT NULL,
	[DivisionID] [uniqueidentifier] NOT NULL,
	[TACalTemplateID] [uniqueidentifier] NOT NULL
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[pTACalTemplateDivision] ADD  CONSTRAINT [DF_Table_1_TACalTemplateDivision]  DEFAULT (newid()) FOR [TACalTemplateDivisionID]
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '08385', GetDate())
GO