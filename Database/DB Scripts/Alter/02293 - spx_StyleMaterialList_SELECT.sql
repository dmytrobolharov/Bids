
-- ******************************************************************************************** */
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Create Script                                                                              */
-- * Database:                                                                                  */
-- * 06 Dec 2011                                                                               */
-- * WorkItem #2066                                                                             */
-- * Copyright (c) 2002-2010 Gerber Technology, Inc.  All rights reserved.                      */
-- * This information is confidential and proprietary.  You may not disseminate it              */
-- * to any other party without the express written consent of Gerber Technology, Inc.          */
-- *                                                                                            */
-- ******************************************************************************************** */
-- ******************************************************************************************** */
-- COMMENTS
--
--
--

/****** Object:  StoredProcedure [dbo].[spx_StyleMaterialList_SELECT]    Script Date: 12/06/2011 22:10:04 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleMaterialList_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleMaterialList_SELECT]
GO

/****** Object:  StoredProcedure [dbo].[spx_StyleMaterialList_SELECT]    Script Date: 12/06/2011 22:10:04 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spx_StyleMaterialList_SELECT] (@MaterialNo varchar(100))  
AS
  
SELECT MaterialNo FROM pMaterial WHERE MaterialNo LIKE '%'+@MaterialNo+'%' ORDER BY MaterialNo ASC

GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='02293'))
BEGIN

	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '02293', GetDate())

END

GO 


