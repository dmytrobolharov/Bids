update pChangeTable set ChangeTableXML= 'ChangeLogItem_Default.xml' where ChangeTableID = 'D6121122-BBBB-3332-AFC1-ABCD56CBBDDD'

GO 

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '05279', GetDate())
GO
