IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_MarkerImageSN_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_MarkerImageSN_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_MarkerImageSN_SELECT]
(
	@StyleID UNIQUEIDENTIFIER
	, @StyleSet INT
)
AS
BEGIN

	SELECT ID, Marker_Image_SN
	FROM pBodyMarker
	WHERE StyleID = @StyleID
		AND StyleSet = @StyleSet
		AND IsLinked = 1

END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.0.0001', '09201', GetDate())
GO