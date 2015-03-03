IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleMarkerImagesUpdate_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE spx_StyleMarkerImagesUpdate_SELECT
GO

CREATE PROCEDURE spx_StyleMarkerImagesUpdate_SELECT
(
	@StyleID UNIQUEIDENTIFIER
)
AS

BEGIN

	SELECT ID, Marker_Image_SN
	FROM pBodyMarker
	WHERE StyleID = @StyleID AND IsLinked = 1

END
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.0.0001', '09161', GetDate())
GO
