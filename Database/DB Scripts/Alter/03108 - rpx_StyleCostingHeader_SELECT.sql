
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

/****** Object:  StoredProcedure [dbo].[rpx_StyleCostingHeader_SELECT]    Script Date: 02/10/2012 16:59:01 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[rpx_StyleCostingHeader_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[rpx_StyleCostingHeader_SELECT]
GO



/****** Object:  StoredProcedure [dbo].[rpx_StyleCostingHeader_SELECT]    Script Date: 02/10/2012 16:59:01 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[rpx_StyleCostingHeader_SELECT](
@StyleID VARCHAR(50)
,@StyleSeasonYearID VARCHAR(50)
)
AS 
BEGIN
	SELECT 
	CONVERT(DECIMAL(19,2),StyleCostingCustomField1) AS StyleCostingCustomField1 ,
	CONVERT(DECIMAL(19,2),StyleCostingCustomField2) AS StyleCostingCustomField2 ,
	CONVERT(DECIMAL(18,2),StyleCostingCustomField3) AS StyleCostingCustomField3  
	FROM pStyleCostingHeader WHERE StyleID = @StyleID 
	--AND StyleSeasonYearID = @StyleSeasonYearID
END



GO
IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='03108'))
BEGIN

	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.2.0000', '03108', GetDate())

END

GO

