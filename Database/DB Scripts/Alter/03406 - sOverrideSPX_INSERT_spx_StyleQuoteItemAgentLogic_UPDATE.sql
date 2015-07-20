-- ******************************************************************************************** */
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Alter Script                                                                               */
-- * Database:                                                                                  */
-- * 8 May 2012                                                                              */
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

IF NOT EXISTS(SELECT OverrideSPXID FROM [sOverrideSPX] WHERE OriginalSPX='spx_StyleQuoteItemAgentLogic_UPDATE')
BEGIN
INSERT [dbo].[sOverrideSPX] 
(
	[OriginalSPX], 
	[FormName], 
	[Override]
) 
VALUES 
(
	N'spx_StyleQuoteItemAgentLogic_UPDATE', 
	N'QuoteHandler', 
	N''
)
END

GO



	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '5.0.0000', '03406', GetDate())


GO
