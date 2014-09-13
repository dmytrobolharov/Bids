IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[dpx_CommitsToDoStyleListHeader_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[dpx_CommitsToDoStyleListHeader_SELECT]
GO

CREATE PROCEDURE [dbo].[dpx_CommitsToDoStyleListHeader_SELECT]
	@CommitsStatusID INT = NULL
AS
BEGIN
	IF @CommitsStatusID IS NULL
		SELECT 'Style List' AS Value
	ELSE
		SELECT 'Style List' + ISNULL(' (' + Custom + ')', '') AS Value
		FROM (
			SELECT Custom, CustomKey FROM pStyleQuoteItemStatus
			UNION
			SELECT 'Without Commitments' AS Custom, 42 AS CustomKey
			UNION
			SELECT 'With Commitments' AS Custom, 100 AS CustomKey

		) AS StatusTable
		WHERE CustomKey = @CommitsStatusID
END


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '05187', GetDate())
GO
