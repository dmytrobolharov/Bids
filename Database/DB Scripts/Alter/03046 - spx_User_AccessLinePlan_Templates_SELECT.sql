IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_User_AccessLinePlan_Templates_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_User_AccessLinePlan_Templates_SELECT]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spx_User_AccessLinePlan_Templates_SELECT] (
@TeamID UNIQUEIDENTIFIER
)
AS 

DECLARE @iCount as int
DECLARE @iCountRow int
DECLARE @sqlScript varchar(2000)
DECLARE @LinePlanTemplateID UNIQUEIDENTIFIER
DECLARE @LinePlanTemplateName NVARCHAR(100)

CREATE TABLE #tempLinePlanTemplate (
	Id int IDENTITY (1, 1) NOT NULL , 
	LinePlanTemplateID UNIQUEIDENTIFIER,
	LinePlanTemplateName NVARCHAR(100)	
) 

CREATE TABLE #tempAccessGroupLinePlanFolderForTemplate (
	Id int IDENTITY (1, 1) NOT NULL , 
	LinePlanTemplateID UNIQUEIDENTIFIER,
	LinePlanTemplateName NVARCHAR(100),	
	AccessRoleID INT,
	AccessPlanView INT,
	AccessPlanNew INT,
	AccessPlanDelete INT,
	AccessHierView INT,
	AccessHierNew INT,
	AccessHierDelete INT
) 


INSERT INTO #tempLinePlanTemplate (LinePlanTemplateID, LinePlanTemplateName)
SELECT LinePlanTemplateID, LinePlanTemplateName FROM pLinePlanTemplate


SET @iCountRow = (SELECT COUNT(*) FROM pLinePlanTemplate)

SET @iCount = 1

WHILE @iCount <= @iCountRow 
BEGIN
	SELECT @LinePlanTemplateID = LinePlanTemplateID FROM #tempLinePlanTemplate WHERE Id = @iCount
	SELECT @LinePlanTemplateName = LinePlanTemplateName FROM #tempLinePlanTemplate WHERE Id = @iCount

	SELECT @sqlScript = 'INSERT INTO #tempAccessGroupLinePlanFolderForTemplate ' +
		'(LinePlanTemplateID, LinePlanTemplateName, AccessRoleID, AccessPlanView, AccessPlanNew, AccessPlanDelete, AccessHierView, AccessHierNew, AccessHierDelete) ' +
		'SELECT ' + CHAR(39) + CAST(@LinePlanTemplateID as nvarchar(50)) + CHAR(39) + ', ' + CHAR(39) + @LinePlanTemplateName + CHAR (39) + ', ' +
		'ISNULL(MAX(AccessRoleID),0) AS AccessRoleID, ISNULL(MAX(AccessPlanView),0) AS AccessPlanView, ' +
		'ISNULL(MAX(AccessPlanNew),0) AS AccessPlanNew, ISNULL(MAX(AccessPlanDelete),0) AS AccessPlanDelete, ' +
		'ISNULL(MAX(AccessHierView),0) AS AccessHierView,  ISNULL(MAX(AccessHierNew),0) AS AccessHierNew, ' +
		'ISNULL(MAX(AccessHierDelete),0) AS AccessHierDelete ' +
		'FROM sAccessGroupLinePlanFolder ' +
		'WHERE (LinePlanTemplateID = ' + CHAR(39) + CAST(@LinePlanTemplateID as nvarchar(50)) + CHAR(39) + ') ' +
		'AND (GroupID IN (SELECT GroupID FROM uUserGroup WHERE TeamID = ' + CHAR(39) + CAST(@TeamID as nvarchar(50)) + CHAR(39) + ')) ' +
		'AND (CustomID IN (SELECT ' + a.LinePlanAttributeValue + ' FROM ' + a.LinePlanAttributeTable + ')) '
	FROM pLinePlanTemplateItem a
	WHERE CAST(a.LinePlanTemplateItemSort AS INT) = '1' 
	AND a.LinePlanTemplateID = @LinePlanTemplateID

	EXEC(@sqlScript)
	
	SET @iCount = @iCount + 1

END


SELECT * FROM #tempAccessGroupLinePlanFolderForTemplate
WHERE AccessRoleID = 3 Or AccessPlanNew = 1


DROP TABLE #tempLinePlanTemplate
DROP TABLE #tempAccessGroupLinePlanFolderForTemplate

GO


IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='03046'))
BEGIN
	
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.2.0000', '03046', GetDate())     

END	  
GO