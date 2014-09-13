IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[rpx_Style_NBOLSummary_Total_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[rpx_Style_NBOLSummary_Total_SELECT]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




CREATE PROCEDURE [dbo].[rpx_Style_NBOLSummary_Total_SELECT] 
(
	@StyleId uniqueidentifier,
	@StyleSet int,
	@WorkflowItemId uniqueidentifier
)
AS

DECLARE @WorkflowId uniqueidentifier
SELECT @WorkflowId = WorkflowID FROM pWorkFlowItem WHERE WorkFlowItemID = @WorkflowItemId

DECLARE	@ExceptionId_Standard as nvarchar (50) = '00000000-0000-0000-0000-000000000000' -- Standard BOL Page (not exception)

BEGIN


CREATE TABLE #tmpStyleBolItems
(
	[StyleNBOLItemID] [uniqueidentifier] NOT NULL,
	[StyleID] [uniqueidentifier] NULL,
	[StyleSet] [int] NULL,
	[ExceptionID] [uniqueidentifier] NULL,
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

CREATE TABLE #tmp_Total(
	ExceptionId uniqueidentifier NULL,
	OperationTypeID uniqueidentifier NULL,
	OperationTypeName nvarchar(200) NULL,
	Totaltime decimal(18,2) NULL,
	Total_Rate decimal(18,2) NULL,
	Sort int NOT NULL
)

--================================================================
-- add list of Standart BOL operations
INSERT INTO #tmpStyleBolItems(
		StyleNBOLItemID, StyleID, StyleSet, ExceptionID,
		TemplateItemID, MacroID, OperationID, IsLinked, ImageID, ImageType,
		Code, Name, MachineID, OperationTypeID, BaseRate, SAM, ParentID,
		Sort, Sort1, Sort2, Coef, Adj, Comments)

SELECT sbi.StyleNBOLItemID, sbi.StyleID, sbi.StyleSet, @ExceptionId_Standard,
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
	AND sbi.MacroID IS NULL
	AND sbi.StyleID = @StyleId AND sbi.StyleSet = @StyleSet AND sbi.WorkFlowID = @WorkflowId AND sbi.WorkFlowItemID = @WorkflowItemId
	AND sbi.StyleNBOLItemID NOT IN (SELECT StyleNBOLItemID FROM pStyleNBOLExceptionEntries WHERE ExceptionID = @ExceptionId_Standard)

UNION

SELECT sbi.StyleNBOLItemID, sbi.StyleID, sbi.StyleSet, @ExceptionId_Standard,
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
	AND sbi.MacroID IS NULL
	AND sbi.StyleID = @StyleId AND sbi.StyleSet = @StyleSet AND sbi.WorkFlowID = @WorkflowId AND sbi.WorkFlowItemID = @WorkflowItemId
	AND sbi.StyleNBOLItemID NOT IN (SELECT StyleNBOLItemID FROM pStyleNBOLExceptionEntries WHERE ExceptionID = @ExceptionId_Standard)


--================================================================
-- add lists of operations of BOL Exceptions
INSERT INTO #tmpStyleBolItems(
		StyleNBOLItemID, StyleID, StyleSet, ExceptionID,
		TemplateItemID, MacroID, OperationID, IsLinked, ImageID, ImageType,
		Code, Name, MachineID, OperationTypeID, BaseRate, SAM, ParentID,
		Sort, Sort1, Sort2, Coef, Adj, Comments)

SELECT sbi.StyleNBOLItemID, sbi.StyleID, sbi.StyleSet, e.ExceptionID,
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
	LEFT JOIN pStyleNBOLException e ON sbi.StyleID = e.StyleID AND sbi.StyleSet = e.StyleSet AND sbi.WorkFlowItemID = e.WorkflowItemID
WHERE sbi.IsLinked = 1 
	AND sbi.MacroID IS NULL
	AND sbi.StyleID = @StyleId AND sbi.StyleSet = @StyleSet AND sbi.WorkFlowID = @WorkflowId AND sbi.WorkFlowItemID = @WorkflowItemId
	AND sbi.StyleNBOLItemID NOT IN (SELECT StyleNBOLItemID FROM pStyleNBOLExceptionEntries WHERE ExceptionID = e.ExceptionID)

UNION

SELECT sbi.StyleNBOLItemID, sbi.StyleID, sbi.StyleSet, e.ExceptionID,
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
	LEFT JOIN pStyleNBOLException e ON sbi.StyleID = e.StyleID AND sbi.StyleSet = e.StyleSet AND sbi.WorkFlowItemID = e.WorkflowItemID
WHERE (sbi.IsLinked = 0 OR sbi.IsLinked = -1)
	AND sbi.MacroID IS NULL
	AND sbi.StyleID = @StyleId AND sbi.StyleSet = @StyleSet AND sbi.WorkFlowID = @WorkflowId AND sbi.WorkFlowItemID = @WorkflowItemId
	AND sbi.StyleNBOLItemID NOT IN (SELECT StyleNBOLItemID FROM pStyleNBOLExceptionEntries WHERE ExceptionID = e.ExceptionID)



-- calc totals by row
UPDATE #tmpStyleBolItems
SET TotalTime = SAM * ISNULL(Coef,1) + (SAM * ISNULL(Coef,1)) * ISNULL(Adj,0) / 100
WHERE MacroID IS NULL

UPDATE #tmpStyleBolItems
SET Total = TotalTime * BaseRate

UPDATE #tmpStyleBolItems SET OperationTypeID = '00000000-0000-0000-0000-000000000000' WHERE OperationTypeID IS NULL AND MacroID IS NULL

--SELECT *  FROM #tmpStyleBolItems ORDER BY ExceptionID, Sort, Sort1, Sort2


-- result table with SUM grouped by exceptions
INSERT INTO #tmp_Total (ExceptionId, OperationTypeID, OperationTypeName, Totaltime, Total_Rate, Sort)
	SELECT ExceptionID, #tmpStyleBolItems.OperationTypeID, 'Type ' + pNBOLOperationType.Name, SUM(TotalTime), SUM(Total), 0
	FROM #tmpStyleBolItems LEFT JOIN
		pNBOLOperationType ON #tmpStyleBolItems.OperationTypeID = pNBOLOperationType.OperationTypeID
	GROUP BY ExceptionID, #tmpStyleBolItems.OperationTypeID, pNBOLOperationType.Name
--UNION
--	SELECT ExceptionID, '00000000-0000-0000-0000-000000000001', 'Total', SUM(TotalTime), SUM(Total), 2
--	FROM #tmpStyleBolItems
--	GROUP BY ExceptionID
	
UPDATE #tmp_Total SET Sort = 1, OperationTypeName = 'Other' WHERE OperationTypeID = '00000000-0000-0000-0000-000000000000'

SELECT e.ExceptionID, e.ExceptionName, OperationTypeID, OperationTypeName, Totaltime, Total_Rate, 
	#tmp_Total.Sort, e.Sort as ExceptionSort
FROM #tmp_Total INNER JOIN
	pStyleNBOLException e ON #tmp_Total.ExceptionId = e.ExceptionID
--ORDER BY e.Sort, #tmp_Total.Sort



DROP TABLE #tmpStyleBolItems
DROP TABLE #tmp_Total


END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '03605', GetDate())
GO