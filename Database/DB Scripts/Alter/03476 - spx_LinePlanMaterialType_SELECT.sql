-- ******************************************************************************************** */
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Alter Script                                                                               */
-- * Database:                                                                                  */
-- * 16 May 2012                                                                              */
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
/****** Object:  StoredProcedure [dbo].[spx_LinePlanMaterialType_SELECT]    Script Date: 05/17/2012 12:49:35 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_LinePlanMaterialType_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_LinePlanMaterialType_SELECT]
GO

/****** Object:  StoredProcedure [dbo].[spx_LinePlanMaterialType_SELECT]    Script Date: 05/17/2012 12:49:35 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[spx_LinePlanMaterialType_SELECT](
	@TeamID UNIQUEIDENTIFIER
)
AS 


    SELECT DISTINCT 
		a.ComponentTypeID, 
		a.ComponentDescription, 
		a.ComponentOrder
    FROM 
		dbo.pComponentType a WITH(NOLOCK) 
	INNER JOIN dbo.sAccessMaterialFolder b WITH(NOLOCK) ON a.ComponentTypeID = b.ComponentTypeId
	AND b.AccessRoleId <> 0 
	AND b.TeamId = @TeamID
	--WHERE a.ComponentTypeID IN (10,11,42,40,13) 
	ORDER BY 
		a.ComponentOrder

GO



	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES ('DB_Version', '5.0.0000', '03476', GetDate())
	
GO
