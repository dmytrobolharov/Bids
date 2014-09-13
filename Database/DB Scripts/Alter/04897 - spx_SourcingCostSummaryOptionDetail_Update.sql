/****** Object:  StoredProcedure [dbo].[spx_SourcingCostSummaryOptionDetail_Update]    Script Date: 01/25/2013 14:37:00 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_SourcingCostSummaryOptionDetail_Update]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_SourcingCostSummaryOptionDetail_Update]
GO

/****** Object:  StoredProcedure [dbo].[spx_SourcingCostSummaryOptionDetail_Update]    Script Date: 01/25/2013 14:37:00 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-- Stored Procedure

CREATE PROCEDURE [dbo].[spx_SourcingCostSummaryOptionDetail_Update]
(@StyleQuoteItemId uniqueidentifier
)
AS 

	

	
BEGIN


select * from vwx_SourcingCostOptionDetailSummary where SourcingCostOptionId in (select SourcingCostOptionID from pSourcingCostOption where StyleQuoteItemID=@StyleQuoteItemId)
union
select  NEWID(), SourcingCostOptionId, 
NEWID(), MinQuantity, MaxQuantity, 
                     CostUnit,StyleQuoteItemID,NEWID(), 
                     NEWID(),NEWID(),NEWID(), 
                     NEWID(),NEWID(),'Hight Level', 
                     '','',null, 
                     null,null,null, 
                     null,null, OptionName,'1' AS orderbysort,OptionNo

from pSourcingCostOption where StyleQuoteItemID=@StyleQuoteItemId 
                     order by 24,11,12,13,25
 

END

GO
INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '04897', GetDate())
GO
