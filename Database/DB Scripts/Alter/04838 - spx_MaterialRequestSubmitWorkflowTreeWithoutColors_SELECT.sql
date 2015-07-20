/****** Object:  StoredProcedure [dbo].[spx_MaterialRequestSubmitWorkflowTreeWithoutColors_SELECT]    Script Date: 01/22/2013 16:25:28 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_MaterialRequestSubmitWorkflowTreeWithoutColors_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_MaterialRequestSubmitWorkflowTreeWithoutColors_SELECT]
GO


/****** Object:  StoredProcedure [dbo].[spx_MaterialRequestSubmitWorkflowTreeWithoutColors_SELECT]    Script Date: 01/22/2013 16:25:28 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[spx_MaterialRequestSubmitWorkflowTreeWithoutColors_SELECT](  
 @MaterialTradePartnerColorID UNIQUEIDENTIFIER,
 @SupplierID UNIQUEIDENTIFIER = NULL
)      
AS       
  
		
DECLARE 
	@MaterialTradePartnerID UNIQUEIDENTIFIER,
	@MaterialRequestWorkflowID VARCHAR(10)
	
     
SELECT TOP 1 
	@MaterialTradePartnerID = MaterialTradePartnerID
FROM pMaterialRequestSubmitWorkflow       
WHERE MaterialTradePartnerColorID = @MaterialTradePartnerColorID    

/** For plmOn and old trade partner management in srmOn **/
IF @SupplierID IS NULL
BEGIN

	SELECT  foo.MaterialTradePartnerColorID, foo.MaterialRequestWorkflowID, 
		b.ColorCode, b.ColorName, 
		a.MaterialTradePartnerID, a.ColorNo, a.VendorColorCode, a.VendorColorNo, a.VendorColorName, 
		a.MaterialID,
		c.Status, '../System/Icons/' + c.StatusIcon AS Icon,
		d.MaterialRequestSubmitWorkflowID, d.Submit, d.DueDate, d.EndDate,  
		e.MaterialRequestWorkflow, e.MaterialRequestWorkflowSort, 
		d.MaterialRequestPartnerTypeID, pt.Custom AS PartnerType, ISNULL(pt.CustomKey, '1') AS PartnerOwner
	FROM (
		SELECT DISTINCT a.MaterialTradePartnerColorID, b.MaterialRequestWorkflowID
		FROM dbo.pMaterialRequestSubmit a WITH(NOLOCK)
			INNER JOIN dbo.pMaterialRequestSubmitWorkflow b WITH(NOLOCK) ON  a.MaterialRequestSubmitWorkflowID = b.MaterialRequestSubmitWorkflowID
			INNER JOIN pMaterialRequestWorkflow c WITH(NOLOCK) ON b.MaterialRequestWorkflowID  = c.MaterialRequestWorkflowID
		WHERE a.MaterialTradePartnerID = @MaterialTradePartnerID
			AND c.MaterialRequestWorkflowColor = 1
		--GROUP BY a.MaterialTradePartnerColorID
	) AS foo 
		INNER JOIN dbo.pMaterialTradePartnerColor a WITH(NOLOCK) ON a.MaterialTradePartnerColorID =  foo.MaterialTradePartnerColorID
		INNER JOIN dbo.pColorPalette b WITH(NOLOCK) ON b.ColorPaletteID   = a.ColorPaletteID
		INNER JOIN dbo.pMaterialRequestSubmitWorkflow d WITH(NOLOCK) ON d.MaterialRequestWorkflowID = foo.MaterialRequestWorkflowID
			AND d.MaterialTradePartnerColorID = foo.MaterialTradePartnerColorID
		INNER JOIN dbo.pMaterialRequestSubmitStatus c WITH(NOLOCK)  ON c.StatusID = d.Status
		INNER JOIN dbo.pMaterialRequestWorkflow e WITH(NOLOCK) ON e.MaterialRequestWorkflowID = foo.MaterialRequestWorkflowID
		LEFT JOIN dbo.uTradePartnerType pt WITH(NOLOCK) ON d.MaterialRequestPartnerTypeID = pt.CustomId
	ORDER BY  e.MaterialRequestWorkflowSort 

