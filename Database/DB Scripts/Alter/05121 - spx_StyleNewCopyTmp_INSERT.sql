IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleNewCopyTmp_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleNewCopyTmp_INSERT]
GO


CREATE PROCEDURE  [dbo].[spx_StyleNewCopyTmp_INSERT](
	@TransactionID UNIQUEIDENTIFIER,
	@StyleID UNIQUEIDENTIFIER,
	@Map UNIQUEIDENTIFIER,
	@WorkflowItemID UNIQUEIDENTIFIER,
	@TeamID UNIQUEIDENTIFIER,
	@CDate DATETIME
)
AS 

DECLARE @StyleCopyTmpID UNIQUEIDENTIFIER

IF @WorkflowItemID IS NULL 
	SELECT @StyleCopyTmpID = StyleCopyTmpID 
	FROM pStyleCopyTmp WITH(NOLOCK)
	WHERE TransactionID = @TransactionID
		AND StyleID = @StyleID 
		AND Map = @Map
ELSE 
	SELECT @StyleCopyTmpID = StyleCopyTmpID 
	FROM pStyleCopyTmp WITH(NOLOCK)
	WHERE TransactionID = @TransactionID
		AND StyleID = @StyleID 
		AND WorkflowItemID = @WorkflowItemID
	

IF @StyleCopyTmpID IS NULL
BEGIN
	
	SET @StyleCopyTmpID = NEWID()
	INSERT INTO pStyleCopyTmp (StyleCopyTmpID , TransactionID, StyleID, Map, WorkflowItemID, TeamID, CDate)
	VALUES (@StyleCopyTmpID, @TransactionID, @StyleID, @Map, @WorkflowItemID, @TeamID, @CDate)

END 


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '05121', GetDate())
GO


