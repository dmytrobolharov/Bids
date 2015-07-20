IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[dpx_RawMaterial_FabricColor_Consumption_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[dpx_RawMaterial_FabricColor_Consumption_SELECT]
GO

/*
Comments:

#01 - Ryan Cabanas - October 21, 2009
	Replace the old color image string with the new color image string using function.
Deleted old code.
#02 - Oleg Pechenevsky - July 2, 2012
	Changed search function (report parameters) to AgentName and VendorName (not IDs).
*/


CREATE     PROCEDURE  [dbo].[dpx_RawMaterial_FabricColor_Consumption_SELECT]
	@Season      			nvarchar(200) = NULL
	,@Year	     			nvarchar(200) = NULL
	,@MaterialType			nvarchar(50) = null	
	,@MaterialNo			nvarchar(50) = null
	,@TradePartnerID		nvarchar(200) = NULL    -- agent name
	,@TradePartnerVendorID	nvarchar(200) = NULL	-- vendor name
	,@ApprovalStatus		nvarchar(40) = NULL

AS

BEGIN
SET NOCOUNT ON


IF @Season IS NULL
BEGIN
 SET @Season = 'ALL'
END

IF @Year IS NULL
BEGIN
 SET @Year = 'ALL'
END

IF  @TradePartnerID IS NULL
	BEGIN
	 SET @TradePartnerID = 'ALL'
	END

IF  @TradePartnerVendorID IS NULL or @TradePartnerVendorID = ''
	BEGIN
	 SET @TradePartnerVendorID = 'ALL'
	END
	
DECLARE @VendorName nvarchar (200) = @TradePartnerVendorID
DECLARE @AgentName nvarchar (200) = @TradePartnerID

	

IF  @ApprovalStatus IS NULL or @ApprovalStatus = ''
	BEGIN
	 SET @ApprovalStatus = 'ALL'
	END

IF @MaterialType IS NULL or @MaterialType = ''
	BEGIN
		Set @MaterialType = 'ALL'
	END

IF @MaterialNo IS NULL or @MaterialNo = ''
	BEGIN
		Set @MaterialNo = 'ALL'
	END


SELECT  LTRIM(RTRIM(h.CustomField2))  as Season
	,LTRIM(RTRIM(h.CustomField4)) as MaterialYear
	,p.ComponentDescription AS MaterialType
	,(dbo.fnx_GetStreamingColorImagePath(t.ColorFolderID, t.ColorPaletteID)) AS ColorImagePath	--Comment #01
	,m.MaterialNo as MaterialCode
	,m.MaterialName
	,m.G as Content
	,(CASE WHEN m.MaterialType = 11 THEN m.K 
               ELSE '' END) AS Weight
	,c.ColorCode,  c.ColorName
	,uc.CountryName as COO
	,t.MaterialTradePartnerID 
	,ut.TradePartnerName
	,uv.VendorName
	,ut.TradePartnerName + '/'+ uv.VendorName as AgentVendor
	,xc.Custom as Status
	,m.R as SupplierMillRefNo
	,st.Width
	--,st.UOM 
	,UOM.UOM
	--,m.F	AS Status
	,CAST (st.QTY AS Decimal(18,4)) AS Quantity	
	,st.Placement
	,h.[Description] as StyleDescription
	,h.StyleNo AS StylesWhereUsed
	,1 as GrandTotalGroup --- only to get the entire row group for grand total of the record count
FROM pMaterial m WITH (NOLOCK) 
INNER JOIN pMaterialTradePartnerColor t WITH (NOLOCK) ON m.MaterialID = t.MaterialID
LEFT OUTER JOIN pMaterialColor c WITH (NOLOCK) ON c.MaterialColorID = t.MaterialColorID
LEFT OUTER JOIN pMaterialSize  s WITH (NOLOCK) ON s.MaterialSizeID  = t.MaterialSizeID 
LEFT OUTER JOIN pComponentType p WITH (NOLOCK) ON p.componentTypeID = m.MaterialType
LEFT OUTER JOIN pMaterialTradePartner tp WITH (NOLOCK) ON tp.MaterialTradePartnerId = t.MaterialTradePartnerId and tp.MaterialId = t.MaterialID
LEFT OUTER JOIN uTradePartner ut WITH (NOLOCK) ON ut.TradepartnerId = tp.TradepartnerId
LEFT OUTER JOIN uTradepartnerVendor uv WITH (NOLOCK) On uv.TradePartnerVendorID = tp.TradepartnerVendorId

LEFT OUTER JOIN	pStyleMaterials  st WITH (NOLOCK) ON  m.MaterialID = st.MaterialID
LEFT OUTER JOIN pStyleHeader h WITH (NOLOCK) ON  st.StyleID = h.StyleID
LEFT OUTER JOIN xCustom8 xc ON m.S = xc.CustomKey
LEFT OUTER JOIN uCountry uc ON m.P = uc.CountryCode
LEFT OUTER JOIN UOM ON m.UOM = uom.UOMValue
WHERE
      (
         ( (LTRIM(RTRIM(h.CustomField2)) = LTRIM(RTRIM(@Season))) 
			OR 
         ( LTRIM(RTRIM(@Season)) = 'ALL'))
       )
   AND (
	       (LTRIM(RTRIM(h.CustomField4)) =  LTRIM(RTRIM(@Year))) or ( LTRIM(RTRIM(@Year)) ='ALL')
        )
   AND (
	      --(CAST(uv.TradePartnerVendorID  AS nvarchar(40)) = @TradePartnerVendorID)
       --    OR  
       --   (@TradePartnerVendorID = 'ALL')  
	      (uv.VendorName like ('%'+@VendorName+'%'))
           OR  
          (@TradePartnerVendorID = 'ALL')  
       )
   AND (
	      --(CAST(ut.TradePartnerID  AS nvarchar(40)) = @TradePartnerID)
       --    OR  
       --   (@TradePartnerID = 'ALL')  
	      (ut.TradePartnerName like ('%'+@AgentName+'%'))
           OR  
          (@TradePartnerID = 'ALL')  
       )
   AND (
		  (RTRIM(t.MaterialTradeColor1) = RTRIM(@ApprovalStatus))
           OR  
          (RTRIM(@ApprovalStatus) = 'ALL')  
       )
   AND (
		  (LTRIM(RTRIM(p.ComponentDescription)) = LTRIM(RTRIM(@MaterialType))) 
			OR 
			(@MaterialType = 'ALL')
		)
   AND (
          (LTRIM(RTRIM(m.MaterialNo)) = LTRIM(RTRIM(@MaterialNo)))
            OR 
          (@MaterialNo = 'ALL')
        )
Order by p.ComponentDescription, m.MaterialNo, c.ColorCode, c.ColorName, AgentVendor, h.StyleNo

END


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0.0000', '05786', GetDate())
GO
