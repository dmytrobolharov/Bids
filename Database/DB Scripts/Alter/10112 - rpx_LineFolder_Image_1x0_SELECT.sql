IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[rpx_LineFolder_Image_1x0_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[rpx_LineFolder_Image_1x0_SELECT]
GO


SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[rpx_LineFolder_Image_1x0_SELECT]
( 
	@LineFolderID AS UNIQUEIDENTIFIER
)
AS
BEGIN
	DECLARE @SeasonYearID UNIQUEIDENTIFIER
	SELECT @SeasonYearID = SeasonYearID FROM pLineFolder WHERE LineFolderID = @LineFolderID

	IF @SeasonYearID IS NOT NULL AND @SeasonYearID <> '00000000-0000-0000-0000-000000000000'
		BEGIN
			SELECT
				sh.StyleID
				, sh.StyleNo
				, sh.[Description]
				, dbo.fnx_GetStreamingImagePath(sh.DesignSketchID, sh.DesignSketchVersion, 2000) AS FilePath
				, COALESCE(scc.Custom, sh.SizeClass) AS SizeClass
				, COALESCE(sr.SizeRangeCode, sh.SizeRange) AS SizeRange
				, lfi.LineFolderItemDrop
				, lfi.LineFolderItemDropUser
				, lfi.LineFolderItemDropDate
				, lfi.LineFolderItemID
				, sc.StyleCategory
				, STUFF((
					SELECT ', ' + ISNULL(sb.MaterialName, '') + ' (' + sb.MaterialNo + ')' FROM
						(SELECT DISTINCT sb.MaterialName, sb.MaterialNo FROM pStyleBOM sb
							INNER JOIN pWorkFlowItem wi ON sb.WorkflowItemId = wi.WorkFlowItemID
							INNER JOIN pStyleSeasonYear ssy ON wi.StyleSeasonYearID = ssy.StyleSeasonYearID AND ssy.SeasonYearID = @SeasonYearID
						 WHERE sb.StyleID = sh.StyleID AND sb.MainMaterial = 1) sb
					FOR XML PATH('')), 1, 2, '')
				  AS MaterialName
			FROM
				pLineFolderItem lfi
				INNER JOIN pStyleHeader sh ON lfi.StyleID = sh.StyleID
				INNER JOIN pStyleCategory sc ON sh.StyleCategory = sc.StyleCategoryId
				LEFT JOIN pSizeClass scc ON scc.CustomID = sh.SizeClassId
				LEFT JOIN pSizeRange sr ON sr.CustomId = sh.SizeRangeId
			WHERE LineFolderID = @LineFolderID
		END
	ELSE
		BEGIN
			SELECT
				sh.StyleID
				, sh.StyleNo
				, sh.[Description]
				, dbo.fnx_GetStreamingImagePath(sh.DesignSketchID, sh.DesignSketchVersion, 2000) AS FilePath
				, COALESCE(scc.Custom, sh.SizeClass) AS SizeClass
				, COALESCE(sr.SizeRangeCode, sh.SizeRange) AS SizeRange
				, lfi.LineFolderItemDrop
				, lfi.LineFolderItemDropUser
				, lfi.LineFolderItemDropDate
				, lfi.LineFolderItemID
				, sc.StyleCategory
				, STUFF((
					SELECT ', ' + ISNULL(sb.MaterialName, '') + ' (' + sb.MaterialNo + ')' FROM
						(SELECT DISTINCT sb.MaterialName, sb.MaterialNo FROM pStyleBOM sb
							INNER JOIN pWorkFlowItem wi ON sb.WorkflowItemId = wi.WorkFlowItemID
						 WHERE sb.StyleID = sh.StyleID AND sb.MainMaterial = 1) sb
					FOR XML PATH('')), 1, 2, '')
				  AS MaterialName
			FROM
				pLineFolderItem lfi
				INNER JOIN pStyleHeader sh ON lfi.StyleID = sh.StyleID
				INNER JOIN pStyleCategory sc ON sh.StyleCategory = sc.StyleCategoryId
				LEFT JOIN pSizeClass scc ON scc.CustomID = sh.SizeClassId
				LEFT JOIN pSizeRange sr ON sr.CustomId = sh.SizeRangeId
			WHERE LineFolderID = @LineFolderID	
		END
END



GO




INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '10112', GetUTCDate())
GO