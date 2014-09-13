IF NOT EXISTS(SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'pBOLFactoryRates')
CREATE TABLE [dbo].[pBOLFactoryRates](
	[FactoryRateId] [uniqueidentifier] NOT NULL,
	[FactoryId] [uniqueidentifier] NULL,
	[BaseRateId] [uniqueidentifier] NULL,
	[SeasonYearId] [uniqueidentifier] NULL,
	[CurrencyId] [uniqueidentifier] NULL,
	[RateValue] [numeric](18, 2) NULL,
	[CUser] [nvarchar](200) NULL,
	[CDate] [datetime] NULL,
	[MUser] [nvarchar](200) NULL,
	[MDate] [datetime] NULL,
	[Active] [int] NULL,
 CONSTRAINT [PK_pBOLFactoryRates] PRIMARY KEY CLUSTERED 
(
	[FactoryRateId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[pBOLFactoryRates]  WITH CHECK ADD  CONSTRAINT [FK_pBOLFactoryRates_pBOLFactories] FOREIGN KEY([FactoryId])
REFERENCES [dbo].[pBOLFactories] ([FactoryId])
ON DELETE CASCADE
GO

ALTER TABLE [dbo].[pBOLFactoryRates] CHECK CONSTRAINT [FK_pBOLFactoryRates_pBOLFactories]
GO

ALTER TABLE [dbo].[pBOLFactoryRates] ADD  CONSTRAINT [DF_pBOLFactoryRates_FactoryRateId]  DEFAULT (newid()) FOR [FactoryRateId]
GO


IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='01714'))
BEGIN
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '01714', GetDate())
END	

GO
