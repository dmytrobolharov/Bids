
SET NOCOUNT ON
GO

DECLARE @tblName nvarchar(200)
DECLARE @message nvarchar(2000)   

DECLARE dvt_cursor CURSOR FOR 
select t.name
from sys.tables t
inner join sys.columns c on c.object_id=t.object_id 
where
t.name like 'dvt%' and 
c.name = 'ItemValue' 

OPEN dvt_cursor

FETCH NEXT FROM dvt_cursor 
INTO @tblName

WHILE @@FETCH_STATUS = 0
BEGIN

	exec('ALTER TABLE ' + @tblName + ' ALTER COLUMN ItemKey nvarchar(200) NOT NULL')
    exec('ALTER TABLE ' + @tblName + ' ALTER COLUMN ItemValue nvarchar(400) NOT NULL')

    -- Get the next table.
    FETCH NEXT FROM dvt_cursor 
    INTO @tblName

END 
CLOSE dvt_cursor;
DEALLOCATE dvt_cursor;

Go


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09915', GetDate())
GO
