IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleHistory_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleHistory_INSERT]
GO

CREATE PROCEDURE [dbo].[spx_StyleHistory_INSERT]
(
	@StyleID UNIQUEIDENTIFIER
	, @TeamID UNIQUEIDENTIFIER
	, @CreatedDate DATETIME
)
AS
BEGIN
	DECLARE @IsSilho BIT
	SELECT @IsSilho = stt.IsSilhouette
	FROM pStyleHeader sh
		INNER JOIN pStyleType st ON sh.StyleType = st.StyleTypeID
		INNER JOIN pStyleTypeTemplate stt ON st.StyleTypeTemplateID = stt.StyleTypeTemplateID
	WHERE sh.StyleID = @StyleID

	MERGE pStyleHistory tgt
	USING (SELECT @TeamID, @StyleID, @CreatedDate, @IsSilho) AS src (TeamID, StyleID, CDate, IsSilho)
	ON src.TeamID = tgt.TeamID AND src.StyleID = tgt.StyleID AND src.IsSilho = tgt.IsSilho
	WHEN MATCHED THEN
		UPDATE SET CDate = src.CDate
	WHEN NOT MATCHED THEN
		INSERT (TeamID, StyleID, CDate, IsSilho)
		VALUES (src.TeamID, src.StyleID, src.CDate, src.IsSilho);
	
	;WITH sh AS (
		SELECT ROW_NUMBER() OVER (ORDER BY CDate DESC) AS RowNum, *
		FROM pStyleHistory
		WHERE IsSilho = @IsSilho
			AND TeamID = @TeamID
	)
	DELETE FROM sh WHERE sh.RowNum > 10
END
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '10422', GetUTCDate())
GO
