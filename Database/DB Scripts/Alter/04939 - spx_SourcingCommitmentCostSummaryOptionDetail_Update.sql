/****** Object:  StoredProcedure [dbo].[spx_SourcingCommitmentCostSummaryOptionDetail_Update]    Script Date: 01/30/2013 18:29:07 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_SourcingCommitmentCostSummaryOptionDetail_Update]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_SourcingCommitmentCostSummaryOptionDetail_Update]
GO

/****** Object:  StoredProcedure [dbo].[spx_SourcingCommitmentCostSummaryOptionDetail_Update]    Script Date: 01/30/2013 18:29:07 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO





-- Stored Procedure

CREATE PROCEDURE [dbo].[spx_SourcingCommitmentCostSummaryOptionDetail_Update]
(@CommitmentItemId uniqueidentifier
)
AS 

	

	
BEGIN


	select * from vwx_SourcingCommitmentCostOptionDetailSummary 
	where SourcingCommitmentCostOptionId in (
		select SourcingCommitmentCostOptionID 
		from pSourcingCommitmentCostOption 
		where CommitmentItemID=@CommitmentItemId
	)

	union

	select  NEWID(), SourcingCommitmentCostOptionId, 
	NEWID(), MinQuantity, MaxQuantity, 
						 CostUnit,StyleQuoteItemID,NEWID(), 
						 NEWID(),NEWID(),NEWID(), 
						 NEWID(),NEWID(),'Hight Level', 
						 '','',null, 
						 null,null,null, 
						 null,null, OptionName,'1' AS orderbysort,OptionNo

	from pSourcingCommitmentCostOption where CommitmentItemID=@CommitmentItemId 
	order by 24,11,12,13,25
 

END




GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '04939', GetDate())
GO