/****** Object:  StoredProcedure [dbo].[spx_SourcingCommitmentCostOptionDetail_Update]    Script Date: 01/30/2013 16:23:21 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_SourcingCommitmentCostOptionDetail_Update]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_SourcingCommitmentCostOptionDetail_Update]
GO
/****** Object:  StoredProcedure [dbo].[spx_SourcingCommitmentCostOptionDetail_Update]    Script Date: 01/30/2013 16:23:21 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




-- Stored Procedure

CREATE PROCEDURE [dbo].[spx_SourcingCommitmentCostOptionDetail_Update]
(@CommitmentItemId uniqueidentifier,
@SourcingCostOptionID uniqueidentifier
)
AS 

	

	
BEGIN

update   pSourcingCommitmentCostOptionDetail  set Active=0 where SourcingCommitmentCostOptionId=@CommitmentItemId

--insert new dimension, that checked in edit
insert pSourcingCommitmentCostOptionDetail(SourcingCommitmentCostOptionDetailID,SourcingCommitmentCostOptionId,SourcingQuotationBOMDetailsID,MinQuantity,
MaxQuantity,CostUnit,Active,ItemDim1Id,ItemDim2Id,ItemDim3Id)
select NEWID(),@SourcingCostOptionID,SourcingCommitmentBOMDetailsID, 0, 0, 0.00, 0,
ItemDim1Id,ItemDim2Id,ItemDim3Id from pSourcingCommitmentBOMDetails where
SourcingCommitmentItemID=@CommitmentItemId 
and not 
(ISNULL(cast(ItemDim1Id as varchar(40)),'')+ISNULL(cast(ItemDim2Id as varchar(40)),'')+ISNULL(cast(ItemDim3Id as varchar(40)),'') in (Select ISNULL(cast(ItemDim1Id as varchar(40)),'')+ISNULL(cast(ItemDim2Id as varchar(40)),'')+ISNULL(cast(ItemDim3Id as varchar(40)),'') from pSourcingCommitmentCostOptionDetail where SourcingCommitmentCostOptionId=@SourcingCostOptionID)
)

update   pSourcingCommitmentCostOptionDetail  set Active=1 where SourcingCommitmentCostOptionId=@SourcingCostOptionID and 
(ISNULL(cast(ItemDim1Id as varchar(40)),'')+ISNULL(cast(ItemDim2Id as varchar(40)),'')+ISNULL(cast(ItemDim3Id as varchar(40)),'') in (Select ISNULL(cast(ItemDim1Id as varchar(40)),'')+ISNULL(cast(ItemDim2Id as varchar(40)),'')+ISNULL(cast(ItemDim3Id as varchar(40)),'') from pSourcingCommitmentBOMDetails where sourcingcommitmentItemID=@CommitmentItemId)
)


select distinct * from vwx_SourcingCommitmentCostOptionDetail where SourcingCommitmentCostOptionId=@SourcingCostOptionID
order by ItemDim1Sort, ItemDim2Sort, ItemDim3Sort
END




GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '04928', GetDate())
GO
