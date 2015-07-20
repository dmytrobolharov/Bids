
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

/****** Object:  StoredProcedure [dbo].[spx_GetStyleCostingType]    Script Date: 02/10/2012 16:59:43 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_GetStyleCostingType]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_GetStyleCostingType]
GO



/****** Object:  StoredProcedure [dbo].[spx_GetStyleCostingType]    Script Date: 02/10/2012 16:59:43 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spx_GetStyleCostingType](
@StyleID			UNIQUEIDENTIFIER
,@StyleSeasonYearID UNIQUEIDENTIFIER
,@ReportMapID		UNIQUEIDENTIFIER
,@ReportPageID		UNIQUEIDENTIFIER
)
AS 
BEGIN
	DECLARE @StyleCostingTypeID VARCHAR(5)
	--SET @StyleCostingTypeID=0
	
	SELECT @StyleCostingTypeID=StyleCostingTypeID FROM  pStyleCostingType WHERE StyleCostingType = 
	(
		SELECT ReportPagename FROM 	rReportStylePageItem 
		WHERE 	ReportMapID = @ReportMapID
		AND ReportPageActive = 1  
		AND  ReportPageID=@ReportPageID
	)
	
	
	
	IF @StyleCostingTypeID IS NOT NULL
	BEGIN
		SELECT pStyleCosting.StyleCostingID, pStyleCosting.StyleID,pStyleCosting.StyleSeasonYearID,pStyleCosting.StyleCostingTypeID, pStyleCosting.StyleCostingDate,
		pStyleCosting.StyleCostingStatus, pStyleCostingType.StyleCostingType, StyleCostingFreightTypeID, pStyleCosting.CUser, pStyleCosting.CDate,
		pStyleCosting.MUser, pStyleCosting.MDate
		FROM pStyleCosting INNER JOIN 
		pStyleCostingType ON pStyleCosting.StyleCostingTypeID = pStyleCostingType.StyleCostingTypeID 
		WHERE pStyleCosting.StyleID = @StyleID 
		--AND pStyleCosting.StyleSeasonYearID = @StyleSeasonYearID
		AND pStyleCosting.StyleCostingTypeID=@StyleCostingTypeID
		ORDER BY pStyleCosting.StyleCostingTypeID
	END 
END


GO
IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='03107'))
BEGIN

	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.2.0000', '03107', GetDate())

END

GO

