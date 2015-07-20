CREATE TABLE #tmpSourcingFolder
(
	ROW_ID INT IDENTITY (1,1),
	SourcingHeaderID UNIQUEIDENTIFIER
)

INSERT INTO #tmpSourcingFolder SELECT SourcingHeaderID FROM pSourcingHeader

DECLARE @iRow INT
DECLARE @iCount INT
DECLARE @SourcingHeaderID UNIQUEIDENTIFIER

SET @iRow = 1
SELECT @iCount = COUNT(*) FROM #tmpSourcingFolder

WHILE @iRow <= @iCount
BEGIN

	SELECT @SourcingHeaderID = SourcingHeaderID FROM #tmpSourcingFolder WHERE ROW_ID = @iRow
	
	IF NOT EXISTS (SELECT * FROM pSourcingHeaderToStyleType WHERE SourcingHeaderID = @SourcingHeaderID)
		AND NOT EXISTS (SELECT * FROM pSourcingHeaderToStyleCategory WHERE SourcingHeaderID = @SourcingHeaderID)
	BEGIN

		INSERT INTO pSourcingHeaderToStyleType (StyleTypeID, SourcingHeaderID)
		SELECT DISTINCT pStyleHeader.StyleType, @SourcingHeaderID FROM pSourcingStyle
			INNER JOIN pStyleHeader ON pSourcingStyle.StyleID = pStyleHeader.StyleID
		WHERE pSourcingStyle.SourcingHeaderID = @SourcingHeaderID
		
		INSERT INTO pSourcingHeaderToStyleCategory (StyleCategoryID, SourcingHeaderID)
		SELECT DISTINCT pStyleHeader.StyleCategory, @SourcingHeaderID FROM pSourcingStyle
			INNER JOIN pStyleHeader ON pSourcingStyle.StyleID = pStyleHeader.StyleID
		WHERE pSourcingStyle.SourcingHeaderID = @SourcingHeaderID

	END
	
	SET @iRow = @iRow + 1
END

DROP TABLE #tmpSourcingFolder
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '06125', GetDate())
GO
