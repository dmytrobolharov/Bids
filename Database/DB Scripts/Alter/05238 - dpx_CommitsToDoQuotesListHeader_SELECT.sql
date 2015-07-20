IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[dpx_CommitsToDoQuotesListHeader_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[dpx_CommitsToDoQuotesListHeader_SELECT]
GO

CREATE PROCEDURE [dbo].[dpx_CommitsToDoQuotesListHeader_SELECT]
	@CommitStatusID INT = NULL
AS
BEGIN
	IF @CommitStatusID IS NULL
		SELECT 'Commitment List' AS Value
	ELSE
		SELECT 'Commitment List' + ISNULL(' (' + Custom + ')', '') AS Value
		FROM (
			SELECT Custom, CustomKey FROM pStyleQuoteItemStatus
		) AS StatusTable
		WHERE CustomKey = @CommitStatusID
END


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '05238', GetDate())
GO
