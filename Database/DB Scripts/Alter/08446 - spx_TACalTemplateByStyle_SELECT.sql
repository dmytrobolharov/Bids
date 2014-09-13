IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_TACalTemplateByStyle_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_TACalTemplateByStyle_SELECT]
GO


CREATE PROCEDURE [dbo].[spx_TACalTemplateByStyle_SELECT](
	@SeasonYearID UNIQUEIDENTIFIER,
	@DivisionID UNIQUEIDENTIFIER
)
AS 
SELECT TACalTemplateId, TACalTemplateName 
FROM pTACalTemplate
WHERE SeasonYearId = @SeasonYearID 
AND TACalTemplateId IN (SELECT pTACalTemplateDivision.TACalTemplateID FROM pTACalTemplateDivision WHERE DivisionID = @DivisionID)
ORDER BY TACalTemplateName

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '08446', GetDate())
GO
