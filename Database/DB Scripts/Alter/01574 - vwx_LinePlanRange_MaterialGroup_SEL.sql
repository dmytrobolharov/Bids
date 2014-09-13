IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[vwx_LinePlanRange_MaterialGroup_SEL]') AND type = N'V' )
	DROP VIEW [dbo].[vwx_LinePlanRange_MaterialGroup_SEL]
GO


CREATE VIEW [dbo].[vwx_LinePlanRange_MaterialGroup_SEL]
AS

SELECT  FOO.LinePlanRangeID, a.* 
FROM (
	SELECT b.MaterialCoreID, a.LinePlanRangeID
	FROM pLinePlanItem a 
	INNER JOIN pStyleHeader b ON a.StyleID = b.StyleID 
	INNER JOIN pMaterialCore  c ON c.MaterialCoreID  = b.MaterialCoreID
	WHERE b.MaterialCoreID IS NOT NULL 
	GROUP BY b.MaterialCoreID, a.LinePlanRangeID
) AS FOO 
INNER JOIN pMaterialCore a ON FOO.MaterialCoreID = a.MaterialCoreID

GO


IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='01574'))
BEGIN
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '01574', GetDate())
END	

GO
