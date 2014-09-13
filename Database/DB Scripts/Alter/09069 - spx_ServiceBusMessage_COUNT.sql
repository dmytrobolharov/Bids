IF OBJECT_ID('spx_ServiceBusMessage_COUNT', 'P') IS NOT NULL
	DROP PROCEDURE spx_ServiceBusMessage_COUNT
GO

CREATE PROCEDURE spx_ServiceBusMessage_COUNT(
	@ServiceBusSessionID UNIQUEIDENTIFIER,
	@TeamID UNIQUEIDENTIFIER = '00000000-0000-0000-0000-000000000000'
)
AS

SELECT COUNT(*)
FROM dbo.sServiceBusMessage 
WHERE ServiceBusSessionID = @ServiceBusSessionID
	AND ISNULL(TeamID, '00000000-0000-0000-0000-000000000000') = ISNULL(@TeamID, '00000000-0000-0000-0000-000000000000')

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES   ('DB_Version', '6.0.0000', '09069', GetDate())
GO

