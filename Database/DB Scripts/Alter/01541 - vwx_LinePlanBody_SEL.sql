IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwx_LinePlanBody_SEL]'))
	DROP VIEW [dbo].[vwx_LinePlanBody_SEL]
GO


CREATE VIEW [dbo].[vwx_LinePlanBody_SEL]
AS

SELECT  a.*,
'<img src=''../System/Control/ImageStream.ashx?S=60&V=' + CAST(a.ImageVersion AS NVARCHAR(5)) 
+ '&IID=' + CAST(a.ImageID AS NVARCHAR(40) ) + ''' /> ' AS ImagePath
FROM dbo.pBody a 



GO


IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='01541'))
BEGIN
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '01541', GetDate())
END	

GO