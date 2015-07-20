-- ******************************************************************************************** */
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Alter Script                                                                               */
-- * Database:                                                                                  */
-- * 25 August 2011                                                                             */
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
GO
/****** Object:  StoredProcedure [dbo].[spx_MaterialWorkflowViewAgentAvailable_SELECTED]    Script Date: 08/25/2011 20:01:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_MaterialWorkflowViewAgentAvailable_SELECTED]') AND type = N'P' )
	DROP PROCEDURE [dbo].[spx_MaterialWorkflowViewAgentAvailable_SELECTED]		
GO

CREATE PROCEDURE [dbo].[spx_MaterialWorkflowViewAgentAvailable_SELECTED]
(
	@TeamId uniqueidentifier
)
AS 
SELECT TradePartnerID, '(' + TradePartnerCode + ') ' + TradePartnerName AS TradePartnerName   
FROM  uTradePartner WITH (NOLOCK)   
WHERE 
(
	TradePartnerID IN   
	(			
		SELECT TradepartnerId FROM  pMaterialSampleWorkflowViewAgent WITH (NOLOCK) WHERE TeamId = @TeamId
	)
)
AND Active = 1   
ORDER BY TradePartnerName

GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='01780'))
BEGIN
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '01780', GetDate())
END
GO






