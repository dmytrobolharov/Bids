
-- ******************************************************************************************** */
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Create Script                                                                              */
-- * Database:                                                                                  */
-- * 22 May 2011                                                                                */
-- * WorkItem #8500                                                                             */
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

/****** Object:  View [dbo].[vwx_MaterialLinePlanSearch_SEL]    Script Date: 05/22/2012 15:10:47 ******/
IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwx_MaterialLinePlanSearch_SEL]'))
DROP VIEW [dbo].[vwx_MaterialLinePlanSearch_SEL]
GO



/****** Object:  View [dbo].[vwx_MaterialLinePlanSearch_SEL]    Script Date: 05/22/2012 15:10:47 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO



CREATE VIEW [dbo].[vwx_MaterialLinePlanSearch_SEL]
AS


SELECT a.MaterialID, a.MaterialType, a.MaterialNo, a.MaterialName, 
a.A, a.B, a.C, a.D, a.F, a.G,a.I,a.K,a.Source, a.Notes, a.VolumePrice, a.CUser,
a.CDate, a.Active,
'<img src="../System/Control/ImageStream.ashx?S=050&V=' + CAST(a.MaterialImageVersion AS NVARCHAR(10)) + 
'&IID=' + CAST(a.MaterialImageID AS NVARCHAR(40)) +  '" />'
 AS ImagePath
FROM dbo.pMaterial a WITH(NOLOCK)



GO



	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '5.1.0000', '03498', GetDate())


GO

