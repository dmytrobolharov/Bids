IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pFlashCostDuty_FlashCostDutyID_1]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pFlashCostDuty] DROP CONSTRAINT [DF_pFlashCostDuty_FlashCostDutyID_1]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pFlashCostDuty_Active]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pFlashCostDuty] DROP CONSTRAINT [DF_pFlashCostDuty_Active]
END

GO

/****** Object:  Table [dbo].[pFlashCostDuty]    Script Date: 12/13/2012 18:34:54 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pFlashCostDuty]') AND type in (N'U'))
DROP TABLE [dbo].[pFlashCostDuty]
GO

/****** Object:  Table [dbo].[pFlashCostDuty]    Script Date: 12/13/2012 18:34:54 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[pFlashCostDuty](
	[FlashCostDutyID] [uniqueidentifier] NOT NULL,
	[DutyCategoryCode] [nvarchar](100) NULL,
	[DutyCategoryName] [nvarchar](200) NULL,
	[Active] [int] NULL,
	[CDate] [datetime] NULL,
	[CUser] [nvarchar](200) NULL,
	[MDate] [datetime] NULL,
	[MUser] [nvarchar](200) NULL,
 CONSTRAINT [PK_pFlashCostDuty_1] PRIMARY KEY CLUSTERED 
(
	[FlashCostDutyID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[pFlashCostDuty] ADD  CONSTRAINT [DF_pFlashCostDuty_FlashCostDutyID_1]  DEFAULT (newid()) FOR [FlashCostDutyID]
GO

ALTER TABLE [dbo].[pFlashCostDuty] ADD  CONSTRAINT [DF_pFlashCostDuty_Active]  DEFAULT ((1)) FOR [Active]
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '04615', GetDate())
GO
