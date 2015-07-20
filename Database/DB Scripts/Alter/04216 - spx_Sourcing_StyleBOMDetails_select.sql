

/****** Object:  StoredProcedure [dbo].[spx_Sourcing_StyleBOMDetails_select]    Script Date: 10/16/2012 10:12:30 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Sourcing_StyleBOMDetails_select]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_Sourcing_StyleBOMDetails_select]
GO


/****** Object:  StoredProcedure [dbo].[spx_Sourcing_StyleBOMDetails_select]    Script Date: 10/16/2012 10:12:30 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-- Stored Procedure

CREATE PROCEDURE [dbo].[spx_Sourcing_StyleBOMDetails_select]
(
@StyleQuoteItemID uniqueidentifier,
@StyleBOMDimensionId uniqueidentifier
)
AS 


BEGIN
	select * from pSourcingQuotationBOMDetails where StyleBOMDimensionID=@StyleBOMDimensionID
	and StyleQuoteItemID=@StyleQuoteItemID 
	and itemdim1active=1 and itemdim2active=1 and itemdim3active=1
	order by Itemdim1sort, itemdim1name,Itemdim2sort, itemdim2name,
	Itemdim3sort, itemdim3name
	
END



GO
INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04216', GetDate())
GO


