IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleCostingHeader_FromLineList_UPDATE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleCostingHeader_FromLineList_UPDATE]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spx_StyleCostingHeader_FromLineList_UPDATE] (
	@LineFolderItemID UNIQUEIDENTIFIER,
	@ModifiedBy VARCHAR(200),
	@ModifiedDate DATETIME
)
AS
BEGIN

DECLARE @StyleID UNIQUEIDENTIFIER
SELECT @StyleID = StyleID FROM vwx_LineListFlashCosting_SELECT WHERE LineFolderItemID = @LineFolderItemID

CREATE TABLE #tmpCostingHeader
(
	 ROW_ID INT IDENTITY,
	 StyleCostingHeaderID UNIQUEIDENTIFIER,
	 StyleSeasonYearID UNIQUEIDENTIFIER
)

INSERT INTO #tmpCostingHeader (StyleCostingHeaderId, StyleSeasonYearID)
SELECT StyleCostingHeaderID, StyleSeasonYearID FROM pStyleCostingHeader WHERE StyleID = @StyleID

DECLARE @StyleCostingHeaderId UNIQUEIDENTIFIER
DECLARE @StyleSeasonYearId UNIQUEIDENTIFIER
DECLARE @WholesalePrice DECIMAL(18,4)
DECLARE @RetailPrice DECIMAL(18,4)
DECLARE @FlashCostLDP DECIMAL(18,6)

SELECT @WholesalePrice = WholesalePrice FROM pLineListFlashCosting WHERE LineFolderItemID = @LineFolderItemID
SELECT @RetailPrice = RetailPrice FROM pLineListFlashCosting WHERE LineFolderItemID = @LineFolderItemID
SELECT @FlashCostLDP = FlashCostLDP FROM pLineListFlashCosting WHERE LineFolderItemID = @LineFolderItemID

DECLARE @iRow INT
DECLARE @iCount INT
SELECT @iCount = COUNT(*) FROM #tmpCostingHeader
SET @iRow = 1

WHILE @iRow <= @iCount
BEGIN
	SELECT @StyleCostingHeaderId = StyleCostingHeaderID, @StyleSeasonYearId = StyleSeasonYearID FROM #tmpCostingHeader WHERE ROW_ID = @iRow
	
	UPDATE pStyleCostingHeader
	SET	StyleCostingCustomField1 = @WholesalePrice,
		StyleCostingCustomField2 = @RetailPrice
	WHERE StyleCostingHeaderID = @StyleCostingHeaderId
	
	IF @WholesalePrice <> 0
		UPDATE pStyleCostingHeader SET StyleCostingCustomField9 = (@WholesalePrice - @FlashCostLDP)/@WholesalePrice
	ELSE	
		UPDATE pStyleCostingHeader SET StyleCostingCustomField9 = 0
		

	EXEC spx_StyleCostingHeaderLogic_UPDATE
			@StyleID = @StyleID,
			@ModifiedBy = @ModifiedBy,
			@ModifiedDate = @ModifiedDate,
			@StyleSeasonYearID = @StyleSeasonYearID
	
	
	SET @iRow = @iRow + 1
END

DROP TABLE #tmpCostingHeader

END
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '04695', GetDate())
GO
