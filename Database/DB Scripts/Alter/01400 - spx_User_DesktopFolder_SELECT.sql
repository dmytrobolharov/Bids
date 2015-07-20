IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_User_DesktopFolder_SELECT]') AND type = N'P' )
	DROP PROCEDURE [dbo].[spx_User_DesktopFolder_SELECT]
GO 


CREATE PROCEDURE [dbo].[spx_User_DesktopFolder_SELECT](
	@TeamID UNIQUEIDENTIFIER
)
AS 

CREATE TABLE #tmp(
	ROWID INT IDENTITY(1,1),
	DeskFolderId INT,
	TemplateItemValue NVARCHAR(200),
	TemplateID NVARCHAR(40),
	DeskFolderName NVARCHAR(200)
)

CREATE TABLE #template(
	ROWID INT IDENTITY(1,1),
	LinePlanTemplateID UNIQUEIDENTIFIER
)



INSERT INTO #tmp(DeskFolderId, DeskFolderName)
SELECT DeskFolderId, DeskFolderName 
FROM cDesktopFolder WITH(NOLOCK)
WHERE DeskFolderId <> 13  -- LinePlan


DECLARE 
	@sqlScript  NVARCHAR(MAX),
	@LinePlanTemplateID UNIQUEIDENTIFIER,
	@ROWID INT,
	@TOTAL INT
	


INSERT INTO #template	( LinePlanTemplateID)
SELECT LinePlanTemplateID FROM dbo.pLinePlanTemplate

SET @ROWID = 1
SELECT @TOTAL =  COUNT(*) FROM #template


WHILE @ROWID  <= @TOTAL
BEGIN
	SELECT @LinePlanTemplateID = LinePlanTemplateID FROM #template WHERE ROWID = @ROWID

	SELECT @sqlScript = ' INSERT #tmp(DeskFolderId, TemplateID, TemplateItemValue, DeskFolderName) SELECT 13, ''' +
	CAST(a.LinePlanTemplateID AS NVARCHAR(40)) + ''', '  + a.LinePlanAttributeValue +
	', ''' + b.LinePlanTemplateName  + ''' + '' - '' +  ' + a.LinePlanAttributeText +  '  FROM ' + a.LinePlanAttributeTable + ' ORDER BY '  +  a.LinePlanAttributeText
	FROM  pLinePlanTemplateItem  a
		INNER JOIN dbo.pLinePlanTemplate b ON b.LinePlanTemplateID = a.LinePlanTemplateID
	WHERE CAST(LinePlanTemplateItemSort AS INT) = '1' 
	AND a.LinePlanTemplateID = @LinePlanTemplateID

	PRINT @sqlScript 
	EXEC sp_executesql @sqlScript 	
	
	SET @ROWID = @ROWID + 1 

END 
	


SELECT * FROM #tmp
ORDER BY DeskFolderId, ROWID

DROP TABLE #tmp


GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.1.0000', '01400', GETDATE())
GO	



