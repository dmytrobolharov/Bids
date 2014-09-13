IF NOT EXISTS(SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'pBOLBaseRateType')
CREATE TABLE [dbo].[pBOLBaseRateType](
	[BaseRateTypeId] [uniqueidentifier] NOT NULL,
	[RateCode] [varchar](200) NULL,
	[RateName] [varchar](200) NULL,
	[RateComment] [varchar](200) NULL,
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
 CONSTRAINT [PK_pBOLBaseRateType1] PRIMARY KEY CLUSTERED 
(
	[BaseRateTypeId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[pBOLBaseRateType] ADD  CONSTRAINT [DF_pBOLBaseRateType1_BaseRateTypeId]  DEFAULT (newid()) FOR [BaseRateTypeId]
GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='01706'))
BEGIN
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '01706', GetDate())
END	

GO
