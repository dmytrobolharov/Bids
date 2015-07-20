IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_TradePartnerInfrastructureImageSortOrder_UPDATE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_TradePartnerInfrastructureImageSortOrder_UPDATE]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spx_TradePartnerInfrastructureImageSortOrder_UPDATE]
(@TradePartnerInfrastructureImageID uniqueidentifier,
@Sort int,
@MUser nvarchar(200),
@MDate datetime)
AS 

BEGIN
UPDATE uTradePartnerInfrastructureImage SET Sort = @Sort, MUser = @MUser, MDate = @MDate
    WHERE TradePartnerInfrastructureImageID =  @TradePartnerInfrastructureImageID
END
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '03953', GetDate())
GO