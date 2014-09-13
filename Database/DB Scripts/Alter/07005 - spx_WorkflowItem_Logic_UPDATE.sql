IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_WorkflowItem_Logic_UPDATE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_WorkflowItem_Logic_UPDATE]
GO

CREATE PROCEDURE [dbo].[spx_WorkflowItem_Logic_UPDATE](
	@WorkflowItemID UNIQUEIDENTIFIER,
	@UpdateSQL NVARCHAR(MAX)	
)
AS 

DECLARE @WorkflowID UNIQUEIDENTIFIER = (SELECT WorkflowID FROM pWorkFlowItem WHERE WorkFlowItemID = @WorkflowItemID)

IF @WorkflowID = '40000000-0000-0000-0000-000000000090'
BEGIN
	SET @updatesql = substring(@updatesql, charindex(' SET ', @updatesql) + LEN(' SET '), LEN(@updatesql))
	SET @UpdateSQL = SUBSTRING(@UpdateSQL, 1, CHARINDEX(' where', @UpdateSQL))

	IF LTRIM(RTRIM(@UpdateSQL)) <> ''
	BEGIN
		--** Create table with changed data
		DECLARE @query AS NVARCHAR(MAX) = 'SELECT ' + @UpdateSQL + ' INTO ##temp'

		EXEC sp_executesql @query

		DECLARE @Columns TABLE (
			ROWID INT identity(1, 1),
			Name nVARCHAR(200))

		INSERT INTO @Columns (NAME)
		SELECT NAME FROM tempdb.sys.columns WHERE object_id = object_id('tempdb..##temp');

		DECLARE @Row INT = 1,
				@Total INT = (SELECT COUNT(*) FROM @Columns),
				@WorkflowItemQuery NVARCHAR(MAX) = '',
				@StyleSKUItemQuery NVARCHAR(MAX) = ''

		WHILE @Row <= @Total
		BEGIN
			DECLARE @Field nVARCHAR(200) = (SELECT Name FROM @Columns WHERE ROWID = @Row)

			IF EXISTS (SELECT NAME FROM sysobjects WHERE id IN (SELECT id FROM syscolumns WHERE NAME = @Field) AND NAME = 'pWorkFlowItem')
			BEGIN
				IF @WorkflowItemQuery = ''
					SET @WorkflowItemQuery = 'UPDATE a SET a.' + @Field + ' = b.' + @Field
				ELSE
					SET @WorkflowItemQuery += ', a.' + @Field + ' = b.' + @Field
			END
			ELSE IF EXISTS (SELECT NAME FROM sysobjects WHERE id IN (SELECT id FROM syscolumns WHERE NAME = @Field) AND NAME = 'pStyleSKUItem')
			BEGIN
				IF @StyleSKUItemQuery = ''
					SET @StyleSKUItemQuery = 'UPDATE a SET a.' + @Field + ' = b.' + @Field
				ELSE
					SET @StyleSKUItemQuery += ', a.' + @Field + ' = b.' + @Field
			END

			SET @Row = @Row + 1
		END

		IF @WorkflowItemQuery <> ''
		BEGIN
			SET @WorkflowItemQuery += ' FROM pWorkFlowItem a INNER JOIN ##temp b ON a.WorkflowItemID = ''' + CAST(@WorkflowItemID AS NVARCHAR(50)) + ''''

			EXEC sp_executesql @statement = @WorkflowItemQuery
		END

		IF @StyleSKUItemQuery <> ''
		BEGIN
			SET @StyleSKUItemQuery += ' FROM pStyleSKUItem a INNER JOIN ##temp b ON a.WorkflowItemID = ''' + CAST(@WorkflowItemID AS NVARCHAR(50)) + ''''

			EXEC sp_executesql @statement = @StyleSKUItemQuery
		END
		
		-- update style sku with bom id from corresponding season year
		UPDATE ssi SET StyleBOMDimensionID = sbd2.StyleBOMDimensionID
		FROM pStyleSKUItem ssi
		INNER JOIN pWorkFlowItem wfi ON ssi.WorkflowItemID = wfi.WorkFlowItemID
		INNER JOIN pStyleBOMDimension sbd ON ssi.StyleBOMDimensionID = sbd.StyleBOMDimensionID		
		INNER JOIN pWorkFlowItem bwfi ON sbd.WorkFlowItemID = bwfi.WorkFlowItemID
		INNER JOIN pWorkFlowItem bwfi2 ON bwfi.WorkflowItemMasterID = bwfi2.WorkflowItemMasterID AND wfi.StyleSeasonYearID = bwfi2.StyleSeasonYearID
		INNER JOIN pStyleBOMDimension sbd2 ON bwfi2.WorkFlowItemID = sbd2.WorkFlowItemID
		WHERE ssi.WorkflowItemID = @WorkflowItemID

		DROP TABLE ##temp
		
	END
END
ELSE
	EXEC(@UpdateSQL)

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07005', GetDate())
GO
