CREATE TABLE pLinePlanStyleLinkedTemp(
	TeamID UNIQUEIDENTIFIER,
	StyleID UNIQUEIDENTIFIER,
	ClientSessionID NVARCHAR(40)
)



--DROP TABLE pLinePlanStyleLinkedTemp
go
INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '4.0.0000', '01051', GetDate())
GO