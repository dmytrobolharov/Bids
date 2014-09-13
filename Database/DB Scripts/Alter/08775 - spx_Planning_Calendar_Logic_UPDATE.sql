IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Planning_Calendar_Logic_UPDATE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_Planning_Calendar_Logic_UPDATE]
GO

CREATE PROCEDURE [dbo].[spx_Planning_Calendar_Logic_UPDATE]
	@PlanningTACalendarID UNIQUEIDENTIFIER,
	@DivisionIDs NVARCHAR(MAX),
	@UpdateSQL NVARCHAR(MAX)
AS

DECLARE @WhereSQL NVARCHAR(MAX)
	
SET @WhereSQL = SUBSTRING(@UpdateSQL, CHARINDEX(' where', LOWER(@UpdateSQL)), LEN(@UpdateSQL))
SET @UpdateSQL = SUBSTRING(@UpdateSQL, CHARINDEX(' set ', LOWER(@UpdateSQL)) + LEN(' set '), LEN(@UpdateSQL))
SET @UpdateSQL = SUBSTRING(@UpdateSQL, 1, CHARINDEX(' where', LOWER(@UpdateSQL)))

IF LTRIM(RTRIM(@UpdateSQL)) <> ''
BEGIN
	
	SELECT * INTO ##temp FROM fnx_Split(@UpdateSQL, ',')

	DECLARE @Row INT = 1, @Total INT = (SELECT COUNT(*) FROM ##temp)

	WHILE @Row <= @Total
	BEGIN
		DECLARE @Field NVARCHAR(500) = (SELECT value FROM ##temp WHERE position = @Row)
		DECLARE @UpdateFieldSQL NVARCHAR(MAX) = 
			'UPDATE vwx_PlanningTACalendar_SEL SET ' + @Field + @WhereSQL
		
		EXEC sp_executesql @UpdateFieldSQL

		SET @Row = @Row + 1
	END
	
	DROP TABLE ##temp	
END

-- update divisions
DELETE cd FROM pTACalTemplateDivision cd
INNER JOIN pPlanningTACalendar pc ON cd.TACalTemplateID = pc.TACalTemplateID
WHERE pc.PlanningTACalendarID = @PlanningTACalendarID

INSERT INTO pTACalTemplateDivision(TACalTemplateID, DivisionID)
SELECT pc.TACalTemplateID, d.value FROM pPlanningTACalendar pc
CROSS JOIN dbo.fnx_Split(@DivisionIDs, ',') d
WHERE pc.PlanningTACalendarID = @PlanningTACalendarID
	

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '08775', GetDate())
GO
