

/****** Object:  StoredProcedure [dbo].[spx_MaterialColorSeasonYear_SELECT]    Script Date: 01/16/2011 23:46:02 ******/
IF  EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[dbo].[spx_MaterialColorSeasonYear_SELECT]') AND OBJECTPROPERTY(id,N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[spx_MaterialColorSeasonYear_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_MaterialColorSeasonYear_SELECT]
(
@MaterialID uniqueidentifier,
@SeasonYearID uniqueidentifier
)
AS 

SELECT pMaterialColor.MaterialColorID, pMaterialColor.MaterialID, pMaterialColor.MaterialColorImageID, pMaterialColor.MaterialColorImageVersion, 
      pMaterialColor.ColorFolderID, pMaterialColor.ColorPaletteID, pMaterialColor.ColorID, pMaterialColor.ColorCode, pMaterialColor.ColorNo, 
      pMaterialColor.ColorName, pMaterialColor.ColorSource, pMaterialColor.CDate, pMaterialColor.CUser, pMaterialColor.MDate, 
      pMaterialColor.MUser, pMaterialColor.Action, pMaterialColor.Sort, pMaterialSeasonYear.MaterialSeasonYearID, 
      pMaterialSeasonYear.SeasonYearID
FROM  pMaterialColor INNER JOIN
      pMaterialSeasonYear ON pMaterialColor.MaterialID = pMaterialSeasonYear.MaterialID
WHERE pMaterialColor.MaterialID = @MaterialID AND  pMaterialSeasonYear.SeasonYearID = @SeasonYearID   
ORDER BY pMaterialColor.ColorName DESC   
      
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '4.0.0000', '01008', GetDate())
GO
