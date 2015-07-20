IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Sample_WorkFlowItemList_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_Sample_WorkFlowItemList_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_Sample_WorkFlowItemList_SELECT] 
(
	@WorkflowId UNIQUEIDENTIFIER
	, @StyleID UNIQUEIDENTIFIER
	, @StyleSet INT
	, @ReportSampleRequestSubmitGroup NVARCHAR(5)
	, @SeasonYearID UNIQUEIDENTIFIER = NULL
)
AS 
BEGIN
	CREATE TABLE #Temp
	(
		Rec_Id INT IDENTITY(1, 1)
		, WorkFlowItemID UNIQUEIDENTIFIER
		, WorkflowID UNIQUEIDENTIFIER
		, WorkflowItemTypeId UNIQUEIDENTIFIER
		, ItemTypeLabel NVARCHAR(200)
		, StyleID UNIQUEIDENTIFIER
		, WorkFlowItemName NVARCHAR(200)
		, Sort NVARCHAR(4)
		, isLinked INT DEFAULT 0
		, CUser NVARCHAR(200)
		, CDate DATETIME
		, MUser NVARCHAR(200)
		, MDate DATETIME
	)

	DECLARE @IsSeasonal INT
	SELECT @IsSeasonal = IsSeasonal
	FROM Mapping
	WHERE Map = @WorkflowID
	
	DECLARE @StyleSeasonYearID UNIQUEIDENTIFIER
	SELECT TOP 1 @StyleSeasonYearID = StyleSeasonYearID
	FROM pStyleSeasonYear
	WHERE StyleID = @StyleID
		AND SeasonYearID = @SeasonYearID

	IF @WorkflowId = '00000000-0000-0000-0000-000000000000'
		INSERT INTO #Temp (WorkFlowItemID, WorkflowID, WorkflowItemTypeId, ItemTypeLabel, StyleID, WorkFlowItemName,
						   Sort, CUser, CDate, MUser, MDate) 
		SELECT ReportSampleRequestSubmitFolderID AS WorkFlowItemID
			, '00000000-0000-0000-0000-000000000000' AS WorkflowId
			, ReportSampleRequestSubmitFolderID AS WorkflowItemTypeId
			, ReportSampleRequestSubmitName AS ItemTypeLabel
			, @StyleID AS StyleID
			, ReportSampleRequestSubmitName AS WorkFlowItemName
			, ReportSampleRequestSubmitSort AS Sort
			, CUser, CDate, MUser, MDate
		FROM rReportSampleRequestSubmitFolder
		WHERE ReportSampleRequestSubmitGroup = @ReportSampleRequestSubmitGroup AND Active = 1
		ORDER BY ReportSampleRequestSubmitSort
	ELSE
		INSERT INTO #Temp (WorkFlowItemID, WorkflowID, WorkflowItemTypeId, ItemTypeLabel, StyleID, WorkFlowItemName,
						   Sort, CUser, CDate, MUser, MDate) 
		SELECT pWorkFlowItem.WorkFlowItemID
			, pWorkFlowItem.WorkflowID
			, pWorkFlowItem.WorkflowItemTypeId
			, pWorkFlowItemType.ItemTypeLabel
			, pWorkFlowItem.StyleID
			, pWorkFlowItem.WorkFlowItemName
			, pWorkFlowItem.Sort
			, pWorkFlowItem.CUser
			, pWorkFlowItem.CDate
			, pWorkFlowItem.MUser
			, pWorkFlowItem.MDate
		FROM pWorkFlowItem
			INNER JOIN pWorkFlowItemType ON pWorkFlowItemType.WorkflowItemTypeId = pWorkFlowItem.WorkflowItemTypeId
		WHERE pWorkFlowItem.StyleID = @StyleID
			AND pWorkFlowItem.StyleSet = @StyleSet
			AND pWorkFlowItem.WorkflowId = @WorkflowId
			AND (@IsSeasonal = 1 AND pWorkFlowItem.StyleSeasonYearID = @StyleSeasonYearID OR @IsSeasonal = 0)
		ORDER BY pWorkFlowItem.Sort

		INSERT INTO #Temp (WorkFlowItemID, WorkflowID, WorkflowItemTypeId, ItemTypeLabel, StyleID, WorkFlowItemName,
						   Sort, isLinked, CUser, CDate, MUser, MDate) 
		SELECT pWorkFlowItem.WorkFlowItemID
			, pWorkFlowItem.WorkflowID
			, pWorkFlowItem.WorkflowItemTypeId
			, pWorkFlowItemType.ItemTypeLabel
			, pWorkFlowItem.StyleID
			, pWorkFlowItem.WorkFlowItemName + '&nbsp;<img align="absMiddle" src="../System/Icons/icon_link.gif" border="0"/>' AS WorkFlowItemName
			, pWorkFlowItem.Sort
			, 1 AS isLinked
			, pWorkFlowItem.CUser
			, pWorkFlowItem.CDate
			, pWorkFlowItem.MUser
			, pWorkFlowItem.MDate
		FROM pWorkFlowItemLinked
			INNER JOIN pWorkFlowItem ON pWorkFlowItemLinked.WorkFlowItemID = pWorkFlowItem.WorkFlowItemID
			INNER JOIN pWorkFlowItemType ON pWorkFlowItemType.WorkflowItemTypeId = pWorkFlowItem.WorkflowItemTypeId
		WHERE pWorkFlowItemLinked.StyleID = @StyleID
			AND pWorkFlowItemLinked.StyleSet = @StyleSet
			AND pWorkFlowItem.WorkflowId = @WorkflowId
			AND (@IsSeasonal = 1 AND pWorkFlowItem.StyleSeasonYearID = @StyleSeasonYearID OR @IsSeasonal = 0)
		ORDER BY pWorkFlowItem.Sort


	 SELECT * FROM #Temp ORDER BY isLinked, Sort
	 DROP TABLE #Temp 
END
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '10426', GetUTCDate())
GO
