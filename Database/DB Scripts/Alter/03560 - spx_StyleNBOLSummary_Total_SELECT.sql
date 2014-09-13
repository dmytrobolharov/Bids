IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleNBOLSummary_Total_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleNBOLSummary_Total_SELECT]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[spx_StyleNBOLSummary_Total_SELECT] 
(
	@StyleId uniqueidentifier,
	@StyleSet int,
	@WorkflowId uniqueidentifier,
	@WorkflowItemId uniqueidentifier
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
	[Image] [nvarchar](200) NULL,
	[MachineID] [uniqueidentifier] NULL,
	[OperationTypeID] [uniqueidentifier] NULL,
	[BaseRate] [decimal](18, 2) NULL,
	[SAM] [decimal](18, 2) NULL,
	[Coef] [decimal](18, 2) NULL,
	[Adj] [decimal](18, 2) NULL,
	[TotalTime] [decimal](18, 2) NULL,
	[Total] [decimal](18, 2) NULL,
	[Comments] [nvarchar](800) NULL,
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

--SELECT *  FROM #tmpStyleBolItems ORDER BY Sort, Sort1, Sort2


-----------------------------
----- CALC TOTAL ------------

CREATE TABLE #tmpExceptions(ROW int identity, ExceptionID uniqueidentifier, ExceptionName nvarchar(200))

INSERT #tmpExceptions (ExceptionID, ExceptionName)
SELECT ExceptionID, ExceptionName FROM pStyleNBOLException WHERE ExceptionID = '00000000-0000-0000-0000-000000000000'
INSERT #tmpExceptions (ExceptionID, ExceptionName)
SELECT ExceptionID, ExceptionName FROM pStyleNBOLException WHERE StyleID = @StyleId AND StyleSet = @StyleSet AND WorkflowID = @WorkflowId AND WorkflowItemID = @WorkflowItemId
ORDER BY Sort

DECLARE @iCountExceptions int
DECLARE @iCountOpTypes int 
DECLARE @iROW int
DECLARE @jROW int

DECLARE @strSQL nvarchar(1000)

CREATE TABLE #pTotal
(	
	ROW int identity, 
	OperationTypeID uniqueidentifier, 
	OperationTypeName nvarchar(200)
)

SET @iROW = 1
SET @iCountExceptions = (SELECT COUNT(*) FROM #tmpExceptions)

WHILE @iROW <= @iCountExceptions
BEGIN

	SET @strSQL = 'ALTER TABLE #pTotal ADD Total_' + CAST(@iROW as nvarchar(5)) + ' decimal(18,2) NULL'
	EXEC (@strSQL)
	SET @strSQL = 'ALTER TABLE #pTotal ADD TotalRate_' + CAST(@iROW as nvarchar(5)) + ' decimal(18,2) NULL'
	EXEC (@strSQL)
	SET @iROW = @iROW + 1

END


INSERT INTO #pTotal(OperationTypeID, OperationTypeName)
SELECT DISTINCT #tmpStyleBolItems.OperationTypeID, pNBOLOperationType.Name 
	FROM #tmpStyleBolItems INNER JOIN pNBOLOperationType ON #tmpStyleBolItems.OperationTypeID = pNBOLOperationType.OperationTypeID
WHERE MacroID IS NULL

INSERT INTO #pTotal(OperationTypeID, OperationTypeName)
VALUES ('00000000-0000-0000-0000-000000000000', 'Other')
INSERT INTO #pTotal(OperationTypeID, OperationTypeName)
VALUES ('00000000-0000-0000-0000-000000000001', 'Total')


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

	SET @jROW = @jROW + 1
END

SET @strSQL = 'SELECT OperationTypeID, OperationTypeName'
SET @jROW = 1
WHILE @jROW <= @iCountExceptions
BEGIN
	SELECT @ExceptionId = ExceptionID FROM #tmpExceptions WHERE ROW = @jROW
	SET @strSQL = @strSQL + ', Total_' + CAST(@jROW as nvarchar(5)) + ', TotalRate_' + CAST(@jROW as nvarchar(5))
	SET @jROW = @jROW + 1
END
SET @strSQL = @strSQL + ' FROM #pTotal'

EXEC (@strSQL)

DROP TABLE #tmpStyleBolItems
DROP TABLE #tmpExceptions
DROP TABLE #pTotal

END

GO



INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '03560', GetDate())

GO 