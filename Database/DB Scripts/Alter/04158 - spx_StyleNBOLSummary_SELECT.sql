
/****** Object:  StoredProcedure [dbo].[spx_StyleNBOLSummary_SELECT]    Script Date: 10/11/2012 18:34:51 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleNBOLSummary_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleNBOLSummary_SELECT]
GO

/****** Object:  StoredProcedure [dbo].[spx_StyleNBOLSummary_SELECT]    Script Date: 10/11/2012 18:34:51 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[spx_StyleNBOLSummary_SELECT] 
(
	@StyleId uniqueidentifier,
	@StyleSet int,
	@WorkflowId uniqueidentifier,
	@WorkflowItemId uniqueidentifier,
	@PageSize int,
	@SearchSQL nvarchar(max) = '',
	@AddEmptyRow int = 0
)
AS

BEGIN

CREATE TABLE #tmpStyleBolItems
(
	[StyleNBOLItemID] [uniqueidentifier] NOT NULL,
	[StyleID] [uniqueidentifier] NULL,
	[StyleSet] [int] NULL,
	[Sort] [nvarchar](5) NULL,
	[Sort1] [nvarchar](50) NULL,
	[Sort2] [nvarchar](5) NULL,
	[IsLinked] [int] NULL,
	[TemplateItemID] [uniqueidentifier] NULL,
	[OperationID] [uniqueidentifier] NULL,
	[MacroID] [uniqueidentifier] NULL,
	[ParentID] [uniqueidentifier] NULL,
	[Code] [nvarchar](200) NULL,
	[Name] [nvarchar](200) NULL,
	[ImageID] [uniqueidentifier] NULL,
	[ImageType] [nvarchar](10) NULL,
	[Image] [nvarchar](800) NULL,
	[MachineID] [uniqueidentifier] NULL,
	[OperationTypeID] [uniqueidentifier] NULL,
	[BaseRate] [decimal](18, 2) NULL,
	[SAM] [decimal](18, 2) NULL,
	[Coef] [decimal](18, 2) NULL,
	[Adj] [decimal](18, 2) NULL,
	[TotalTime] [decimal](18, 2) NULL,
	[Total] [decimal](18, 2) NULL,
	[Comments] [nvarchar](800) NULL,
	[Exceptions] [nvarchar](800) NULL,
	[CUser] [nvarchar](200) NULL,
	[CDate] [datetime] NULL,
	[MUser] [nvarchar](200) NULL,
	[MDate] [datetime] NULL
)


INSERT INTO #tmpStyleBolItems(
		StyleNBOLItemID, StyleID, StyleSet,
		TemplateItemID, MacroID, OperationID, IsLinked, ImageID, ImageType,
		Code, Name, MachineID, OperationTypeID, BaseRate, SAM, ParentID,
		Sort, Sort1, Sort2, Coef, Adj, Comments)

SELECT sbi.StyleNBOLItemID, sbi.StyleID, sbi.StyleSet,
		ti.TemplateItemID, ti.MacroID, ti.OperationID, sbi.IsLinked, ti.ImageID, 
		ImageType = CASE
			WHEN sbi.MacroID IS NOT NULL THEN 'BOLMOP'
			WHEN sbi.OperationID IS NOT NULL THEN 'BOLOP'
		END,
		ti.Code, ti.Name, ti.MachineID, ti.OperationTypeID, 
		sbi.BaseRate, sbi.SAM, ti.ParentID,
		sbi.Sort, Sort1 = CASE
			WHEN sbi.MacroID IS NOT NULL THEN sbi.TemplateItemID
			WHEN sbi.OperationID IS NOT NULL THEN sbi.ParentID
		END,
		sbi.Sort2, sbi.Coef, sbi.Adj, sbi.Comments
FROM pStyleNBOLItems sbi
	LEFT JOIN pNBOLTemplateItem ti ON sbi.TemplateItemID = ti.TemplateItemID
WHERE sbi.IsLinked = 1 
	AND sbi.StyleID = @StyleId AND sbi.StyleSet = @StyleSet AND sbi.WorkFlowID = @WorkflowId AND sbi.WorkFlowItemID = @WorkflowItemId

UNION

SELECT sbi.StyleNBOLItemID, sbi.StyleID, sbi.StyleSet,
		sbi.TemplateItemID, sbi.MacroID, sbi.OperationID, sbi.IsLinked, sbi.ImageID, 
		ImageType = CASE
			WHEN sbi.MacroID IS NOT NULL THEN 'BOLMOP'
			WHEN sbi.OperationID IS NOT NULL THEN 'BOLOP'
		END,
		sbi.Code, sbi.Name, sbi.MachineID, sbi.OperationTypeID, sbi.BaseRate, sbi.SAM, sbi.ParentID,
		sbi.Sort, Sort1 = CASE
			WHEN sbi.MacroID IS NOT NULL THEN sbi.TemplateItemID
			WHEN sbi.OperationID IS NOT NULL THEN sbi.ParentID
		END,
		sbi.Sort2, sbi.Coef, sbi.Adj, sbi.Comments
FROM pStyleNBOLItems sbi
WHERE (sbi.IsLinked = 0 OR sbi.IsLinked = -1)
	AND sbi.StyleID = @StyleId AND sbi.StyleSet = @StyleSet AND sbi.WorkFlowID = @WorkflowId AND sbi.WorkFlowItemID = @WorkflowItemId

ORDER BY Sort, Sort1, Sort2


DECLARE @ImageServer nvarchar(200) 
SET @ImageServer = (SELECT AppSettingValue FROM sAppSetting WHERE AppSettingKey = 'ImageServer' AND ConfigFileName = 'Server.config')

UPDATE #tmpStyleBolItems
SET [Image] = 
	'<img src="'+@ImageServer+'/ImageStream.ashx?IT=' + ISNULL(ImageType, 'BOLOP') + '&S=50&ID=' + CAST(ISNULL(ImageID, '00000000-0000-0000-0000-000000000000') AS NVARCHAR(50)) + '" ' +
	'onclick="javascript:var w=window.open(''' + @ImageServer + '/ImageStream.ashx?IT=' + ISNULL(ImageType, 'BOLOP') + '&S=600&V=0&ID=' + CAST(ISNULL(ImageID, '00000000-0000-0000-0000-000000000000') AS NVARCHAR(50)) + ''', ''ImageZoom'', ''menubar=0,toolbar=0,status=0,scrollbars=1,location=0,resizable=1,top=1,left=1,height=800,width=800''); w.focus(); return false;"' +
	' />'


UPDATE #tmpStyleBolItems
SET TotalTime = SAM * ISNULL(Coef,1) + (SAM * ISNULL(Coef,1)) * ISNULL(Adj,0) / 100
WHERE MacroID IS NULL

UPDATE #tmpStyleBolItems
SET Total = TotalTime * BaseRate

UPDATE #tmpStyleBolItems
SET TotalTime = (SELECT SUM(TotalTime) FROM #tmpStyleBolItems t1 WHERE #tmpStyleBolItems.TemplateItemID = t1.ParentID)
WHERE #tmpStyleBolItems.MacroID IS NOT NULL

UPDATE #tmpStyleBolItems
SET Total = (SELECT SUM(Total) FROM #tmpStyleBolItems t1 WHERE #tmpStyleBolItems.TemplateItemID = t1.ParentID)
WHERE #tmpStyleBolItems.MacroID IS NOT NULL

UPDATE #tmpStyleBolItems SET OperationTypeID = '00000000-0000-0000-0000-000000000000' WHERE OperationTypeID IS NULL AND MacroID IS NULL


IF @AddEmptyRow = 0
BEGIN
	UPDATE #tmpStyleBolItems 
	SET Exceptions = (SELECT dbo.fnx_StyleNBOL_GetExceptionEntriesString (StyleNBOLItemID, @WorkflowItemId))
	WHERE MacroID IS NULL
END

--SELECT *  FROM #tmpStyleBolItems ORDER BY Sort, Sort1, Sort2

--============================================================================

CREATE TABLE #tmpBOL (
	ROW INT IDENTITY(1, 1),
	ROWINDEX INT NULL,
	StyleNBOLItemID UNIQUEIDENTIFIER
)	

DECLARE @sqlString nvarchar(4000)
--SET @sqlString = 
--	'INSERT INTO #tmpBOL(StyleNBOLItemID) 
--	 SELECT StyleNBOLItemID FROM #tmpStyleBolItems '
--	 + @SearchSQL +
--	'ORDER BY Sort, Sort1, Sort2'
--EXEC (@sqlString)

	SET @sqlString = 
	'INSERT INTO #tmpBOL(StyleNBOLItemID) 
	SELECT StyleNBOLItemID FROM #tmpStyleBolItems sbi
	WHERE 
	  sbi.StyleNBOLItemID IN 
		(
			SELECT StyleNBOLItemID FROM #tmpStyleBolItems '
			+ @SearchSQL +
	'	)
	OR sbi.TemplateItemID IN
		(
			SELECT ParentID FROM #tmpStyleBolItems '
			+ @SearchSQL +
	'	)
	ORDER BY Sort, Sort1, Sort2'
	EXEC (@sqlString)
	
	IF @AddEmptyRow = 1
	BEGIN

		UPDATE #tmpBOL SET ROWINDEX = ROW -- ROWINDEX is used because identities can't be inserted manually

		-- select operations and macro only (without macrooperation)
		SELECT IDENTITY(INT, 1, 1) AS ROW, ROW AS ROW_FROM, #tmpBOL.StyleNBOLItemID
		INTO #tmpBOL_P
		FROM #tmpBOL LEFT JOIN #tmpStyleBolItems sbi ON sbi.StyleNBOLItemID = #tmpBOL.StyleNBOLItemID
		WHERE sbi.ParentID IS NULL	
		
		DECLARE @CurrentRow INT = @PageSize - 1,
				@Total INT;
				
		SELECT @Total = COUNT(*) FROM #tmpBOL_P
		
		WHILE @CurrentRow < @Total
		BEGIN
			DECLARE @LinkedRow INT
			SELECT @LinkedRow = ROW_FROM FROM #tmpBOL_P WHERE ROW = @CurrentRow
			
			-- insert empty row at the end of each page
			INSERT INTO #tmpBOL(ROWINDEX, StyleNBOLItemID)
			VALUES(@LinkedRow, '00000000-0000-0000-0000-000000000000')
			
			SET @CurrentRow = @CurrentRow + @PageSize - 1
		END
		
		-- add empty row at the very end
		SELECT @Total = COUNT(*) FROM #tmpBOL
		INSERT INTO #tmpBOL(ROWINDEX, StyleNBOLItemID)
		VALUES(@Total + 1, '00000000-0000-0000-0000-000000000000')	
		
		DROP TABLE #tmpBOL_P
	
	END

	SELECT #tmpBOL.StyleNBOLItemID, sbi.StyleID, sbi.StyleSet, 
		TemplateItemID = CASE 
		WHEN sbi.TemplateItemID IS NOT NULL THEN sbi.TemplateItemID 
		WHEN sbi.TemplateItemID IS NULL THEN '00000000-0000-0000-0000-000000000000' 
		END, 
		sbi.ParentID, sbi.Sort, sbi.Sort1, sbi.Sort2, 
		sbi.IsLinked, sbi.OperationID, sbi.MacroID, sbi.Code, sbi.Name, sbi.MachineID, sbi.OperationTypeID,  
		sbi.BaseRate, sbi.SAM, sbi.Adj, sbi.Coef, sbi.Comments, sbi.Exceptions, sbi.[Image], 
		sbi.Total, sbi.TotalTime 
	FROM #tmpBOL 
		LEFT JOIN #tmpStyleBolItems sbi ON #tmpBOL.StyleNBOLItemID = sbi.StyleNBOLItemID
	ORDER BY #tmpBOL.ROWINDEX

	DROP TABLE #tmpBOL

--============================================================================

DROP TABLE #tmpStyleBolItems

END

	GO
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04158', GetDate())
GO
	

