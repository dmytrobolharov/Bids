IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_WorkflowTemplateFiltered_ByDivision_ByStyleType_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_WorkflowTemplateFiltered_ByDivision_ByStyleType_SELECT]
GO


CREATE PROCEDURE [dbo].[spx_WorkflowTemplateFiltered_ByDivision_ByStyleType_SELECT]
	@DivisionID NVARCHAR(50)
	, @StyleTypeID INT
	, @OrderBy NVARCHAR(200)
AS
BEGIN

	DECLARE @sqlQuery NVARCHAR(MAX)
	
	SET @sqlQuery = 'SELECT NULL as WorkflowTemplateID, '''' as TemplateName ' +
					'UNION ' +
					'SELECT a.WorkflowTemplateID, a.TemplateName FROM pWorkflowTemplate a ' +
					'INNER JOIN pDivisionStyleType b ON b.StyleTypeID = @StyleTypeID AND b.DivisionID = @DivisionID ' +
					'LEFT JOIN pDivisionStyleTypeFilter c ON a.WorkflowTemplateID = c.WorkflowTemplateID AND b.DivisionStyleTypeID = c.DivisionStyleTypeID ' + 
					'WHERE (Active = 1 And Body = 0 And (c.Filter = 1 OR c.WorkflowTemplateID IS NULL)) '
					
	IF @OrderBy IS NOT NULL AND @OrderBy <> ''
	BEGIN
		SET @sqlQuery = 'SELECT * FROM (' + @sqlQuery + ') t ORDER BY ' + @OrderBy
	END
	ELSE
	BEGIN
		SET @sqlQuery = 'SELECT * FROM (' + @sqlQuery + ') t ORDER BY TemplateName'
	END
	
	exec sp_executesql @sqlQuery,
		N'@DivisionID nvarchar(50), @StyleTypeID int',
		@DivisionID = @DivisionID,
		@StyleTypeID = @StyleTypeID	

END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '08332', GetDate())
GO
