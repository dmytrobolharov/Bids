
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_LinePlanTemplateIndex_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_LinePlanTemplateIndex_SELECT]
GO



CREATE PROCEDURE dbo.spx_LinePlanTemplateIndex_SELECT (
@LinePlanID UNIQUEIDENTIFIER 
)
AS

DECLARE @LinePlanTemplateID  UNIQUEIDENTIFIER 
SELECT @LinePlanTemplateID = LinePlanTemplateID FROM pLinePlan WHERE LinePlanID = @LinePlanID 
SELECT COUNT(*) FROM pLinePlanTemplateItem WHERE LinePlanTemplateID = @LinePlanTemplateID


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '2.6.9999', '105', GetDate())

GO

