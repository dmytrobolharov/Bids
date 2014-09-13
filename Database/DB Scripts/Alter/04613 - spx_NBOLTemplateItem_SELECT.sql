IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_NBOLTemplateItem_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_NBOLTemplateItem_SELECT]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spx_NBOLTemplateItem_SELECT]
	@TemplateID UNIQUEIDENTIFIER,
	@SearchSQL NVARCHAR(MAX),	
	@PageSize INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	IF CHARINDEX(' WHERE ', @SearchSQL, 0) > 0
		SET @SearchSQL = 'SELECT * FROM vwx_NBOL_TemplateItem_SEL ' +
					'WHERE TemplateItemID IN ' +
					'(SELECT TemplateItemID FROM vwx_NBOL_TemplateItem_SEL ' + @SearchSQL + ' ) ' +
					'OR TemplateItemID IN ' + 
					'(SELECT ParentID FROM vwx_NBOL_TemplateItem_SEL ' + @SearchSQL + ' )' +
					'OR ParentID IN ' + 
					'(SELECT TemplateItemID FROM vwx_NBOL_TemplateItem_SEL ' + @SearchSQL + ' )'
		
	SET @SearchSQL = 'SELECT TemplateItemID ' + SUBSTRING(@SearchSQL, CHARINDEX('FROM', @SearchSQL, 0), LEN(@SearchSQL)) + ' ORDER BY Sort, Sort2'

	CREATE TABLE #tmpTI (
		ROW INT IDENTITY(1, 1),
		ROWINDEX INT NULL,
		TemplateItemID UNIQUEIDENTIFIER
	)	
	
	INSERT INTO #tmpTI(TemplateItemID) EXEC(@SearchSQL)
	
	UPDATE #tmpTI SET ROWINDEX = ROW -- ROWINDEX is used because identities can't be inserted manually
	
	-- select operations and macro only (without macrooperation)
	SELECT IDENTITY(INT, 1, 1) AS ROW, ROW AS ROW_FROM, #tmpTI.TemplateItemID
	INTO #tmpTIP
	FROM #tmpTI LEFT JOIN pNBOLTemplateItem ti ON ti.TemplateItemID = #tmpTI.TemplateItemID
	WHERE ti.ParentID IS NULL	
	
	DECLARE @CurrentRow INT = @PageSize - 1,
			@Total INT;
			
	SELECT @Total = COUNT(*) FROM #tmpTIP
	
	WHILE @CurrentRow < @Total
	BEGIN
		DECLARE @LinkedRow INT
		SELECT @LinkedRow = ROW_FROM FROM #tmpTIP WHERE ROW = @CurrentRow
		
		-- insert empty row at the end of each page
		INSERT INTO #tmpTI(ROWINDEX, TemplateItemID)
		VALUES(@LinkedRow, '00000000-0000-0000-0000-000000000000')
		
		SET @CurrentRow = @CurrentRow + @PageSize - 1
	END
	
	-- add empty row at the very end
	SELECT @Total = COUNT(*) FROM #tmpTI
	INSERT INTO #tmpTI(ROWINDEX, TemplateItemID)
	VALUES(@Total + 1, '00000000-0000-0000-0000-000000000000')	
	
	DROP TABLE #tmpTIP
	
	SELECT ISNULL(ti.TemplateItemID, '00000000-0000-0000-0000-000000000000') AS TemplateItemID, ti.TemplateID, ti.MacroID, ti.OperationID, ti.ImageID,
		ti.Code, ti.Name, ti.MachineID, ti.OperationTypeID, ti.BaseRate, ti.SAM, ti.ParentID, ti.[Image],
		ti.Sort, ti.Sort2, ti.CUser, ti.CDate, ti.MUser, ti.MDate,ti.Active  
	FROM #tmpTI LEFT JOIN vwx_NBOL_TemplateItem_SEL ti ON ti.TemplateItemID = #tmpTI.TemplateItemID
	ORDER BY #tmpTI.ROWINDEX
	
	DROP TABLE #tmpTI	
END
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '04613', GetDate())
GO
