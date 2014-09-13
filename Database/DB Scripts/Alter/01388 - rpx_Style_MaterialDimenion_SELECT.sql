IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[rpx_Style_MaterialDimenion_SELECT]') AND type = N'P' )
	DROP PROCEDURE [dbo].[rpx_Style_MaterialDimenion_SELECT]
GO


CREATE PROCEDURE [dbo].[rpx_Style_MaterialDimenion_SELECT]
(
	@StyleID varchar(50),
	@StyleSet int
)
AS

SELECT
	a.MaterialNo,
	a.MaterialName,
	a.MaterialSize,
	a.Qty,
	a.MaterialSizeA0,
	a.MaterialSizeA1,
	a.MaterialSizeA2,
	a.MaterialSizeA3,
	a.MaterialSizeA4,
	a.MaterialSizeA5,
	a.MaterialSizeA6,
	a.MaterialSizeA7,
	a.MaterialSizeA8,
	a.MaterialSizeA9,
	a.MaterialSizeA10,
	a.MaterialSizeA11,
	a.MaterialSizeA12,
	a.MaterialSizeA13,
	a.MaterialSizeA14,
	a.MaterialSizeA15,
	a.MaterialSizeA16,
	a.MaterialSizeA17,
	a.MaterialSizeA18,
	a.MaterialSizeA19,
	a.MaterialSizeB0,
	a.MaterialSizeB1,
	a.MaterialSizeB2,
	a.MaterialSizeB3,
	a.MaterialSizeB4,
	a.MaterialSizeB5,
	a.MaterialSizeB6,
	a.MaterialSizeB7,
	a.MaterialSizeB8,
	a.MaterialSizeB9,
	a.MaterialSizeB10,
	a.MaterialSizeB11,
	a.MaterialSizeB12,
	a.MaterialSizeB13,
	a.MaterialSizeB14,
	a.MaterialSizeB15,
	a.MaterialSizeB16,
	a.MaterialSizeB17,
	a.MaterialSizeB18,
	a.MaterialSizeB19,
	c.Size0,
	c.Size1,
	c.Size2,
	c.Size3,
	c.Size4,
	c.Size5,
	c.Size6,
	c.Size7,
	c.Size8,
	c.Size9,
	c.Size10,
	c.Size11,
	c.Size12,
	c.Size13,
	c.Size14,
	c.Size15,
	c.Size16,
	c.Size17,
	c.Size18,
	c.Size19
FROM pStyleMaterials a LEFT OUTER JOIN pStyleHeader b ON
	a.StyleID = b.StyleID LEFT OUTER JOIN pSizeRange c ON
	b.SizeRange = c.SizeRangeCode
WHERE a.StyleID = @StyleID AND a.StyleSet = @StyleSet AND a.MaterialDimension = 1
ORDER BY a.MaterialSort, a.MaterialNo, a.MaterialName, a.MaterialSize
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.1.0000', '01388', GETDATE())
GO