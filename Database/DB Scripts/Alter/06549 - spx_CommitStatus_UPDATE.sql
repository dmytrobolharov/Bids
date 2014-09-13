IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_CommitStatus_UPDATE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_CommitStatus_UPDATE]
GO


CREATE PROCEDURE [dbo].[spx_CommitStatus_UPDATE]
(
@QuoteItemID uniqueidentifier,
@StatusID int = 3,
@MUser nvarchar(200),
@MDate datetime
)
AS 

BEGIN
	IF @StatusID IN (1,2,3) -- On Hold, Dropped, Approved
	BEGIN
		UPDATE pStyleQuoteItem
		   SET 
			  StyleQuoteItemStatusId = @StatusID,
			  StyleQuoteItemApprovedBy = @MUser,
			  StyleQuoteItemApprovedDate = @MDate,
			  MDate = @MDate, 
			  MUser = @MUser
		 WHERE StyleQuoteItemID = @QuoteItemID
	END
END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '06549', GetDate())
GO
