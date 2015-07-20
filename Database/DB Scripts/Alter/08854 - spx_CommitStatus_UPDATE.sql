/****** Object:  StoredProcedure [dbo].[spx_CommitStatus_UPDATE]    Script Date: 08/17/2014 11:34:04 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_CommitStatus_UPDATE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_CommitStatus_UPDATE]
GO

/****** Object:  StoredProcedure [dbo].[spx_CommitStatus_UPDATE]    Script Date: 08/17/2014 11:34:04 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
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
	
	IF @StatusID = 3 -- Approved
	BEGIN
		UPDATE pStyleQuoteItem SET ActualEnd = @MDate WHERE StyleQuoteItemID = @QuoteItemID	
	END
	
	EXEC spx_TACalendar_SourcingQuoteWorkflowReferences_Progress_UPDATE @QuoteItemID
END



GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.0.0000', '08854', GetDate())
GO
