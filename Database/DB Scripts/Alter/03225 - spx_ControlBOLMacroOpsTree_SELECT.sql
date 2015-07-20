IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_ControlBOLMacroOpsTree_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_ControlBOLMacroOpsTree_SELECT]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spx_ControlBOLMacroOpsTree_SELECT] 
AS 

DECLARE @NumSpaceChar INT = 5

SELECT CategoryId as ID, NULL as ParentID, CategoryName as Name, Active, 
	CategoryName as CategoryName, CategoryId as Sort1, 
	NULL as SubcategoryName, NULL as Sort2, 
	0 as [Level] 
FROM pBOLMacroCategory
WHERE Active = 1

UNION

SELECT s.SubcategoryId as ID, s.CategoryId as ParentID, REPLICATE('&nbsp;',@NumSpaceChar*1) + s.SubcategoryName as Name, s.Active, 
	CategoryName as CategoryName, c.CategoryId as Sort1, 
	s.SubcategoryName as SubcategoryName, s.SubcategoryId as Sort2, 
	1 as [Level] 
FROM pBOLMacroSubcategory s 
	INNER JOIN pBOLMacroCategory c ON s.CategoryId = c.CategoryId
WHERE s.Active = 1 
	AND s.CategoryId IN (SELECT CategoryId FROM pBOLMacroCategory WHERE Active = 1)

UNION

SELECT t.TypeId as ID, t.SubcategoryId as ParentID, REPLICATE('&nbsp;',@NumSpaceChar*2) + t.TypeName as Name, s.Active, 
	CategoryName as CategoryName, c.CategoryId as Sort1, 
	s.SubcategoryName as SubcategoryName, s.SubcategoryId as Sort2, 
	2 as [Level] 
FROM pBOLMacroType t 
	INNER JOIN pBOLMacroSubcategory s ON t.SubcategoryId = s.SubcategoryId
	INNER JOIN pBOLMacroCategory c ON s.CategoryId = c.CategoryId
WHERE s.Active = 1 
	AND t.SubcategoryId IN (SELECT SubcategoryId FROM pBOLMacroSubcategory WHERE Active = 1)
	AND s.CategoryId IN (SELECT CategoryId FROM pBOLMacroCategory WHERE Active = 1)


ORDER BY CategoryName, Sort1, SubcategoryName, Sort2, [Level], Name


GO



IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='03225'))
BEGIN

	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '5.0.0000', '03225', GetDate())

END
GO 