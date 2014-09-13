IF OBJECT_ID('spx_ServiceBusMessage_INSERT', 'P') IS NOT NULL
	DROP PROCEDURE spx_ServiceBusMessage_INSERT
GO

CREATE PROCEDURE spx_ServiceBusMessage_INSERT(
	@ServiceBusMessageID UNIQUEIDENTIFIER,
	@ServiceBusSessionID UNIQUEIDENTIFIER,
	@TeamID UNIQUEIDENTIFIER = '00000000-0000-0000-0000-000000000000',
	@SessionURL NVARCHAR(4000),
	@MessageType NVARCHAR(50),
	@MessageDocument NVARCHAR(MAX),
	@PluginName NVARCHAR(100),
	@CDate DATETIME,
	@CUser NVARCHAR(50)
)
AS

IF NOT EXISTS (SELECT * FROM dbo.sServiceBusMessage 
	WHERE ServiceBusSessionID = @ServiceBusSessionID
		AND ISNULL(TeamID, '00000000-0000-0000-0000-000000000000') = ISNULL(@TeamID, '00000000-0000-0000-0000-000000000000'))
BEGIN
	INSERT INTO dbo.sServiceBusMessage
	        ( ServiceBusMessageID,
			  ServiceBusSessionID,
			  TeamID,
			  SessionURL,
			  MessageType,
			  MessageDocument,
			  PluginName,
			  CDate,
			  CUser
	        )
	VALUES  ( @ServiceBusMessageID,
			  @ServiceBusSessionID,
			  @TeamID,
			  @SessionURL,
			  @MessageType,
			  @MessageDocument,
			  @PluginName,
			  @CDate,
			  @CUser
	        )
END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES   ('DB_Version', '6.0.0000', '09071', GetDate())
GO

