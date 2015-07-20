
/****** Object:  View [dbo].[vw_Style_BOL_OPERATIONS_SELECT]    Script Date: 12/06/2011 17:00:29 ******/
IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vw_Style_BOL_OPERATIONS_SELECT]'))
DROP VIEW [dbo].[vw_Style_BOL_OPERATIONS_SELECT]
GO

CREATE VIEW [dbo].[vw_Style_BOL_OPERATIONS_SELECT]  
AS  

	SELECT			
		PSBPO.PageOperationId, 	
		PBM.MacroCode AS Code, 	
		PBMC.MachineCode, 
		PBM.MacroName AS Name,		  
		CASE WHEN UTV.VendorCode+' ('+UTV.VendorName+')' IS NULL  THEN 'NA' ELSE UTV.VendorCode+' ('+UTV.VendorName+')' END AS VendorCode,
		PSBPO.StyleID,
		PSBPO.StyleSet,	
		'N' AS IsDutiable,
		PSBPO.Comments,	 
		dbo.fnx_GetStreamingImageBOLImagePath('BOLMOP','50',CAST(ISNULL(PBM.Image, '00000000-0000-0000-0000-000000000000') AS NVARCHAR(50))) AS Imagefilepath,
		PSBPO.Sort,
		PSBPO.MacroId,
		NULL AS MacroParentId
	FROM         
		pStyleBOLPageOperations PSBPO
		INNER JOIN pBOLMacro PBM ON PSBPO.MacroId = PBM.MacroId 
		LEFT OUTER JOIN pBOLOpToMacro PBOM ON PBM.MacroId=PBOM.MacroId  
		LEFT OUTER JOIN pBOLOperations PBO ON PBOM.OperationId =PBO.OperationId 
		LEFT OUTER JOIN pBOLMachines PBMC ON PBO.MachineId=PBMC.MachineId	
		LEFT OUTER JOIN pBOLFactoryMachines PBFM ON PBMC.MachineId=PBFM.MachineId			
		LEFT OUTER JOIN pBOLFactories PBF ON PBFM.FactoryId= PBF.FactoryId		
		LEFT OUTER JOIN uTradePartnerVendor UTV ON 	PBFM.TradePartnerVendorID= UTV.TradePartnerVendorID 
	WHERE 
		IsLinked = 1 
		AND PSBPO.MacroId IS NOT NULL 
		
	UNION  
	/* SELECT Operations of Linked Macro*/ 
	SELECT 			
		PSBPO.PageOperationId, 
		PBO.OperationCode AS Code,
		PBMC.MachineCode, 	
		PBO.OperationName AS Name,		  
		CASE WHEN UTV.VendorCode+' ('+UTV.VendorName+')' IS NULL  THEN 'NA' ELSE UTV.VendorCode+' ('+UTV.VendorName+')' END AS VendorCode,
		PSBPO.StyleID,
		PSBPO.StyleSet,
		CASE WHEN PBO.Fixed=1 THEN 'D' ELSE 'N' END AS IsDutiable,
		PSBPO.Comments, 	
		dbo.fnx_GetStreamingImageBOLImagePath('BOLMOP','50',CAST(ISNULL(PBM.Image, '00000000-0000-0000-0000-000000000000') AS NVARCHAR(50))) AS Imagefilepath, 
		psbpo.Sort,
		NULL AS MacroId,
		PSBPO.PageOperationId AS MacroParentId  
	FROM         
		pStyleBOLPageOperations PSBPO
		INNER JOIN pBOLOpToMacro PBTM ON PSBPO.MacroId =PBTM.MacroId 
		INNER JOIN pBOLOperations PBO ON PBTM.OperationId = PBO.OperationId 
		LEFT OUTER JOIN pBOLMachines PBMC ON PBO.MachineId=PBMC.MachineId	
		LEFT OUTER JOIN pBOLMacro PBM ON PSBPO.MacroId = PBM.MacroId  
		LEFT OUTER JOIN pBOLFactoryMachines PBFM ON PBMC.MachineId=PBFM.MachineId 		  	
		LEFT OUTER JOIN pBOLFactories PBF ON PBFM.FactoryId= PBF.FactoryId	
		LEFT OUTER JOIN uTradePartnerVendor UTV ON 	PBFM.TradePartnerVendorID= UTV.TradePartnerVendorID 
	WHERE     
		IsLinked = 1 
		AND PSBPO.MacroId IS NOT NULL  		
		
	UNION  
	/* SELECT Linked Operations*/ 
	SELECT	
		PSBPO.PageOperationId, 
		PBO.OperationCode AS Code,	
		PBMC.MachineCode,
		PBO.OperationName AS Name,		  
		CASE WHEN UTV.VendorCode+' ('+UTV.VendorName+')' IS NULL  THEN 'NA' ELSE UTV.VendorCode+' ('+UTV.VendorName+')' END AS VendorCode,
		PSBPO.StyleID,
		PSBPO.StyleSet,
		CASE WHEN PBO.Fixed=1 THEN 'D' ELSE 'N' END AS IsDutiable,
		PSBPO.Comments,		 
		dbo.fnx_GetStreamingImageBOLImagePath('BOLOP','50',CAST(ISNULL(PBO.Image, '00000000-0000-0000-0000-000000000000') AS NVARCHAR(50))) AS Imagefilepath,
		PSBPO.Sort,
		NULL AS MacroId,
		NULL AS MacroParentId  
	FROM 
		pStyleBOLPageOperations PSBPO
		INNER JOIN pBOLOperations PBO ON PSBPO.OperationId = PBO.OperationId  
		LEFT OUTER JOIN pBOLFactoryMachines PBFM ON PSBPO.MachineId=PBFM.MachineId
		LEFT OUTER JOIN pBOLMachines PBMC ON PSBPO.MachineId=PBMC.MachineId	   	
		LEFT OUTER JOIN pBOLFactories PBF ON PBFM.FactoryId= PBF.FactoryId
		LEFT OUTER JOIN uTradePartnerVendor UTV ON 	PBFM.TradePartnerVendorID= UTV.TradePartnerVendorID 	
	WHERE     
		IsLinked = 1 
		AND PSBPO.OperationId IS NOT NULL   
		
		
	UNION  
	/* SELECT Operations of Unlinked Macro*/ 
	SELECT 		
		T1.PageOperationId, 
		T1.Code AS Code,
		PBMC.MachineCode, 
		T1.Name AS Name,	
		CASE WHEN UTV.VendorCode+' ('+UTV.VendorName+')' IS NULL  THEN 'NA' ELSE UTV.VendorCode+' ('+UTV.VendorName+')' END AS VendorCode,
		T1.StyleID,
		T1.StyleSet,
		'N' AS IsDutiable,
		T1.Comments,		
		dbo.fnx_GetStreamingImageBOLImagePath('BOLOP','50',CAST(ISNULL(PBO.Image, '00000000-0000-0000-0000-000000000000') AS NVARCHAR(50))) AS Imagefilepath,
		T1.Sort,
		T1.MacroId,
		T1.MacroParentId
	FROM         
		pStyleBOLPageOperations AS T1 
		INNER JOIN pStyleBOLPageOperations AS T2 ON T1.MacroParentId = T2.PageOperationId
		LEFT OUTER JOIN pBOLOperations PBO ON T2.OperationId = PBO.OperationId  
		LEFT OUTER JOIN pBOLFactoryMachines PBFM ON T1.MachineId=PBFM.MachineId  
		LEFT OUTER JOIN pBOLMachines PBMC ON T1.MachineId=PBMC.MachineId	 	
		LEFT OUTER JOIN pBOLFactories PBF ON PBFM.FactoryId= PBF.FactoryId	
		LEFT OUTER JOIN uTradePartnerVendor UTV ON 	PBFM.TradePartnerVendorID= UTV.TradePartnerVendorID   
	WHERE     
		T1.IsLinked = 0 
		AND T1.MacroParentId IS NOT NULL 
		
	UNION  
	/* SELECT Unlinked Operations or Unlinked Macro*/ 
	SELECT 			
		T4.PageOperationId, 
		T4.Code AS Code,
		PBMC.MachineCode,  
		T4.Name AS Name, 
		CASE WHEN UTV.VendorCode+' ('+UTV.VendorName+')' IS NULL  THEN 'NA' ELSE UTV.VendorCode+' ('+UTV.VendorName+')' END AS VendorCode,
		T4.StyleID,
		T4.StyleSet,
		'N' AS IsDutiable,
		T4.Comments,	
		dbo.fnx_GetStreamingImageBOLImagePath('BOLS','50',CAST(ISNULL(T4.ImageID, '00000000-0000-0000-0000-000000000000') AS NVARCHAR(50))) AS Imagefilepath, 
		T4.Sort,
		T4.MacroId,
		T4.MacroParentId
	FROM         
		pStyleBOLPageOperations AS T4  
		LEFT OUTER JOIN pBOLOperations PBO ON T4.OperationId = PBO.OperationId  
		LEFT OUTER JOIN pBOLFactoryMachines PBFM ON T4.MachineId=PBFM.MachineId  
		LEFT OUTER JOIN pBOLMachines PBMC ON T4.MachineId=PBMC.MachineId	  	
		LEFT OUTER JOIN pBOLFactories PBF ON PBFM.FactoryId= PBF.FactoryId	
		LEFT OUTER JOIN uTradePartnerVendor UTV ON 	PBFM.TradePartnerVendorID= UTV.TradePartnerVendorID   
	WHERE 
		T4.IsLinked = 0 
		AND T4.MacroParentId IS NULL 

GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='02302'))
	BEGIN
		INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
		VALUES ('DB_Version', '4.1.0000', '02302', GetDate())
	END
GO	

