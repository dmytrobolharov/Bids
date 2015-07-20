/****** Object:  StoredProcedure [dbo].[spx_StyleQuote_CommitmentBOMOption_SELECT]    Script Date: 01/30/2013 16:29:32 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleQuote_CommitmentBOMOption_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleQuote_CommitmentBOMOption_SELECT]
GO


/****** Object:  StoredProcedure [dbo].[spx_StyleQuote_CommitmentBOMOption_SELECT]    Script Date: 01/30/2013 16:29:32 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



Create PROCEDURE [dbo].[spx_StyleQuote_CommitmentBOMOption_SELECT]
	@CommitmentItemID UNIQUEIDENTIFIER
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    SELECT * FROM pSourcingCommitmentBOMOption WHERE SourcingCommitmentItemID = @CommitmentItemID ORDER BY OptionNo ASC
END


GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '04930', GetDate())
GO