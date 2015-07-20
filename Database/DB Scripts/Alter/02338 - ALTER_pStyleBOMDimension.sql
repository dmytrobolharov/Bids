DECLARE @constraint_name sysname, @sql nvarchar(max)

SELECT @constraint_name = name 
FROM sys.default_constraints 
WHERE parent_object_id = object_id('pStyleBOMDimension')
AND type = 'D'
AND parent_column_id = (
    SELECT column_id 
    FROM sys.columns 
    WHERE object_id = object_id('pStyleBOMDimension')
    AND name = 'IsAvgQuantity' 
    )
    
set @sql = 'ALTER TABLE pStyleBOMDimension DROP CONSTRAINT ' + @constraint_name
exec (@sql)

ALTER TABLE pStyleBOMDimension DROP COLUMN IsAvgQuantity

ALTER TABLE dbo.pStyleBOMDimension ADD
	IsAvgQuantity INT DEFAULT(1) WITH VALUES
GO




IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='02338'))
BEGIN

	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '02338', GetDate())

END
GO