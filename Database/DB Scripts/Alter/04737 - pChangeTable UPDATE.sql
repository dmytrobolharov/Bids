update pChangeTable set ChangeTableXML='ChangeLogItem_Default.xml' where ChangeTableID='7938A3FD-0580-422F-A3A6-895CA0223A81'

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '04737', GetDate())
GO