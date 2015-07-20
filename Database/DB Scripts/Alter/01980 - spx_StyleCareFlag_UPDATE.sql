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

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'spx_StyleCareFlag_UPDATE') AND type = N'P' )
	DROP PROCEDURE spx_StyleCareFlag_UPDATE
GO

CREATE PROCEDURE [dbo].[spx_StyleCareFlag_UPDATE] (  
@StyleId UNIQUEIDENTIFIER,  
@StyleSet INT,  
@StyleCareWashFlag BIT,  
@StyleCareCycleFlag BIT,  
@StyleCareBleachFlag BIT,  
@StyleCareDryFlag BIT,  
@StyleCareIronFlag BIT,  
@StyleCareDryCleanFlag BIT)  
AS 
  
  IF (SELECT COUNT(*) FROM pStyleCare WITH (NOLOCK) WHERE StyleId = @StyleId AND StyleSet = @StyleSet) <> 0
  BEGIN  
    UPDATE dbo.pStyleCare  
    SET StyleCareWashFlag = @StyleCareWashFlag,
		StyleCareCycleFlag = @StyleCareCycleFlag, 
		StyleCareBleachFlag = @StyleCareBleachFlag,   
		StyleCareDryFlag = @StyleCareDryFlag, 
		StyleCareIronFlag = @StyleCareIronFlag, 
		StyleCareDryCleanFlag = @StyleCareDryCleanFlag
    WHERE StyleId = @StyleId 
		  AND StyleSet = @StyleSet  
  END  
GO
IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='01980'))
BEGIN
	
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '01980', GetDate())     

END	
GO