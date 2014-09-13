-- ******************************************************************************************** */
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Alter Script                                                                               */
-- * Database:                                                                                  */
-- * 18 December 2012                                                                           */
-- *                                                                                            */
-- * Copyright (c) 2002-2012 Gerber Technology, Inc.  All rights reserved.                      */
-- * This information is confidential and proprietary.  You may not disseminate it              */
-- * to any other party without the express written consent of Gerber Technology, Inc.          */
-- *                                                                                            */
-- ******************************************************************************************** */
-- ******************************************************************************************** */
-- COMMENTS
--
--
--
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET NOCOUNT ON
GO

IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'vwx_ColorType_Desc_API_SEL'))
	DROP VIEW vwx_ColorType_Desc_API_SEL
GO


CREATE VIEW vwx_ColorType_Desc_API_SEL
AS

SELECT a.ColorFolderID, a.ColorFolderDescription, a.ColorSubFolder1, a.ColorSubFolder2, a.ColorSubFolder3, a.ColorSubFolder4, 
	a.ColorSubFolder5, a.ColorSubFolder6, a.ColorSubFolder7, a.ColorSubFolder8, a.ColorSubFolder9, a.CUser, a.CDate, 
	a.MUser, a.MDate, a.MChange, a.Active, a.StyleColorway, a.SystemServerStorageID, a.ColorTypeID, a.ColorTypeSort, b.ColorTypeDescription,
	cp.ColorName, cp.ColorCode, '' AS ColorNumber
FROM pColorFolder AS a 
INNER JOIN pColorType AS b ON a.ColorTypeID = b.ColorTypeID
LEFT OUTER JOIN pColorPalette cp ON a.ColorFolderID = cp.ColorFolderID

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '04666', GetDate())
GO

SET NOCOUNT Off
GO
