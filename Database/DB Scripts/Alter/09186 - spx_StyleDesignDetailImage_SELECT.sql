IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleDesignDetailImage_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleDesignDetailImage_SELECT]
GO

CREATE PROCEDURE  [dbo].[spx_StyleDesignDetailImage_SELECT]
(
	@StyleID UNIQUEIDENTIFIER
	, @StyleSet INT = NULL
)
AS
BEGIN
	SELECT *
	FROM pStyleImageItem
	WHERE StyleID = @StyleID
		AND (StyleSet = @StyleSet OR @StyleSet IS NULL)
		AND WorkflowID = '40000000-0000-0000-0000-000000000006'
	ORDER BY Sort, ImageId ASC
	
END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09186', GetDate())
GO