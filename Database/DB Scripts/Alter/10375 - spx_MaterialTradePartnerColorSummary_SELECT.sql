IF OBJECT_ID(N'[dbo].[spx_MaterialTradePartnerColorSummary_SELECT]') IS NOT NULL
 DROP PROCEDURE [dbo].[spx_MaterialTradePartnerColorSummary_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_MaterialTradePartnerColorSummary_SELECT]
(
 @MaterialTradePartnerColorID UNIQUEIDENTIFIER
)
AS 
BEGIN

  SELECT mtpc.MaterialTradePartnerColorID, mtpc.MaterialTradePartnerID, mtpc.MaterialColorID, 
	     mtpc.MaterialID, mtpc.MaterialColorImageID, mtpc.MaterialColorImageVersion, mtpc.ColorFolderID, 
	     mtpc.ColorPaletteID, 
		 dbo.fnx_GetStreamingImageHTML(m.MaterialImageID, m.MaterialImageVersion, 150, '') AS lblMaterialCustom1,
	     m.MaterialNo AS lblMaterialCustom2, m.MaterialName AS lblMaterialCustom3, 
	     ms.MaterialSize AS lblMaterialCustom4, '<hr>' AS lblMaterialCustom5,
	     dbo.fnx_GetStreamingColorImageHTML(mtpc.ColorFolderID, mtpc.ColorPaletteID, 100, '') AS lblMaterialCustom6,
	     mtpc.ColorCode AS lblMaterialCustom7, mtpc.ColorNo AS lblMaterialCustom8, 
	     mtpc.ColorName AS lblMaterialCustom9 	
  FROM pMaterialTradePartnerColor mtpc
  INNER JOIN pMaterial m ON mtpc.MaterialID = m.MaterialID 
  LEFT OUTER JOIN pMaterialSize ms ON mtpc.MaterialSizeID = ms.MaterialSizeID
  WHERE mtpc.MaterialTradePartnerColorID = @MaterialTradePartnerColorID

END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '10375', GetUTCDate())
GO
