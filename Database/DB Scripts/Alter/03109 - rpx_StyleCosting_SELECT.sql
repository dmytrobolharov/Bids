
-- ******************************************************************************************** */
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Create Script                                                                              */
-- * Database:                                                                                  */
-- * 10 Feb 2011																				*/
-- * WorkItem #6786																				*/
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

/****** Object:  StoredProcedure [dbo].[rpx_StyleCosting_SELECT]    Script Date: 02/10/2012 16:59:22 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[rpx_StyleCosting_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[rpx_StyleCosting_SELECT]
GO



/****** Object:  StoredProcedure [dbo].[rpx_StyleCosting_SELECT]    Script Date: 02/10/2012 16:59:22 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[rpx_StyleCosting_SELECT](
@StyleID				VARCHAR(50)
,@StyleSeasonYearID		VARCHAR(50)
,@StyleCostingID		VARCHAR(50)
,@StyleCostingTypeID	INT
)
AS 
BEGIN
	/*SELECT * FROM pStyleCosting WHERE StyleID=@StyleID 
	AND StyleSeasonYearID=@StyleSeasonYearID 
	AND StyleCostingID=@StyleCostingID
	AND StyleCostingTypeID=@StyleCostingTypeID*/
	
	
	SELECT 
	CONVERT(DECIMAL(18,2),BOMCost) AS BOMCost 
	,CONVERT(DECIMAL(18,2),BOLCost) AS BOLCost 
	,BOLCurr
	,CONVERT(DECIMAL(18,2),StyleCostingCustomField6)		AS StyleCostingCustomField6 
	,CONVERT(DECIMAL(18,2),StyleCostingCustomField7 * 100)	AS StyleCostingCustomField7
	,CONVERT(DECIMAL(18,2),StyleCostingCustomField8)		AS StyleCostingCustomField8
	,CONVERT(DECIMAL(18,2),StyleCostingCustomField9 * 100)	AS StyleCostingCustomField9
	,CONVERT(DECIMAL(18,2),StyleCostingCustomField10)		AS StyleCostingCustomField10
	,CONVERT(DECIMAL(18,2),StyleCostingCustomField11 * 100) AS StyleCostingCustomField11
	,CONVERT(DECIMAL(18,2),StyleCostingCustomField12)		AS StyleCostingCustomField12
	,CONVERT(DECIMAL(18,2),StyleCostingCustomField13)		AS StyleCostingCustomField13
	,CONVERT(DECIMAL(18,2),StyleCostingCustomField14)		AS StyleCostingCustomField14
	,CONVERT(DECIMAL(18,2),StyleCostingCustomField15)		AS StyleCostingCustomField15
	,CONVERT(DECIMAL(18,2),StyleCostingCustomField16)		AS StyleCostingCustomField16
	,CONVERT(DECIMAL(18,2),StyleCostingCustomField18*100)	AS StyleCostingCustomField18
	,StyleCostingCustomField19
	,CONVERT(DECIMAL(18,2),StyleCostingCustomField20)		AS StyleCostingCustomField20 
	,CONVERT(DECIMAL(18,2),StyleCostingCustomField21)		AS StyleCostingCustomField21
	,CONVERT(DECIMAL(18,2),StyleCostingCustomField22)		AS StyleCostingCustomField22
	,CONVERT(DECIMAL(18,2),StyleCostingCustomField23*100)	AS StyleCostingCustomField23
	,StyleID
	,StyleSeasonYearID
	,StyleCostingID
	,StyleCostingTypeID
	FROM pStyleCosting WHERE StyleID=@StyleID 
	--AND StyleSeasonYearID=@StyleSeasonYearID 
	AND StyleCostingID=@StyleCostingID
	AND StyleCostingTypeID=@StyleCostingTypeID
END



GO
IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='03109'))
BEGIN

	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.2.0000', '03109', GetDate())

END

GO
