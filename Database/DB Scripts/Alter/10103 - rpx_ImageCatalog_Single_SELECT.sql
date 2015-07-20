IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[rpx_ImageCatalog_Single_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[rpx_ImageCatalog_Single_SELECT]
GO


SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[rpx_ImageCatalog_Single_SELECT]
	@ImageCatalogID UNIQUEIDENTIFIER
AS
	SELECT pi.ImageKeywords
		, (dbo.fnx_GetStreamingImagePath(ci.ImageID, ci.ImageVersion, 2000)) AS FilePath
	FROM pImageCatalogItem ci
		INNER JOIN pImage pi ON ci.ImageID = pi.ImageID
	WHERE ci.ImageCatalogID = @ImageCatalogID
	ORDER BY ci.ImageSort, pi.ImageNo



GO




INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '10103', GetUTCDate())
GO