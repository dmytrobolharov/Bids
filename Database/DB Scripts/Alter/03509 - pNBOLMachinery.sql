IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pNBOLMachinery_MachineID]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pNBOLMachinery] DROP CONSTRAINT [DF_pNBOLMachinery_MachineID]
END
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pNBOLMachinery]') AND type in (N'U'))
DROP TABLE [dbo].[pNBOLMachinery]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[pNBOLMachinery](
	[MachineID] [uniqueidentifier] NOT NULL,
	[MachineCode] [nvarchar](200) NULL,
	[MachineName] [nvarchar](200) NULL,
	[MachineDesc] [nvarchar](200) NULL,
	[MachineClassID] [uniqueidentifier] NULL,
	[MachineTypeID] [uniqueidentifier] NULL,
	[ImageID] [uniqueidentifier] NULL,
	[CustomField1] [nvarchar](200) NULL,
	[CustomField2] [nvarchar](200) NULL,
	[CustomField3] [nvarchar](200) NULL,
	[CustomField4] [nvarchar](200) NULL,
	[CustomField5] [nvarchar](200) NULL,
	[CUser] [nvarchar](200) NULL,
	[CDate] [datetime] NULL,
	[MUser] [nvarchar](200) NULL,
	[MDate] [datetime] NULL,
	[Active] [int] NULL,
 CONSTRAINT [PK_pBOLMachinery] PRIMARY KEY CLUSTERED 
(
	[MachineID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[pNBOLMachinery] ADD  CONSTRAINT [DF_pNBOLMachinery_MachineID]  DEFAULT (newid()) FOR [MachineID]
GO



INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '03509', GetDate())
GO