END
ELSE
BEGIN

	SELECT  foo.MaterialTradePartnerColorID, foo.MaterialRequestWorkflowID, 
		b.ColorCode, b.ColorName, 
		a.MaterialTradePartnerID, a.ColorNo, a.VendorColorCode, a.VendorColorNo, a.VendorColorName, 
		a.MaterialID,
		c.Status, '../System/Icons/' + c.StatusIcon AS Icon,
		d.MaterialRequestSubmitWorkflowID, d.Submit, d.DueDate, d.EndDate,  
		e.MaterialRequestWorkflow, e.MaterialRequestWorkflowSort, 
		d.MaterialRequestPartnerTypeID, pt.Custom AS PartnerType, ISNULL(pt.CustomKey, '1') AS PartnerOwner
	FROM (
		SELECT DISTINCT a.MaterialTradePartnerColorID, b.MaterialRequestWorkflowID
		FROM dbo.pMaterialRequestSubmit a WITH(NOLOCK)
			INNER JOIN dbo.pMaterialRequestSubmitWorkflow b WITH(NOLOCK) ON  a.MaterialRequestSubmitWorkflowID = b.MaterialRequestSubmitWorkflowID
			INNER JOIN pMaterialRequestWorkflow c WITH(NOLOCK) ON b.MaterialRequestWorkflowID  = c.MaterialRequestWorkflowID
		WHERE a.MaterialTradePartnerID = @MaterialTradePartnerID
			AND c.MaterialRequestWorkflowColor = 1
		--GROUP BY a.MaterialTradePartnerColorID
	) AS foo 
		INNER JOIN dbo.pMaterialTradePartnerColor a WITH(NOLOCK) ON a.MaterialTradePartnerColorID =  foo.MaterialTradePartnerColorID
		INNER JOIN dbo.pColorPalette b WITH(NOLOCK) ON b.ColorPaletteID   = a.ColorPaletteID
		INNER JOIN dbo.pMaterialRequestSubmitWorkflow d WITH(NOLOCK) ON d.MaterialRequestWorkflowID = foo.MaterialRequestWorkflowID
			AND d.MaterialTradePartnerColorID = foo.MaterialTradePartnerColorID
		INNER JOIN dbo.pMaterialRequestSubmitStatus c WITH(NOLOCK)  ON c.StatusID = d.Status
		INNER JOIN dbo.pMaterialRequestWorkflow e WITH(NOLOCK) ON e.MaterialRequestWorkflowID = foo.MaterialRequestWorkflowID
		LEFT JOIN dbo.uTradePartnerType pt WITH(NOLOCK) ON d.MaterialRequestPartnerTypeID = pt.CustomId
		INNER JOIN dbo.pMaterialRequestSubmitWorkflowShare share ON share.MaterialRequestSubmitWorkflowID = foo.MaterialRequestWorkflowID
		AND share.TradePartnerID = @SupplierID
	ORDER BY  e.MaterialRequestWorkflowSort 
END
/*
      
SELECT d.MaterialTradePartnerColorID, d.ColorCode, e.MaterialRequestSubmitID,       
	d.ColorNo, d.ColorName, d.VendorColorCode,       
	d.VendorColorNo, d.VendorColorName, b.MaterialRequestWorkflowID,       
	b.GroupName, b.GroupID, a.Status,       
	c.Submit, c.DueDate, c.EndDate,       
	b.MaterialRequestWorkflow, c.MaterialRequestSubmitWorkflowID,       
	b.MaterialRequestWorkflowSort, d.MaterialID,       
	'../System/Icons/' + a.StatusIcon AS Icon,      
	c.MaterialTradePartnerID, b.MaterialRequestWorkflowColor, d.ColorFolderID, d.ColorPaletteID,      
	d.MaterialColorImageID, d.MaterialColorImageVersion, c.MaterialRequestSubmitAllColors      
FROM pMaterialRequestSubmitStatus a WITH(NOLOCK)   
	INNER JOIN pMaterialRequestWorkflow b WITH(NOLOCK)   
	INNER JOIN pMaterialRequestSubmitWorkflow c WITH(NOLOCK) ON  b.MaterialRequestWorkflowID = c.MaterialRequestWorkflowID   
		ON a.StatusID = c.Status   
	INNER JOIN pMaterialTradePartnerColor d WITH(NOLOCK) ON  c.MaterialTradePartnerColorID = d.MaterialTradePartnerColorID   
	INNER JOIN pMaterialRequestSubmit e WITH(NOLOCK) ON c.MaterialRequestSubmitWorkflowID = e.MaterialRequestSubmitWorkflowID       
	LEFT OUTER JOIN  pMaterialRequestWorkflowTemplateItem f ON c.MaterialRequestWorkflowTempItemID = f.MaterialRequestWorkflowTempItemID  
WHERE c.MaterialTradePartnerColorID = @MaterialTradePartnerColorID   
	AND c.MaterialRequestSubmitAllColors = 1      
	AND c.Active = 1       
ORDER BY  f.MaterialRequestWorkflowSort , c.MaterialRequestWorkflowTempItemID

   */



GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04838', GetDate())
GO
