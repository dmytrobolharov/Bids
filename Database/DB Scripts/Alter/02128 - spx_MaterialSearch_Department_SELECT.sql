SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.ROUTINES WHERE SPECIFIC_NAME = N'spx_MaterialSearch_Department_SELECT')
   DROP PROCEDURE spx_MaterialSearch_Department_SELECT
GO


SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create PROCEDURE [dbo].[spx_MaterialSearch_Department_SELECT]  (
@MaterialTradePartner VARCHAR(100), 
@strSqlSearch  NVARCHAR(1000)
)
AS
BEGIN
	DECLARE @CSV varchar(max)
	
	set @CSV =	'select tt.* from (SELECT     MaterialID, TempID, TempNo, MaterialImageID, MaterialImageVersion, MaterialImageDetailID, 
	MaterialImageDetailVersion, NoColorMatch, SupplierID, MaterialType, 
	MaterialNo, MaterialName, A, B, C, D, E, F, G, H, I, J, K, L, M, N, O, P, Q, R, S, T, U, V, W, X, Y, Z,
	 Source, Notes, VendorPrice, VolumePrice, VolumePriceMinimum, 
	VendorProductionMin, VendorProductionLeadTime, MaterialPlacement, DetailYesNo, ImageType1, height, 
	width, CDate, CUser, MDate, MUser, MChange, DChange, 
	Action, Status, Active, MultiDimension, UOM, MaterialCode, MaterialCodeNo, SAPCode, SAPControl, 
	MaterialColorRequired, FactorySourced, TradePartnerID,TradePartnerVendorID, HeaderLocked, 
	dbo.fnx_GetMaterialDepartment_COMMA(MaterialID,''' + @MaterialTradePartner + ''') AS MaterialTradePartnerCustom24
	FROM dbo.pMaterial) as tt ' + @strSqlSearch

	EXEC (@CSV)

	PRINT (@CSV)
END	

GO
IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='02128'))
BEGIN
	INSERT INTO sVersion
		(
			AppName
			,[Version]
			,LastScriptRun
			,[TimeStamp]
		)
	VALUES     
		(
			'DB_Version'
			,'4.1.3000'
			,'02128'
			,GetDate()
		)
END	
GO



