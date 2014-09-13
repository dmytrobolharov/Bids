IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pCalendarMilestoneItem_CalendarMilestoneItem]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pCalendarMilestoneItem] DROP CONSTRAINT [DF_pCalendarMilestoneItem_CalendarMilestoneItem]
END
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pCalendarMilestoneItem]') AND type in (N'U'))
DROP TABLE [dbo].[pCalendarMilestoneItem]
GO


CREATE TABLE [dbo].[pCalendarMilestoneItem](
	[CalendarMilestoneItemID] [uniqueidentifier] NOT NULL,
	[CalendarHeaderID] [uniqueidentifier] NULL,
	[MilestoneTemplateItemID] [uniqueidentifier] NULL,
	[CalendarMilestoneItemName] [nvarchar](200) NULL,
	[CalendarMilestoneItemDescription] [nvarchar](400) NULL,
	[DependentWorkflowTypeID] [uniqueidentifier] NULL,
	[DependentWorkflowStatusID] [int] NULL,
	[Days] [int] NULL,
	[MilestoneDate] [datetime] NULL,
	[SortOrder] [varchar](5) NULL,
	[CUser] [nvarchar](200) NULL,
	[CDate] [datetime] NULL,
	[MUser] [nvarchar](200) NULL,
	[MDate] [datetime] NULL,
 CONSTRAINT [PK_pCalendarMilestoneItem] PRIMARY KEY CLUSTERED 
(
	[CalendarMilestoneItemID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[pCalendarMilestoneItem] ADD  CONSTRAINT [DF_pCalendarMilestoneItem_CalendarMilestoneItem]  DEFAULT (newid()) FOR [CalendarMilestoneItemID]
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '05456', GetDate())
GO
