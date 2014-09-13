IF OBJECT_ID('spx_ServiceBusMessage_DELETE', 'P') IS NOT NULL
	DROP PROCEDURE spx_ServiceBusMessage_DELETE
GO

CREATE PROCEDURE spx_ServiceBusMessage_DELETE(
	@ServiceBusMessageID UNIQUEIDENTIFIER
)
AS

DELETE FROM dbo.sServiceBusMessage WHERE ServiceBusMessageID = @ServiceBusMessageID

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES   ('DB_Version', '6.0.0000', '09070', GetDate())
GO

