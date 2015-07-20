-- ******************************************************************************************** */
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Create Script                                                                              */
-- * Database:                                                                                  */
-- * 15 May 2012                                                                                */
-- * WorkItem #8252																										*/
-- * Copyright (c) 2002-2011 Gerber Technology, Inc.  All rights reserved.                      */
-- * This information is confidential and proprietary.  You may not disseminate it              */
-- * to any other party without the express written consent of Gerber Technology, Inc.          */
-- *                                                                                            */
-- ******************************************************************************************** */
-- ******************************************************************************************** */
-- COMMENTS

/****** Object:  View [dbo].[vwx_LinePlanMaterial_SEL]    Script Date: 05/15/2012 18:22:25 ******/
IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwx_Style_BOMComponentType_SELECT]'))
DROP VIEW [dbo].[vwx_Style_BOMComponentType_SELECT]
GO


SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE VIEW [dbo].[vwx_Style_BOMComponentType_SELECT]
AS
SELECT  '0' as ComponentTypeID, 'N/A' as ComponentDescription, '00' as componentorder Union select ComponentTypeID, ComponentDescription,componentorder FROM pComponentType

GO



	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '5.0.0000', '03464', GetDate())



GO

