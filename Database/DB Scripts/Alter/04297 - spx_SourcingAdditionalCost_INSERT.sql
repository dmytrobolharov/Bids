IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_SourcingAdditionalCost_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_SourcingAdditionalCost_INSERT]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- Stored Procedure

create PROCEDURE [dbo].[spx_SourcingAdditionalCost_INSERT]
(
@QuoteItemID uniqueidentifier,
@SourcingHeaderID uniqueidentifier,
@SourcingStyleID uniqueidentifier,
@TeamID uniqueidentifier,
@CUser nvarchar(200),
@CDate datetime
)
AS 

BEGIN
	INSERT INTO pSourcingAdditionalCost 
		(QuoteItemID,SourcingHeaderID,SourcingStyleID, [Description], Amount, TeamID, CUser, CDate, MUser, MDate) 
	VALUES 
		(@QuoteItemID, @SourcingHeaderID,@SourcingStyleID, '', 0, @TeamID, @CUser, @CDate, @Cuser, @CDate)
END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04297', GetDate())
GO

