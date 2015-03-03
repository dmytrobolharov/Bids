/****** Object:  StoredProcedure [dbo].[spx_LineFolder_BOMList_Select]    Script Date: 1/29/2015 12:38:16 PM ******/
DROP PROCEDURE [dbo].[spx_LineFolder_BOMList_Select]
GO


CREATE PROCEDURE [dbo].[spx_LineFolder_BOMList_Select](
@LineFolderItemID UNIQUEIDENTIFIER
)
AS 
BEGIN

	 SELECT b.StyleBOMDimensionID as StyleBOMDimensionID, w.WorkFlowItemName as WorkFlowItemName , b.StyleID
	 FROM  pWorkFlowItem w 
		INNER JOIN pStyleBOMDimension b  ON w.WorkFlowItemID = b.WorkFlowItemID 
		INNER JOIN pLineFolderItem lfi ON lfi.StyleID = w.StyleID 
		/* use LineFolder.SeasonYearID for filtering BOMs (not pLineFolderItem.StyleSeasonYearID) */
			--AND lfi.StyleSeasonYearID = w.StyleSeasonYearID
			INNER JOIN pStyleSeasonYear ssy ON w.StyleSeasonYearID = ssy.StyleSeasonYearID
			INNER JOIN pLineFolder lf ON lfi.LineFolderID = lf.LineFolderID 
				AND (ssy.SeasonYearID = lf.SeasonYearID 
					OR (lf.SeasonYearID = '00000000-0000-0000-0000-000000000000' AND lfi.StyleSeasonYearID = w.StyleSeasonYearID)) 
						-- for non-seasonal line lists - grab BOMs by StyleSeasonYearID
		/**********************************/
	 WHERE lfi.LineFolderItemID = @LineFolderItemID
	 ORDER BY WorkFlowItemName 
 	
END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.0.0001', '09222', GetDate())
GO

