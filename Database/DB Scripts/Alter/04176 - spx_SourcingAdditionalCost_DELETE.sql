IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_SourcingAdditionalCost_DELETE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_SourcingAdditionalCost_DELETE]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

create PROCEDURE [dbo].[spx_SourcingAdditionalCost_DELETE]
(@SourcingAdditionalCostID uniqueidentifier)
AS 

DELETE FROM pSourcingAdditionalCost WHERE SourcingAdditionalCostID = @SourcingAdditionalCostID

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04176', GetDate())
GO