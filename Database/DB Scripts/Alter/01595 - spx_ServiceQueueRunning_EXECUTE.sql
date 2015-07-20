IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_ServiceQueueRunning_EXECUTE]') AND type = N'P' )
	DROP PROCEDURE [dbo].[spx_ServiceQueueRunning_EXECUTE]
GO

CREATE PROCEDURE [dbo].[spx_ServiceQueueRunning_EXECUTE](
	@ServiceQueueId int
)

AS 

--DECLARE @ServiceQueueId int
--SET @ServiceQueueId=2
DECLARE @nError INT 
SET @nError = 0 


BEGIN TRANSACTION

	DECLARE @SqlString nvarchar(4000)
	SET @SqlString = (SELECT TOP 1 ServiceQueueSql  FROM sServiceQueueRunning WHERE ServiceQueueID = @ServiceQueueId)
	EXEC sp_executesql @SqlString
	IF @@ERROR <> 0
	 BEGIN
		SET @nError = 1
		-- Rollback the transaction
		ROLLBACK
	   --Return
	 END
		
	IF @nError = 0 
	BEGIN 
		DELETE FROM sServiceQueueRunning WHERE ServiceQueueID = @ServiceQueueId
		IF @@ERROR <> 0
		 BEGIN
			-- Rollback the transaction
			SET @nError = 1
			ROLLBACK
		   --Return
		 END
	END

IF @nError = 0 
	COMMIT
ELSE
	UPDATE sServiceQueueRunning SET Attempt = Attempt + 1 WHERE ServiceQueueID = @ServiceQueueId
	


GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='01595'))
BEGIN
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '01595', GetDate())
END	

GO









