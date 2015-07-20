

/****** Object:  StoredProcedure [dbo].[spx_MaterialSize_SELECT]    Script Date: 01/16/2011 23:46:02 ******/
IF  EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[dbo].[spx_MaterialSize_SELECT]') AND OBJECTPROPERTY(id,N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[spx_MaterialSize_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_MaterialSize_SELECT]
(
@MaterialID uniqueidentifier
)
AS 

SELECT MaterialSizeID, MaterialID, MaterialSize, MaterialPrice, CDate, CUser, MDate, MUser, Sort
FROM  pMaterialSize
WHERE pMaterialSize.MaterialID = @MaterialID
ORDER BY Sort

 
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '4.0.0000', '01006', GetDate())
GO


