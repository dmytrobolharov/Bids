IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[rpx_LineFolder_Image_4x0_SELECT]') AND type in (N'P', N'PC'))
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
				, sh.DesignSketchID
				, sh.DesignSketchVersion
				, sh.SizeClass
				, sh.SizeRange
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
				, sh.DesignSketchID
				, sh.DesignSketchVersion
				, sh.SizeClass
				, sh.SizeRange
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
			WHERE LineFolderID = @LineFolderID	
		END
END
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07217', GetDate())
GO
