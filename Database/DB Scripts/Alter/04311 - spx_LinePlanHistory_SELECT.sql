IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_LinePlanHistory_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_LinePlanHistory_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_LinePlanHistory_SELECT](
	@TeamID UNIQUEIDENTIFIER
)
AS 
	
	SELECT a.LinePlanID,b.[Description],c.LinePlanTemplateName AS LinePlanType FROM pLinePlanHistory a
				INNER JOIN pLinePlan b ON a.LinePlanID = b.LinePlanID
				LEFT OUTER JOIN pLinePlanTemplate c ON b.LinePlanTemplateID = c.LinePlanTemplateID
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04311', GetDate())
GO
