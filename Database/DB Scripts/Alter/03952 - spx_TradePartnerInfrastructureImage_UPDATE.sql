IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_TradePartnerInfrastructureImage_UPDATE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_TradePartnerInfrastructureImage_UPDATE]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spx_TradePartnerInfrastructureImage_UPDATE]
(@TradePartnerInfrastructureImageID uniqueidentifier,
@ImageDescription nvarchar(200),
@ImageName nvarchar(100),
@ImageSize int,
@ImageType nvarchar(50),
@MUser nvarchar(200),
@MDate datetime)
AS 

BEGIN
UPDATE uTradePartnerInfrastructureImage SET ImageDescription = @ImageDescription,  
	ImageName = @ImageName, ImageSize = @ImageSize, ImageType = @ImageType, MUser = @MUser, MDate = @MDate
    WHERE TradePartnerInfrastructureImageID =  @TradePartnerInfrastructureImageID
END
GO
INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '03952', GetDate())
GO