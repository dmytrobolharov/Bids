/****** Object:  StoredProcedure [dbo].[spx_StyleNBOLSummary_Total_SELECT]    Script Date: 04/08/2014 13:23:33 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleNBOLSummary_Total_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleNBOLSummary_Total_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_StyleNBOLSummary_Total_SELECT] 
(
	@StyleId uniqueidentifier,
	@StyleSet int,
	@WorkflowId uniqueidentifier,
	@WorkflowItemId uniqueidentifier,
	@ExchangeRateItemId uniqueidentifier = NULL,
	@SortOrder NVARCHAR(MAX) = ''
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
	[Image] [nvarchar](200) collate database_default NULL,
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
		ti.TemplateItemID, ti.MacroID, ti.OperationID, sbi.IsLinked, ti.ImageID, 
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
WHERE sbi.IsLinked = 1 
	AND sbi.StyleID = @StyleId AND sbi.StyleSet = @StyleSet AND sbi.WorkFlowID = @WorkflowId AND sbi.WorkFlowItemID = @WorkflowItemId

UNION

SELECT sbi.StyleNBOLItemID, sbi.StyleID, sbi.StyleSet,
		sbi.TemplateItemID, sbi.MacroID, sbi.OperationID, sbi.IsLinked, sbi.ImageID, 
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
WHERE (sbi.IsLinked = 0 OR sbi.IsLinked = -1)
	AND sbi.StyleID = @StyleId AND sbi.StyleSet = @StyleSet AND sbi.WorkFlowID = @WorkflowId AND sbi.WorkFlowItemID = @WorkflowItemId

ORDER BY Sort, Sort1, Sort2


UPDATE #tmpStyleBolItems
SET TotalTime = SAM * ISNULL(Coef,1) + (SAM * ISNULL(Coef,1)) * ISNULL(Adj,0) / 100
WHERE MacroID IS NULL

--UPDATE #tmpStyleBolItems
--SET Total = TotalTime * BaseRate

/**** Calc converted Rate ****/
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
/**************************/

