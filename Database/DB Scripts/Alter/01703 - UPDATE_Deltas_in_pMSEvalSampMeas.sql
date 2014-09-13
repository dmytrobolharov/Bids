-- ******************************************************************************************** */
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Create Script                                                                              */
-- * Database:                                                                                  */
-- * 3 August 2011                                                                              */
-- * WorkItem #4107                                                                             */
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

IF NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun = '01703')
BEGIN

	UPDATE pMSEvalSampMeas 
	SET VdrDelta = VdrDelta * -1, SampDelta = SampDelta * -1

	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES ('DB_Version', '4.1.0000', '01703', GetDate())

END
GO

SET NOCOUNT Off
GO
