
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_LinePlanIndex_SELECT]') AND type = N'P' )
	DROP PROCEDURE [dbo].[spx_LinePlanIndex_SELECT]
GO 

CREATE PROCEDURE [dbo].[spx_LinePlanIndex_SELECT](
	@LinePlanID UNIQUEIDENTIFIER 
)
AS


SELECT  COUNT(*) 
FROM dbo.pLinePlanTemplateItem a WITH(NOLOCK)
	INNER JOIN pLineplan b WITH(NOLOCK) ON a.LinePlanTemplateID = b.LinePlanTemplateID 
WHERE b.LinePlanID = @LinePlanID

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.1.0000', '01447', GetDate())
GO




