IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_MaterialCoreColorway_MultiCloth_SELECT]') AND type = N'P' )
	DROP PROCEDURE [dbo].[spx_MaterialCoreColorway_MultiCloth_SELECT]
GO


CREATE PROCEDURE [dbo].[spx_MaterialCoreColorway_MultiCloth_SELECT](
	@LinePlanColorGroupID UNIQUEIDENTIFIER,
	@MaterialCoreID UNIQUEIDENTIFIER,
	@MaterialID UNIQUEIDENTIFIER
)
AS 


select 
ISNULL(CAST(a.MaterialColorID AS NVARCHAR(40)),'') AS MaterialColorID ,
a.LinePlanMultiCloth2ColorTempID, a.MaterialCoreItemID
INTO #tmp
FROM pLinePlanMultiCloth2MaterialGroupItemTemp a
INNER JOIN pMaterial b ON b.MaterialID =  a.MaterialID
INNER JOIN pLinePlanMultiCloth2ColorTemp c ON c.LinePlanMultiCloth2ColorTempID = a.LinePlanMultiCloth2ColorTempID
WHERE c.MaterialID = @MaterialID
AND a.LinePlanColorGroupID = @LinePlanColorGroupID
AND a.MaterialCoreColorID IN ( 
	SELECT  MaterialCoreColorID
	FROM pLinePlanMultiCloth2ColorTemp -- 8
	WHERE LinePlanColorGroupID = @LinePlanColorGroupID
	AND MaterialCoreColorID <> '00000000-0000-0000-0000-000000000000'
	AND MaterialCoreColorID IS NOT NULL
)
order by a.MaterialCoreItemID,a.LinePlanMultiCloth2ColorTempID

SELECT 
a.Placement,				-- #01
b.MaterialID,
b.MaterialNo, b.MaterialName, 
'<img src="../System/Control/ImageStream.ashx?S=50&V='  +  ISNULL(CAST(b.MaterialImageVersion  AS NVARCHAR(5)),'0')+  
'&IID=' + ISNULL(CAST(b.MaterialImageID AS NVARCHAR(40)),'00000000-0000-0000-0000-000000000000') + '" />'
as ImagePath , #tmp.*
INTO #tmp2
FROM pMaterialCoreItem a
INNER JOIN pMaterial b ON a.MaterialID = b.MaterialID 
LEFT OUTER JOIN #tmp ON  a.MaterialCoreItemID  = #tmp.MaterialCoreItemID 
WHERE a.MaterialCoreID = @MaterialCoreID



--Finally we got it pivoting the table.
EXECUTE spx_Crosstab 'SELECT * FROM #tmp2',
NULL,
NULL,
'LinePlanMultiCloth2ColorTempID',
'MaterialColorID',
'MAX'

DROP TABLE #tmp
DROP TABLE #tmp2



GO



IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='01616'))
BEGIN
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '01616', GetDate())
END	

GO



