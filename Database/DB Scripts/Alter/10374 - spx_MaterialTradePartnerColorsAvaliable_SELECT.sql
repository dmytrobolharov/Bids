IF OBJECT_ID(N'[dbo].[spx_MaterialTradePartnerColorsAvaliable_SELECT]') IS NOT NULL
 DROP PROCEDURE [dbo].[spx_MaterialTradePartnerColorsAvaliable_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_MaterialTradePartnerColorsAvaliable_SELECT] (
@MaterialID  UNIQUEIDENTIFIER , 
@MaterialTradePartnerID UNIQUEIDENTIFIER 
)
AS


SELECT  *  FROM   (

	SELECT CAST (pMaterialColor.MaterialColorID  as nvarchar(50) ) + '/' + 
	CASE 
		WHEN pMaterialSize.MaterialSizeID IS NULL  THEN  '00000000-0000-0000-0000-000000000000'
		ELSE CAST ( pMaterialSize.MaterialSizeID as nvarchar (50) ) 
	END  AS RecID
	, pMaterialColor.MaterialColorID, 
	CASE 	
		WHEN pMaterialSize.MaterialSizeID  IS NULL THEN  '00000000-0000-0000-0000-000000000000'
		ELSE pMaterialSize.MaterialSizeID 
	END AS  MaterialSizeID ,
	pMaterialColor.MaterialID , pMaterialColor.MaterialColorImageID, pMaterialColor.MaterialColorImageVersion,   
	pMaterialColor.ColorFolderID, pMaterialColor.ColorPaletteID , pMaterialColor.ColorCode, pMaterialColor.ColorNo  ,  
	pMaterialColor.ColorName, pMaterialColor.VendorColorCode, pMaterialColor.VendorColorNo, pMaterialColor.VendorColorName,
	
	CASE 
		WHEN pMaterialSize.MaterialSizeID IS NULL  THEN  '*NA'
		ELSE pMaterialSize.MaterialSize 
	
	END AS Size,
	pMaterialSize.MaterialPrice   as Price ,
	CASE  
		WHEN MaterialColorImageID IS NULL  
		THEN dbo.fnx_GetStreamingColorImageHTML(ColorFolderID, ColorPaletteID, 25, '') 
		ELSE dbo.fnx_GetStreamingImageHTML(MaterialColorImageID, MaterialColorImageVersion, 25, '') 
	END AS ColorImagePath  
	FROM pMaterialColor LEFT OUTER JOIN  pMaterialSize ON   pMaterialColor.MaterialID =   pMaterialSize.MaterialID 
	WHERE pMaterialColor.MaterialID = @MaterialID
) AS FOO1 
WHERE   RECID NOT IN ( 
	
	Select  CAST (  pMaterialTradePartnerColor.MaterialColorID as nvarchar(50))  +  '/' + 
	CASE 
		WHEN MaterialSizeID IS NULL  THEN '00000000-0000-0000-0000-000000000000'
		ELSE CAST (  pMaterialTradePartnerColor.MaterialSizeID as nvarchar(50) )
	END 
	AS  RecID
	FROM  pMaterialTradePartnerColor INNER JOIN pMaterialTradePartner ON pMaterialTradePartnerColor.MaterialTradePartnerId  =  pMaterialTradePartner.MaterialTradePartnerId  
	WHERE pMaterialTradePartner.MaterialTradePartnerID =  @MaterialTradePartnerID
	AND pMaterialTradePartnerColor.MaterialID = @MaterialID   
	
)
ORDER BY  ColorName , Size

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '10374', GetUTCDate())
GO
