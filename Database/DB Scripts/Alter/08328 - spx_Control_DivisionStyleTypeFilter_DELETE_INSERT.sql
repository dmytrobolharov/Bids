IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Control_DivisionStyleTypeFilter_DELETE_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_Control_DivisionStyleTypeFilter_DELETE_INSERT]
GO


CREATE PROCEDURE [dbo].[spx_Control_DivisionStyleTypeFilter_DELETE_INSERT]
	@WorkflowTemplateID UNIQUEIDENTIFIER
AS
BEGIN

	-- delete
	DELETE FROM pDivisionStyleTypeFilter
	WHERE WorkflowTemplateID = @WorkflowTemplateID
	AND DivisionStyleTypeID NOT IN (SELECT DivisionStyleTypeID FROM pDivisionStyleType)
	


	-- insert
	CREATE TABLE #tmpFilter 
	(
		Row_ID INT IDENTITY (1,1),
		DivisionStyleTypeID UNIQUEIDENTIFIER
	)
	
	INSERT INTO #tmpFilter (DivisionStyleTypeID)
	SELECT DivisionStyleTypeID FROM pDivisionStyleType
	WHERE DivisionStyleTypeID NOT IN 
	(SELECT DivisionStyleTypeID FROM pDivisionStyleTypeFilter WHERE WorkflowTemplateID = @WorkflowTemplateID)
	
	DECLARE @iRow INT
	DECLARE @iCount INT
	DECLARE @DivisionStyleTypeID UNIQUEIDENTIFIER
	
	SET @iRow = 1
	SET @iCount = (SELECT COUNT(*) FROM #tmpFilter)
	
	WHILE @iRow <= @iCount
	BEGIN
	
		SELECT @DivisionStyleTypeID = DivisionStyleTypeID FROM #tmpFilter WHERE Row_ID = @iRow
		
		INSERT INTO pDivisionStyleTypeFilter (FilterID, WorkflowTemplateID, DivisionStyleTypeID, Filter)
		SELECT NEWID(), @WorkflowTemplateID, @DivisionStyleTypeID, NULL
		
		SET @iRow = @iRow + 1
	
	END
	
	DROP TABLE #tmpFilter
	
END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '08328', GetDate())
GO
