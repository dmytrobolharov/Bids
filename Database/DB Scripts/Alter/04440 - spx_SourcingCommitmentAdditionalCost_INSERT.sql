
/****** Object:  StoredProcedure [dbo].[spx_SourcingCommitmentAdditionalCost_INSERT]    Script Date: 11/23/2012 15:19:16 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_SourcingCommitmentAdditionalCost_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_SourcingCommitmentAdditionalCost_INSERT]
GO


/****** Object:  StoredProcedure [dbo].[spx_SourcingCommitmentAdditionalCost_INSERT]    Script Date: 11/23/2012 15:19:16 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-- Stored Procedure

CREATE PROCEDURE [dbo].[spx_SourcingCommitmentAdditionalCost_INSERT]
(
@SourcingCommitmentItemID uniqueidentifier,
@SourcingHeaderID uniqueidentifier,
@SourcingStyleID uniqueidentifier,
@TeamID uniqueidentifier,
@CUser nvarchar(200),
@CDate datetime
)
AS 

BEGIN
	INSERT INTO pSourcingCommitmentAdditionalCost 
		(CommitmentItemID,SourcingHeaderID,SourcingStyleID, [Description], Amount, TeamID, CUser, CDate, MUser, MDate) 
	VALUES 
		(@SourcingCommitmentItemID, @SourcingHeaderID,@SourcingStyleID, '', 0, @TeamID, @CUser, @CDate, @Cuser, @CDate)
END


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04440', GetDate())
GO  
