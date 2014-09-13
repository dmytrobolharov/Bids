SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[pWorkFlowItem](
	[WorkFlowItemID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_pWorkFlowItem_WorkFlowItemID]  DEFAULT (newid()),
	[WorkflowID] [uniqueidentifier] NULL,
	[StyleID] [uniqueidentifier] NULL,
        [WorkFlowItemName] [nvarchar](100) NULL,
	[Sort] [nvarchar](4) NULL CONSTRAINT [DF_pWorkFlowItem_WorkSort]  DEFAULT ((0)),
	[CUser] [nvarchar](100) NULL,
	[CDate] [datetime] NULL,
	[MUser] [nvarchar](100) NULL,
	[MDate] [datetime] NULL,
 CONSTRAINT [PK_pWorkFlowItem] PRIMARY KEY CLUSTERED 
(
	[WorkFlowItemID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

CREATE NONCLUSTERED INDEX [IX_pWorkFlowItemSID] ON [dbo].[pWorkFlowItem] 
(
	[StyleID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO

CREATE NONCLUSTERED INDEX [IX_pWorkFlowItemWFID] ON [dbo].[pWorkFlowItem] 
(
	[WorkflowID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.0.0000', '663', GetDate())
GO