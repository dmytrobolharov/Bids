IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleCosting_NBOL_UPDATE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleCosting_NBOL_UPDATE]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[spx_StyleCosting_NBOL_UPDATE] 
(
	@StyleCostingId uniqueidentifier,
	@StyleId uniqueidentifier,
	@StyleSet int,
	@WorkflowId uniqueidentifier,
	@WorkflowItemId uniqueidentifier
)
AS

BEGIN

CREATE TABLE #tmpStyleBolItems
(
	[ExceptionId] uniqueidentifier NULL,
	[ExceptionName] [nvarchar](200) collate database_default NULL,
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

INSERT INTO #tmpStyleBolItems(ExceptionId, ExceptionName,
		StyleNBOLItemID, StyleID, StyleSet,
		TemplateItemID, MacroID, OperationID, IsLinked, ImageID, ImageType,
		Code, Name, MachineID, OperationTypeID, BaseRate, SAM, ParentID,
		Sort, Sort1, Sort2, Coef, Adj, Comments)

SELECT '00000000-0000-0000-0000-000000000000', 'Standard',
		sbi.StyleNBOLItemID, sbi.StyleID, sbi.StyleSet,
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
	AND sbi.StyleNBOLItemID NOT IN (SELECT StyleNBOLItemID FROM pStyleNBOLExceptionEntries WHERE ExceptionId = '00000000-0000-0000-0000-000000000000')

UNION

SELECT '00000000-0000-0000-0000-000000000000', 'Standard',
		sbi.StyleNBOLItemID, sbi.StyleID, sbi.StyleSet,
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
	AND sbi.StyleNBOLItemID NOT IN (SELECT StyleNBOLItemID FROM pStyleNBOLExceptionEntries WHERE ExceptionId = '00000000-0000-0000-0000-000000000000')

------------------------------------
----  if calculation average cost by all exceptions is required
----  it should be uncommented
----  
----  now it takes only standard list of operation

--UNION

--SELECT e.ExceptionID, e.ExceptionName,
--		sbi.StyleNBOLItemID, sbi.StyleID, sbi.StyleSet,
--		ti.TemplateItemID, ti.MacroID, ti.OperationID, sbi.IsLinked, ti.ImageID, 
--		ImageType = CASE
--			WHEN sbi.MacroID IS NOT NULL THEN 'BOLMOP'
--			WHEN sbi.OperationID IS NOT NULL THEN 'BOLOP'
--		END,
--		ti.Code, ti.Name, ti.MachineID, ti.OperationTypeID, 
--		sbi.BaseRate, sbi.SAM, ti.ParentID,
--		sbi.Sort, Sort1 = CASE
--			WHEN sbi.MacroID IS NOT NULL THEN sbi.TemplateItemID
--			WHEN sbi.OperationID IS NOT NULL THEN sbi.ParentID
--		END,
--		sbi.Sort2, sbi.Coef, sbi.Adj, sbi.Comments
--FROM pStyleNBOLItems sbi
--	LEFT JOIN pNBOLTemplateItem ti ON sbi.TemplateItemID = ti.TemplateItemID
--	INNER JOIN pStyleNBOLException e ON sbi.WorkFlowItemID = e.WorkflowItemID
--WHERE sbi.IsLinked = 1 
--	AND sbi.StyleID = @StyleId AND sbi.StyleSet = @StyleSet AND sbi.WorkFlowID = @WorkflowId AND sbi.WorkFlowItemID = @WorkflowItemId
--	AND sbi.StyleNBOLItemID NOT IN (SELECT StyleNBOLItemID FROM pStyleNBOLExceptionEntries WHERE ExceptionId = e.ExceptionId)


--UNION

--SELECT e.ExceptionID, e.ExceptionName,
--		sbi.StyleNBOLItemID, sbi.StyleID, sbi.StyleSet,
--		sbi.TemplateItemID, sbi.MacroID, sbi.OperationID, sbi.IsLinked, sbi.ImageID, 
--		ImageType = CASE
--			WHEN sbi.MacroID IS NOT NULL THEN 'BOLMOP'
--			WHEN sbi.OperationID IS NOT NULL THEN 'BOLOP'
--		END,
--		sbi.Code, sbi.Name, sbi.MachineID, sbi.OperationTypeID, sbi.BaseRate, sbi.SAM, sbi.ParentID,
--		sbi.Sort, Sort1 = CASE
--			WHEN sbi.MacroID IS NOT NULL THEN sbi.TemplateItemID
--			WHEN sbi.OperationID IS NOT NULL THEN sbi.ParentID
--		END,
--		sbi.Sort2, sbi.Coef, sbi.Adj, sbi.Comments
--FROM pStyleNBOLItems sbi
--	INNER JOIN pStyleNBOLException e ON sbi.WorkFlowItemID = e.WorkflowItemID
--WHERE (sbi.IsLinked = 0 OR sbi.IsLinked = -1)
--	AND sbi.StyleID = @StyleId AND sbi.StyleSet = @StyleSet AND sbi.WorkFlowID = @WorkflowId AND sbi.WorkFlowItemID = @WorkflowItemId
--	AND sbi.StyleNBOLItemID NOT IN (SELECT StyleNBOLItemID FROM pStyleNBOLExceptionEntries WHERE ExceptionId = e.ExceptionId)

ORDER BY Sort, Sort1, Sort2


UPDATE #tmpStyleBolItems
SET TotalTime = SAM * ISNULL(Coef,1) + (SAM * ISNULL(Coef,1)) * ISNULL(Adj,0) / 100
WHERE MacroID IS NULL

UPDATE #tmpStyleBolItems
SET Total = TotalTime * BaseRate

-- testing comment
--SELECT * FROM #tmpStyleBolItems ORDER BY ExceptionId, Sort, Sort1, Sort2

--select ExceptionId, SUM(Total) as ExceptionTotal from #tmpStyleBolItems
--	where macroid is null
--	group by ExceptionId



DECLARE @StyleNBOLHeaderID uniqueidentifier
SELECT @StyleNBOLHeaderID = StyleNBOLHeaderID FROM pStyleNBOLHeader WHERE WorkflowID = @WorkflowId AND WorkFlowItemID = @WorkflowItemId

DECLARE @BOLCosting AS DECIMAL (18,3)

SELECT @BOLCosting = AVG(TotalByException)
FROM
	(select ExceptionId, SUM(ISNULL(Total,0)) as TotalByException from #tmpStyleBolItems
	where macroid is null
	group by ExceptionId) TotalByExceptionTable

-- update data in costing table
UPDATE pStyleCosting 
SET StyleNBOLHeaderID = @StyleNBOLHeaderID,
	BOLCost = @BOLCosting
WHERE StyleCostingID = @StyleCostingId


DROP TABLE #tmpStyleBolItems

END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES			('DB_Version', '5.0.0000', '03850', GetDate())
GO
