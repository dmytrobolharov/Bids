/****** Object:  StoredProcedure [dbo].[spx_LinePlanAttributeTableList_SELECT]    Script Date: 06/05/2014 11:45:21 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_LinePlanAttributeTableList_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_LinePlanAttributeTableList_SELECT]
GO

/****** Object:  StoredProcedure [dbo].[spx_LinePlanAttributeTableList_SELECT]    Script Date: 06/05/2014 11:45:21 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spx_LinePlanAttributeTableList_SELECT]
(
@LinePlanId nvarchar(50),
@LinePlanTemplateItemId nvarchar(50) ,
@TeamID UNIQUEIDENTIFIER 
)
AS 

DECLARE @LinePlanAttributeTable nvarchar(200)
DECLARE @LinePlanAttributeText nvarchar(200)
DECLARE @LinePlanAttributeValue nvarchar(200) 
DECLARE @LinePlanAttributeSql nvarchar(4000)
DECLARE @LinePlanTemplateItemSort INT 
DECLARE @LinePlanTemplateID UNIQUEIDENTIFIER 
DECLARE @Count INT

SET  @Count = 0

SELECT @LinePlanAttributeValue = LinePlanAttributeValue, @LinePlanAttributeTable = LinePlanAttributeTable,
@LinePlanAttributeText = LinePlanAttributeText,
@LinePlanTemplateItemSort = CAST ( LinePlanTemplateItemSort AS INT ),
@LinePlanTemplateID  = LinePlanTemplateID
FROM pLinePlanTemplateItem WHERE (LinePlanTemplateItemId = @LinePlanTemplateItemId)



DECLARE @TOTAL  INT 
SELECT @TOTAL   = COUNT(*) 
FROM pLinePlanAttribute 
WHERE  LinePlanTemplateItemId = @LinePlanTemplateItemId 
AND LinePlanID =  @LinePlanID 


IF @LinePlanTemplateItemSort = 1 
BEGIN
	-- Check for permissions
	SELECT DISTINCT ProductTypeId INTO #tmp 
	FROM fnx_Permissions_GetGuidProductTypePermissions(@TeamID, 13) a
	WHERE PermissionRoleId = 3
	SELECT @Count = COUNT(*) FROM #tmp

END 

IF @TOTAL> 0 
BEGIN 
	SET @LinePlanAttributeSql = 'SELECT * FROM ' + @LinePlanAttributeTable + ' WHERE Active = 1 AND  '
	+ @LinePlanAttributeValue + ' NOT IN (SELECT LinePlanAttributeValue FROM pLinePlanAttribute WHERE  LinePlanTemplateItemId = ''' + @LinePlanTemplateItemId +
	 ''' AND LinePlanID =  ''' + @LinePlanID + ''') ' 

	IF @LinePlanTemplateItemSort = 1 AND @Count > 0 
		SET @LinePlanAttributeSql = @LinePlanAttributeSql + '  AND '   + @LinePlanAttributeValue + ' IN ( SELECT CustomID FROM #tmp  ) '
 	
	 SET @LinePlanAttributeSql = @LinePlanAttributeSql + ' ORDER BY ' + @LinePlanAttributeText
END 
ELSE
BEGIN 
	SET @LinePlanAttributeSql = 'SELECT * FROM ' + @LinePlanAttributeTable + ' WHERE Active = 1 ' 
	IF @LinePlanTemplateItemSort = 1 AND @Count > 0 	
		SET @LinePlanAttributeSql = @LinePlanAttributeSql + '  AND '   + @LinePlanAttributeValue + ' IN ( SELECT CustomID FROM #tmp  ) '

	SET @LinePlanAttributeSql = @LinePlanAttributeSql + ' ORDER BY ' + @LinePlanAttributeText
END 

print @LinePlanAttributeSql
EXEC (@LinePlanAttributeSql)

IF @LinePlanTemplateItemSort = 1 
	DROP TABLE #tmp

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07908', GetDate())
GO
