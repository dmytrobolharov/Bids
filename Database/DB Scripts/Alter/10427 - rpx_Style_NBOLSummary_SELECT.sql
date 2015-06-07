IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[rpx_Style_NBOLSummary_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[rpx_Style_NBOLSummary_SELECT]
GO

CREATE PROCEDURE [dbo].[rpx_Style_NBOLSummary_SELECT] 
(
	@WorkflowItemId UNIQUEIDENTIFIER
	, @StyleID UNIQUEIDENTIFIER = NULL
	, @StyleSet INT = NULL
)
AS

BEGIN

	CREATE TABLE #tmpStyleBolItems
	(
		StyleNBOLItemID UNIQUEIDENTIFIER NOT NULL
		, StyleID UNIQUEIDENTIFIER NULL
		, StyleSet INT NULL
		, Sort NVARCHAR(5) NULL
		, Sort1 NVARCHAR(50) NULL
		, Sort2 NVARCHAR(5) NULL
		, IsLinked INT NULL
		, TemplateItemID UNIQUEIDENTIFIER NULL
		, OperationID UNIQUEIDENTIFIER NULL
		, MacroID UNIQUEIDENTIFIER NULL
		, ParentID UNIQUEIDENTIFIER NULL
		, Code NVARCHAR(200) NULL
		, NAME NVARCHAR(200) NULL
		, ImageID UNIQUEIDENTIFIER NULL
		, ImageType NVARCHAR(10) NULL
		, ImagePath NVARCHAR(800) NULL
		, MachineID UNIQUEIDENTIFIER NULL
		, OperationTypeID UNIQUEIDENTIFIER NULL
		, BaseRate DECIMAL(18, 2) NULL
		, SAM DECIMAL(18, 2) NULL
		, Coef DECIMAL(18, 2) NULL
		, Adj DECIMAL(18, 2) NULL
		, TotalTime DECIMAL(18, 2) NULL
		, Total DECIMAL(18, 2) NULL
		, Comments NVARCHAR(800) NULL
		, Exceptions NVARCHAR(800) NULL
		, CUser NVARCHAR(200) NULL
		, CDate DATETIME NULL
		, MUser NVARCHAR(200) NULL
		, MDate DATETIME NULL
	)

	INSERT INTO #tmpStyleBolItems(
			StyleNBOLItemID, StyleID, StyleSet, 
			TemplateItemID, MacroID, OperationID, IsLinked, ImageID, ImageType,
			Code, Name, MachineID, OperationTypeID, BaseRate, SAM, ParentID,
			Sort, Sort1, Sort2, Coef, Adj, Comments)

	SELECT sbi.StyleNBOLItemID, sbi.StyleID, sbi.StyleSet,
			ti.TemplateItemID, ti.MacroID, ti.OperationID, sbi.IsLinked,
			CASE WHEN sbi.MacroID IS NULL THEN o.ImageID ELSE m.ImageID END as ImageID,
			CASE
				WHEN sbi.MacroID IS NOT NULL THEN 'BOLMOP'
				WHEN sbi.OperationID IS NOT NULL THEN 'BOLOP'
			END AS ImageType,
			ti.Code, ti.Name, ti.MachineID, ti.OperationTypeID, 
			sbi.BaseRate, sbi.SAM, ti.ParentID,
			sbi.Sort, CASE
				WHEN sbi.MacroID IS NOT NULL THEN sbi.TemplateItemID
				WHEN sbi.OperationID IS NOT NULL THEN sbi.ParentID
			END Sort1,
			sbi.Sort2, sbi.Coef, sbi.Adj, sbi.Comments
	FROM pStyleNBOLItems sbi
		LEFT JOIN pNBOLTemplateItem ti ON sbi.TemplateItemID = ti.TemplateItemID
		LEFT JOIN dbo.pNBOLOperation o ON o.OperationID = ti.OperationID
		LEFT JOIN dbo.pNBOLMacro m ON m.MacroID = ti.MacroID
	WHERE sbi.IsLinked = 1 
		AND sbi.WorkFlowItemID = @WorkflowItemId

	UNION

	SELECT sbi.StyleNBOLItemID, sbi.StyleID, sbi.StyleSet,
			sbi.TemplateItemID, sbi.MacroID, sbi.OperationID, sbi.IsLinked,
			CASE WHEN sbi.MacroID IS NULL THEN o.ImageID ELSE m.ImageID END as ImageID,
			CASE
				WHEN sbi.MacroID IS NOT NULL THEN 'BOLMOP'
				WHEN sbi.OperationID IS NOT NULL THEN 'BOLOP'
			END AS ImageType,
			sbi.Code, sbi.Name, sbi.MachineID, sbi.OperationTypeID, sbi.BaseRate, sbi.SAM, sbi.ParentID,
			sbi.Sort, CASE
				WHEN sbi.MacroID IS NOT NULL THEN sbi.TemplateItemID
				WHEN sbi.OperationID IS NOT NULL THEN sbi.ParentID
			END AS Sort1,
			sbi.Sort2, sbi.Coef, sbi.Adj, sbi.Comments
	FROM pStyleNBOLItems sbi
		LEFT JOIN dbo.pNBOLOperation o ON o.OperationID = sbi.OperationID
		LEFT JOIN dbo.pNBOLMacro m ON m.MacroID = sbi.MacroID
	WHERE (sbi.IsLinked = 0 OR sbi.IsLinked = -1)
		AND sbi.WorkFlowItemID = @WorkflowItemId

	ORDER BY Sort, Sort1, Sort2

	-- for images in report
	UPDATE #tmpStyleBolItems
	SET [ImagePath] = dbo.fnx_GetStreamingImageBOLImagePath(ImageType, '200', CAST(ISNULL(ImageID, '00000000-0000-0000-0000-000000000000') AS NVARCHAR(50)))

	-- calc Total time
	UPDATE #tmpStyleBolItems
	SET TotalTime = SAM * ISNULL(Coef,1) + (SAM * ISNULL(Coef,1)) * ISNULL(Adj,0) / 100
	WHERE MacroID IS NULL

	-- calc total (time * rate)
	UPDATE #tmpStyleBolItems
	SET Total = TotalTime * BaseRate

	-- calc totals for macro
	UPDATE #tmpStyleBolItems
	SET TotalTime = (SELECT SUM(TotalTime) FROM #tmpStyleBolItems t1 WHERE #tmpStyleBolItems.TemplateItemID = t1.ParentID),
		Total = (SELECT SUM(Total) FROM #tmpStyleBolItems t1 WHERE #tmpStyleBolItems.TemplateItemID = t1.ParentID),
		SAM = (SELECT SUM(SAM) FROM #tmpStyleBolItems t1 WHERE #tmpStyleBolItems.TemplateItemID = t1.ParentID)
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
VALUES ('DB_Version', '6.1.0000', '10427', GetUTCDate())
GO
