IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Control_DivisionStyleType_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_Control_DivisionStyleType_SELECT]
GO


CREATE PROCEDURE [dbo].[spx_Control_DivisionStyleType_SELECT]
	@WorkflowTemplateID UNIQUEIDENTIFIER
AS
BEGIN	
	SELECT DivisionID, StyleTypeID, Name, Division, Filter FROM
    (
    	SELECT dst.DivisionID, st.StyleTypeID, st.StyleTypeDescription AS Name, ic1.Custom AS Division, ISNULL(Filter, 1) AS Filter
    	FROM pStyleType st
		INNER JOIN pDivisionStyleType dst ON st.StyleTypeID = dst.StyleTypeID
		INNER JOIN iCustom1 ic1 ON ic1.CustomID = dst.DivisionID
		LEFT JOIN pDivisionStyleTypeFilter dstf ON dst.DivisionStyleTypeID = dstf.DivisionStyleTypeID AND dstf.WorkflowTemplateID = @WorkflowTemplateID
		UNION		
		SELECT dst.DivisionID, NULL AS StyleTypeID, ic1.Custom AS Name, ic1.Custom AS Division, 0 AS Filter FROM pStyleType st
		INNER JOIN pDivisionStyleType dst ON st.StyleTypeID = dst.StyleTypeID
		INNER JOIN iCustom1 ic1 ON ic1.CustomID = dst.DivisionID 
	) t
	ORDER BY DivisionID, StyleTypeID
END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '08329', GetDate())
GO
