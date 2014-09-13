UPDATE sYuniFaceDeskTop
   SET DeskActive = 0

 WHERE UPPER(DeskName) in ('SERVERS','DATABASE EXTENSIONS')
GO

UPDATE sYuniFaceDeskTop
   SET DeskName = 'Table Viewer', DeskDescription = 'Database Table Viewer', DeskLabel2 = 'Viewer'

 WHERE UPPER(DeskName) = 'TABLE EDITOR'
GO

UPDATE  sSystemButtons   
SET en_US='Table Viewer'
WHERE     (DesignString = 'btn_Desk_TableEditor.gif')
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '06071', GetDate())
GO
