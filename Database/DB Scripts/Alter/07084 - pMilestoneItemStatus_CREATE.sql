IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pMilestoneItemStatus_MilestoneItemStatusRepID]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pMilestoneItemStatus] DROP CONSTRAINT [DF_pMilestoneItemStatus_MilestoneItemStatusRepID]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pMilestoneItemStatus_Active]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pMilestoneItemStatus] DROP CONSTRAINT [DF_pMilestoneItemStatus_Active]
END

GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pMilestoneItemStatus]') AND type in (N'U'))
DROP TABLE [dbo].[pMilestoneItemStatus]
GO

CREATE TABLE [dbo].[pMilestoneItemStatus](
	[MilestoneItemStatusID] [int] NOT NULL,
	[MilestoneItemStatus] [nvarchar](200) NULL,
	[MilestoneItemStatusRepID] [uniqueidentifier] NOT NULL,
	[Active] [int] NULL,
 CONSTRAINT [PK_pMilestoneItemStatus] PRIMARY KEY CLUSTERED 
(
	[MilestoneItemStatusID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[pMilestoneItemStatus] ADD  CONSTRAINT [DF_pMilestoneItemStatus_MilestoneItemStatusRepID]  DEFAULT (newid()) FOR [MilestoneItemStatusRepID]
GO

ALTER TABLE [dbo].[pMilestoneItemStatus] ADD  CONSTRAINT [DF_pMilestoneItemStatus_Active]  DEFAULT ((1)) FOR [Active]
GO


INSERT pMilestoneItemStatus (MilestoneItemStatusID, MilestoneItemStatus, MilestoneItemStatusRepID, Active) 
VALUES (1, N'In Progres', N'6394af95-4772-4278-816b-6a0a8babc332', 1)

INSERT pMilestoneItemStatus (MilestoneItemStatusID, MilestoneItemStatus, MilestoneItemStatusRepID, Active) 
VALUES (2, N'Approved', N'10bbfa0b-8db1-4f55-b57e-954f9973d7b8', 1)

INSERT pMilestoneItemStatus (MilestoneItemStatusID, MilestoneItemStatus, MilestoneItemStatusRepID, Active) 
VALUES (3, N'Complete', N'33dcd33d-99f3-4bf5-b09c-5629c19946d0', 1)

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07084', GetDate())
GO
