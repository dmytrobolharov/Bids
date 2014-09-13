/****** Object:  StoredProcedure [dbo].[spx_LineFolder_BOMList_Select]    Script Date: 06/18/2013 11:22:34 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_LineFolder_BOMList_Select]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_LineFolder_BOMList_Select]
GO

/****** Object:  StoredProcedure [dbo].[spx_LineFolder_BOMList_Select]    Script Date: 06/18/2013 11:22:34 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spx_LineFolder_BOMList_Select]
(
@LineFolderItemID UNIQUEIDENTIFIER
)
AS 


BEGIN
	 SELECT b.StyleBOMDimensionID as StyleBOMDimensionID, w.WorkFlowItemName as WorkFlowItemName , b.StyleID
	 FROM  pWorkFlowItem w INNER JOIN pStyleBOMDimension b  ON w.WorkFlowItemID = b.WorkFlowItemID 
	 INNER JOIN pLineFolderItem lf ON lf.StyleID = w.StyleID AND lf.StyleSeasonYearID = w.StyleSeasonYearID
	 where lf.LineFolderItemID = @LineFolderItemID
	 ORDER BY WorkFlowItemName 
 	
END



GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '05880', GetDate())
GO
