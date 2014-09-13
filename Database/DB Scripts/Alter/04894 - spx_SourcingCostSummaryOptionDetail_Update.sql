/****** Object:  StoredProcedure [dbo].[spx_SourcingCostSummaryOptionDetail_Update]    Script Date: 01/24/2013 19:12:14 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_SourcingCostSummaryOptionDetail_Update]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_SourcingCostSummaryOptionDetail_Update]
GO

/****** Object:  StoredProcedure [dbo].[spx_SourcingCostSummaryOptionDetail_Update]    Script Date: 01/24/2013 19:12:14 ******/
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

select * from vwx_SourcingCostOptionDetail where SourcingCostOptionId in (select SourcingCostOptionID from pSourcingCostOption where StyleQuoteItemID=@StyleQuoteItemId)


END






GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04894', GetDate())
GO