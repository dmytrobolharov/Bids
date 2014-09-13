/****** Object:  StoredProcedure [dbo].[spx_ServiceQueueRunning_EXECUTE]    Script Date: 06/18/2013 16:14:43 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_ServiceQueueRunning_EXECUTE]') AND type in (N'P', N'PC'))
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

BEGIN TRY
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
		
END TRY
BEGIN CATCH
	IF XACT_STATE() <> 0
	BEGIN
		ROLLBACK
		UPDATE sServiceQueueRunning SET Attempt = Attempt + 1 WHERE ServiceQueueID = @ServiceQueueId
	END
END CATCH
	



GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '05884', GetDate())
GO
