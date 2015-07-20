IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = N'pConPageDetail' and COLUMN_NAME = N'Level0ID')
       BEGIN 
			
            ALTER TABLE pConPageDetail ADD [Level0ID] [uniqueidentifier] NULL CONSTRAINT [DF_pConPageDetail_Level0ID]  DEFAULT ('{00000000-0000-0000-0000-000000000000}')
       END
GO

IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = N'pConPageDetail' and COLUMN_NAME = N'Level0Desc')
       BEGIN 
			
            ALTER TABLE pConPageDetail ADD [Level0Desc] [nvarchar](100) NULL
       END
GO

IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[pConPageDetail]') AND name = N'IX_pConPageDetail_0')
DROP INDEX [IX_pConPageDetail_0] ON [dbo].[pConPageDetail] WITH ( ONLINE = OFF )
GO

CREATE NONCLUSTERED INDEX [IX_pConPageDetail_0] ON [dbo].[pConPageDetail] 
(
	[Level0ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO

IF  EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = N'pConPageDetail' and COLUMN_NAME = N'Level0ID')
       BEGIN 
			
            update pConPageDetail set Level0ID = (select Level0ID from pConLevel0 where Level0Desc = 'Category')
       END
GO
IF  EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = N'pConPageDetail' and COLUMN_NAME = N'Level0Desc')
       BEGIN 
			
            update pConPageDetail set Level0Desc = 'Category'
       END
GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='02138'))
	BEGIN
		INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
		VALUES     ('DB_Version', '4.1.0000', '02138', GetDate())
	END
GO
