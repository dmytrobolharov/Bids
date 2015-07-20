/****** Object:  StoredProcedure [dbo].[spx_CommitStatusCommitment_UPDATE]    Script Date: 08/11/2014 14:59:14 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_CommitStatusCommitment_UPDATE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_CommitStatusCommitment_UPDATE]
GO

/****** Object:  StoredProcedure [dbo].[spx_CommitStatusCommitment_UPDATE]    Script Date: 08/11/2014 14:59:14 ******/
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

	IF @StatusID IN (1,2,3) -- On Hold, Dropped, Approved
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
	
END



GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '08730', GetDate())
GO
