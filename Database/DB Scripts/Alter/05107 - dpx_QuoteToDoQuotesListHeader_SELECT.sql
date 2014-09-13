IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[dpx_QuoteToDoQuotesListHeader_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[dpx_QuoteToDoQuotesListHeader_SELECT]
GO

CREATE PROCEDURE [dbo].[dpx_QuoteToDoQuotesListHeader_SELECT]
	@QuoteStatusID INT = NULL
AS
BEGIN
	IF @QuoteStatusID IS NULL
		SELECT 'Quote List' AS Value
	ELSE
		SELECT 'Quote List' + ISNULL(' (' + Custom + ')', '') AS Value
		FROM (
			SELECT Custom, CustomKey FROM pStyleQuoteItemStatus
			UNION
			SELECT 'Has BOM Options' AS Custom, 200 AS CustomKey
		) AS StatusTable
		WHERE CustomKey = @QuoteStatusID
END
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '05107', GetDate())
GO
