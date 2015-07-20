/****** Object:  StoredProcedure [dbo].[spx_CommitStatusCommitment_UPDATE]    Script Date: 07/26/2013 12:03:43 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_CommitStatusCommitment_UPDATE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_CommitStatusCommitment_UPDATE]
GO
/****** Object:  StoredProcedure [dbo].[spx_CommitStatusCommitment_UPDATE]    Script Date: 07/26/2013 12:03:43 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[spx_CommitStatusCommitment_UPDATE]
(
@CommitmentItemID uniqueidentifier,
@MUser nvarchar(200),
@MDate datetime
)
AS 

BEGIN
	UPDATE pSourcingCommitmentItem
	   SET 
		  StyleQuoteItemStatusId = 3,
		  MDate = @MDate, 
		  MUser = @MUser
	 WHERE SourcingCommitmentItemID = @CommitmentItemID
END


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '06085', GetDate())
GO