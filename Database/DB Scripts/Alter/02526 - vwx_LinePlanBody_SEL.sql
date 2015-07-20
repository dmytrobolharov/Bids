IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwx_LinePlanBody_SEL]'))
DROP VIEW [dbo].[vwx_LinePlanBody_SEL]
GO
/****** Object:  View [dbo].[vwx_LinePlanBody_SEL]    Script Date: 12/30/2011 18:00:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE VIEW [dbo].[vwx_LinePlanBody_SEL]
AS

SELECT  a.*,
'<img src=''../System/Control/ImageStream.ashx?S=60&V=' + CAST(a.ImageVersion AS NVARCHAR(5)) 
+ '&IID=' + CAST(a.ImageID AS NVARCHAR(40) ) + ''' /> ' AS ImagePath
FROM dbo.pBody a 

GO
IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='02526'))
BEGIN
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.2.0000', '02526', GetDate())
END
GO