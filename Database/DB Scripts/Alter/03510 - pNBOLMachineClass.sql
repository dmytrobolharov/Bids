IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pNBOLMachineClass_MachineClassID]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pNBOLMachineClass] DROP CONSTRAINT [DF_pNBOLMachineClass_MachineClassID]
END
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pNBOLMachineClass]') AND type in (N'U'))
DROP TABLE [dbo].[pNBOLMachineClass]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[pNBOLMachineClass](
	[MachineClassID] [uniqueidentifier] NOT NULL,
	[MachineClassCode] [nvarchar](200) NULL,
	[MachineClassName] [nvarchar](200) NULL,
	[CustomField1] [nvarchar](200) NULL,
	[CustomField2] [nvarchar](200) NULL,
	[CustomField3] [nvarchar](200) NULL,
	[CustomField4] [nvarchar](200) NULL,
	[CustomField5] [decimal](18, 3) NULL,
	[CUser] [nvarchar](200) NULL,
	[CDate] [datetime] NULL,
	[MUser] [nvarchar](200) NULL,
	[MDate] [datetime] NULL,
	[Active] [int] NULL,
 CONSTRAINT [PK_pNBOLMachineClass] PRIMARY KEY CLUSTERED 
(
	[MachineClassID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[pNBOLMachineClass] ADD  CONSTRAINT [DF_pNBOLMachineClass_MachineClassID]  DEFAULT (newid()) FOR [MachineClassID]
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '03510', GetDate())
GO