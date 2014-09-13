
/****** Object:  StoredProcedure [dbo].[spx_Sourcing_CommitmentBOMDetails_select]    Script Date: 11/22/2012 17:15:25 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Sourcing_CommitmentBOMDetails_select]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_Sourcing_CommitmentBOMDetails_select]
GO


/****** Object:  StoredProcedure [dbo].[spx_Sourcing_CommitmentBOMDetails_select]    Script Date: 11/22/2012 17:15:25 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



-- Stored Procedure
Create PROCEDURE [dbo].[spx_Sourcing_CommitmentBOMDetails_select]
(
@CommitmentItemId uniqueidentifier,
@StyleBOMDimensionId uniqueidentifier
)
AS 


BEGIN
	select * from pSourcingCommitmentBOMDetails where StyleBOMDimensionID=@StyleBOMDimensionID
	and SourcingCommitmentItemID=@CommitmentItemId 
	and itemdim1active=1 and itemdim2active=1 and itemdim3active=1
	order by Itemdim1sort, itemdim1name,Itemdim2sort, itemdim2name,
	Itemdim3sort, itemdim3name
	
END


GO
INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04427', GetDate())
GO

