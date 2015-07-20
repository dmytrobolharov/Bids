-- ******************************************************************************************** */
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Alter Script                                                                               */
-- * Database:                                                                                  */
-- * 9 March 2012                                                                           */
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
/****** Object:  View [dbo].[vwx_pMaterialCore_SELECT]    Script Date: 03/09/2012 16:06:04 ******/
IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwx_pMaterialCore_SELECT]'))
DROP VIEW [dbo].[vwx_pMaterialCore_SELECT]
GO

/****** Object:  View [dbo].[vwx_pMaterialCore_SELECT]    Script Date: 03/09/2012 16:06:04 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[vwx_pMaterialCore_SELECT]
AS
	SELECT 
		MaterialCoreID,
		MaterialCoreName,
		MaterialCoreDescription,
		CASE WHEN ACTIVE=1 THEN 'Yes' ELSE 'No' END AS Active,
		CDate,
		CUser,
		MUser,
		MDate,
		Sort 
	FROM 
		pMaterialCore

GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='03212'))
BEGIN

	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '5.0.0000', '03212', GetDate())

END
GO