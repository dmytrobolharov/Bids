-- ******************************************************************************************** */
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Create Script                                                                              */
-- * Database:                                                                                  */
-- * 19 Dec 2011                                                                                */
-- * WorkItem #6368																				*/
-- * Copyright (c) 2002-2011 Gerber Technology, Inc.  All rights reserved.                      */
-- * This information is confidential and proprietary.  You may not disseminate it              */
-- * to any other party without the express written consent of Gerber Technology, Inc.          */
-- *                                                                                            */
-- ******************************************************************************************** */
-- ******************************************************************************************** */
-- COMMENTS
--
--
--
/****** Object:  View [dbo].[vwx_pGRMeasurementsPOM_SelectNew]    Script Date: 12/19/2011 18:19:48 ******/
IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwx_pGRMeasurementsPOM_SelectNew]'))
DROP VIEW [dbo].[vwx_pGRMeasurementsPOM_SelectNew]
GO



/****** Object:  View [dbo].[vwx_pGRMeasurementsPOM_SelectNew]    Script Date: 12/19/2011 18:19:48 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[vwx_pGRMeasurementsPOM_SelectNew]
AS

SELECT     POMID, POMCode, POMDesc,  How2MeasText, CUser, CDate, MUser, MDate,Sort,
 '../System/Control/ImageStream.ashx?IT=POM&S=50&ID=' + CAST(ISNULL(dbo.pGRMeasurementsPOM.ImageId, '00000000-0000-0000-0000-000000000000')
 AS NVARCHAR(50)) + '' AS ImageURL,ImageId
FROM         dbo.pGRMeasurementsPOM



GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='02462'))
BEGIN

	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '02462', GetDate())

END

GO


