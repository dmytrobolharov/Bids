IF OBJECT_ID(N'[dbo].[vwx_MaterialWizardRequest_ColorSeasonYear_Available_SEL]') IS NOT NULL
 DROP VIEW [dbo].[vwx_MaterialWizardRequest_ColorSeasonYear_Available_SEL]
GO

CREATE VIEW [dbo].[vwx_MaterialWizardRequest_ColorSeasonYear_Available_SEL]
AS
SELECT a.MaterialColorID, a.MaterialID, a.MaterialColorImageID, a.MaterialColorImageVersion, a.ColorFolderID, a.ColorPaletteID, 
       a.ColorID, a.ColorCode, a.ColorNo, a.ColorName, a.ColorSource, a.VendorColorNo, a.VendorColorName, a.MaterialColorNote, 
	   a.ColorHex, a.Hex, a.R, a.G, a.B, a.C, a.M, a.Y, a.K, a.H, a.S, a.L, a.LAB_L, a.LAB_A, a.LAB_B, a.ColorHexCode, a.CDate, 
	   a.CUser, a.MDate, a.MUser, a.MaterialColorVersion, a.ColorVersion, a.Action, a.Sort, a.VendorColorCode, a.CopyMaterialColorID, 
	   b.SeasonYearID, b.MaterialColorSeasonYearID, 
	   CASE WHEN a.MaterialColorImageID IS NULL 
            THEN '<TABLE cellSpacing="0" cellPadding="0" width="100%" border="0"><TR><TD width="18">' + 
		         dbo.fnx_GetStreamingColorImageHTML(a.ColorFolderID, a.ColorPaletteID, 16, 'border="0" alt="Open"') +
				 '</TD></TR></TABLE>' 
		    ELSE '<TABLE cellSpacing="0" cellPadding="0" width="100%" border="0"><TR><TD width="18">' +
		         dbo.fnx_GetStreamingImageHTML(a.MaterialColorImageID, a.MaterialColorImageVersion, 16, 'border="0" alt="Open"') + 
		         '</TD></TR></TABLE>' 
	   END AS ColorImagePath, 
       CASE WHEN d .MaterialSizeID IS NULL THEN '*NA' ELSE d .MaterialSize END AS MaterialSize, 
	   CASE WHEN d .MaterialSizeID IS NULL THEN '00000000-0000-0000-0000-000000000000' ELSE d .MaterialSizeID END AS MaterialSizeID
FROM dbo.pMaterialColor AS a 
INNER JOIN dbo.pMaterialColorSeasonYear AS b ON a.MaterialColorID = b.MaterialColorID 
LEFT OUTER JOIN dbo.pMaterialSize AS d ON a.MaterialID = d.MaterialID

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '10326', GetUTCDate())
GO
