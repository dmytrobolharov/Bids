/****** Object:  StoredProcedure [dbo].[spx_LineFolderPlanningValues_SELECT]    Script Date: 03/20/2013 18:44:22 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_LineFolderPlanningValues_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_LineFolderPlanningValues_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_LineFolderPlanningValues_SELECT]
	@LineFolderID UNIQUEIDENTIFIER
AS
BEGIN
	
	declare @LinePlanFinancialIDList VARCHAR(MAX)
	SELECT @LinePlanFinancialIDList = COALESCE(@LinePlanFinancialIDList + ',', '') + 
	'[' + CAST(LineFolderFinancialID AS VARCHAR(50)) + ']'
	FROM pLineFolderFinancial WHERE Active = 1 AND Editable = 1 ORDER BY LineFolderFinancialSort
	
	declare @sql NVARCHAR(MAX) = 
		'SELECT Name, LineFolderDivisionID, LineFolderStyleTypeID, LineFolderStyleCategoryID, ' + @LinePlanFinancialIDList + '
		FROM (
			SELECT LineFolderPlanningCh, LineFolderDivisionID, LineFolderStyleTypeID, LineFolderStyleCategoryID, LineFolderFinancialID,
				COALESCE(LineFolderStyleCategory, LineFolderStyleTypeDescription, LineFolderDivision) as Name
			FROM pLineFolderBusiness WHERE LineFolderID = ''' + CAST(@LineFolderID as VARCHAR(40)) + '''
		) tbl
		PIVOT (MAX(LineFolderPlanningCh) FOR LineFolderFinancialID IN (' + @LinePlanFinancialIDList + ')) pvt'
	
	exec(@sql)
	
END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '05365', GetDate())
GO