UPDATE #tmpStyleBolItems
SET 
	TotalTime = ISNULL((SELECT SUM(TotalTime) FROM #tmpStyleBolItems t1 WHERE #tmpStyleBolItems.TemplateItemID = t1.ParentID),'0.00'),
	Total = ISNULL((SELECT SUM(Total) FROM #tmpStyleBolItems t1 WHERE #tmpStyleBolItems.TemplateItemID = t1.ParentID),'0.00')
WHERE #tmpStyleBolItems.MacroID IS NOT NULL

UPDATE #tmpStyleBolItems SET OperationTypeID = '00000000-0000-0000-0000-000000000000' WHERE OperationTypeID IS NULL AND MacroID IS NULL

--SELECT *  FROM #tmpStyleBolItems ORDER BY Sort, Sort1, Sort2


-----------------------------
----- CALC TOTAL ------------

CREATE TABLE #tmpExceptions(ROW int identity, ExceptionID uniqueidentifier, ExceptionName nvarchar(200) collate database_default)

INSERT #tmpExceptions (ExceptionID, ExceptionName)
SELECT ExceptionID, ExceptionName FROM pStyleNBOLException WHERE ExceptionID = '00000000-0000-0000-0000-000000000000'
INSERT #tmpExceptions (ExceptionID, ExceptionName)
SELECT ExceptionID, ExceptionName FROM pStyleNBOLException WHERE StyleID = @StyleId AND StyleSet = @StyleSet AND WorkflowID = @WorkflowId AND WorkflowItemID = @WorkflowItemId
ORDER BY Sort

DECLARE @iCountExceptions int
DECLARE @iCountOpTypes int 
DECLARE @iROW int
DECLARE @jROW int

DECLARE @Rate decimal(18,4)
SELECT @Rate = Rate FROM sExchangeRateItem WHERE ExchangeRateItemID = @ExchangeRateItemId
IF @Rate IS NULL SET @Rate = 1.00


DECLARE @strSQL nvarchar(MAX)

CREATE TABLE #pTotal
(	
	ROW int identity, 
	OperationTypeID uniqueidentifier, 
	OperationTypeName nvarchar(200) collate database_default,
	IsCalculated INT DEFAULT 0,
	IsOther INT DEFAULT 0
)

SET @iROW = 1
SET @iCountExceptions = (SELECT COUNT(*) FROM #tmpExceptions)

WHILE @iROW <= @iCountExceptions
BEGIN

	SET @strSQL = 'ALTER TABLE #pTotal ADD Total_' + CAST(@iROW as nvarchar(5)) + ' decimal(18,2) NULL'
	EXEC (@strSQL)
	SET @strSQL = 'ALTER TABLE #pTotal ADD TotalRate_' + CAST(@iROW as nvarchar(5)) + ' decimal(18,2) NULL'
	EXEC (@strSQL)
	--SET @strSQL = 'ALTER TABLE #pTotal ADD TotalExchangeRate_' + CAST(@iROW as nvarchar(5)) + ' decimal(18,2) NULL'
	--EXEC (@strSQL)
	SET @iROW = @iROW + 1

END


INSERT INTO #pTotal(OperationTypeID, OperationTypeName)
SELECT DISTINCT #tmpStyleBolItems.OperationTypeID, pNBOLOperationType.Name 
	FROM #tmpStyleBolItems INNER JOIN pNBOLOperationType ON #tmpStyleBolItems.OperationTypeID = pNBOLOperationType.OperationTypeID
WHERE MacroID IS NULL

INSERT INTO #pTotal(OperationTypeID, OperationTypeName, IsOther)
VALUES ('00000000-0000-0000-0000-000000000000', 'Other', 1)
INSERT INTO #pTotal(OperationTypeID, OperationTypeName, IsCalculated)
VALUES ('00000000-0000-0000-0000-000000000001', 'Total', 1)


DECLARE @ExceptionId nvarchar(50)
DECLARE @OperationTypeId nvarchar(50)

SET @iCountOpTypes = ((SELECT COUNT(*) FROM #pTotal) - 1)

SET @iROW = 1
WHILE @iROW <= @iCountOpTypes
BEGIN

	SELECT @OperationTypeId = OperationTypeID FROM #pTotal WHERE ROW = @iROW
	
	SET @jROW = 1
	WHILE @jROW <= @iCountExceptions
	BEGIN

		SELECT @ExceptionId = ExceptionID FROM #tmpExceptions WHERE ROW = @jROW
		
		SET @strSQL =
'		UPDATE #pTotal SET Total_' + CAST(@jROW as nvarchar(5)) + ' = 
			(
				SELECT SUM(TotalTime) FROM #tmpStyleBolItems sbi
				WHERE #pTotal.OperationTypeID = sbi.OperationTypeID AND sbi.MacroID IS NULL
				AND sbi.StyleNBOLItemID NOT IN
					(
						SELECT StyleNBOLItemID FROM pStyleNBOLExceptionEntries
						WHERE ExceptionID = ''' + @ExceptionId + '''' +
					')
			)
		WHERE OperationTypeID = ''' + @OperationTypeId + ''''
		EXEC (@strSQL)

		SET @strSQL =
'		UPDATE #pTotal SET TotalRate_' + CAST(@jROW as nvarchar(5)) + ' = 
			(
				SELECT SUM(Total) FROM #tmpStyleBolItems sbi
				WHERE #pTotal.OperationTypeID = sbi.OperationTypeID AND sbi.MacroID IS NULL
				AND sbi.StyleNBOLItemID NOT IN
					(
						SELECT StyleNBOLItemID FROM pStyleNBOLExceptionEntries
						WHERE ExceptionID = ''' + @ExceptionId + '''' +
					')
			)
		WHERE OperationTypeID = ''' + @OperationTypeId + ''''
		EXEC (@strSQL)

	
		SET @jROW = @jROW + 1
	END	

	SET @iROW = @iROW + 1
END


--SET @jROW = 1
--WHILE @jROW <= @iCountExceptions
--BEGIN

--	SET @strSQL = 'UPDATE #pTotal SET TotalExchangeRate_' + CAST(@jROW as nvarchar(5)) + ' = ' +
--		'TotalRate_' + CAST(@jROW as nvarchar(5)) + ' * ' + CAST(@Rate as nvarchar(25))
--	EXEC (@strSQL)
	
--	SET @jROW = @jROW + 1
--END


SET @jROW = 1
WHILE @jROW <= @iCountExceptions
BEGIN

	SELECT @ExceptionId = ExceptionID FROM #tmpExceptions WHERE ROW = @jROW
	
	SET @strSQL =
'	UPDATE #pTotal SET Total_' + CAST(@jROW as nvarchar(5)) + ' =
		(
			SELECT SUM(Total_' + CAST(@jROW as nvarchar(5)) + ') FROM #pTotal WHERE OperationTypeID <> ''00000000-0000-0000-0000-000000000001''
		)
	WHERE OperationTypeID = ''00000000-0000-0000-0000-000000000001'''
	EXEC (@strSQL)

	SET @strSQL =
'	UPDATE #pTotal SET TotalRate_' + CAST(@jROW as nvarchar(5)) + ' =
		(
			SELECT SUM(TotalRate_' + CAST(@jROW as nvarchar(5)) + ') FROM #pTotal WHERE OperationTypeID <> ''00000000-0000-0000-0000-000000000001''
		)
	WHERE OperationTypeID = ''00000000-0000-0000-0000-000000000001'''
	EXEC (@strSQL)
	
--	SET @strSQL =
--'	UPDATE #pTotal SET TotalExchangeRate_' + CAST(@jROW as nvarchar(5)) + ' =
--		(
--			SELECT SUM(TotalExchangeRate_' + CAST(@jROW as nvarchar(5)) + ') FROM #pTotal WHERE OperationTypeID <> ''00000000-0000-0000-0000-000000000001''
--		)
--	WHERE OperationTypeID = ''00000000-0000-0000-0000-000000000001'''
--	EXEC (@strSQL)

	SET @jROW = @jROW + 1
END

SET @strSQL = 'SELECT OperationTypeID, OperationTypeName'
SET @jROW = 1
WHILE @jROW <= @iCountExceptions
BEGIN
	SELECT @ExceptionId = ExceptionID FROM #tmpExceptions WHERE ROW = @jROW
	SET @strSQL = @strSQL + ', Total_' + CAST(@jROW as nvarchar(5)) + ', TotalRate_' + CAST(@jROW as nvarchar(5)) 
	--+ ', TotalExchangeRate_' + CAST(@jROW as nvarchar(5))
	SET @jROW = @jROW + 1
END

SET @strSQL = @strSQL + ' FROM #pTotal ORDER BY IsCalculated ASC'

IF @SortOrder IS NOT NULL AND RTRIM(LTRIM(@SortOrder)) <> ''
BEGIN
	IF CHARINDEX('OperationTypeName', @SortOrder) > 0
		SET @SortOrder = 'IsOther ASC, ' + @SortOrder
	SET @strSQL = @strSQL + ', ' + @SortOrder
END

EXEC (@strSQL)

DROP TABLE #tmpStyleBolItems
DROP TABLE #tmpExceptions
DROP TABLE #pTotal

END


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07425', GetDate())
GO
