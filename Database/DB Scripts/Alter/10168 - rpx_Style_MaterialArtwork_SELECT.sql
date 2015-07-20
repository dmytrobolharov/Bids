IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[rpx_Style_MaterialArtwork_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[rpx_Style_MaterialArtwork_SELECT]
GO

CREATE  PROCEDURE [dbo].[rpx_Style_MaterialArtwork_SELECT] 
	@StyleID	AS nVARCHAR(255)
	,@StyleSet	As INT
	,@FlagBOM	AS INT=0
	,@SeasonYearID AS nVARCHAR(40) = NULL
	,@ReportTechPackID AS nVARCHAR(40) = NULL
AS

BEGIN
	IF  @FlagBOM=0
	BEGIN
		SELECT ('(' + sm.MaterialNo + ') ' + ISNULL(sm.MaterialName,'')) AS MaterialDescription, 
		(dbo.fnx_GetStreamingImagePath(hi.ImageID, hi.[Version], 2000)) AS FilePath	--Comment #01
		FROM	pStyleMaterials sm, hImage hi 
		WHERE ((sm.MaterialImageID = hi.ImageID) 
		AND (sm.MaterialImageVersion = hi.Version) 
		AND (sm.StyleSet =  @StyleSet) 
		AND (sm.StyleID = @StyleID))
		AND (sm.Artwork = 1)
		ORDER BY sm.MainMaterial DESC, sm.MaterialType, sm.MaterialSort, sm.MaterialNo
	END
	ELSE
	IF @FlagBOM=1
	BEGIN
		SELECT ('(' + sm.MaterialNo + ') ' + ISNULL(sm.MaterialName,'')) AS MaterialDescription, 
		(dbo.fnx_GetStreamingImagePath(hi.ImageID, hi.[Version], 2000)) AS FilePath	--Comment #01
		FROM pStyleBOM sm
			LEFT JOIN hImage hi ON sm.MaterialImageID = hi.ImageID AND sm.MaterialImageVersion = hi.Version
			INNER JOIN pWorkFlowItem wi ON sm.WorkflowItemId = wi.WorkFlowItemID
			INNER JOIN pStyleSeasonYear ssy ON wi.StyleSeasonYearID = ssy.StyleSeasonYearID
		WHERE sm.StyleSet =  @StyleSet
		AND sm.StyleID = @StyleID
		AND ssy.SeasonYearID = @SeasonYearID
		AND sm.Artwork = 1
		-- WI #21738
		AND (@ReportTechPackID IS NULL OR @ReportTechPackID = '' 
			OR wi.WorkFlowItemID IN (SELECT WorkFlowItemID FROM pTechPackWorkflowItem WHERE TechPackID = @ReportTechPackID))
		ORDER BY sm.MainMaterial DESC, sm.MaterialType, sm.MaterialSort, sm.MaterialNo
	END
END



GO




INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '10168', GetUTCDate())
GO