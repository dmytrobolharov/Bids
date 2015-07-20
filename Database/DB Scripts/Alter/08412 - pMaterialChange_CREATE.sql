IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pMaterialChange_MaterialChangeID]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pMaterialChange] DROP CONSTRAINT [DF_pMaterialChange_MaterialChangeID]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pMaterialChange_MaterialStatus]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pMaterialChange] DROP CONSTRAINT [DF_pMaterialChange_MaterialStatus]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pMaterialChange_ActiveID]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pMaterialChange] DROP CONSTRAINT [DF_pMaterialChange_ActiveID]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pMaterialChange_Active]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pMaterialChange] DROP CONSTRAINT [DF_pMaterialChange_Active]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pMaterialChange_RepRowGuidColID]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pMaterialChange] DROP CONSTRAINT [DF_pMaterialChange_RepRowGuidColID]
END

GO

/****** Object:  Table [dbo].[pMaterialChange]    Script Date: 07/24/2014 18:11:33 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pMaterialChange]') AND type in (N'U'))
DROP TABLE [dbo].[pMaterialChange]
GO

/****** Object:  Table [dbo].[pMaterialChange]    Script Date: 07/24/2014 18:11:33 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[pMaterialChange](
	[MaterialChangeID] [uniqueidentifier] NOT NULL,
	[MaterialChangeNo] [int] IDENTITY(1,1) NOT NULL,
	[MaterialStatus] [bit] NULL,
	[MaterialWorkflowPageID] [uniqueidentifier] NULL,
	[MaterialID] [uniqueidentifier] NULL,
	[MaterialChangeNotifyTo] [nvarchar](4000) NULL,
	[MaterialChangeType] [nvarchar](100) NULL,
	[MaterialChangeDescription] [nvarchar](4000) NULL,
	[MaterialChangeBy] [nvarchar](100) NULL,
	[MaterialChangeDate] [datetime] NULL,
	[ActiveID] [uniqueidentifier] NOT NULL,
	[Active] [bit] NOT NULL,
	[RepRowGuidColID] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
 CONSTRAINT [PK_pMaterialChange] PRIMARY KEY CLUSTERED 
(
	[MaterialChangeID] ASC,
	[MaterialChangeNo] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[pMaterialChange] ADD  CONSTRAINT [DF_pMaterialChange_MaterialChangeID]  DEFAULT (newid()) FOR [MaterialChangeID]
GO

ALTER TABLE [dbo].[pMaterialChange] ADD  CONSTRAINT [DF_pMaterialChange_MaterialStatus]  DEFAULT ((0)) FOR [MaterialStatus]
GO

ALTER TABLE [dbo].[pMaterialChange] ADD  CONSTRAINT [DF_pMaterialChange_ActiveID]  DEFAULT ('{00000000-0000-0000-0000-000000000000}') FOR [ActiveID]
GO

ALTER TABLE [dbo].[pMaterialChange] ADD  CONSTRAINT [DF_pMaterialChange_Active]  DEFAULT ((1)) FOR [Active]
GO

ALTER TABLE [dbo].[pMaterialChange] ADD  CONSTRAINT [DF_pMaterialChange_RepRowGuidColID]  DEFAULT (newid()) FOR [RepRowGuidColID]
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '08412', GetDate())
GO
