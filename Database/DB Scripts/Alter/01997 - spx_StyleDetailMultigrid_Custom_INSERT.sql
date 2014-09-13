
/****** Object:  StoredProcedure [dbo].[spx_StyleDetailMultigrid_Custom_INSERT]    Script Date: 10/07/2011 12:19:12 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleDetailMultigrid_Custom_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleDetailMultigrid_Custom_INSERT]
GO


CREATE PROCEDURE [dbo].[spx_StyleDetailMultigrid_Custom_INSERT](
	@StyleID UNIQUEIDENTIFIER,
	@StyleSet INT,
	@WorkflowID UNIQUEIDENTIFIER,
	@NoRow INT,
	@TableName NVARCHAR(200),
	@CreatedBy NVARCHAR(50),
	@CreatedDate NVARCHAR(50)	
)

AS
	DECLARE @sql NVARCHAR(800)
	DECLARE @Max INT
	DECLARE @Len INT
	DECLARE @Sort NVARCHAR (5)

BEGIN

	set @sql = N'SELECT @Max = MAX (Cast(Sort AS INT)) FROM ' + @TableName
	set @sql = @sql + ' WITH (NOLOCK) WHERE StyleID = ''' + CAST (@StyleID as nvarchar(50)) + ''' AND StyleSet = ' + CAST (@StyleSet as nvarchar(50)) + ' AND WorkflowID = ''' + CAST (@WorkflowID as nvarchar(50)) + ''''
	exec sp_executesql
        @query = @sql, 
        @params = N'@Max INT OUTPUT', 
        @Max = @Max OUTPUT 

	IF @Max IS NULL     
		SET @Max  = 1    
	ELSE    
		SET @Max = @Max + 1
		
	print @Max

	DECLARE @Rows INT
	DECLARE @sql_insert NVARCHAR(500)

	SET @Rows = @NoRow
    
	WHILE @Rows > 0
	BEGIN
		SET @Len = LEN ( CAST ( @Max AS NVARCHAR ( 5 ) ) )
		SELECT @Sort = REPLICATE ('0', 5 - @Len ) + CAST ( @Max AS NVARCHAR ( 5 ) )
		set @sql_insert = N'INSERT INTO ' + @TableName + ' (StyleID, StyleSet, WorkflowID, Sort, CUser, CDate, MUser, MDate) VALUES (''' + CAST (@StyleID AS nvarchar(50)) + ''', ' + CAST (@StyleSet AS nvarchar(5)) + ', ''' + CAST (@WorkflowID AS nvarchar(50)) + ''', ''' + CAST (@Sort AS nvarchar(5)) + ''', ''' + @CreatedBy + ''', ''' + @CreatedDate + ''', ''' + @CreatedBy + ''', ''' + @CreatedDate + ''')'
		exec (@sql_insert)
		SET @Max  = @Max  + 1     
		SET @Rows = @Rows - 1    
	END
	
END

GO


IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='01997'))
BEGIN
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '01997', GetDate())
END
GO