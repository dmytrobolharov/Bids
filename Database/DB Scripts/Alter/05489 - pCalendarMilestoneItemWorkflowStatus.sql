/****** Object:  Table [dbo].[pCalendarMilestoneItemWorkflowStatus]    Script Date: 04/04/2013 13:36:55 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pCalendarMilestoneItemWorkflowStatus]') AND type in (N'U'))
DROP TABLE [dbo].[pCalendarMilestoneItemWorkflowStatus]
GO

CREATE TABLE [dbo].[pCalendarMilestoneItemWorkflowStatus](
	[CalendarMilestoneItemID] [uniqueidentifier] NOT NULL,
	[WorkflowStatusID] [int] NOT NULL,
 CONSTRAINT [PK_pCalendarMilestoneItemWorkflowStatus] PRIMARY KEY CLUSTERED 
(
	[CalendarMilestoneItemID] ASC,
	[WorkflowStatusID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '05489', GetDate())
GO
