IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Get_TACalendarList_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_Get_TACalendarList_SELECT]
GO


CREATE PROCEDURE [dbo].[spx_Get_TACalendarList_SELECT]
	@FolderTypeId INT,
	@ProductID UNIQUEIDENTIFIER,
	@SeasonYearID UNIQUEIDENTIFIER = NULL
AS
BEGIN

	IF @SeasonYearID IS NOT NULL
	BEGIN
		SELECT * FROM pTACalTemplate ct 
			INNER JOIN pTACalReference cr ON ct.TACalTemplateId = cr.TACalTemplateId
		WHERE ct.SeasonYearId = @SeasonYearID AND cr.ReferenceId = @ProductID AND TACalReferenceTypeId = @FolderTypeId
	END
	ELSE
	BEGIN
		SELECT * FROM pTACalTemplate ct 
			INNER JOIN pTACalReference cr ON ct.TACalTemplateId = cr.TACalTemplateId
		WHERE cr.ReferenceId = @ProductID AND TACalReferenceTypeId = @FolderTypeId
	END

END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '08460', GetDate())
GO
