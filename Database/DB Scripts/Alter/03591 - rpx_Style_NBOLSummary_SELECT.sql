IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[rpx_Style_NBOLSummary_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[rpx_Style_NBOLSummary_SELECT]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[rpx_Style_NBOLSummary_SELECT] 
(
	@StyleId uniqueidentifier,
	@StyleSet int,
	@WorkflowItemId uniqueidentifier
)
AS
DECLARE @WorkflowId uniqueidentifier
SELECT @WorkflowId = WorkflowID FROM pWorkFlowItem WHERE WorkFlowItemID = @WorkflowItemId

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
	[ImagePath] [nvarchar](800) NULL,
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

-- linked to template items (IsLinked = 1)
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
-- unlinked (IsLinked = -1) or added by user on Style page (IsLinked = 0)
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

-- for images in report
UPDATE #tmpStyleBolItems
SET [ImagePath] = @ImageServer + '/ImageStream.ashx?IT=' + ImageType + '&S=200&ID=' + CAST(ISNULL(ImageID, '00000000-0000-0000-0000-000000000000') AS NVARCHAR(50))

-- calc Total time
UPDATE #tmpStyleBolItems
SET TotalTime = SAM * ISNULL(Coef,1) + (SAM * ISNULL(Coef,1)) * ISNULL(Adj,0) / 100
WHERE MacroID IS NULL

-- calc total (time * rate)
UPDATE #tmpStyleBolItems
SET Total = TotalTime * BaseRate

-- calc totals for macro
UPDATE #tmpStyleBolItems
SET TotalTime = (SELECT SUM(TotalTime) FROM #tmpStyleBolItems t1 WHERE #tmpStyleBolItems.TemplateItemID = t1.ParentID)
WHERE #tmpStyleBolItems.MacroID IS NOT NULL

UPDATE #tmpStyleBolItems
SET Total = (SELECT SUM(Total) FROM #tmpStyleBolItems t1 WHERE #tmpStyleBolItems.TemplateItemID = t1.ParentID)
WHERE #tmpStyleBolItems.MacroID IS NOT NULL

UPDATE #tmpStyleBolItems SET OperationTypeID = '00000000-0000-0000-0000-000000000000' WHERE OperationTypeID IS NULL AND MacroID IS NULL

-- get string of exception for every operation separated by ","
UPDATE #tmpStyleBolItems 
SET Exceptions = (SELECT dbo.fnx_StyleNBOL_GetExceptionEntriesString (StyleNBOLItemID, @WorkflowItemId))
WHERE MacroID IS NULL


-- select result
SELECT sbi.StyleNBOLItemID, sbi.Code, sbi.Name, m.MachineName, ot.Name as OperationTypeName, 
	sbi.MacroID, sbi.ParentID, sbi.ImagePath,
	sbi.BaseRate, sbi.SAM, sbi.Coef, sbi.Adj, sbi.TotalTime, sbi.Total, sbi.Exceptions
FROM #tmpStyleBolItems sbi LEFT JOIN
	pNBOLMachinery m ON sbi.MachineID = m.MachineID LEFT JOIN
	pNBOLOperationType ot ON sbi.OperationTypeID = ot.OperationTypeID
ORDER BY Sort, Sort1, Sort2


DROP TABLE #tmpStyleBolItems

END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '03591', GetDate())
GO