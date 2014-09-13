IF NOT EXISTS(SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'pBOLFactoryMachines')
CREATE TABLE [dbo].[pBOLFactoryMachines](
	[FactoryMachinesId] [uniqueidentifier] NOT NULL,
	[FactoryId] [uniqueidentifier] NULL,
	[MachineId] [uniqueidentifier] NULL,
	[CUser] [nvarchar](200) NULL,
	[CDate] [datetime] NULL,
	[MUser] [nvarchar](200) NULL,
	[MDate] [datetime] NULL,
	[Active] [int] NULL,
 CONSTRAINT [PK_pBOLFactoryMachines] PRIMARY KEY CLUSTERED 
(
	[FactoryMachinesId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[pBOLFactoryMachines]  WITH CHECK ADD  CONSTRAINT [FK_pBOLFactoryMachines_pBOLFactories] FOREIGN KEY([FactoryId])
REFERENCES [dbo].[pBOLFactories] ([FactoryId])
ON DELETE CASCADE
GO

ALTER TABLE [dbo].[pBOLFactoryMachines] CHECK CONSTRAINT [FK_pBOLFactoryMachines_pBOLFactories]
GO

ALTER TABLE [dbo].[pBOLFactoryMachines] ADD  CONSTRAINT [DF_pBOLFactoryMachines_FactoryMachinesId]  DEFAULT (newid()) FOR [FactoryMachinesId]
GO


IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='01716'))
BEGIN
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '01716', GetDate())
END	

GO
