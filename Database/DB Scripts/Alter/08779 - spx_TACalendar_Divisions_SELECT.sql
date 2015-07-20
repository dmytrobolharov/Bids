IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_TACalendar_Divisions_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_TACalendar_Divisions_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_TACalendar_Divisions_SELECT]
	@TACalTemplateID UNIQUEIDENTIFIER
AS

SELECT DivisionID, DivisionName, IsChecked 
FROM vwx_TACalTemplate_DropDownDivisions_SEL 
WHERE TACalTemplateId = @TACalTemplateId 
ORDER BY DivisionName


GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '08779', GetDate())
GO
