
/****** Object:  View [dbo].[vwx_UOM_List_SELECT]    Script Date: 01/03/2012 22:03:32 ******/
IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwx_UOM_List_SELECT]'))
DROP VIEW [dbo].[vwx_UOM_List_SELECT]
GO

CREATE VIEW [dbo].[vwx_UOM_List_SELECT]
AS


SELECT     
	UOMId, 
	UOM, 
	UOMValue, 
	UOMSort, 
	Active, 
	CUser, 
	CDate, 
	MUser, 
	MDate
FROM 
	dbo.UOM


GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='02533'))
BEGIN
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.2.0000', '02533', GetDate())
END
GO