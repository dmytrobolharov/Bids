IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[rpx_POM_Library_Report_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[rpx_POM_Library_Report_SELECT]
GO

CREATE PROCEDURE [dbo].[rpx_POM_Library_Report_SELECT]

AS

SELECT
	pom_a.Row % 2 AS TableColumn
	, pom_a.Row / 2 AS TableRow
	, *
FROM (
	SELECT
		pom.Row-1 as Row
		, pom.POMCode
		, pom.POMDesc
		, pom.How2MeasText
		, a.AlternatesCode
		, a.AlternatesDesc
		, dbo.fnx_GetStreamingImageGRPOMPath(ISNULL(pom.ImageId,'00000000-0000-0000-0000-000000000000'), 200) AS ImageFile
		, pom.MDate
		, pom.Muser
	FROM (SELECT ROW_NUMBER() OVER(ORDER BY pomid DESC) AS Row, * FROM pGRMeasurementsPOM) pom
		LEFT JOIN pGRMeasurementsPOMAlternates a ON pom.POMId = a.POMId
	WHERE
		pom.Active = 1
) pom_a
ORDER BY
	pom_a.Row
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '10046', GetUTCDate())
GO