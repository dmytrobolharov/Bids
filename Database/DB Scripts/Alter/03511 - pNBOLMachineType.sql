IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pNBOLMachineType_MachineTypeID]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pNBOLMachineType] DROP CONSTRAINT [DF_pNBOLMachineType_MachineTypeID]
END
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pNBOLMachineType]') AND type in (N'U'))
DROP TABLE [dbo].[pNBOLMachineType]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[pNBOLMachineType](
	[MachineTypeID] [uniqueidentifier] NOT NULL,
	[MachineClassID] [uniqueidentifier] NULL,
	[MachineTypeCode] [nvarchar](200) NULL,
	[MachineTypeName] [nvarchar](200) NULL,
	[CustomField1] [nvarchar](200) NULL,
	[CustomField2] [nvarchar](200) NULL,
	[CustomField3] [nvarchar](200) NULL,
	[CustomField4] [nvarchar](200) NULL,
	[CustomField5] [decimal](18, 3) NULL,
	[Sort] [nvarchar](5) NULL,
	[CUser] [nvarchar](200) NULL,
	[CDate] [datetime] NULL,
	[MUser] [nvarchar](200) NULL,
	[MDate] [datetime] NULL,
	[Active] [int] NULL,
 CONSTRAINT [PK_pNBOLMachineType] PRIMARY KEY CLUSTERED 
(
	[MachineTypeID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[pNBOLMachineType] ADD  CONSTRAINT [DF_pNBOLMachineType_MachineTypeID]  DEFAULT (newid()) FOR [MachineTypeID]
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '03511', GetDate())
GO