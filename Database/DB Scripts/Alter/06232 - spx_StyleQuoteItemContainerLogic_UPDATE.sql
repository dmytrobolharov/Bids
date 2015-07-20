IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleQuoteItemContainerLogic_UPDATE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleQuoteItemContainerLogic_UPDATE]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spx_StyleQuoteItemContainerLogic_UPDATE]
(
@StyleQuoteItemID uniqueidentifier
)
AS 

DECLARE @StyleQuoteDutyId uniqueidentifier
DECLARE @TradePartnerID uniqueidentifier
DECLARE @TradePartnerVendorID uniqueidentifier
DECLARE @GarmentWgt decimal(19,3) --StyleCostingCustomField2
DECLARE @AvgFirstCost decimal(19,3) --StyleQuoteItemCustomField1
DECLARE @RetailCost decimal(19,3) --StyleQuoteItemCustomField1
DECLARE @MiscCost  decimal(19,3) --StyleCostingCustomField4  
DECLARE @RoyaltyPerc decimal(19,3) --StyleCostingCustomField8 
DECLARE @RoyaltyCode int
DECLARE @VariancePerc decimal(19,3) --StyleCostingCustomField10
DECLARE @DutyPerc decimal(19,3) --StyleCostingCustomField11
DECLARE @Surcharge decimal(19,3) --StyleCostingCustomField12
DECLARE @BrokerHarborFee decimal(19,3) --StyleCostingCustomField13
DECLARE @CountryCode varchar(50) --StyleQuoteItemCustomField4,
DECLARE @StyleCostingType int
DECLARE @TradePartnerState varchar(2)

DECLARE @CartonDimension varchar(3) --StyleCostingCustomField20
DECLARE @CartonHeight decimal(19,3) --StyleCostingCustomField21
DECLARE @CartonLeght decimal(19,3) --StyleCostingCustomField22
DECLARE @CartonWidth decimal(19,3) --StyleCostingCustomField23
DECLARE @UnitPerCarton decimal(19,3) --StyleCostingCustomField24
DECLARE @VolCubicFeet decimal(19,3) --StyleCostingCustomField25
DECLARE @ContainerSize varchar(10) --StyleCostingCustomField26


DECLARE @NumberOfUnit decimal(19,3)
DECLARE @HomeCost varchar(10)

--Preference Table
DECLARE @PrefImportVariance decimal(19,3)
DECLARE @PrefDomesticVariance decimal(19,3)
DECLARE @PrefIndirectVariance decimal(19,3)
DECLARE @PrefContainerSizeInCft20 decimal(19,3)
DECLARE @PrefContainerSizeInCft40 decimal(19,3)
DECLARE @PrefContainerSizeInCftLCL decimal(19,3)

SELECT	@PrefImportVariance = ImportVariance, 
		@PrefDomesticVariance = DomesticVariance, 
		@PrefIndirectVariance = IndirectVariance, 
		@PrefContainerSizeInCft20 = ContainerSizePref20Cft,
		@PrefContainerSizeInCft40 = ContainerSizePref40Cft,
		@PrefContainerSizeInCftLCL = 0
FROM pStyleCostingPreference WITH (NOLOCK)


