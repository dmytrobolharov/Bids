
-- ******************************************************************************************** */
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Create Script                                                                              */
-- * Database:                                                                                  */
-- * 13 June 2012                                                                                */
-- * WorkItem #8832                                                                             */
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

/****** Object:  View [dbo].[vwx_BatchQ_ColorFolder_SEL]    Script Date: 06/13/2012 17:15:29 ******/
IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwx_BatchQ_ColorFolder_SEL]'))
DROP VIEW [dbo].[vwx_BatchQ_ColorFolder_SEL]
GO



/****** Object:  View [dbo].[vwx_BatchQ_ColorFolder_SEL]    Script Date: 06/13/2012 17:15:29 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO




CREATE VIEW [dbo].[vwx_BatchQ_ColorFolder_SEL]
AS

	SELECT * FROM dbo.pColorFolder where Active=1


GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.1.0000', '03620', GetDate())



GO

