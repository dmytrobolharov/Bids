/****** Object:  StoredProcedure [dbo].[spx_LinePlanAttributeTableList_SELECTED]    Script Date: 06/05/2014 15:17:45 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_LinePlanAttributeTableList_SELECTED]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_LinePlanAttributeTableList_SELECTED]
GO

/****** Object:  StoredProcedure [dbo].[spx_LinePlanAttributeTableList_SELECTED]    Script Date: 06/05/2014 15:17:45 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spx_LinePlanAttributeTableList_SELECTED](
@LinePlanId nvarchar(40),
@LinePlanTemplateItemId nvarchar(40),
@TeamID UNIQUEIDENTIFIER 
)
AS 

/*
DECLARE @LinePlanId nvarchar(40)
DECLARE @LinePlanTemplateItemId nvarchar(40)
DECLARE @TeamID UNIQUEIDENTIFIER 

SET @linePlanId=N'b7c141b0-aee5-448b-b1a0-6fd11106e186'
SET @LinePlanTemplateItemId=N'70000000-0000-0000-0001-000000000002'
SET @TeamID=N'1e37969e-e790-49c9-8341-999999999999'
*/

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




IF @LinePlanTemplateItemSort = 1 
BEGIN
	-- Check for permissions
	SELECT DISTINCT ProductTypeId INTO #tmp 
	FROM fnx_Permissions_GetGuidProductTypePermissions(@TeamID, 13)
	WHERE PermissionRoleId <> 0
	
	SELECT @Count = COUNT(*) FROM #tmp
	
END 

IF @LinePlanTemplateItemSort = 1 AND @Count = 0 
BEGIN
	SET @LinePlanAttributeSql = 'SELECT NULL AS ' + @LinePlanAttributeValue + ' ,  NULL AS ' + @LinePlanAttributeText  + ' WHERE 1 = 2 ' 
END 
ELSE 
BEGIN 

	SET @LinePlanAttributeSql = 'SELECT ' + @LinePlanAttributeValue + ', ' + @LinePlanAttributeText 
	+ ' FROM ' + @LinePlanAttributeTable + ' WHERE Active = 1 AND 	 ' 
	+ @LinePlanAttributeValue + ' IN (SELECT LinePlanAttributeValue FROM pLinePlanAttribute WHERE  LinePlanTemplateItemId = ''' 
	+ @LinePlanTemplateItemId + ''' AND LinePlanID =  ''' + @LinePlanID + ''')  '

	IF @LinePlanTemplateItemSort = 1 AND @Count > 0 
		SET @LinePlanAttributeSql = @LinePlanAttributeSql + '  AND '   + @LinePlanAttributeValue + ' IN ( SELECT CustomID FROM #tmp  ) '

	SET @LinePlanAttributeSql  = @LinePlanAttributeSql   + 'ORDER BY ' + @LinePlanAttributeText + ''
END 

EXEC (@LinePlanAttributeSql)


IF @LinePlanTemplateItemSort = 1 
	DROP TABLE #tmp

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07909', GetDate())
GO
