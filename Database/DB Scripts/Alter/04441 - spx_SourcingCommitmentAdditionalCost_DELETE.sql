

/****** Object:  StoredProcedure [dbo].[spx_SourcingCommitmentAdditionalCost_DELETE]    Script Date: 11/23/2012 15:18:58 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_SourcingCommitmentAdditionalCost_DELETE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_SourcingCommitmentAdditionalCost_DELETE]
GO


/****** Object:  StoredProcedure [dbo].[spx_SourcingCommitmentAdditionalCost_DELETE]    Script Date: 11/23/2012 15:18:58 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spx_SourcingCommitmentAdditionalCost_DELETE]
(@CommitmentAdditionalCostID uniqueidentifier)
AS 

DELETE FROM pSourcingCommitmentAdditionalCost WHERE CommitmentAdditionalCostID = @CommitmentAdditionalCostID


GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04441', GetDate())
GO  