
-- ******************************************************************************************** */
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Create Script                                                                              */
-- * Database:                                                                                  */
-- * 15 Feb 2011																				*/
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
/****** Object:  StoredProcedure [dbo].[spx_GetCostingTypeExists]    Script Date: 02/15/2012 16:14:30 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_GetCostingTypeExists]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_GetCostingTypeExists]
GO



/****** Object:  StoredProcedure [dbo].[spx_GetCostingTypeExists]    Script Date: 02/15/2012 16:14:30 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[spx_GetCostingTypeExists](
@StyleID			UNIQUEIDENTIFIER
,@StyleCostingType	NVARCHAR(100)
)
AS 
BEGIN
	--SELECT COUNT(StyleCostingType) FROM pstylecostingtype WHERE StyleCostingType=@StyleCostingType AND Active=1
	
	DECLARE @StyleCostingTypeID VARCHAR(5)
	
	
	SELECT @StyleCostingTypeID=StyleCostingTypeID FROM  pStyleCostingType WHERE StyleCostingType = @StyleCostingType AND Active=1
	
	IF @StyleCostingTypeID IS NOT NULL
	BEGIN
		SELECT COUNT(*)
		FROM pStyleCosting INNER JOIN 
		pStyleCostingType ON pStyleCosting.StyleCostingTypeID = pStyleCostingType.StyleCostingTypeID 
		WHERE pStyleCosting.StyleID = @StyleID
		AND pStyleCosting.StyleCostingTypeID=@StyleCostingTypeID
	END 
END
	
GO
IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='03125'))
BEGIN

	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.2.0000', '03125', GetDate())

END

GO

