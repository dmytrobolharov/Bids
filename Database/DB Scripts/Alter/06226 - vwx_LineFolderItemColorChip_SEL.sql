-- ******************************************************************************************** */
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Alter Script                                                                               */
-- * Database:                                                                                  */
-- * 21 August 2013                                                                             */
-- *                                                                                            */
-- * Copyright (c) 2002-2013 Gerber Technology, Inc.  All rights reserved.                      */
-- * This information is confidential and proprietary.  You may not disseminate it              */
-- * to any other party without the express written consent of Gerber Technology, Inc.          */
-- *                                                                                            */
-- ******************************************************************************************** */
-- ******************************************************************************************** */
-- COMMENTS:
--
--
--
IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwx_LineFolderItemColorChip_SEL]'))
	DROP VIEW [dbo].[vwx_LineFolderItemColorChip_SEL]
GO

CREATE VIEW [dbo].[vwx_LineFolderItemColorChip_SEL]
AS
	SELECT pLineFolderItemColor.LineFolderItemColorID, pLineFolderItemColor.LineFolderItemID, pColorPalette.ColorFolderID, pColorPalette.ColorPaletteID, 
		pColorPalette.ColorCode, pColorPalette.ColorName, pStyleColorway.StyleColorNo, pStyleColorway.StyleColorName, 
		NULL AS MaterialColorImageID, NULL AS MaterialColorImageVersion, pStyleColorway.Sort
	FROM pStyleColorway WITH (NOLOCK) 
		INNER JOIN pLineFolderItemColor WITH (NOLOCK) ON pStyleColorway.StyleColorID = pLineFolderItemColor.StyleColorID 
		INNER JOIN pColorPalette ON pStyleColorway.ColorPaletteID = pColorPalette.ColorPaletteID
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '06226', GetDate())
GO
