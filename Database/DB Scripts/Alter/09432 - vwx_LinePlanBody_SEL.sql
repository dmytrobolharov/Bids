IF OBJECT_ID(N'[dbo].[vwx_LinePlanBody_SEL]') IS NOT NULL
 DROP VIEW [dbo].[vwx_LinePlanBody_SEL]
GO

CREATE VIEW [dbo].[vwx_LinePlanBody_SEL]
AS

SELECT  a.*,
'<img src=''../System/Control/ImageStream.ashx?S=60&V=' + CAST(a.ImageVersion AS NVARCHAR(5)) 
+ '&IID=' + CAST(a.ImageID AS NVARCHAR(40) ) + ''' /> ' AS ImagePath
FROM dbo.pBody a 


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09432', GetDate())
GO
