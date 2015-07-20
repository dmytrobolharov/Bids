IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_ServiceQueueRunning_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_ServiceQueueRunning_SELECT]
GO


CREATE  PROCEDURE [dbo].[spx_ServiceQueueRunning_SELECT]

AS 

BEGIN

	SELECT TOP 5 ServiceQueueID, ServiceQueueSql, ServiceQueuePriority, ServiceQueueRunningDate 
	FROM sServiceQueueRunning 
	WHERE Attempt < 3
	ORDER BY ServiceQueueID, ServiceQueuePriority ASC, ServiceQueueRunningDate ASC

END










GO
