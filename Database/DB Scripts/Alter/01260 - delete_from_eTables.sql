delete from eMailAccounts
delete from eMailContactType
delete from eMailMessage
delete from eMessageFolder

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.0.0000', '01260', GetDate())