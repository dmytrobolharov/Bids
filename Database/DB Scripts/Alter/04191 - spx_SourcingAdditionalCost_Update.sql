

/****** Object:  StoredProcedure [dbo].[spx_SourcingAdditionalCost_Update]    Script Date: 10/15/2012 11:36:02 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_SourcingAdditionalCost_Update]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_SourcingAdditionalCost_Update]
GO


/****** Object:  StoredProcedure [dbo].[spx_SourcingAdditionalCost_Update]    Script Date: 10/15/2012 11:36:02 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- Stored Procedure

CREATE PROCEDURE [dbo].[spx_SourcingAdditionalCost_Update]
(@SourcingAdditionalCostID uniqueidentifier,
@QuoteItemID uniqueidentifier,
@Amount decimal(18,4),
@Description nvarchar(200),
@Cuser nvarchar(200),
@Cdate datetime
)
AS 


BEGIN
	update pSourcingAdditionalCost set  Amount=@Amount, [Description]=@Description,
	Cuser=@Cuser, Muser=@Cuser, Cdate=@Cdate , Mdate=@Cdate
	where SourcingAdditionalCostID=@SourcingAdditionalCostID
	and QuoteItemID=@QuoteItemID
	
END


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04191', GetDate())
GO


