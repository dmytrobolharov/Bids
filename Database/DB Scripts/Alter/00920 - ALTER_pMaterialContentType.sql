declare @table_name nvarchar(256) 
declare @CONST_NAME nvarchar(256) 
declare @Command  nvarchar(1000)  
set @table_name = N'pMaterialContentType' 
 
select @CONST_NAME = CONSTRAINT_NAME from INFORMATION_SCHEMA.TABLE_CONSTRAINTS where TABLE_NAME = 'pMaterialContentType'
select @Command = 'ALTER TABLE ' + @table_name + ' drop constraint ' + @CONST_NAME  

--print @Command  
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(@table_name) AND name = @CONST_NAME)
	BEGIN 
		execute (@Command) 
	END
GO

IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = N'pMaterialContentType' and COLUMN_NAME = N'CustomID')
       BEGIN 
            ALTER TABLE pMaterialContentType ADD CustomID uniqueidentifier NOT NULL DEFAULT NewId()
       END
GO
IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = N'pMaterialContentType' and COLUMN_NAME = N'CustomID')
       BEGIN 
            UPDATE pMaterialContentType SET CustomID = NEWID()
       END
GO
IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = N'pMaterialContentType' and COLUMN_NAME = N'CustomID')
       BEGIN 
		ALTER TABLE pMaterialContentType ADD  CONSTRAINT PK_pMaterialContentTypeID PRIMARY KEY CLUSTERED 
		(
			CustomID ASC
		)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
       END
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.0.0000', '920', GetDate())
GO