IF (SELECT COUNT(*) FROM pStyleCategorySubCategory) = 0
BEGIN
INSERT INTO pStyleCategorySubCategory (StyleCategoryId, SubCategoryId) 
(
  SELECT DISTINCT PlanningStyleCategoryID  AS StyleCategoryId, SubCategoryID 
  FROM pPlanningStyleCategoryToSubCategory
)
END
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07342', GetDate())
GO
