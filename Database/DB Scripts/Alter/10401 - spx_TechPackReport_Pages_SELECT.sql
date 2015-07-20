IF OBJECT_ID(N'[dbo].[spx_TechPackReport_Pages_SELECT]') IS NOT NULL
	DROP PROCEDURE [dbo].[spx_TechPackReport_Pages_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_TechPackReport_Pages_SELECT]
	@TechPackFolderId UNIQUEIDENTIFIER,
	@StyleId UNIQUEIDENTIFIER,
	@ReportPageBySet INT,
	@ReportTechpackID UNIQUEIDENTIFIER = NULL,
	@SeasonYearID UNIQUEIDENTIFIER = NULL
WITH EXECUTE AS CALLER
AS

BEGIN

	CREATE TABLE #tmpTechPackReportPages (  
		ReportTechPackPageID UNIQUEIDENTIFIER
		, ReportTechPackFolderID UNIQUEIDENTIFIER
		, ReportPageTypeID UNIQUEIDENTIFIER
		, ReportTemplateName NVARCHAR(200)
		, ReportPageName NVARCHAR(200)
		, ReportPageDescription NVARCHAR(4000)
		, ReportServerType NVARCHAR(5)
		, ReportFormName NVARCHAR(250)
		, ReportPageURL NVARCHAR(250)
		, ReportPKIField NVARCHAR(200)
		, ReportPageActive INT
		, ReportPageFormat NVARCHAR(5)
		, ReportPageSort NVARCHAR(4)
		, ReportMapID UNIQUEIDENTIFIER
		, StyleID UNIQUEIDENTIFIER
		, WorkFlowItemName NVARCHAR(100)
		, WorkFlowItemID UNIQUEIDENTIFIER
		, WorkflowItemTypeId UNIQUEIDENTIFIER
		, WorkflowID UNIQUEIDENTIFIER
		, MapID UNIQUEIDENTIFIER
	)

	INSERT INTO #tmpTechPackReportPages (
			ReportTechPackPageID
			, ReportTechPackFolderID
			, ReportPageTypeID
			, ReportTemplateName
			, ReportPageName
			, ReportPageDescription
			, ReportServerType
			, ReportFormName
			, ReportPageURL
			, ReportPKIField
			, ReportPageActive 
			, ReportPageFormat
			, ReportPageSort
			, ReportMapID
			, StyleID
			, WorkFlowItemName
			, WorkFlowItemID
			, WorkflowItemTypeId
			, WorkflowID
			, MapID
		)
	SELECT dbo.rReportTechPackPageItem.ReportTechPackPageID, dbo.rReportTechPackPageItem.ReportTechPackFolderID, dbo.rReportTechPackPageItem.ReportPageTypeID, 
		  dbo.rReportTechPackPageItem.ReportTemplateName, dbo.rReportTechPackPageItem.ReportPageName, dbo.rReportTechPackPageItem.ReportPageDescription, 
		  dbo.rReportTechPackPageItem.ReportServerType, dbo.rReportTechPackPageItem.ReportFormName, dbo.rReportTechPackPageItem.ReportPageURL, 
		  dbo.rReportTechPackPageItem.ReportPKIField, dbo.rReportTechPackPageItem.ReportPageActive, 
		  dbo.rReportTechPackPageItem.ReportPageFormat, dbo.rReportTechPackPageItem.ReportPageSort, dbo.rReportTechPackPageItem.ReportMapID, 
		  dbo.pWorkFlowItem.StyleID, dbo.pWorkFlowItem.WorkFlowItemName, dbo.pWorkFlowItem.WorkFlowItemID, dbo.pWorkflowItemType.WorkflowItemTypeId,
		  dbo.pWorkFlowItem.WorkflowID, dbo.rReportTechPackPageItem.WorkflowID AS MapID
	FROM  dbo.pWorkFlowItem INNER JOIN
		  dbo.pWorkflowItemType ON dbo.pWorkFlowItem.WorkflowItemTypeId = dbo.pWorkflowItemType.WorkflowItemTypeId RIGHT OUTER JOIN
		  dbo.rReportTechPackPageItem ON dbo.pWorkflowItemType.MapId = dbo.rReportTechPackPageItem.ReportMapID
	WHERE (dbo.pWorkFlowItem.StyleID = @StyleID) 
			AND (dbo.rReportTechPackPageItem.ReportTechPackFolderID = @TechPackFolderId)
			AND ReportPageActive = '1' AND ReportPageBySet = @ReportPageBySet
			AND (@ReportTechPackID IS NULL OR dbo.pWorkFlowItem.WorkFlowItemID IN (
					SELECT WorkFlowItemID FROM pTechPackWorkflowItem WHERE TechPackID = @ReportTechPackID
				)
			)	

	/* select linked workflowitems */
	INSERT INTO #tmpTechPackReportPages (
			ReportTechPackPageID
			, ReportTechPackFolderID
			, ReportPageTypeID
			, ReportTemplateName
			, ReportPageName
			, ReportPageDescription
			, ReportServerType
			, ReportFormName
			, ReportPageURL
			, ReportPKIField
			, ReportPageActive 
			, ReportPageFormat
			, ReportPageSort
			, ReportMapID
			, StyleID
			, WorkFlowItemName
			, WorkFlowItemID
			, WorkflowItemTypeId
			, WorkflowID
			, MapID
		)
	SELECT dbo.rReportTechPackPageItem.ReportTechPackPageID, dbo.rReportTechPackPageItem.ReportTechPackFolderID, dbo.rReportTechPackPageItem.ReportPageTypeID, 
		  dbo.rReportTechPackPageItem.ReportTemplateName, dbo.rReportTechPackPageItem.ReportPageName, dbo.rReportTechPackPageItem.ReportPageDescription, 
		  dbo.rReportTechPackPageItem.ReportServerType, dbo.rReportTechPackPageItem.ReportFormName, dbo.rReportTechPackPageItem.ReportPageURL, 
		  dbo.rReportTechPackPageItem.ReportPKIField, dbo.rReportTechPackPageItem.ReportPageActive, 
		  dbo.rReportTechPackPageItem.ReportPageFormat, dbo.rReportTechPackPageItem.ReportPageSort, dbo.rReportTechPackPageItem.ReportMapID, 
		  dbo.pWorkFlowItem.StyleID, dbo.pWorkFlowItem.WorkFlowItemName, dbo.pWorkFlowItem.WorkFlowItemID, dbo.pWorkflowItemType.WorkflowItemTypeId,
		  dbo.pWorkFlowItem.WorkflowID, dbo.rReportTechPackPageItem.WorkflowID AS MapID
	FROM  dbo.pWorkFlowItem INNER JOIN
		  dbo.pWorkFlowItemLinked ON dbo.pWorkFlowItem.WorkFlowItemID = dbo.pWorkFlowItemLinked.WorkFlowItemID INNER JOIN
		  dbo.pWorkflowItemType ON dbo.pWorkFlowItem.WorkflowItemTypeId = dbo.pWorkflowItemType.WorkflowItemTypeId RIGHT OUTER JOIN
		  dbo.rReportTechPackPageItem ON dbo.pWorkflowItemType.MapId = dbo.rReportTechPackPageItem.ReportMapID
	WHERE (dbo.pWorkFlowItemLinked.StyleID = @StyleID) 
			AND (dbo.rReportTechPackPageItem.ReportTechPackFolderID = @TechPackFolderId)
			AND ReportPageActive = '1' AND ReportPageBySet = @ReportPageBySet
			AND (@ReportTechPackID IS NULL OR dbo.pWorkFlowItem.WorkFlowItemID IN (
					SELECT WorkFlowItemID FROM pTechPackWorkflowItem WHERE TechPackID = @ReportTechPackID
				)
			)	 	

	INSERT INTO #tmpTechPackReportPages (
			ReportTechPackPageID
			, ReportTechPackFolderID
			, ReportPageTypeID
			, ReportTemplateName
			, ReportPageName
			, ReportPageDescription
			, ReportServerType
			, ReportFormName
			, ReportPageURL
			, ReportPKIField
			, ReportPageActive 
			, ReportPageFormat
			, ReportPageSort
			, ReportMapID
			, StyleID
			, WorkFlowItemName
			, WorkFlowItemID
			, WorkflowItemTypeId
			, WorkflowID
			, MapID
		)     
	SELECT ReportTechPackPageID, ReportTechPackFolderID, ReportPageTypeID, ReportTemplateName, ReportPageName, ReportPageDescription, ReportServerType, 
		 ReportFormName, ReportPageURL, ReportPKIField, ReportPageActive, ReportPageFormat, ReportPageSort, ReportMapID,
		 NULL AS StyleID, NULL AS WorkflowItemName, ReportTechPackPageID AS WorkflowItemID, NULL AS WorkflowItemTypeID,
		 ReportTechPackPageID AS WorkflowItemID, WorkflowID AS MapID
	FROM  dbo.rReportTechPackPageItem
	WHERE (ReportTechPackFolderID = @TechPackFolderId) AND ReportMapID IS NULL
			AND ReportPageActive = '1' AND ReportPageBySet = @ReportPageBySet

	--** Remove Text-Image, Design Detail and Artwork reports from the TechPack if there is no any data.

	--** Text-Image / 40000000-0000-0000-0000-000000000018
	IF EXISTS (SELECT * FROM #tmpTechPackReportPages WHERE MapID = '40000000-0000-0000-0000-000000000018')
	BEGIN
		DELETE FROM #tmpTechPackReportPages
		WHERE WorkflowItemID NOT IN (
			SELECT DISTINCT pStyleDetailForm.WorkflowItemID
			FROM pStyleDetailForm 
				INNER JOIN #tmpTechPackReportPages ON pStyleDetailForm.WorkflowItemID = #tmpTechPackReportPages.WorkflowItemID
				INNER JOIN hImage ON pStyleDetailForm.ImageID = hImage.ImageID AND pStyleDetailForm.ImageVersion = hImage.[Version]
			WHERE #tmpTechPackReportPages.MapID = '40000000-0000-0000-0000-000000000018'
		) AND #tmpTechPackReportPages.MapID = '40000000-0000-0000-0000-000000000018'
	END

	--** Design Detail / 40000000-0000-0000-0000-000000000006
	IF EXISTS (SELECT * FROM #tmpTechPackReportPages WHERE MapID = '40000000-0000-0000-0000-000000000006')
	BEGIN
		IF NOT EXISTS (
			SELECT *
			FROM pStyleImageItem 
				INNER JOIN #tmpTechPackReportPages ON pStyleImageItem.WorkflowID = #tmpTechPackReportPages.MapID
				INNER JOIN hImage ON (pStyleImageItem.ImageID = hImage.ImageID) AND (pStyleImageItem.ImageVersion = hImage.[Version])
			WHERE pStyleImageItem.StyleID = @StyleID AND #tmpTechPackReportPages.MapID = '40000000-0000-0000-0000-000000000006'
		) DELETE FROM #tmpTechPackReportPages WHERE MapID = '40000000-0000-0000-0000-000000000006'
	END

	--** Artwork / 40000000-0000-0000-0000-000000000010
	--** If selected DBOMs don't have Artwork images
	IF EXISTS (SELECT * FROM #tmpTechPackReportPages WHERE MapID = '40000000-0000-0000-0000-000000000010') AND 
		EXISTS (SELECT * FROM #tmpTechPackReportPages WHERE MapID = '40000000-0000-0000-0000-000000000080')
	BEGIN
		IF NOT EXISTS (
			SELECT * FROM pStyleBOM
				INNER JOIN #tmpTechPackReportPages ON pStyleBOM.WorkflowItemID = #tmpTechPackReportPages.WorkflowItemID
				INNER JOIN hImage ON (pStyleBOM.MaterialImageID = hImage.ImageID) AND (pStyleBOM.MaterialImageVersion = hImage.[Version])
			WHERE pStyleBOM.StyleID = @StyleID AND pStyleBOM.Artwork = 1 AND #tmpTechPackReportPages.MapID = '40000000-0000-0000-0000-000000000080'
		) DELETE FROM #tmpTechPackReportPages WHERE MapID = '40000000-0000-0000-0000-000000000010'
	END
	--** If no DBOMs were selected, check for all DBOMs
	ELSE IF EXISTS (SELECT * FROM #tmpTechPackReportPages WHERE MapID = '40000000-0000-0000-0000-000000000010') AND 
		NOT EXISTS (SELECT * FROM #tmpTechPackReportPages WHERE MapID = '40000000-0000-0000-0000-000000000080')
	BEGIN
		IF NOT EXISTS (
			SELECT * FROM pStyleBOM
				INNER JOIN pWorkFlowItem ON pStyleBOM.WorkflowItemId = pWorkFlowItem.WorkFlowItemID
				INNER JOIN pStyleSeasonYear ON pWorkFlowItem.StyleSeasonYearID = pStyleSeasonYear.StyleSeasonYearID
				INNER JOIN hImage ON (pStyleBOM.MaterialImageID = hImage.ImageID) AND (pStyleBOM.MaterialImageVersion = hImage.[Version])
			WHERE pStyleBOM.StyleID = @StyleID AND pStyleBOM.Artwork = 1 AND pStyleSeasonYear.SeasonYearID = @SeasonYearID
		) DELETE FROM #tmpTechPackReportPages WHERE MapID = '40000000-0000-0000-0000-000000000010'
	END

	SELECT * FROM #tmpTechPackReportPages ORDER BY ReportPageSort
	DROP TABLE #tmpTechPackReportPages

END
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '10401', GetUTCDate())
GO