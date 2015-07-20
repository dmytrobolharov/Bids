-- ******************************************************************************************** */
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Alter Script                                                                               */
-- * Database:                                                                                  */
-- * 25 April 2012                                                                              */
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
/****** Object:  StoredProcedure [dbo].[spx_ColorTypeDataTable_SELECT]    Script Date: 04/25/2012 12:49:38 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_ColorTypeDataTable_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_ColorTypeDataTable_SELECT]
GO

/****** Object:  StoredProcedure [dbo].[spx_ColorTypeDataTable_SELECT]    Script Date: 04/25/2012 12:49:38 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spx_ColorTypeDataTable_SELECT]
@TeamID AS NVARCHAR(50)
AS 

BEGIN

	SELECT 
		ColorTypeID, 
		ColorTypeDescription 
	FROM 
		pColorType 
	WHERE
		ColorTypeID IN 
		(
			SELECT 
				ColorTypeID 
			FROM 
				sAccessColorFolder 
			WHERE 
				( 
					AccessRoleId =3 
					OR 
					AccessView = 1 
				)  
				AND TeamId = @TeamID
		)
	ORDER BY 
		ColorTypeDescription

END
GO

	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '5.0.0000', '03394', GetDate())

GO