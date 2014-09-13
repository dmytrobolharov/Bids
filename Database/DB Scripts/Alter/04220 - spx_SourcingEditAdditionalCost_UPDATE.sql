
/****** Object:  StoredProcedure [dbo].[spx_SourcingEditAdditionalCost_UPDATE]    Script Date: 10/16/2012 11:49:34 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_SourcingEditAdditionalCost_UPDATE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_SourcingEditAdditionalCost_UPDATE]
GO


/****** Object:  StoredProcedure [dbo].[spx_SourcingEditAdditionalCost_UPDATE]    Script Date: 10/16/2012 11:49:34 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[spx_SourcingEditAdditionalCost_UPDATE]
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

	UPDATE pSourcingAdditionalCost
	   SET 
		  [Description] = @Description,
		  Amount = @Amount,
		  MDate = @Cdate, 
		  MUser = @Cuser
	 WHERE SourcingAdditionalCostID = @SourcingAdditionalCostID
	 and QuoteItemID=@QuoteItemID
	 
END
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04220', GetDate())
GO

