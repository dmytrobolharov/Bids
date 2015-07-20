

/****** Object:  StoredProcedure [dbo].[spx_Sourcing_StyleBOMShowHide_Clean]    Script Date: 11/22/2012 02:19:45 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Sourcing_StyleBOMShowHide_Clean]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_Sourcing_StyleBOMShowHide_Clean]
GO


/****** Object:  StoredProcedure [dbo].[spx_Sourcing_StyleBOMShowHide_Clean]    Script Date: 11/22/2012 02:19:45 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-- Stored Procedure

CREATE PROCEDURE [dbo].[spx_Sourcing_StyleBOMShowHide_Clean]
(@StyleQuoteItemId uniqueidentifier,
@StyleBOMDimensionId nvarchar(50),
@MUser nvarchar(200),
@MDate datetime
)
AS 

	

	
BEGIN

update   pSourcingQuoteStyleBOM set ItemDim1Active=0, ItemDim2Active=0, ItemDim3Active=0
WHERE StyleQuoteItemID=@StyleQuoteItemID and StyleBOMDimensionId=@StyleBOMDimensionId

END





GO









INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04416', GetDate())
GO
