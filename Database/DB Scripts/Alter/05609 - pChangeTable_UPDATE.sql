UPDATE pChangeTable SET ChangeTableXML = 'ChangeLogItem_Default.xml' 
WHERE ChangeTableID IN ('5612ADDD-CDAB-2211-AACC-DDCD78C000DD', 'D612ADCB-BBBB-2211-AFCC-ABCD56C000DD')

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '05609', GetDate())
GO
