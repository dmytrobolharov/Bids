IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_LineList_ColorPalette_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_LineList_ColorPalette_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_LineList_ColorPalette_SELECT]
	@LineFolderID UNIQUEIDENTIFIER
	, @PlannigColor INT
	, @WhereExp NVARCHAR(MAX) = ''
AS
BEGIN
	DECLARE @SqlStr NVARCHAR(MAX)
	DECLARE @PlanningID NVARCHAR(50)
	
	SELECT @PlanningID = CAST(PlanningID AS NVARCHAR(50)) FROM pLineFolder WHERE LineFolderID = @LineFolderID

	IF @PlannigColor = 1
		SET @SqlStr = 'SELECT * FROM (SELECT cp.*, pc.PlanningID FROM pColorPalette cp INNER JOIN pPlanningColor pc ON cp.ColorPaletteID = pc.ColorPaletteID) a WHERE Active = 1 AND PlanningID = ''' + @PlanningID + ''' ' + @WhereExp + ' ORDER BY Sort,L ,H ,S'
	ELSE
		SET @SqlStr = 'SELECT * FROM pColorPalette WHERE Active = 1 ' + @WhereExp + ' ORDER BY Sort,L ,H ,S'

	EXEC (@SqlStr)
END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '06432', GetDate())
GO
