IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[rpx_Style_SizeConstructionGrid_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[rpx_Style_SizeConstructionGrid_SELECT]
GO


CREATE PROCEDURE [dbo].[rpx_Style_SizeConstructionGrid_SELECT]
	@StyleID VARCHAR(50),
	@StyleSet INT
AS

SELECT
	pSizeHome.Custom AS StyleDetailCustom1, 
	pStyleDetailGrid.StyleDetailCustom1 AS GridCustom1,
	pStyleDetailGrid.StyleDetailCustom2, 
	pStyleDetailGrid.StyleDetailCustom3, 
	pStyleDetailGrid.StyleDetailCustom4, 	
	pStyleDetailGrid.StyleDetailCustom5,
	pStyleDetailGrid.StyleDetailCustom6,
	pStyleDetailGrid.StyleDetailCustom7,
	pStyleDetailGrid.StyleDetailCustom8,
	pStyleDetailGrid.StyleDetailCustom9,
	pStyleDetailGrid.StyleDetailCustom10, 
	pStyleDetailGrid.Sort,
	pStyleDevelopmentItem.StyleDevelopmentName
FROM pStyleDetailGrid
	INNER JOIN pStyleDevelopmentItem ON	pStyleDevelopmentItem.StyleID = pStyleDetailGrid.StyleID
	LEFT OUTER JOIN pSizeHome ON	pStyleDetailGrid.SizeHomeID = pSizeHome.CustomKey
WHERE pStyleDetailGrid.StyleID = @StyleID
	AND pStyleDetailGrid.StyleSet = @StyleSet
ORDER BY
	pStyleDetailGrid.Sort,
	pSizeHome.Custom
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '03459', GetDate())
GO