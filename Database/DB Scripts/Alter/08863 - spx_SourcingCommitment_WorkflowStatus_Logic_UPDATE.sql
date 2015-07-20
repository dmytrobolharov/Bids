/****** Object:  StoredProcedure [dbo].[spx_SourcingCommitment_WorkflowStatus_Logic_UPDATE]    Script Date: 08/14/2014 20:25:22 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_SourcingCommitment_WorkflowStatus_Logic_UPDATE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_SourcingCommitment_WorkflowStatus_Logic_UPDATE]
GO

/****** Object:  StoredProcedure [dbo].[spx_SourcingCommitment_WorkflowStatus_Logic_UPDATE]    Script Date: 08/14/2014 20:25:22 ******/
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

EXEC spx_TACalendar_SourcingCommitmentWorkflowReferences_Progress_UPDATE @SourcingCommitmentItemID
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.0.0000', '08863', GetDate())
GO
