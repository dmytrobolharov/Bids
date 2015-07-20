IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pPlanningFlashEdit_PlanningFlashEditID]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pPlanningFlashEdit] DROP CONSTRAINT [DF_pPlanningFlashEdit_PlanningFlashEditID]
END

GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pPlanningFlashEdit]') AND type in (N'U'))
DROP TABLE [dbo].[pPlanningFlashEdit]
GO
CREATE TABLE [dbo].[pPlanningFlashEdit](
	[PlanningFlashEditID] [uniqueidentifier] NOT NULL,
	[PlanningFlashEditName] [nvarchar](50) NULL,
	[PlanningFlashEditDescription] [nvarchar](400) NULL,
	[PlanningFlashEditSort] [int] NULL,
	[PlanningFlashEditActive] [int] NULL,
	[PlanningFlashEditGridXML] [nvarchar](200) NULL,
	[PlanningFlashEditBatchXML] [nvarchar](200) NULL,
	[PlanningFlashEditSearchXML] [nvarchar](200) NULL,
	[PlanningFlashEditUpdateLogicSPX] [nvarchar](200) NULL,
	[CUser] [nvarchar](200) NULL,
	[CDate] [datetime] NULL,
	[MUser] [nvarchar](200) NULL,
	[MDate] [datetime] NULL,
 CONSTRAINT [PK_pPlanningFlashEdit] PRIMARY KEY CLUSTERED 
(
	[PlanningFlashEditID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[pPlanningFlashEdit] ADD  CONSTRAINT [DF_pPlanningFlashEdit_PlanningFlashEditID]  DEFAULT (newid()) FOR [PlanningFlashEditID]
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07333', GetDate())
GO
