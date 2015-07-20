IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwx_Planning_SELECT]'))
DROP VIEW [dbo].[vwx_Planning_SELECT]
GO

CREATE VIEW [dbo].[vwx_Planning_SELECT]
AS
		SELECT     p.*, psy.PlanningSeason, psy.PlanningYear, psy.SeasonYearID, STUFF
      ((SELECT     ', ' + CAST(pd.DivisionID AS NVARCHAR(50))
          FROM      pPlanningDivision pd
          WHERE     pd.PlanningID = p.PlanningID FOR XML PATH('')), 1, 2, '') AS DivisionIDs, STUFF
      ((SELECT     ', ' + d .Custom
          FROM         iCustom1 d INNER JOIN
                                pPlanningDivision ON d .CustomID = pPlanningDivision.DivisionID
          WHERE     pPlanningDivision.PlanningID = p.PlanningID FOR XML PATH('')), 1, 2, '') AS Divisions, STUFF
      ((SELECT     ', ' + CAST(stype.StyleTypeID AS NVARCHAR(5))
          FROM         (SELECT DISTINCT dst.StyleTypeID
                                 FROM       pDivisionStyleType dst 
                                 INNER JOIN pPlanningDivision ON dst.DivisionID = pPlanningDivision.DivisionID
                                 WHERE      pPlanningDivision.PlanningID = p.PlanningID) stype FOR XML PATH('')), 1, 2, '') AS StyleTypeIDs, STUFF
      ((SELECT     ', ' + stype.StyleTypeDescription
          FROM         (SELECT DISTINCT st.StyleTypeDescription
                                 FROM          pStyleType st INNER JOIN
                                                        pDivisionStyleType dst ON st.StyleTypeID = dst.StyleTypeID INNER JOIN
                                                        pPlanningDivision ON dst.DivisionID = pPlanningDivision.DivisionID
                                 WHERE      pPlanningDivision.PlanningID = p.PlanningID) stype FOR XML PATH('')), 1, 2, '') AS StyleTypes, STUFF
      ((SELECT     ', ' + CAST(scategory.StyleCategoryID AS NVARCHAr(50))
          FROM         (SELECT DISTINCT scst.StyleCategoryID
						FROM pStyleCategoryStyleType scst 
						INNER JOIN pDivisionStyleType dst ON scst.StyleTypeID = dst.StyleTypeID 
						INNER JOIN pPlanningDivision ON dst.DivisionID = pPlanningDivision.DivisionID
						WHERE pPlanningDivision.PlanningID = p.PlanningID) scategory FOR XML PATH('')), 1, 2, '') AS StyleCategoryIDs, STUFF
      ((SELECT     ', ' + scategory.StyleCategory
          FROM         (SELECT DISTINCT sc.StyleCategory
		 FROM          pStyleCategory sc INNER JOIN
								pStyleCategoryStyleType scst ON sc.StyleCategoryId = scst.StyleCategoryID INNER JOIN
								pDivisionStyleType dst ON scst.StyleTypeID = dst.StyleTypeID INNER JOIN
								pPlanningDivision ON dst.DivisionID = pPlanningDivision.DivisionID
		 WHERE      pPlanningDivision.PlanningID = p.PlanningID) scategory FOR XML PATH('')), 1, 2, '') AS StyleCategories, pt.PlanningType 
		FROM pPlanning p 
		LEFT JOIN pPlanningSeasonYear psy ON p.PlanningID = psy.PlanningID
		LEFT JOIN pPlanningType pt ON p.PlanningTypeID = pt.PlanningTypeID


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07715', GetDate())
GO
