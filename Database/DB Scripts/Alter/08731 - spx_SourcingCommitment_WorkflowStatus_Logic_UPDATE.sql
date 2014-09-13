/****** Object:  StoredProcedure [dbo].[spx_SourcingCommitment_WorkflowStatus_Logic_UPDATE]    Script Date: 08/11/2014 13:57:56 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_SourcingCommitment_WorkflowStatus_Logic_UPDATE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_SourcingCommitment_WorkflowStatus_Logic_UPDATE]
GO

/****** Object:  StoredProcedure [dbo].[spx_SourcingCommitment_WorkflowStatus_Logic_UPDATE]    Script Date: 08/11/2014 13:57:56 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[spx_SourcingCommitment_WorkflowStatus_Logic_UPDATE]
	@SourcingCommitmentItemID UNIQUEIDENTIFIER,
	@UpdateSQL NVARCHAR(MAX)
AS

DECLARE @PrevWorkStatus INT,
		@WorkStatus INT
		
SELECT @PrevWorkStatus = StyleQuoteItemStatusId 
FROM pSourcingCommitmentItem 
WHERE SourcingCommitmentItemID = @SourcingCommitmentItemID

EXEC(@UpdateSQL)

SELECT @WorkStatus = StyleQuoteItemStatusId 
FROM pSourcingCommitmentItem 
WHERE SourcingCommitmentItemID = @SourcingCommitmentItemID

IF @PrevWorkStatus = 3 AND @WorkStatus != 3
BEGIN
	UPDATE pSourcingCommitmentItem SET ActualEnd = NULL WHERE SourcingCommitmentItemID = @SourcingCommitmentItemID
END
ELSE IF @PrevWorkStatus != 3 AND @WorkStatus = 3
BEGIN
	UPDATE pSourcingCommitmentItem SET ActualEnd = CURRENT_TIMESTAMP WHERE SourcingCommitmentItemID = @SourcingCommitmentItemID
END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '08731', GetDate())
GO
