/****** Object:  StoredProcedure [dbo].[spx_Planning_LineLists_SELECT]    Script Date: 06/05/2014 14:38:05 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Planning_LineLists_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_Planning_LineLists_SELECT]
GO

/****** Object:  StoredProcedure [dbo].[spx_Planning_LineLists_SELECT]    Script Date: 06/05/2014 14:38:05 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[spx_Planning_LineLists_SELECT]
	@PlanningID UNIQUEIDENTIFIER,
	@SeasonYearID UNIQUEIDENTIFIER,
	@TeamID UNIQUEIDENTIFIER
AS
BEGIN
	
	SELECT CAST(LineSubFolder6 AS DATETIME) AS DueDate, lf.*
	FROM vwx_LineFolder_Header_SEL lf
	INNER JOIN fnx_Permissions_GetGuidProductTypePermissions(@TeamID, 3) alf ON alf.ProductTypeId = lf.LineListTypeID
	WHERE PlanningID = @PlanningID AND SeasonYearID = @SeasonYearID
		AND (alf.PermissionRoleId = 3 OR alf.PermissionView = 1)
	
END


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07915', GetDate())
GO