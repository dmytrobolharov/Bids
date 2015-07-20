/****** Object:  StoredProcedure [dbo].[spx_LineFolder_MerchandiseAttribute_SELECT]    Script Date: 07/07/2014 15:48:36 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_LineFolder_MerchandiseAttribute_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_LineFolder_MerchandiseAttribute_SELECT]
GO

/****** Object:  StoredProcedure [dbo].[spx_LineFolder_MerchandiseAttribute_SELECT]    Script Date: 07/07/2014 15:48:36 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[spx_LineFolder_MerchandiseAttribute_SELECT]
	@LineFolderID UNIQUEIDENTIFIER
AS
BEGIN
	
	DECLARE @PlanningID UNIQUEIDENTIFIER
	DECLARE @DivisionID UNIQUEIDENTIFIER
	
	SELECT @DivisionID = LineFolderDivisionID, @PlanningID = PlanningID 
	FROM pLineFolder WHERE LineFolderID = @LineFolderID

	;WITH PB as (
		SELECT PlanningDivisionID, PlanningStyleTypeID, PlanningStyleCategoryID, PlanningID, PlanningFinancialID, 
			SUM(ISNULL(PlanningPlanningCh, 0)) AS PlanningPlanningCh, 
			SUM(ISNULL(PlanningActualCh, 0)) AS PlanningActualCh, 
			SUM(ISNULL(PlanningDIPCh, 0)) AS PlanningDIPCh
		FROM pPlanningBusiness
		WHERE PlanningID = @PlanningID
		GROUP BY PlanningDivisionID, PlanningStyleTypeID, PlanningStyleCategoryID, PlanningID, PlanningFinancialID
	)
	SELECT DISTINCT vw.*, CASE 
	WHEN vw.AttributeLevel = 1 THEN 1 -- divisions level
	WHEN vw.AttributeLevel IN (2,3) AND pb.PlanningPlanningCh > 0 OR pb.PlanningDIPCh > 0 OR pb.PlanningActualCh > 0 THEN 1 
	ELSE 0 
	END IsVisible 
	FROM vwx_Division_StyleType_StyleCategory_SELECT vw
		INNER JOIN pStyleType st ON vw.StyleTypeID = st.StyleTypeID OR vw.StyleTypeID IS NULL
		INNER JOIN pStyleTypeTemplate stt ON st.StyleTypeTemplateID = stt.StyleTypeTemplateID AND stt.StyleTypeTemplateName = 'Style'
		INNER JOIN pPlanningDivision pd ON vw.DivisionID = pd.DivisionID AND pd.PlanningID = @PlanningID		
		LEFT JOIN PB pb ON vw.DivisionID = pb.PlanningDivisionID 
			AND ISNULL(vw.StyleTypeID,'0') = ISNULL(pb.PlanningStyleTypeID, '0')
			AND ISNULL(vw.StyleCategoryID,'00000000-0000-0000-0000-000000000000') = ISNULL(pb.PlanningStyleCategoryID, '00000000-0000-0000-0000-000000000000')
			AND pb.PlanningID = @PlanningID
			AND pb.PlanningFinancialID = '10000000-0000-0000-0000-000000000000' -- Number of Styles
	WHERE vw.StyleTypeID IS NULL OR vw.StyleTypeID IN (SELECT StyleTypeID FROM pLineFolderStyleType WHERE LineFolderID = @LineFolderID)
	AND vw.StyleCategoryID IS NULL OR vw.StyleCategoryID IN (SELECT StyleCategoryID FROM pLineFolderStyleCategory WHERE LineFolderID = @LineFolderID)
	AND vw.DivisionID = @DivisionID
	ORDER BY vw.DivisionName, vw.StyleTypeDescription, vw.StyleCategory
END


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '08239', GetDate())
GO
