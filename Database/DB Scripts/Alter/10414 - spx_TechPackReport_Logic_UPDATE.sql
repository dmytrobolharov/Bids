IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_TechPackReport_Logic_UPDATE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_TechPackReport_Logic_UPDATE]
GO

CREATE PROCEDURE [dbo].[spx_TechPackReport_Logic_UPDATE]
	@TechPackID UNIQUEIDENTIFIER
	,@StyleID UNIQUEIDENTIFIER
	,@SeasonYearID UNIQUEIDENTIFIER
AS

BEGIN

	--** Remove Text-Image, Design Detail and Artwork reports from the TechPack if there is no any data.

	--** Text-Image / 40000000-0000-0000-0000-000000000018
	IF EXISTS (SELECT * FROM rReportStylePageItemTemp WHERE MapID = '40000000-0000-0000-0000-000000000018' AND ReportTechpackID = @TechPackID)
	BEGIN
		DELETE FROM rReportStylePageItemTemp
		WHERE WorkflowItemID NOT IN (
			SELECT DISTINCT pStyleDetailForm.WorkflowItemID
			FROM pStyleDetailForm 
				INNER JOIN rReportStylePageItemTemp ON pStyleDetailForm.WorkflowItemID = rReportStylePageItemTemp.WorkflowItemID
				INNER JOIN hImage ON pStyleDetailForm.ImageID = hImage.ImageID AND pStyleDetailForm.ImageVersion = hImage.[Version]
			WHERE rReportStylePageItemTemp.MapID = '40000000-0000-0000-0000-000000000018' AND ReportTechpackID = @TechPackID
		) AND rReportStylePageItemTemp.MapID = '40000000-0000-0000-0000-000000000018' AND ReportTechpackID = @TechPackID
	END

	--** Design Detail / 40000000-0000-0000-0000-000000000006
	IF EXISTS (SELECT * FROM rReportStylePageItemTemp WHERE MapID = '40000000-0000-0000-0000-000000000006' AND ReportTechpackID = @TechPackID)
	BEGIN
		IF NOT EXISTS (
			SELECT *
			FROM pStyleImageItem 
				INNER JOIN rReportStylePageItemTemp ON pStyleImageItem.WorkflowID = rReportStylePageItemTemp.MapID
				INNER JOIN hImage ON (pStyleImageItem.ImageID = hImage.ImageID) AND (pStyleImageItem.ImageVersion = hImage.[Version])
			WHERE pStyleImageItem.StyleID = @StyleID AND rReportStylePageItemTemp.MapID = '40000000-0000-0000-0000-000000000006' AND ReportTechpackID = @TechPackID
		) DELETE FROM rReportStylePageItemTemp WHERE MapID = '40000000-0000-0000-0000-000000000006' AND ReportTechpackID = @TechPackID
	END

	--** Artwork / 40000000-0000-0000-0000-000000000010
	--** If selected DBOMs don't have Artwork images
	IF EXISTS (SELECT * FROM rReportStylePageItemTemp WHERE MapID = '40000000-0000-0000-0000-000000000010' AND ReportTechpackID = @TechPackID) AND 
		EXISTS (SELECT * FROM rReportStylePageItemTemp WHERE MapID = '40000000-0000-0000-0000-000000000080' AND ReportTechpackID = @TechPackID)
	BEGIN
		IF NOT EXISTS (
			SELECT * FROM pStyleBOM
				INNER JOIN rReportStylePageItemTemp ON pStyleBOM.WorkflowItemID = rReportStylePageItemTemp.WorkflowItemID
				INNER JOIN hImage ON (pStyleBOM.MaterialImageID = hImage.ImageID) AND (pStyleBOM.MaterialImageVersion = hImage.[Version])
			WHERE pStyleBOM.StyleID = @StyleID AND pStyleBOM.Artwork = 1 AND rReportStylePageItemTemp.MapID = '40000000-0000-0000-0000-000000000080' AND ReportTechpackID = @TechPackID
		) DELETE FROM rReportStylePageItemTemp WHERE MapID = '40000000-0000-0000-0000-000000000010' AND ReportTechpackID = @TechPackID
	END
	--** If no DBOMs were selected, check for all DBOMs
	ELSE IF EXISTS (SELECT * FROM rReportStylePageItemTemp WHERE MapID = '40000000-0000-0000-0000-000000000010' AND ReportTechpackID = @TechPackID) AND 
		NOT EXISTS (SELECT * FROM rReportStylePageItemTemp WHERE MapID = '40000000-0000-0000-0000-000000000080' AND ReportTechpackID = @TechPackID)
	BEGIN
		IF NOT EXISTS (
			SELECT * FROM pStyleBOM
				INNER JOIN pWorkFlowItem ON pStyleBOM.WorkflowItemId = pWorkFlowItem.WorkFlowItemID
				INNER JOIN pStyleSeasonYear ON pWorkFlowItem.StyleSeasonYearID = pStyleSeasonYear.StyleSeasonYearID
				INNER JOIN hImage ON (pStyleBOM.MaterialImageID = hImage.ImageID) AND (pStyleBOM.MaterialImageVersion = hImage.[Version])
			WHERE pStyleBOM.StyleID = @StyleID AND pStyleBOM.Artwork = 1 AND pStyleSeasonYear.SeasonYearID = @SeasonYearID
		) DELETE FROM rReportStylePageItemTemp WHERE MapID = '40000000-0000-0000-0000-000000000010' AND ReportTechpackID = @TechPackID
	END

	SELECT COUNT(*) FROM rReportStylePageItemTemp WHERE ReportTechpackID = @TechPackID

END
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '10414', GetUTCDate())
GO