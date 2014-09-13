IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_MaterialRequestSubmitWorkflowColor_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_MaterialRequestSubmitWorkflowColor_INSERT]
GO

CREATE PROCEDURE [dbo].[spx_MaterialRequestSubmitWorkflowColor_INSERT] ( 
@MaterialTradePartnerID UNIQUEIDENTIFIER,
@MaterialColorID UNIQUEIDENTIFIER,
@MaterialSizeID UNIQUEIDENTIFIER,
@CUser NVARCHAR(200), 
@CDate DATETIME 
)
AS

IF  ( SELECT COUNT(*) FROM  pMaterialTradePartnerColor 
WHERE MaterialColorID = @MaterialColorID AND MaterialSizeID = @MaterialSizeID AND MaterialTradePartnerID = @MaterialTradePartnerID ) = 0 
BEGIN
	
	DECLARE @MaterialTradePartnerColorID UNIQUEIDENTIFIER 
	SET @MaterialTradePartnerColorID = NEWID() 
	
	INSERT INTO pMaterialTradePartnerColor ( MaterialTradePartnerColorID , MaterialTradePartnerID , MaterialColorID , MaterialID , 
	ColorFolderID, ColorPaletteID , ColorName, ColorSource, VendorColorName, Hex, R, G, B, H, S, L ,
	CUser, CDate, MUser, MDate, MaterialColorVersion, MaterialSizeID )
	SELECT @MaterialTradePartnerColorID, @MaterialTradePartnerID , @MaterialColorID , a.MaterialID,   
	a.ColorFolderID, a.ColorPaletteID, a.ColorName, a.ColorSource, a.VendorColorName, a.Hex, a.R, a.G, a.B, a.H, a.S, a.L ,
	@CUser, @Cdate, @CUser, @Cdate,1, @MaterialSizeID 
	FROM pMaterialColor a
	WHERE a.MaterialColorID = @MaterialColorID


	EXEC dbo.spx_MaterialRequestSubmitWorkflowColor_Logic_UPDATE 
		@MaterialTradePartnerID = @MaterialTradePartnerID,
		@MaterialTradePartnerColorID = @MaterialTradePartnerColorID

END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '08365', GetDate())
GO
