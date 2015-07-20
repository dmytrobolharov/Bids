
-- ******************************************************************************************** */
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Create Script                                                                              */
-- * Database:                                                                                  */
-- * 01 June 2012                                                                               */
-- * WorkItem #7724                                                                             */
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

/****** Object:  View [dbo].[vwx_pPOMTemplate]    Script Date: 06/01/2012 12:43:27 ******/
IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwx_pPOMTemplate]'))
DROP VIEW [dbo].[vwx_pPOMTemplate]
GO



/****** Object:  View [dbo].[vwx_pPOMTemplate]    Script Date: 06/01/2012 12:43:27 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




CREATE VIEW [dbo].[vwx_pPOMTemplate]
AS

SELECT     POMTempID, POMTempGroupID, POMTempVersion, POMType, POMTypeDescription, SpecSketchID, SpecSketchVersion, SizeClass, SizeRange, CustomField1, 
                      CustomField2, CustomField3, CustomField4, CustomField5, Size0, Size1, Size2, Size3, Size4, Size5, Size6, Size7, Size8, Size9, Size10, Size11, Size12, Size13, 
                      Size14, Size15, Size16, Size17, Size18, Size19, CUser, CDate, MDate, MUser, Sort, 
                      CASE WHEN POMTempActive = 0 THEN 'No' WHEN POMTempActive = 1 THEN 'Yes' END AS 'POMTempActive'
FROM         pPOMTemplate



GO



	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '5.0.0000', '03578', GetDate())



GO 

