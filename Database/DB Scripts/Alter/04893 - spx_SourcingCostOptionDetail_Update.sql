/****** Object:  StoredProcedure [dbo].[spx_SourcingCostOptionDetail_Update]    Script Date: 01/24/2013 19:12:03 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_SourcingCostOptionDetail_Update]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_SourcingCostOptionDetail_Update]
GO

/****** Object:  StoredProcedure [dbo].[spx_SourcingCostOptionDetail_Update]    Script Date: 01/24/2013 19:12:03 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



-- Stored Procedure

CREATE PROCEDURE [dbo].[spx_SourcingCostOptionDetail_Update]
(@StyleQuoteItemId uniqueidentifier,
@SourcingCostOptionID uniqueidentifier
)
AS 

	

	
BEGIN

update   pSourcingCostOptionDetail  set Active=0 where SourcingCostOptionId=@SourcingCostOptionID

--insert new dimension, that checked in edit
insert pSourcingCostOptionDetail(SourcingCostOptionDetailID,SourcingCostOptionId,SourcingQuotationBOMDetailsID,MinQuantity,
MaxQuantity,CostUnit,Active,ItemDim1Id,ItemDim2Id,ItemDim3Id)
select NEWID(),@SourcingCostOptionID,SourcingQuotationBOMDetailsID, 0, 0, 0.00, 0,
ItemDim1Id,ItemDim2Id,ItemDim3Id from pSourcingQuotationBOMDetails where
StyleQuoteItemID=@StyleQuoteItemId 
and not 
(ISNULL(cast(ItemDim1Id as varchar(40)),'')+ISNULL(cast(ItemDim2Id as varchar(40)),'')+ISNULL(cast(ItemDim3Id as varchar(40)),'') in (Select ISNULL(cast(ItemDim1Id as varchar(40)),'')+ISNULL(cast(ItemDim2Id as varchar(40)),'')+ISNULL(cast(ItemDim3Id as varchar(40)),'') from pSourcingCostOptionDetail where SourcingCostOptionId=@SourcingCostOptionID)
)

update   pSourcingCostOptionDetail  set Active=1 where SourcingCostOptionId=@SourcingCostOptionID and 
(ISNULL(cast(ItemDim1Id as varchar(40)),'')+ISNULL(cast(ItemDim2Id as varchar(40)),'')+ISNULL(cast(ItemDim3Id as varchar(40)),'') in (Select ISNULL(cast(ItemDim1Id as varchar(40)),'')+ISNULL(cast(ItemDim2Id as varchar(40)),'')+ISNULL(cast(ItemDim3Id as varchar(40)),'') from pSourcingQuotationBOMDetails where StyleQuoteItemID=@StyleQuoteItemId)
)


select * from vwx_SourcingCostOptionDetail where SourcingCostOptionId=@SourcingCostOptionID
END



GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04893', GetDate())
GO

