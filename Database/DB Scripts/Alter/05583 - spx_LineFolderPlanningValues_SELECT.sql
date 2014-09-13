/****** Object:  StoredProcedure [dbo].[spx_LineFolderPlanningValues_SELECT]    Script Date: 04/16/2013 13:51:34 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_LineFolderPlanningValues_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_LineFolderPlanningValues_SELECT]
GO

/****** Object:  StoredProcedure [dbo].[spx_LineFolderPlanningValues_SELECT]    Script Date: 04/16/2013 13:51:34 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO



CREATE PROCEDURE [dbo].[spx_LineFolderPlanningValues_SELECT]
	@LineFolderID UNIQUEIDENTIFIER
AS
BEGIN
	
	DECLARE @LinePlanFinancialIDList VARCHAR(MAX)
	SELECT @LinePlanFinancialIDList = COALESCE(@LinePlanFinancialIDList + ',', '') + 
	'[' + CAST(LineFolderFinancialID AS VARCHAR(50)) + ']'
	FROM pLineFolderFinancial WHERE Active = 1 AND Editable = 1 ORDER BY LineFolderFinancialSort
	
	DECLARE @sql NVARCHAR(MAX) = 
		'SELECT Name, LineFolderStyleCategory, LineFolderStyleTypeDescription, LineFolderDivision, 
				LineFolderDivisionID, LineFolderStyleTypeID, LineFolderStyleCategoryID, ' + @LinePlanFinancialIDList + ',
		(
			SELECT COUNT(*) FROM pStyleCategoryStyleType scst
			INNER JOIN pLineFolderStyleCategory lfsc ON scst.StyleCategoryID = lfsc.StyleCategoryID
			WHERE LineFolderID=''' + CAST(@LineFolderID as VARCHAR(40)) + ''' AND scst.StyleTypeID = pvt.LineFolderStyleTypeID
		) AS CategoriesCount
		FROM (
			SELECT LineFolderPlanningCh, LineFolderDivisionID, LineFolderStyleTypeID, LineFolderStyleCategoryID, LineFolderFinancialID,
				COALESCE(LineFolderStyleCategory, LineFolderStyleTypeDescription, LineFolderDivision) as Name,
				LineFolderStyleCategory, LineFolderStyleTypeDescription, LineFolderDivision
			FROM pLineFolderBusiness WHERE LineFolderID = ''' + CAST(@LineFolderID as VARCHAR(40)) + '''
		) tbl
		PIVOT (MAX(LineFolderPlanningCh) FOR LineFolderFinancialID IN (' + @LinePlanFinancialIDList + ')) pvt
		ORDER BY CASE WHEN LineFolderStyleTypeID IS NULL AND LineFolderStyleCategoryID IS NULL THEN 1 ELSE 0 END'
	
	EXEC(@sql)
	
END




GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '05583', GetDate())
GO
