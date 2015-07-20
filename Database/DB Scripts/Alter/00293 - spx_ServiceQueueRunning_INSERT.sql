IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_ServiceQueueRunning_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_ServiceQueueRunning_INSERT]
GO


CREATE  PROCEDURE [dbo].[spx_ServiceQueueRunning_INSERT]
AS 

BEGIN

	
	INSERT INTO sServiceQueueRunning (ServiceQueueID, ServiceQueueSql, ServiceQueuePriority, ServiceQueueRunningDate, Attempt)
	SELECT TOP 5 ServiceQueueID, ServiceQueueSql, ServiceQueuePriority, ServiceQueueDate, 0 AS Attempt
	FROM sServiceQueue 
	WHERE ServiceQueueID NOT IN (
		SELECT ServiceQueueID FROM sServiceQueueRunning
	)	
	ORDER BY ServiceQueueID

	DELETE FROM sServiceQueue WHERE ServiceQueueID IN (SELECT ServiceQueueID FROM sServiceQueueRunning)

END











GO
