IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[vwx_BatchQ_MaterialColorSeasonal_SEL]') AND type = N'V' )
	DROP VIEW [dbo].[vwx_BatchQ_MaterialColorSeasonal_SEL]
GO


CREATE VIEW [dbo].[vwx_BatchQ_MaterialColorSeasonal_SEL]
AS 


SELECT b.MaterialID, b.SeasonYearID, d.ComponentDescription AS MaterialType,
	c.MaterialName, c.MaterialNo, c.Active, c.CUser, c.CDate
FROM (
SELECT DISTINCT materialID, SeasonYearID 
FROM pMaterialColorSeasonYear a WITH(NOLOCK)
) AS foo 
INNER JOIN pMaterialSeasonyear b WITH(NOLOCK) ON foo.MaterialID = b.MaterialID
		AND b.SeasonyearID =  foo.SeasonYearID
INNER JOIN dbo.pMaterial c WITH(NOLOCK) ON c.MaterialID = b.MaterialID
INNER JOIN dbo.pComponentType d WITH(NOLOCK) ON C.MaterialType =  d.ComponentTypeID

GO



IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='01573'))
BEGIN
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '01573', GetDate())
END	

GO
