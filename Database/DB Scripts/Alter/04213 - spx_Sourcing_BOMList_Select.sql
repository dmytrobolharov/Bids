

/****** Object:  StoredProcedure [dbo].[spx_Sourcing_BOMList_Select]    Script Date: 10/16/2012 10:09:12 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Sourcing_BOMList_Select]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_Sourcing_BOMList_Select]
GO

/****** Object:  StoredProcedure [dbo].[spx_Sourcing_BOMList_Select]    Script Date: 10/16/2012 10:09:12 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-- Stored Procedure

CREATE PROCEDURE [dbo].[spx_Sourcing_BOMList_Select]
(@Styleid uniqueidentifier
)
AS 


BEGIN
	 SELECT b.StyleBOMDimensionID as StyleBOMDimensionID, w.WorkFlowItemName as WorkFlowItemName , b.StyleID
	 FROM  pWorkFlowItem w INNER JOIN pStyleBOMDimension b  ON w.WorkFlowItemID = b.WorkFlowItemID 
	 where b.StyleID=@Styleid order by WorkFlowItemName 
 	
END



GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04213', GetDate())
GO
