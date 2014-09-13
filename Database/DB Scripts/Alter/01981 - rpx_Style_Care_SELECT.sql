-- ******************************************************************************************** */
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Alter Script                                                                               */
-- * Database:                                                                                  */
-- * 29 September 2011                                                                               */
-- *                                                                                            */
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
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET NOCOUNT ON
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'rpx_Style_Care_SELECT') AND type = N'P' )
	DROP PROCEDURE rpx_Style_Care_SELECT
GO

CREATE PROCEDURE [dbo].[rpx_Style_Care_SELECT]   
 @StyleId varchar(255),   
 @StyleSet int  
AS  
  
SELECT cw.Custom AS CareWash,  
 dbo.fnx_GetStreamingCareImagePath(RTRIM(cw.CustomKey), 'Wash') AS CareWashImage,   
 cb.Custom AS CareBleach,  
 dbo.fnx_GetStreamingCareImagePath(RTRIM(cb.CustomKey), 'Bleach') AS CareBleachImage,   
 cd.Custom AS CareDry,  
 dbo.fnx_GetStreamingCareImagePath(RTRIM(cd.CustomKey), 'Dry') AS CareDryImage,  
 cc.Custom AS CareCycle,  
 dbo.fnx_GetStreamingCareImagePath(RTRIM(cc.CustomKey), 'Cycle') AS CareCycleImage,  
 ci.Custom AS CareIron,  
 dbo.fnx_GetStreamingCareImagePath(RTRIM(ci.CustomKey), 'Iron') AS CareIronImage,  
 dc.Custom AS CareDryClean,  
 dbo.fnx_GetStreamingCareImagePath(RTRIM(dc.CustomKey), 'DryClean') AS CareDryCleanImage,  
 sc.StyleCareInstruction,  
 scs.Custom AS Special
,sc.StyleCareWashFlag
,sc.StyleCareCycleFlag
,sc.StyleCareBleachFlag
,sc.StyleCareDryFlag 
,sc.StyleCareIronFlag 
,sc.StyleCareDryCleanFlag    
FROM pStyleCare sc LEFT OUTER JOIN  
 pStyleCareBleach cb ON sc.StyleCareBleach = cb.CustomKey LEFT OUTER JOIN  
  pStyleCareCycle cc ON sc.StyleCareCycle = cc.CustomKey LEFT OUTER JOIN  
 pStyleCareWash cw ON sc.StyleCareWash = cw.CustomKey LEFT OUTER JOIN  
 pStyleCareDry cd ON sc.StyleCareDry = cd.CustomKey LEFT OUTER JOIN  
 pStyleCareDryClean dc ON sc.StyleCareDryClean = dc.CustomKey LEFT OUTER JOIN  
 pStyleCareIron ci ON sc.StyleCareIron = ci.CustomKey LEFT OUTER JOIN  
 pStyleCareSpecial scs ON sc.StyleCareSpecial = scs.CustomKey  
WHERE ((sc.StyleId = @StyleId)   
AND (sc.StyleSet = @StyleSet))
GO
IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='01981'))
BEGIN
	
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '01981', GetDate())     

END	  
GO  