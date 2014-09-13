
/****** Object:  StoredProcedure [dbo].[spx_StyleGetDesignDetaiMultigridlFreeRecordNumber]    Script Date: 10/07/2011 12:11:45 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleGetDesignDetaiMultigridlFreeRecordNumber]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleGetDesignDetaiMultigridlFreeRecordNumber]
GO


CREATE PROCEDURE [dbo].[spx_StyleGetDesignDetaiMultigridlFreeRecordNumber] (
	@StyleID NVARCHAR(50),
	@StyleSet INT,
	@WorkflowID NVARCHAR(50),
	@TableName NVARCHAR(200), 
	@MaxRows INT
)
AS
BEGIN
	DECLARE @sql NVARCHAR(800)
	DECLARE @CountRows INT
	DECLARE @ResultRows INT

	set @sql = N'SELECT @CountRows = count(*) FROM ' + @TableName
	set @sql = @sql + ' WHERE StyleID = ''' + @StyleID + ''' AND StyleSet = ' + CAST (@StyleSet AS nvarchar(5)) + ' AND WorkflowID = ''' + @WorkflowID + ''''

	exec sp_executesql
        @query = @sql, 
        @params = N'@CountRows INT OUTPUT', 
        @CountRows = @CountRows OUTPUT 
 
	set @ResultRows = @MaxRows - @CountRows	
	
	select @ResultRows
END

GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='01996'))
BEGIN
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '01996', GetDate())
END
GO