SELECT 
	@StyleQuoteDutyId = ISNULL(StyleQuotaDutyId,'{00000000-0000-0000-0000-000000000000}'),
	@TradePartnerID = ISNULL(TradePartnerID,'{00000000-0000-0000-0000-000000000000}'), 
	@TradePartnerVendorID = ISNULL(TradePartnerVendorID,'{00000000-0000-0000-0000-000000000000}'),  
	@AvgFirstCost = ISNULL(StyleQuoteItemCustomField1,0),
	@RetailCost = ISNULL(StyleQuoteItemCustomField2,0),
	@RoyaltyCode = ISNULL(StyleQuoteItemCustomField3,0),
	@CountryCode = ISNULL(StyleQuoteItemCustomField4,''),
	@MiscCost = ISNULL(StyleCostingCustomField4,0),
	@RoyaltyPerc = ISNULL(StyleCostingCustomField8,0),
	@VariancePerc = ISNULL(StyleCostingCustomField10,0),
	@DutyPerc = ISNULL(StyleCostingCustomField11,0),
	@Surcharge = ISNULL(StyleCostingCustomField12,0),
	@GarmentWgt = ISNULL(StyleCostingCustomField2,0),
	@BrokerHarborFee = ISNULL(StyleCostingCustomField13,0),
	@NumberOfUnit = ISNULL(StyleCostingCustomField18,0),
	@CartonDimension = StyleCostingCustomField20, 
	@CartonHeight = ISNULL(StyleCostingCustomField21,0),
	@CartonLeght = ISNULL(StyleCostingCustomField22,0), 
	@CartonWidth = ISNULL(StyleCostingCustomField23,0),
	@UnitPerCarton = ISNULL(StyleCostingCustomField24,0),
	@VolCubicFeet = ISNULL(StyleCostingCustomField25,0),
	@ContainerSize = ISNULL(StyleCostingCustomField26,0),
	@HomeCost = ISNULL(StyleQuoteItemCustomField25,0)
FROM  dbo.pStyleQuoteItem WITH (NOLOCK)
WHERE  (StyleQuoteItemID = @StyleQuoteItemID)

DECLARE @TradePartnerClass varchar(50)
DECLARE @TradePartnerCommission decimal(19,3) --StyleCostingCustomField9

SELECT @TradePartnerClass = TradePartnerClass, @TradePartnerCommission = TradePartnerCommision, @TradePartnerState = State, @StyleCostingType = TradePartnerClass
FROM uTradePartner WITH (NOLOCK) WHERE TradePartnerID = @TradePartnerID


DECLARE @TradePartnerVendorCountry varchar(50)

SELECT @TradePartnerVendorCountry = Country 
FROM uTradePartnerVendor WITH (NOLOCK) WHERE TradePartnerVendorID = @TradePartnerVendorID


--Must Select duty Perc from Duty Table
SELECT 
@DutyPerc = DutyPerc, 
@Surcharge = DutySurcharge
FROM pStyleCostingDuty WITH (NOLOCK) 
WHERE CustomID = @StyleQuoteDutyId

--Country rate
DECLARE @AirRate decimal(19,3), @BoatRate decimal(19,3)
DECLARE @Container40 decimal(19,3), @Container20 decimal(19,3), @ContainerLCL decimal(19,3), @ContainerVolumeAir decimal(19,3) 
SELECT @AirRate = AirRate, @BoatRate = SeaRate, @Container40 = Container40, @Container20 = Container20, @ContainerLCL = ContainerLCL, @ContainerVolumeAir = ContainerVolAir   
FROM uCountry WITH (NOLOCK) WHERE CountryCode = @CountryCode

