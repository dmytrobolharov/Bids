/****** Object:  StoredProcedure [dbo].[spx_CommitStatusCommitment_UPDATE]    Script Date: 08/09/2014 21:06:37 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_CommitStatusCommitment_UPDATE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_CommitStatusCommitment_UPDATE]
GO

/****** Object:  StoredProcedure [dbo].[spx_CommitStatusCommitment_UPDATE]    Script Date: 08/09/2014 21:06:37 ******/
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
	
	IF @StatusID = 3 -- Approved
	BEGIN
		UPDATE pSourcingCommitmentItem SET ActualEnd = @MDate WHERE SourcingCommitmentItemID = @CommitmentItemID	
	END
	
END


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '08693', GetDate())
GO
