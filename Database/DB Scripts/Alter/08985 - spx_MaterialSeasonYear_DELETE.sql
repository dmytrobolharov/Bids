/****** Object:  StoredProcedure [dbo].[spx_MaterialSeasonYear_DELETE]    Script Date: 08/23/2014 15:56:05 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_MaterialSeasonYear_DELETE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_MaterialSeasonYear_DELETE]
GO

/****** Object:  StoredProcedure [dbo].[spx_MaterialSeasonYear_DELETE]    Script Date: 08/23/2014 15:56:05 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spx_MaterialSeasonYear_DELETE] (
@MaterialSeasonYearID UNIQUEIDENTIFIER 
)
AS
BEGIN
	DECLARE @MaterialID UNIQUEIDENTIFIER
	DECLARE @SeasonYearID UNIQUEIDENTIFIER
	SELECT @MaterialID = MaterialID, @SeasonYearID = SeasonYearID 
	FROM pMaterialSeasonYear 
	WHERE MaterialSeasonYearID = @MaterialSeasonYearID
	-- Removing the references to correspondent calendars
	DECLARE @TACalTemplateID UNIQUEIDENTIFIER
	
	DECLARE CalendarCursor CURSOR SCROLL FOR
	SELECT ct.TACalTemplateId FROM pTACalReference cr 
	INNER JOIN pTACalTemplate ct ON cr.TACalTemplateId = ct.TACalTemplateId
	WHERE ct.SeasonYearId = @SeasonYearID AND cr.ReferenceId = @MaterialID AND cr.TACalReferenceTypeId = 8
	
	OPEN CalendarCursor
	FETCH NEXT FROM CalendarCursor INTO @TACalTemplateID
	WHILE @@FETCH_STATUS = 0
	BEGIN
		EXEC spx_TACalReference_DELETE @TACalTemplateID, @MaterialID
		FETCH NEXT FROM CalendarCursor INTO @TACalTemplateID
	END
	CLOSE CalendarCursor
	DEALLOCATE CalendarCursor
	
	DELETE FROM pMaterialSeasonYear WHERE MaterialSeasonYearID = @MaterialSeasonYearID

END
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.0.0000', '08985', GetDate())
GO