IF NOT EXISTS(SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'pBOLFactories')
CREATE TABLE [dbo].[pBOLFactories](
	[FactoryId] [uniqueidentifier] NOT NULL,
	[FactoryCode] [nvarchar](200) NULL,
	[FactoryName] [nvarchar](200) NULL,
	[FactoryCountry] [uniqueidentifier] NULL,
	[FactoryDefCurrency] [uniqueidentifier] NULL,
	[CUser] [nvarchar](200) NULL,
	[CDate] [datetime] NULL,
	[MUser] [nvarchar](200) NULL,
	[MDate] [datetime] NULL,
	[Active] [int] NULL,
	[Comment] [nvarchar](max) NULL,
	[Custom1] [nvarchar](200) NULL,
	[Custom2] [nvarchar](200) NULL,
	[Custom3] [nvarchar](200) NULL,
	[Custom4] [nvarchar](200) NULL,
	[Custom5] [nvarchar](200) NULL,
 CONSTRAINT [PK_pBOLFactories] PRIMARY KEY CLUSTERED 
(
	[FactoryId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[pBOLFactories] ADD  CONSTRAINT [DF_pBOLFactories_FactoryId]  DEFAULT (newid()) FOR [FactoryId]
GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='01713'))
BEGIN
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '01713', GetDate())
END	

GO
