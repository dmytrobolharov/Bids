-- ******************************************************************************************** */
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Alter Script                                                                               */
-- * Database:                                                                                  */
-- * 16 August 2012                                                                             */
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
--
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET NOCOUNT ON
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleCostingLogic_FromFlashEdit_UPDATE]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[spx_StyleCostingLogic_FromFlashEdit_UPDATE]
GO


CREATE PROCEDURE [dbo].[spx_StyleCostingLogic_FromFlashEdit_UPDATE](
	@StyleCostingHeaderId UNIQUEIDENTIFIER
)
AS 
	DECLARE @StyleID UNIQUEIDENTIFIER,
		@StyleSeasonYearID UNIQUEIDENTIFIER


	SELECT @StyleID=StyleID, @StyleSeasonYearID=StyleSeasonYearID
	FROM dbo.pStyleCostingHeader  WITH (NOLOCK) WHERE StyleCostingHeaderID = @StyleCostingHeaderId 

	CREATE TABLE #tmpCosting (
		RowID INT IDENTITY,
		StyleCostingID UNIQUEIDENTIFIER
	)
	DECLARE @iROW INT, @iCount INT
	DECLARE @StyleCostingId UNIQUEIDENTIFIER

	INSERT INTO #tmpCosting (StyleCostingID) 
	SELECT StyleCostingID FROM pStyleCosting WHERE StyleID = @StyleID AND StyleSeasonYearID = @StyleSeasonYearID

	SET @iROW = 1
	SELECT @iCount = (SELECT COUNT(*) FROM #tmpCosting)

	WHILE @iROW <= @iCount
	BEGIN
		SELECT @StyleCostingId = StyleCostingID FROM #tmpCosting WHERE RowID = @iROW
		exec spx_StyleCostingLogic_UPDATE @StyleCostingId = @StyleCostingId, @StyleSeasonYearID = @StyleSeasonYearID, @FromFlashEdit = '1'
		SET @iROW = @iROW + 1
	END
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '03780', GetDate())
GO
