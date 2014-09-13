/****** Object:  StoredProcedure [dbo].[spx_RadGridField_SpecifyGroupingField_INSERT_UPDATE]    Script Date: 11/30/2012 13:53:15 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_RadGridField_SpecifyGroupingField_INSERT_UPDATE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_RadGridField_SpecifyGroupingField_INSERT_UPDATE]
GO


/****** Object:  StoredProcedure [dbo].[spx_RadGridField_SpecifyGroupingField_INSERT_UPDATE]    Script Date: 11/30/2012 13:53:15 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spx_RadGridField_SpecifyGroupingField_INSERT_UPDATE]
	@FormName NVARCHAR(200),
	@ColumnUniqueName NVARCHAR(200),
	@ColumnToSwapUniqueName NVARCHAR(200) = NULL,
	@ColumnGroupByIndex INT = NULL,
	@ColumnGroupBySortOrder VARCHAR(5) = NULL,
	@TeamID UNIQUEIDENTIFIER
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	/* Inserting the new record with order for column, or updating an existing one*/
	IF @ColumnGroupByIndex IS NOT NULL
	BEGIN
		IF NOT EXISTS(SELECT * FROM pRadGridFieldSort WHERE RadGridFormName = @FormName AND ColumnUniqueName = @ColumnUniqueName AND TeamID = @TeamID)
		BEGIN
			INSERT INTO pRadGridFieldSort (RadGridFormName, ColumnUniqueName, ColumnOrderIndex, ColumnGroupByIndex, TeamID)
			VALUES(@FormName, @ColumnUniqueName, -1, @ColumnGroupByIndex, @TeamID)
		END
		ELSE
		BEGIN

			-- Processing add or delete of the column			
			UPDATE pRadGridFieldSort SET ColumnGroupByIndex = @ColumnGroupByIndex
			WHERE RadGridFormName = @FormName AND ColumnUniqueName = @ColumnUniqueName
			AND TeamID = @TeamID
				
			-- Reordering Group By clauses after deleting one, to preserve duplicate indexes and
			-- blank fields.
			IF @ColumnGroupByIndex = -1
			BEGIN
			
				UPDATE pRadGridFieldSort SET ColumnGroupBySortOrder = 'ASC'
				WHERE RadGridFormName = @FormName AND ColumnUniqueName = @ColumnUniqueName
				AND TeamID = @TeamID
					
				CREATE TABLE #tempRadGridOrderBySort
				(
					RadGridSordID UNIQUEIDENTIFIER,
					ColumnUniqueName NVARCHAR(200),
					ColumnGroupByIndex INT,
					ColumnRowNumber INT
				)
					
				INSERT INTO #tempRadGridOrderBySort
				SELECT RadGridSortID, ColumnUniqueName, ColumnGroupByIndex, 
				(ROW_NUMBER() OVER(ORDER BY ColumnGroupByIndex) - 1) AS Ind 
				FROM pRadGridFieldSort
				WHERE RadGridFormName = @FormName AND ColumnGroupByIndex <> -1 AND TeamID = @TeamID
				ORDER BY ColumnGroupByIndex
					
				UPDATE pRadGridFieldSort
				SET pRadGridFieldSort.ColumnGroupByIndex = #tempRadGridOrderBySort.ColumnRowNumber
				FROM pRadGridFieldSort INNER JOIN #tempRadGridOrderBySort
				ON pRadGridFieldSort.RadGridSortID = #tempRadGridOrderBySort.RadGridSordID
					
				DROP TABLE #tempRadGridOrderBySort
			END
		END
	END
	-- Processing column swap
	IF @ColumnToSwapUniqueName IS NOT NULL
	BEGIN
		DECLARE @FirstColumnGroupByIndex INT
		DECLARE @FirstColumnID UNIQUEIDENTIFIER
		DECLARE @SecondColumnGroupByIndex INT
		DECLARE @SecondColumnID UNIQUEIDENTIFIER
			
		SELECT @FirstColumnGroupByIndex = ColumnGroupByIndex, @FirstColumnID = RadGridSortID FROM pRadGridFieldSort 
		WHERE RadGridFormName = @FormName 
		AND ColumnUniqueName = @ColumnUniqueName 
		AND TeamID = @TeamID
			
		SELECT @SecondColumnGroupByIndex = ColumnGroupByIndex, @SecondColumnID = RadGridSortID FROM pRadGridFieldSort 
		WHERE RadGridFormName = @FormName 
		AND ColumnUniqueName = @ColumnToSwapUniqueName 
		AND TeamID = @TeamID
			
		UPDATE pRadGridFieldSort SET ColumnGroupByIndex = @FirstColumnGroupByIndex WHERE RadGridSortID = @SecondColumnID
		UPDATE pRadGridFieldSort SET ColumnGroupByIndex = @SecondColumnGroupByIndex WHERE RadGridSortID = @FirstColumnID
    END
    
    -- Change sort order, if it was changed
    IF @ColumnGroupBySortOrder IS NOT NULL
    BEGIN
			UPDATE pRadGridFieldSort SET ColumnGroupBySortOrder = @ColumnGroupBySortOrder
			WHERE RadGridFormName = @FormName 
			AND ColumnUniqueName = @ColumnUniqueName 
			AND TeamID = @TeamID
    END
    
END

GO
INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04508', GetDate())
GO

