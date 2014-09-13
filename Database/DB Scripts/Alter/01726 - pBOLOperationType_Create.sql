IF NOT EXISTS(SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'pBOLOperationType')
CREATE TABLE [dbo].[pBOLOperationType](
	[TypeId] [uniqueidentifier] NOT NULL,
	[TypeName] [varchar](200) NULL,
	[CUser] [nvarchar](200) NULL,
	[CDate] [datetime] NULL,
	[MUser] [nvarchar](200) NULL,
	[MDate] [datetime] NULL,
	[Active] [int] NULL,
	[SubcategoryId] [uniqueidentifier] NULL,
 CONSTRAINT [PK_pBOLOperationType] PRIMARY KEY CLUSTERED 
(
	[TypeId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[pBOLOperationType] ADD  CONSTRAINT [DF_pBOLOperationType_TypeId]  DEFAULT (newid()) FOR [TypeId]
GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='01726'))
BEGIN
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '01726', GetDate())
END	

GO
