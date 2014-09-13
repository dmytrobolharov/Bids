IF NOT EXISTS(SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'pBOLOperations')
CREATE TABLE [dbo].[pBOLOperations](
	[OperationId] [uniqueidentifier] NOT NULL,
	[OperationCode] [nvarchar](200) NULL,
	[OperationName] [nvarchar](200) NULL,
	[BaseRateId] [uniqueidentifier] NULL,
	[SAM] [numeric](10, 2) NULL,
	[MachineId] [uniqueidentifier] NULL,
	[Image] [uniqueidentifier] NULL,
	[Fixed] [int] NULL,
	[CUser] [nvarchar](200) NULL,
	[CDate] [datetime] NULL,
	[MUser] [nvarchar](200) NULL,
	[MDate] [datetime] NULL,
	[Active] [int] NULL,
	[CategoryId] [uniqueidentifier] NULL,
	[Sort] [nvarchar](5) NULL,
 CONSTRAINT [PK_pBOLOperations] PRIMARY KEY CLUSTERED 
(
	[OperationId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[pBOLOperations] ADD  CONSTRAINT [DF_pBOLOperations_OperationId]  DEFAULT (newid()) FOR [OperationId]
GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='01724'))
BEGIN
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '01724', GetDate())
END	

GO
