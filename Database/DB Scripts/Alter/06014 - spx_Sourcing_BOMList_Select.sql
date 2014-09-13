IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Sourcing_BOMList_Select]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_Sourcing_BOMList_Select]
GO


CREATE PROCEDURE [dbo].[spx_Sourcing_BOMList_Select]
(
	@Styleid uniqueidentifier, 
	@SeasonYearID uniqueidentifier = NULL
)
AS 

BEGIN
	IF @SeasonYearID IS NOT NULL
	BEGIN
	 SELECT b.StyleBOMDimensionID as StyleBOMDimensionID, w.WorkFlowItemName as WorkFlowItemName , b.StyleID
	 FROM  pWorkFlowItem w 
		INNER JOIN pStyleBOMDimension b  ON w.WorkFlowItemID = b.WorkFlowItemID 
		INNER JOIN pStyleSeasonYear ssy ON w.StyleSeasonYearID = ssy.StyleSeasonYearID
	 WHERE b.StyleID=@Styleid 
		AND ssy.SeasonYearID = @SeasonYearID
	 ORDER BY WorkFlowItemName 
 	END
 	ELSE
	BEGIN
	 SELECT b.StyleBOMDimensionID as StyleBOMDimensionID, w.WorkFlowItemName as WorkFlowItemName , b.StyleID
	 FROM  pWorkFlowItem w INNER JOIN pStyleBOMDimension b  ON w.WorkFlowItemID = b.WorkFlowItemID 
	 where b.StyleID=@Styleid order by WorkFlowItemName 
 	END
 	
END
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '06014', GetDate())
GO
