IF OBJECT_ID('sServiceBusMessage', 'U') IS NOT NULL
	DROP TABLE sServiceBusMessage
GO

CREATE TABLE sServiceBusMessage
(
	ServiceBusMessageID UNIQUEIDENTIFIER DEFAULT(NEWID()),
	ServiceBusSessionID UNIQUEIDENTIFIER NOT NULL,
	TeamID UNIQUEIDENTIFIER,
	SessionURL NVARCHAR(4000),
	MessageType NVARCHAR(50),
	MessageDocument NVARCHAR(MAX),
	PluginName NVARCHAR(100),
	CDate DATETIME,
	CUser NVARCHAR(50)
)

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES   ('DB_Version', '6.0.0000', '09068', GetDate())
GO
