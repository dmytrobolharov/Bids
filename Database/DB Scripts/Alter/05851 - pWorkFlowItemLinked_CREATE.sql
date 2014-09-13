IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pWorkFlowItemLinked]') AND type in (N'U'))
DROP TABLE [dbo].[pWorkFlowItemLinked]
GO

CREATE TABLE [dbo].[pWorkFlowItemLinked](
	[WorkFlowItemLinkedID] [uniqueidentifier] NOT NULL,
	[WorkFlowItemID] [uniqueidentifier]NULL,
	[StyleID] [uniqueidentifier] NULL,
	[StyleSet] [int] NULL
 CONSTRAINT [PK_pWorkFlowItemLinked] PRIMARY KEY CLUSTERED 
(
	[WorkFlowItemLinkedID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[pWorkFlowItemLinked] ADD  CONSTRAINT [DF_pWorkFlowItemLinked_WorkFlowItemLinkedID]  DEFAULT (NEWID()) FOR [WorkFlowItemLinkedID]
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0.0000', '05851', GetDate())
GO
