IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[vwx_MaterialLinePlanSearch_SEL]') AND type = N'V' )
	DROP VIEW [dbo].[vwx_MaterialLinePlanSearch_SEL]
GO 

CREATE VIEW dbo.vwx_MaterialLinePlanSearch_SEL
AS


SELECT a.MaterialID, a.MaterialType, a.MaterialNo, a.MaterialName, 
a.A, a.B, a.C, a.D, a.F, a.G, a.Source, a.Notes, a.VolumePrice, a.CUser,
a.CDate, a.Active,
'<img src="../System/Control/ImageStream.ashx?S=050&V=' + CAST(a.MaterialImageVersion AS NVARCHAR(10)) + 
'&IID=' + CAST(a.MaterialImageID AS NVARCHAR(40)) +  '" />'
 AS ImagePath
FROM dbo.pMaterial a WITH(NOLOCK)

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.1.0000', '01416', GetDate())

GO
