
/****** Object:  Table [dbo].[pQuickBatchReplaceType]    Script Date: 06/07/2010 17:16:23 ******/

CREATE TABLE [dbo].[pQuickBatchReplaceType](
	[QuickBRTypeId] [int] NOT NULL,
	[QuickBRTypeName] [nvarchar](100)  NULL,
	[QuickBRTypeDescription] [nvarchar](200)  NULL,
	[QuickBROrder] [nvarchar](5)  NULL,
	[QuickBRSchema] [nvarchar](200) NULL,
	[QuickBRSearchSchema] [nvarchar](200)  NULL,
 CONSTRAINT [PK_QuickBatchReplaceType1] PRIMARY KEY CLUSTERED 
(
	[QuickBRTypeId] ASC
)
) ON [PRIMARY]

GO

INSERT INTO dbo.pQuickBatchReplaceType VALUES(1,'Costing','Quick Costing Edit Replace',null,'QuickBR_Default.xml','QuickBR_Search.xml') 
GO

INSERT INTO dbo.pQuickBatchReplaceType VALUES(2,'Style','Replace Size Class',null,'QuickBR_Default.xml','QuickBR_Search.xml') 
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '3.0.0000', '118', GetDate())
GO