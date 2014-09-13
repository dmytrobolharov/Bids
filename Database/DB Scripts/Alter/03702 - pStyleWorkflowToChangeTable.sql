/****** Object:  Table [dbo].[pStyleWorkflowToChangeTable]    Script Date: 07/12/2012 14:04:03 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pStyleWorkflowToChangeTable]') AND type in (N'U'))
DROP TABLE [dbo].[pStyleWorkflowToChangeTable]
GO

/****** Object:  Table [dbo].[pStyleWorkflowToChangeTable]    Script Date: 07/12/2012 14:04:04 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[pStyleWorkflowToChangeTable](
	[WorkflowID] [uniqueidentifier] NOT NULL,
	[ChangeTableID] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_pWorkflowToChangeTable] PRIMARY KEY CLUSTERED 
(
	[WorkflowID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '03702', GetDate())
GO