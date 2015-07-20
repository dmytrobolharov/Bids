
-- ******************************************************************************************** */
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Create Script                                                                              */
-- * Database:                                                                                  */
-- * 07 September 2011                                                                          */
-- * WorkItem #4944																				*/
-- * Copyright (c) 2002-2010 Gerber Technology, Inc.  All rights reserved.                      */
-- * This information is confidential and proprietary.  You may not disseminate it              */
-- * to any other party without the express written consent of Gerber Technology, Inc.          */
-- *                                                                                            */
-- ******************************************************************************************** */
-- ******************************************************************************************** */
-- COMMENTS
--
--
--

/****** Object:  StoredProcedure [dbo].[spx_StyleMaterialRollup_SELECT]    Script Date: 09/07/2011 16:45:04 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleMaterialRollup_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleMaterialRollup_SELECT]
GO

/****** Object:  StoredProcedure [dbo].[spx_StyleMaterialRollup_SELECT]    Script Date: 09/07/2011 16:45:04 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE  PROCEDURE [dbo].[spx_StyleMaterialRollup_SELECT]
(
@StyleId uniqueidentifier,
@StyleSet int
)
AS

/*
Declare @MaterialPrice1 DECIMAL(18,2)
Declare @MaterialPrice0 DECIMAL(18,2)
Set @MaterialPrice1 = 1.00
Set @MaterialPrice0 = 0.00

SELECT '   ' AS cellSpace, 'BOM Costing  ' AS [Cost Type ], '$' + CAST(CAST(SUM(ISNULL(CASE WHEN Qty<>@MaterialPrice0 THEN Qty ELSE @MaterialPrice1 END,1) * isnull(MaterialPrice,VolumePrice)) AS DECIMAL(18,2)) AS VARCHAR(10)) + '' AS [Total Cost], '   ' AS cellSpace1
FROM         dbo.pStyleMaterials
WHERE pStyleMaterials.StyleId = @StyleId AND pStyleMaterials.StyleSet = @StyleSet AND MaterialBOM = 1
GROUP BY StyleID, MaterialBOM
UNION ALL
SELECT '   ' AS cellSpace, 'Total Costing  ' AS [Cost Type ], '$' +  CAST(CAST(SUM(ISNULL(CASE WHEN Qty<>@MaterialPrice0 THEN Qty ELSE @MaterialPrice1 END,1) * isnull(MaterialPrice,VolumePrice)) AS DECIMAL(18,2)) AS VARCHAR(10)) + '' AS Total, '   ' AS cellSpace1
FROM         dbo.pStyleMaterials
WHERE pStyleMaterials.StyleId = @StyleId AND pStyleMaterials.StyleSet = @StyleSet
GROUP BY StyleID
*/


SELECT '   ' AS cellSpace, 'BOM Costing  ' AS [Cost Type ], '$' + CAST(CAST(SUM(ISNULL(Qty,1) * isnull(MaterialPrice,VolumePrice)) AS DECIMAL(18,2)) AS VARCHAR(10)) + '' AS [Total Cost], '   ' AS cellSpace1
FROM         dbo.pStyleMaterials
WHERE pStyleMaterials.StyleId = @StyleId AND pStyleMaterials.StyleSet = @StyleSet AND MaterialBOM = 1
GROUP BY StyleID, MaterialBOM
UNION ALL
SELECT '   ' AS cellSpace, 'Total Costing  ' AS [Cost Type ], '$' +  CAST(CAST(SUM(ISNULL(Qty,1) * isnull(MaterialPrice,VolumePrice)) AS DECIMAL(18,2)) AS VARCHAR(10)) + '' AS Total, '   ' AS cellSpace1
FROM         dbo.pStyleMaterials
WHERE pStyleMaterials.StyleId = @StyleId AND pStyleMaterials.StyleSet = @StyleSet
GROUP BY StyleID

GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='01903'))
BEGIN

	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '01903', GetDate())

END

GO

