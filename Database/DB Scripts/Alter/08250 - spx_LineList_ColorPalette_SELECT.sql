IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_LineList_ColorPalette_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_LineList_ColorPalette_SELECT]
GO
/****** Object:  StoredProcedure [dbo].[spx_LineList_ColorPalette_SELECT]    Script Date: 07/09/2014 11:02:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[spx_LineList_ColorPalette_SELECT]
	@LineFolderID UNIQUEIDENTIFIER
	, @PlannigColor INT
	, @WhereExp NVARCHAR(MAX) = ''
AS
BEGIN
	DECLARE @SqlStr NVARCHAR(MAX)
	DECLARE @PlanningID NVARCHAR(50)
	DECLARE @SeasonYearID NVARCHAR(50)
	
	SELECT @PlanningID = CAST(PlanningID AS NVARCHAR(50)), @SeasonYearID = SeasonYearID FROM pLineFolder WHERE LineFolderID = @LineFolderID

	IF @PlannigColor = 1
		IF @SeasonYearID IS NOT NULL AND @SeasonYearID <> '00000000-0000-0000-0000-000000000000'
		BEGIN
			SET @SqlStr = 'SELECT * FROM (SELECT cp.*, pc.PlanningID FROM vwx_ColorPalette_Grid_SEL cp INNER JOIN pPlanningColor pc ON cp.ColorPaletteID = pc.ColorPaletteID WHERE SeasonYearID = ''' + @SeasonYearID + ''' AND PlanningColorDrop = 0) a WHERE Active = 1 AND PlanningID = ''' + @PlanningID + ''' ' + @WhereExp + ' ORDER BY Sort,L ,H ,S'
		END
		ELSE
		BEGIN
			SET @SqlStr = 'SELECT * FROM (SELECT cp.*, pc.PlanningID FROM vwx_ColorPalette_Grid_SEL cp INNER JOIN pPlanningColor pc ON cp.ColorPaletteID = pc.ColorPaletteID WHERE PlanningColorDrop = 0) a WHERE Active = 1 AND PlanningID = ''' + @PlanningID + ''' ' + @WhereExp + ' ORDER BY Sort,L ,H ,S'
		END
	ELSE
		SET @SqlStr = 'SELECT * FROM vwx_ColorPalette_Grid_SEL WHERE Active = 1 ' + @WhereExp + ' ORDER BY Sort,L ,H ,S'

	EXEC (@SqlStr)
END
GO
INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '08250', GetDate())
GO         