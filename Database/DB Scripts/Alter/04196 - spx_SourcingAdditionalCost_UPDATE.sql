IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_SourcingAdditionalCost_UPDATE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_SourcingAdditionalCost_UPDATE]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[spx_SourcingAdditionalCost_UPDATE]
(
@QuoteItemID uniqueidentifier,
@SourcingHeaderID uniqueidentifier,
@SourcingStyleID uniqueidentifier,
@Description nvarchar(200),
@Amount int,
@MUser nvarchar(200),
@MDate datetime
)
AS 

BEGIN
	UPDATE pSourcingAdditionalCost
	   SET 
		  SourcingHeaderID = @SourcingHeaderID, 
		  SourcingStyleID = @SourcingStyleID, 
		  [Description] = @Description,
		  Amount = @Amount,
		  MDate = @MDate, 
		  MUser = @MUser
	 WHERE QuoteItemID = @QuoteItemID
END


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04196', GetDate())
GO

