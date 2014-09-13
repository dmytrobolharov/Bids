IF NOT EXISTS(SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'pBOLOperationFixed')
CREATE TABLE [dbo].[pBOLOperationFixed](
	[OperationFixingId] [uniqueidentifier] NOT NULL,
	[OperationId] [uniqueidentifier] NULL,
	[VendorId] [uniqueidentifier] NULL,
	[SeasonId] [uniqueidentifier] NULL,
	[FixedCost] [float] NULL,
	[CUser] [nvarchar](200) NULL,
	[CDate] [datetime] NULL,
	[MUser] [nvarchar](200) NULL,
	[MDate] [datetime] NULL,
	[Active] [int] NULL,
 CONSTRAINT [PK_pBOLOperationFixed] PRIMARY KEY CLUSTERED 
(
	[OperationFixingId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[pBOLOperationFixed] ADD  CONSTRAINT [DF_pBOLOperationFixed_OperationFixingId]  DEFAULT (newid()) FOR [OperationFixingId]
GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='01723'))
BEGIN
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '01723', GetDate())
END	

GO
