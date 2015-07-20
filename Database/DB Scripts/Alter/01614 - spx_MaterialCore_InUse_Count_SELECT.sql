IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_MaterialCore_InUse_Count_SELECT]') AND type = N'P' )
	DROP PROCEDURE [dbo].[spx_MaterialCore_InUse_Count_SELECT]
GO

CREATE PROCEDURE dbo.spx_MaterialCore_InUse_Count_SELECT(
@MaterialCoreID UNIQUEIDENTIFIER
)
AS


SELECT COUNT(*) FROM pStyleHeader 
WHERE MaterialCoreID = @MaterialCoreID



GO


IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='01614'))
BEGIN
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '01614', GetDate())
END	

GO
