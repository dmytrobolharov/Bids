IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[dpx_QuoteToDoStyleListHeader_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[dpx_QuoteToDoStyleListHeader_SELECT]
GO

CREATE PROCEDURE [dbo].[dpx_QuoteToDoStyleListHeader_SELECT]
	@QuoteStatusID INT = NULL
AS
BEGIN
	IF @QuoteStatusID IS NULL
		SELECT 'Style List' AS Value
	ELSE
		SELECT 'Style List' + ISNULL(' (' + Custom + ')', '') AS Value
		FROM (
			SELECT Custom, CustomKey FROM pStyleQuoteItemStatus
			UNION
			SELECT 'Without Quotes' AS Custom, 42 AS CustomKey
			UNION
			SELECT 'Commited' AS Custom, -1 AS CustomKey
			UNION
			SELECT 'With Quotes' AS Custom, 100 AS CustomKey
			UNION
			SELECT 'Has BOM Options' AS Custom, 200 AS CustomKey
		) AS StatusTable
		WHERE CustomKey = @QuoteStatusID
END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '05069', GetDate())
GO