SELECT @CountryCode AS COUNTRY

	
	--AIR
	
	DECLARE @AirCostperUnit decimal(19,3)
	
	DECLARE @AirCartonDimension decimal(19,3)
	SET @AirCartonDimension = (@CartonHeight * @CartonLeght * @CartonWidth)	
	
	DECLARE @CartonVolumeInLbs decimal(19,3)
	SET @CartonVolumeInLbs = @AirCartonDimension / 166
	
	DECLARE @AirFreightCostPerCarton decimal(19,3)
	SET @AirFreightCostPerCarton = (@CartonVolumeInLbs) *  (@AirRate * 16) 

	SET @AirCostperUnit = (@AirRate * 16) * (@AirCartonDimension) / (@UnitPerCarton * 166)

	
	SELECT @AirRate AS AirRate, @AirCartonDimension AS AirCartonDimension, @AirCostperUnit AS  AirCostperUnit1 
	
	---BOAT	
	
	DECLARE @BoatCostperUnit decimal(19,3)
	DECLARE @CartonVolumeInCft decimal(19,3)	
	
	DECLARE @BoatCartonDimension decimal(19,3)
	SET @BoatCartonDimension = (@CartonHeight * @CartonLeght * @CartonWidth)
	
	
	DECLARE @BoatCostPerCarton decimal(19,3)
	SET @BoatCostPerCarton = (@CartonVolumeInCft *  @BoatRate)
	
	DECLARE @ContainerPerc decimal(19,5)
	DECLARE @CartonInContainer decimal(19,5)
	DECLARE @CostPercarton decimal(19,5)
	DECLARE @CartonVolumeCountryCftRate decimal(19,4)
	DECLARE @PrefContainerSizeInCft decimal(19,4)
	
	BEGIN
	IF @ContainerSize = '0' SET @CartonVolumeCountryCftRate = @ContainerLCL 
	IF @ContainerSize = '40' SET @CartonVolumeCountryCftRate = @Container40 
	IF @ContainerSize = '20' SET @CartonVolumeCountryCftRate = @Container20
	END
	
	BEGIN
	IF @ContainerSize = '0' SET @PrefContainerSizeInCft = @PrefContainerSizeInCftLCL
	IF @ContainerSize = '40' SET @PrefContainerSizeInCft = @PrefContainerSizeInCft40
	IF @ContainerSize = '20' SET @PrefContainerSizeInCft = @PrefContainerSizeInCft20
	END
	
	SELECT @ContainerSize
	
	
	IF @CartonDimension = 'IN'
	BEGIN
		
		SET @CartonVolumeInCft = (@BoatCartonDimension / 1728)
		SET @BoatCostperUnit = @BoatCostPerCarton / @UnitPerCarton
		
		SET  @CostPercarton = @CartonVolumeInCft * @CartonVolumeCountryCftRate 
		SET @BoatCostPerUnit = @CostPercarton /@UnitPerCarton
		
		IF @PrefContainerSizeInCft = 0
			BEGIN
				SET @ContainerPerc = 0
			END
		ELSE
			BEGIN
				SET @ContainerPerc = (@CartonVolumeInCft * @NumberOfUnit * (1/@UnitPerCarton)) / @PrefContainerSizeInCft
			END		


		SELECT @NumberOfUnit AS NumberofUnit, @ContainerPerc AS CartonPerc, @UnitPerCarton AS UnitPerCarton, @PrefContainerSizeInCft AS PrefContainerSizeInCft, @CartonVolumeInCft AS CartonVolumeInCft, @CostPercarton AS CostPercarton, @BoatCostPerUnit AS BoatCostPerUnit 
	END	

	
	IF @CartonDimension = 'CM'
	BEGIN
		
		SET @CartonVolumeInCft = (@BoatCartonDimension / 16.38) / 1728
		SET @BoatCostperUnit = @BoatCostPerCarton / @UnitPerCarton
		
		SET  @CostPercarton = @CartonVolumeInCft * @CartonVolumeCountryCftRate 
		SET @BoatCostPerUnit = @CostPercarton /@UnitPerCarton
		
		IF @PrefContainerSizeInCft = 0
			BEGIN
				SET @ContainerPerc = 0
			END
		ELSE
			BEGIN
				SET @ContainerPerc = (@CartonVolumeInCft * @NumberOfUnit * (1/@UnitPerCarton)) / @PrefContainerSizeInCft
			END	
		
		
		SELECT @NumberOfUnit AS NumberofUnit, @ContainerPerc AS CartonPerc, @UnitPerCarton AS UnitPerCarton, @PrefContainerSizeInCft AS PrefContainerSizeInCft, @CartonVolumeInCft AS CartonVolumeInCft, @CostPercarton AS CostPercarton, @BoatCostPerUnit AS BoatCostPerUnit 
	END	

	
	BEGIN
		UPDATE pStyleQuoteItem SET 
			StyleCostingCustomField25 = @CartonVolumeInCft,	--Vol. in Cubic Feet
			StyleCostingCustomField27 = @ContainerPerc,		--Container %
			StyleCostingCustomField28 = @CostPercarton,		--Cost/Carton
			StyleCostingCustomField29 = @BoatCostperUnit,		--Cost/Unit
			StyleCostingCustomField30 = 0						--Air Wt/Carton
		WHERE StyleQuoteItemID = @StyleQuoteItemID
	END



GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0.0000', '06232', GetDate())
GO
