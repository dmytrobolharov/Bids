IF NOT EXISTS(SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'pBOLMachines')
CREATE TABLE [dbo].[pBOLMachines](
	[MachineId] [uniqueidentifier] NOT NULL,
	[MachineCode] [varchar](200) NULL,
	[MachineName] [varchar](200) NULL,
	[MachineDesc] [varchar](200) NULL,
	[MachineTypeId] [uniqueidentifier] NULL,
	[Image] [uniqueidentifier] NULL,
	[Custom1] [varchar](200) NULL,
	[Custom2] [varchar](200) NULL,
	[Custom3] [varchar](200) NULL,
	[Custom4] [varchar](200) NULL,
	[Custom5] [varchar](200) NULL,
	[CUser] [nvarchar](200) NULL,
	[CDate] [datetime] NULL,
	[MUser] [nvarchar](200) NULL,
	[MDate] [datetime] NULL,
	[Active] [int] NULL,
 CONSTRAINT [PK_pBOLMachines] PRIMARY KEY CLUSTERED 
(
	[MachineId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[pBOLMachines] ADD  CONSTRAINT [DF_Table_1_MachineID]  DEFAULT (newid()) FOR [MachineId]
GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='01715'))
BEGIN
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '01715', GetDate())
END	

GO
