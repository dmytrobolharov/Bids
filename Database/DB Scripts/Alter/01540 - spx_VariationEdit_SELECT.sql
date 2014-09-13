
-- ******************************************************************************************** */
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Create Script                                                                               */
-- * Database:                                                                                  */
-- * 22 June 2011                                                                                */
-- * WorkItem#3708                                                                                         */
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

/****** Object:  StoredProcedure [dbo].[spx_VariationEdit_SELECT]    Script Date: 06/22/2011 17:30:04 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_VariationEdit_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_VariationEdit_SELECT]
GO

/****** Object:  StoredProcedure [dbo].[spx_VariationEdit_SELECT]    Script Date: 06/22/2011 17:30:04 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spx_VariationEdit_SELECT]
(@StyleDevelopmentID uniqueidentifier)
AS 
SELECT   COALESCE(StyleDevelopmentName, 'Variation ' + CAST(Variation AS VARCHAR(5))) AS StyleDevelopmentName, StyleDevelopmentID, Variation
FROM         pStyleDevelopmentItem WITH (NOLOCK)
GROUP BY StyleDevelopmentName, Variation, StyleDevelopmentID 
HAVING      (StyleDevelopmentID = @StyleDevelopmentID)
ORDER BY Variation

GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='01539'))
BEGIN
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '01540', GetDate())
END	



