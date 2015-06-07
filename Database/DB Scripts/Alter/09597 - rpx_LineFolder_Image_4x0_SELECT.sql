IF OBJECT_ID(N'[dbo].[rpx_LineFolder_Image_4x0_SELECT]') IS NOT NULL
 DROP PROCEDURE [dbo].[rpx_LineFolder_Image_4x0_SELECT]
GO

CREATE PROCEDURE [dbo].[rpx_LineFolder_Image_4x0_SELECT]
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
				(ROW_NUMBER() OVER(ORDER BY lfi.LineFolderItemSort, sh.StyleNo, sh.Description) - 1) / 4 AS [Row]
				, (ROW_NUMBER() OVER(ORDER BY lfi.LineFolderItemSort, sh.StyleNo, sh.Description) - 1) % 4 AS [Column]
				, sh.StyleID
				, sh.StyleNo
				, sh.[Description]
				, dbo.fnx_GetStreamingImagePath(sh.DesignSketchID, sh.DesignSketchVersion) AS FilePath
				, COALESCE(scc.Custom, sh.SizeClass) AS SizeClass
				, COALESCE(sr.SizeRangeCode, sh.SizeRange) AS SizeRange
				, lfi.LineFolderItemDrop
				, lfi.LineFolderItemDropUser
				, lfi.LineFolderItemDropDate
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
				(ROW_NUMBER() OVER(ORDER BY lfi.LineFolderItemSort, sh.StyleNo, sh.Description) - 1) / 4 AS [Row]
				, (ROW_NUMBER() OVER(ORDER BY lfi.LineFolderItemSort, sh.StyleNo, sh.Description) - 1) % 4 AS [Column]
				, sh.StyleID
				, sh.StyleNo
				, sh.[Description]
				, dbo.fnx_GetStreamingImagePath(sh.DesignSketchID, sh.DesignSketchVersion) AS FilePath
				, COALESCE(scc.Custom, sh.SizeClass) AS SizeClass
				, COALESCE(sr.SizeRangeCode, sh.SizeRange) AS SizeRange
				, lfi.LineFolderItemDrop
				, lfi.LineFolderItemDropUser
				, lfi.LineFolderItemDropDate
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
VALUES ('DB_Version', '6.1.0000', '09597', GetDate())
GO
