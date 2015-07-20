/****** Object:  StoredProcedure [dbo].[spx_CommitStatusCommitment_UPDATE]    Script Date: 08/14/2014 21:02:02 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_CommitStatusCommitment_UPDATE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_CommitStatusCommitment_UPDATE]
GO

/****** Object:  StoredProcedure [dbo].[spx_CommitStatusCommitment_UPDATE]    Script Date: 08/14/2014 21:02:02 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO





CREATE PROCEDURE [dbo].[spx_CommitStatusCommitment_UPDATE]
(
@CommitmentItemID uniqueidentifier,
@StatusID int = 3,
@MUser nvarchar(200),
@MDate datetime
)
AS 

BEGIN

	DECLARE @PrevWorkStatus INT
	SELECT @PrevWorkStatus = StyleQuoteItemStatusId FROM pSourcingCommitmentItem WHERE SourcingCommitmentItemID = @CommitmentItemID

	IF @StatusID IN (0,1,2,3) -- In Progress, On Hold, Dropped, Approved
	BEGIN
		UPDATE pSourcingCommitmentItem
		   SET 
			  StyleQuoteItemStatusId = @StatusID,
			  StyleQuoteItemApprovedBy = @MUser,
			  StyleQuoteItemApprovedDate = @MDate,
			  MDate = @MDate, 
			  MUser = @MUser
		 WHERE SourcingCommitmentItemID = @CommitmentItemID
	END
	
	IF @PrevWorkStatus = 3 AND @StatusID != 3
	BEGIN
		UPDATE pSourcingCommitmentItem SET ActualEnd = NULL WHERE SourcingCommitmentItemID = @CommitmentItemID
	END
	ELSE IF @PrevWorkStatus != 3 AND @StatusID = 3
	BEGIN
		UPDATE pSourcingCommitmentItem SET ActualEnd = @MDate WHERE SourcingCommitmentItemID = @CommitmentItemID
	END
	
	EXEC spx_TACalendar_SourcingCommitmentWorkflowReferences_Progress_UPDATE @CommitmentItemID
	
END




GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.0.0000', '08855', GetDate())
GO
