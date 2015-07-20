IF NOT EXISTS(SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'pBOLMachineCategory')
CREATE TABLE [dbo].[pBOLMachineCategory](
	[CategoryId] [uniqueidentifier] NOT NULL,
	[CategoryName] [varchar](200) NULL,
	[CUser] [nvarchar](200) NULL,
	[CDate] [datetime] NULL,
	[MUser] [nvarchar](200) NULL,
	[MDate] [datetime] NULL,
	[Active] [int] NULL,
 CONSTRAINT [PK_pBOLMachinesCategory] PRIMARY KEY CLUSTERED 
(
	[CategoryId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[pBOLMachineCategory] ADD  CONSTRAINT [DF_pBOLMachinesCategory_CategoryId]  DEFAULT (newid()) FOR [CategoryId]
GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='01752'))
BEGIN
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '01752', GetDate())
END	

GO
