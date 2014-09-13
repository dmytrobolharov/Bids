

/****** Object:  StoredProcedure [dbo].[spx_SourcingCommitmentEditAdditionalCost_UPDATE]    Script Date: 11/23/2012 15:18:32 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_SourcingCommitmentEditAdditionalCost_UPDATE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_SourcingCommitmentEditAdditionalCost_UPDATE]
GO


/****** Object:  StoredProcedure [dbo].[spx_SourcingCommitmentEditAdditionalCost_UPDATE]    Script Date: 11/23/2012 15:18:32 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




CREATE PROCEDURE [dbo].[spx_SourcingCommitmentEditAdditionalCost_UPDATE]
(
@SourcingAdditionalCostID uniqueidentifier,
@QuoteItemID uniqueidentifier,
@Amount decimal(18,4),
@Description nvarchar(200),
@Cuser nvarchar(200),
@Cdate datetime
)
AS 

BEGIN

	UPDATE pSourcingCommitmentAdditionalCost
	   SET 
		  [Description] = @Description,
		  Amount = @Amount,
		  MDate = @Cdate, 
		  MUser = @Cuser
	 WHERE CommitmentAdditionalCostID = @SourcingAdditionalCostID
	 and CommitmentItemID=@QuoteItemID
	 
END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04439', GetDate())
GO  
