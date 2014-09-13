
/****** Object:  StoredProcedure [dbo].[spx_StyleDetailMultigrid_Custom_GridCopy_INSERT]    Script Date: 10/17/2011 15:10:55 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleDetailMultigrid_Custom_Copy_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleDetailMultigrid_Custom_Copy_INSERT]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleDetailMultigrid_Custom_GridCopy_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleDetailMultigrid_Custom_GridCopy_INSERT]
GO

CREATE  PROCEDURE [dbo].[spx_StyleDetailMultigrid_Custom_GridCopy_INSERT](
	@StyleID UNIQUEIDENTIFIER,
	@StyleSet INT,
	@NewStyleID UNIQUEIDENTIFIER,
	@NewStyleSet INT,
	@WorkflowID UNIQUEIDENTIFIER,
	@CreatedBy NVARCHAR(50),
	@CreatedDate NVARCHAR(50),
	@TableName NVARCHAR(200)
)

AS	
	DECLARE @Fields NVARCHAR(Max)
	DECLARE @sql NVARCHAR(Max)
BEGIN

	
	--copy data of custom table

	IF @TableName <> ''
	BEGIN
		SELECT
			@Fields = COALESCE(@Fields + ',', '') + column_name
		FROM
			information_schema.columns
		WHERE
			table_schema = 'dbo' AND
			table_name = @TableName AND
			column_name <> 'CustomID' AND column_name <> 'StyleID' AND column_name <> 'StyleSet' AND column_name <> 'WorkflowID' AND
			column_name <> 'CUser' AND column_name <> 'CDate' AND column_name <> 'MUser' AND column_name <> 'MDate'
		ORDER BY
			ordinal_position;
		    
		SET @sql = 'INSERT INTO ' + @TableName + ' (StyleID,StyleSet,WorkflowID,' + @Fields
		SET @sql = @sql + ',CUser,CDate,MUser,MDate) SELECT '
		SET @sql = @sql + '''' + CAST (@NewStyleID AS NVARCHAR(50)) + ''',' + CAST (@NewStyleSet AS NVARCHAR(50)) + ',''' + CAST (@WorkflowID AS NVARCHAR(50)) + ''',' + @Fields
		SET @sql = @sql + ',''' + @CreatedBy + ''',''' + @CreatedDate + ''',''' + @CreatedBy + ''',''' + @CreatedDate + ''''
		SET @sql = @sql + ' FROM ' + @TableName + ' WITH (NOLOCK)'
		SET @sql = @sql + ' WHERE StyleID = ''' + CAST (@StyleID AS NVARCHAR(50)) + ''''
		SET @sql = @sql + ' AND StyleSet = ' + CAST (@StyleSet AS NVARCHAR(50))
		SET @sql = @sql + ' AND WorkflowID = ''' + CAST (@WorkflowID AS NVARCHAR(50)) + ''''

		print @sql
		exec (@sql)
		
	END

END

GO


IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='02028'))
BEGIN
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '02028', GetDate())
END
GO