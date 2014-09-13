
ALTER PROCEDURE spx_StyleAttributeTableList_SELECTED
(
@StyleId varchar(50),
@StyleAttributeTableId varchar(5)
)
AS 


DECLARE @StyleAttributeTable varchar(200)
DECLARE @StyleAttributeText varchar(200)
DECLARE @StyleAttributeSql varchar(4000)

SELECT @StyleAttributeTable = StyleAttributeTable, @StyleAttributeText = StyleAttributeText FROM pStyleAttributeTable WITH (NOLOCK) WHERE (StyleAttributeTableId = @StyleAttributeTableId)


DECLARE @SQL NVARCHAR(4000)
SET @SQL = '
DELETE FROM pStyleAttribute
WHERE StyleAttributeId IN ( 
	SELECT a.StyleAttributeId 
	FROM  pStyleAttribute a
	LEFT OUTER JOIN  ' +  @StyleAttributeTable +  ' b ON b.CustomKey  = a.StyleAttributeValue
	WHERE a.StyleAttributeTableId  = ' + @StyleAttributeTableId + '  
	AND b.CustomKey IS NULL
)	
'
EXEC (@SQL)

IF @@ROWCOUNT > 0  
BEGIN

	DECLARE @text NVARCHAR(4000)
	SET @text= ''
	SELECT @text = @text +  StyleAttributeText + ', ' FROM pStyleAttribute 
	WHERE StyleId = @StyleId 
	
	IF LEN (@text) > 0 
	BEGIN 
		UPDATE pStyleHeader Set StyleAttribute = @text
		WHERE StyleID = @StyleID
	END 
		
END 

SET @StyleAttributeSql = 'SELECT * FROM ' + @StyleAttributeTable + ' WHERE Active = 1 AND 
	CustomKey IN (SELECT StyleAttributeValue FROM pStyleAttribute WITH (NOLOCK) WHERE  StyleAttributeTableId = ''' + @StyleAttributeTableId + ''' AND StyleID =  ''' + @StyleID + ''') ORDER BY ' + @StyleAttributeText + ''

EXEC (@StyleAttributeSql)

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '2.6.9999', '026', GetDate())
GO
