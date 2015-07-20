IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_LineFolder_BOMList_Select]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_LineFolder_BOMList_Select]
GO

CREATE PROCEDURE [dbo].[spx_LineFolder_BOMList_Select]
(
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
			INNER JOIN pLineFolder lf ON lfi.LineFolderID = lf.LineFolderID AND ssy.SeasonYearID = lf.SeasonYearID
		/**********************************/
	 where lfi.LineFolderItemID = @LineFolderItemID
	 ORDER BY WorkFlowItemName 
 	
END
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '06301', GetDate())
GO
