/****** Object:  StoredProcedure [dbo].[spx_StyleNBOLSummary_SELECT]    Script Date: 04/08/2014 13:22:56 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleNBOLSummary_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleNBOLSummary_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_StyleNBOLSummary_SELECT] 
(
	@StyleId uniqueidentifier,
	@StyleSet int,
	@WorkflowId uniqueidentifier,
	@WorkflowItemId uniqueidentifier,
	@PageSize int,
	@SearchSQL nvarchar(max) = '',
	@AddEmptyRow int = 0,
	@ConfigFile nVARCHAR(256) = 'Server.config',
	@ExchangeRateItemID uniqueidentifier = null
)
AS

BEGIN

DECLARE @ExchangeRateID UNIQUEIDENTIFIER
DECLARE @ConvCurrType NVARCHAR(5)
DECLARE @ConvCurrRate DECIMAL(18,4)

SELECT @ConvCurrType = CurrencyType, @ExchangeRateID = ExchangeRateID, @ConvCurrRate = Rate 
FROM sExchangeRateItem WHERE ExchangeRateItemID = @ExchangeRateItemID

CREATE TABLE #tmpStyleBolItems
(
	[StyleNBOLItemID] [uniqueidentifier] NOT NULL,
	[StyleID] [uniqueidentifier] NULL,
	[StyleSet] [int] NULL,
	[Sort] [nvarchar](5) collate database_default NULL,
	[Sort1] [nvarchar](50) collate database_default NULL,
	[Sort2] [nvarchar](5) collate database_default NULL,
	[IsLinked] [int] NULL,
	[TemplateItemID] [uniqueidentifier] NULL,
	[OperationID] [uniqueidentifier] NULL,
	[MacroID] [uniqueidentifier] NULL,
	[ParentID] [uniqueidentifier] NULL,
	[Code] [nvarchar](200) collate database_default NULL,
	[Name] [nvarchar](200) collate database_default NULL,
	[ImageID] [uniqueidentifier] NULL,
	[ImageType] [nvarchar](10) collate database_default NULL,
	[Image] [nvarchar](800) collate database_default NULL,
	[MachineID] [uniqueidentifier] NULL,
	[OperationTypeID] [uniqueidentifier] NULL,
	[BaseRate] [decimal](18, 2) NULL,
	[CurrencyType] [nvarchar](5) collate database_default NULL,
	[ConvBaseRate] [decimal](18, 2) NULL,
	[SAM] [decimal](18, 2) NULL,
	[Coef] [decimal](18, 2) NULL,
	[Adj] [decimal](18, 2) NULL,
	[TotalTime] [decimal](18, 2) NULL,
	[Total] [decimal](18, 2) NULL,
	[Comments] [nvarchar](800) collate database_default NULL,
	[Exceptions] [nvarchar](800) collate database_default NULL,
	[CUser] [nvarchar](200) collate database_default NULL,
	[CDate] [datetime] NULL,
	[MUser] [nvarchar](200) collate database_default NULL,
	[MDate] [datetime] NULL
)


INSERT INTO #tmpStyleBolItems(
		StyleNBOLItemID, StyleID, StyleSet,
		TemplateItemID, MacroID, OperationID, IsLinked, ImageID, ImageType,
		Code, Name, MachineID, OperationTypeID, BaseRate, CurrencyType, SAM, ParentID,
		Sort, Sort1, Sort2, Coef, Adj, Comments)

SELECT sbi.StyleNBOLItemID, sbi.StyleID, sbi.StyleSet,
		ti.TemplateItemID, ti.MacroID, ti.OperationID, sbi.IsLinked,
		CASE WHEN sbi.MacroID IS NULL THEN o.ImageID ELSE m.ImageID END as ImageID,
		ImageType = CASE
			WHEN sbi.MacroID IS NOT NULL THEN 'BOLMOP'
			WHEN sbi.OperationID IS NOT NULL THEN 'BOLOP'
		END,
		ti.Code, ti.Name, ti.MachineID, ti.OperationTypeID, 
		sbi.BaseRate, sbi.CurrencyType, sbi.SAM, ti.ParentID,
		sbi.Sort, Sort1 = CASE
			WHEN sbi.MacroID IS NOT NULL THEN sbi.TemplateItemID
			WHEN sbi.OperationID IS NOT NULL THEN sbi.ParentID
		END,
		sbi.Sort2, sbi.Coef, sbi.Adj, sbi.Comments
FROM pStyleNBOLItems sbi
	LEFT JOIN pNBOLTemplateItem ti ON sbi.TemplateItemID = ti.TemplateItemID
	LEFT JOIN dbo.pNBOLOperation o ON o.OperationID = ti.OperationID
	LEFT JOIN dbo.pNBOLMacro m ON m.MacroID = ti.MacroID
WHERE sbi.IsLinked = 1 
	AND sbi.StyleID = @StyleId AND sbi.StyleSet = @StyleSet AND sbi.WorkFlowID = @WorkflowId AND sbi.WorkFlowItemID = @WorkflowItemId

UNION

SELECT sbi.StyleNBOLItemID, sbi.StyleID, sbi.StyleSet,
		sbi.TemplateItemID, sbi.MacroID, sbi.OperationID, sbi.IsLinked,
		CASE WHEN sbi.MacroID IS NULL THEN o.ImageID ELSE m.ImageID END as ImageID,
		ImageType = CASE
			WHEN sbi.MacroID IS NOT NULL THEN 'BOLMOP'
			WHEN sbi.OperationID IS NOT NULL THEN 'BOLOP'
		END,
		sbi.Code, sbi.Name, sbi.MachineID, sbi.OperationTypeID, sbi.BaseRate, sbi.CurrencyType, sbi.SAM, sbi.ParentID,
		sbi.Sort, Sort1 = CASE
			WHEN sbi.MacroID IS NOT NULL THEN sbi.TemplateItemID
			WHEN sbi.OperationID IS NOT NULL THEN sbi.ParentID
		END,
		sbi.Sort2, sbi.Coef, sbi.Adj, sbi.Comments
FROM pStyleNBOLItems sbi
	LEFT JOIN dbo.pNBOLOperation o ON o.OperationID = sbi.OperationID
	LEFT JOIN dbo.pNBOLMacro m ON m.MacroID = sbi.MacroID
WHERE (sbi.IsLinked = 0 OR sbi.IsLinked = -1)
	AND sbi.StyleID = @StyleId AND sbi.StyleSet = @StyleSet AND sbi.WorkFlowID = @WorkflowId AND sbi.WorkFlowItemID = @WorkflowItemId

ORDER BY Sort, Sort1, Sort2


DECLARE @ImageServer nvarchar(200) 
SET @ImageServer = (SELECT AppSettingValue FROM sAppSetting WHERE AppSettingKey = 'ImageServer' AND ConfigFileName = @ConfigFile)

UPDATE #tmpStyleBolItems
SET [Image] = 
	'<img src="'+@ImageServer+'/ImageStream.ashx?IT=' + ISNULL(ImageType, 'BOLOP') + '&S=40&ID=' + CAST(ISNULL(ImageID, '00000000-0000-0000-0000-000000000000') AS NVARCHAR(50)) + '" ' +
	'onclick="javascript:var w=window.open(''' + @ImageServer + '/ImageStream.ashx?IT=' + ISNULL(ImageType, 'BOLOP') + '&S=600&V=0&ID=' + CAST(ISNULL(ImageID, '00000000-0000-0000-0000-000000000000') AS NVARCHAR(50)) + ''', ''ImageZoom'', ''menubar=0,toolbar=0,status=0,scrollbars=1,location=0,resizable=1,top=1,left=1,height=800,width=800''); w.focus(); return false;"' +
	' />'


UPDATE #tmpStyleBolItems
SET TotalTime = SAM * ISNULL(Coef,1) + (SAM * ISNULL(Coef,1)) * ISNULL(Adj,0) / 100
WHERE MacroID IS NULL

--UPDATE #temp_BOM SET ConvTotal = Total * @ConvCurrRate / (SELECT Rate FROM sExchangeRateItem WHERE ExchangeRateID = @ExchangeRateID AND CurrencyType = #temp_BOM.CurrencyType)
--UPDATE #tmpStyleBolItems SET CurrencyType = @ConvCurrType
--WHERE CurrencyType IS NULL OR CurrencyType = ''

UPDATE #tmpStyleBolItems
SET ConvBaseRate = BaseRate * @ConvCurrRate / (SELECT Rate FROM sExchangeRateItem WHERE ExchangeRateID = @ExchangeRateID AND CurrencyType = #tmpStyleBolItems.CurrencyType)
WHERE MacroID IS NULL
AND CurrencyType IS NOT NULL AND CurrencyType <> ''

UPDATE #tmpStyleBolItems
SET ConvBaseRate = BaseRate
WHERE MacroID IS NULL
AND (CurrencyType IS NULL OR CurrencyType = '')

IF @ExchangeRateItemID IS NOT NULL
BEGIN
	UPDATE #tmpStyleBolItems
	SET Total = TotalTime * ConvBaseRate
END
ELSE
BEGIN
	UPDATE #tmpStyleBolItems
	SET Total = TotalTime * BaseRate
END

UPDATE #tmpStyleBolItems
SET 
	SAM = ISNULL((SELECT SUM(SAM) FROM #tmpStyleBolItems t1 WHERE #tmpStyleBolItems.TemplateItemID = t1.ParentID), '0.00'),
	TotalTime = ISNULL((SELECT SUM(TotalTime) FROM #tmpStyleBolItems t1 WHERE #tmpStyleBolItems.TemplateItemID = t1.ParentID),'0.00'),
	Total = ISNULL((SELECT SUM(Total) FROM #tmpStyleBolItems t1 WHERE #tmpStyleBolItems.TemplateItemID = t1.ParentID),'0.00')
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
	OR sbi.ParentID IN
		(
			SELECT TemplateItemID FROM #tmpStyleBolItems '
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
		sbi.BaseRate, sbi.CurrencyType, sbi.SAM, sbi.Adj, sbi.Coef, sbi.Comments, sbi.Exceptions, sbi.[Image], 
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
VALUES ('DB_Version', '0.5.0000', '07424', GetDate())
GO
