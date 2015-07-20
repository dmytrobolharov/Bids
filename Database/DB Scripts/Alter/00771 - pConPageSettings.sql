SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[pConPageSettings](
	[ConPageSettingsID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_pConPageSettings_ConPageSettingsID]  DEFAULT (newid()),
	[WorkflowItemTypeID] [uniqueidentifier] NULL,
	[LinkDetail] [int] NULL,
	[LinkUserDefined1] [int] NULL,
	[LinkUserDefined2] [int] NULL,
	[LinkUserDefined3] [int] NULL,
	[LinkUserDefined4] [int] NULL,
	[LinkUserDefined5] [int] NULL,
 CONSTRAINT [PK_pConPageSettings] PRIMARY KEY CLUSTERED 
(
	[ConPageSettingsID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

CREATE NONCLUSTERED INDEX [IX_pConPageSettingsWFITID] ON [dbo].[pConPageSettings] 
(
	[WorkflowItemTypeID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.0.0000', '771', GetDate())

GO