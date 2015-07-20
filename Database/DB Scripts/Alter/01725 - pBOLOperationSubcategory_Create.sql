IF NOT EXISTS(SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'pBOLOperationSubcategory')
CREATE TABLE [dbo].[pBOLOperationSubcategory](
	[SubcategoryId] [uniqueidentifier] NOT NULL,
	[SubcategoryName] [varchar](200) NULL,
	[CUser] [nvarchar](200) NULL,
	[CDate] [datetime] NULL,
	[MUser] [nvarchar](200) NULL,
	[MDate] [datetime] NULL,
	[Active] [int] NULL,
	[CategoryId] [uniqueidentifier] NULL,
 CONSTRAINT [PK_pBOLOperationSubcategory] PRIMARY KEY CLUSTERED 
(
	[SubcategoryId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[pBOLOperationSubcategory] ADD  CONSTRAINT [DF_pBOLOperationSubcategory_SubcategoryId]  DEFAULT (newid()) FOR [SubcategoryId]
GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='01725'))
BEGIN
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '01725', GetDate())
END	

GO
