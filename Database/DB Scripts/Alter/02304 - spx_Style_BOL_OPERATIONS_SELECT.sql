/****** Object:  StoredProcedure [dbo].[spx_Style_BOL_OPERATIONS_SELECT]    Script Date: 12/06/2011 16:56:19 ******/

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Style_BOL_OPERATIONS_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_Style_BOL_OPERATIONS_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_Style_BOL_OPERATIONS_SELECT]
(
	@StyleId NVARCHAR(50),
	@StyleSet NVARCHAR(5)
)
AS  
BEGIN
	DECLARE @ColCount AS INT
	
	
	CREATE TABLE #tempStyleBOLOperations
	(		
		RowID				INT IDENTITY(0,1),
		PageOperationId		UNIQUEIDENTIFIER,
		Code				NVARCHAR(50),
		MachineCode			NVARCHAR(50),
		Name				NVARCHAR(200),
		VendorCode			NVARCHAR(50),
		StyleID				UNIQUEIDENTIFIER,
		StyleSet			INT,
		IsDutiable			VARCHAR(2),
		Comments			NVARCHAR(1000),
		Imagefilepath		NVARCHAR(200),
		Sort				NVARCHAR(5),
		IsLink				NVARCHAR(2)
	)
	
	/* SELECT Operations of Linked Macro*/ 		
	INSERT INTO #tempStyleBOLOperations(PageOperationId,Code,MachineCode,Name,VendorCode,StyleID,StyleSet,IsDutiable,Comments,Imagefilepath,Sort,IsLink)	
	SELECT						
		PSBPO.PageOperationId, 	
		PBM.MacroCode AS Code, 	
		PBMC.MachineCode, 
		PBM.MacroName AS Name,		  
		CASE WHEN '(' + UTV.VendorCode + ')' + UTV.VendorName IS NULL  THEN 'NA' ELSE '(' + UTV.VendorCode + ')' + UTV.VendorName END AS VendorCode,
		PSBPO.StyleID,
		PSBPO.StyleSet,	
		'N' AS IsDutiable,
		PSBPO.Comments,	 
		dbo.fnx_GetStreamingImageBOLImagePath('BOLMOP','50',CAST(ISNULL(PBM.Image, '00000000-0000-0000-0000-000000000000') AS NVARCHAR(50))) AS Imagefilepath,
		PSBPO.Sort,
		1
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
		AND PSBPO.StyleID=@StyleId
		AND PSBPO.StyleSet=@StyleSet  		
	
	/* SELECT Operations of Linked Macro*/ 
	INSERT INTO #tempStyleBOLOperations(PageOperationId,Code,MachineCode,Name,VendorCode,StyleID,StyleSet,IsDutiable,Comments,Imagefilepath,Sort,IsLink)	
	SELECT 			
		PSBPO.PageOperationId, 
		PBO.OperationCode AS Code,
		PBMC.MachineCode, 	
		PBO.OperationName AS Name,		  
		CASE WHEN '(' + UTV.VendorCode + ')' + UTV.VendorName IS NULL  THEN 'NA' ELSE '(' + UTV.VendorCode + ')' + UTV.VendorName END AS VendorCode,
		PSBPO.StyleID,
		PSBPO.StyleSet,
		CASE WHEN PBO.Fixed=1 THEN 'D' ELSE 'N' END AS IsDutiable,
		PSBPO.Comments, 	
		dbo.fnx_GetStreamingImageBOLImagePath('BOLOP','50',CAST(ISNULL(PBO.Image, '00000000-0000-0000-0000-000000000000') AS NVARCHAR(50))) AS Imagefilepath, 
		psbpo.Sort,
		1
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
		AND PSBPO.StyleID=@StyleId
		AND PSBPO.StyleSet=@StyleSet  
		
	--UNION  
	/* SELECT Linked Operations*/ 
	INSERT INTO #tempStyleBOLOperations(PageOperationId,Code,MachineCode,Name,VendorCode,StyleID,StyleSet,IsDutiable,Comments,Imagefilepath,Sort,IsLink)	
	SELECT	
		PSBPO.PageOperationId, 
		PBO.OperationCode AS Code,	
		PBMC.MachineCode,
		PBO.OperationName AS Name,		  
		CASE WHEN '(' + UTV.VendorCode + ')' + UTV.VendorName IS NULL  THEN 'NA' ELSE '(' + UTV.VendorCode + ')' + UTV.VendorName END AS VendorCode,
		PSBPO.StyleID,
		PSBPO.StyleSet,
		CASE WHEN PBO.Fixed=1 THEN 'D' ELSE 'N' END AS IsDutiable,
		PSBPO.Comments,		 
		dbo.fnx_GetStreamingImageBOLImagePath('BOLOP','50',CAST(ISNULL(PBO.Image, '00000000-0000-0000-0000-000000000000') AS NVARCHAR(50))) AS Imagefilepath,
		PSBPO.Sort,
		0   
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
		AND PSBPO.StyleID=@StyleId
		AND PSBPO.StyleSet=@StyleSet  				
	
	/* SELECT Operations of Unlinked Macro*/ 
	INSERT INTO #tempStyleBOLOperations(PageOperationId,Code,MachineCode,Name,VendorCode,StyleID,StyleSet,IsDutiable,Comments,Imagefilepath,Sort,IsLink)	
	SELECT 		
		T1.PageOperationId, 
		T1.Code AS Code,
		PBMC.MachineCode, 
		T1.Name AS Name,	
		CASE WHEN '(' + UTV.VendorCode + ')' + UTV.VendorName IS NULL  THEN 'NA' ELSE '(' + UTV.VendorCode + ')' + UTV.VendorName END AS VendorCode,
		T1.StyleID,
		T1.StyleSet,
		'N' AS IsDutiable,
		T1.Comments,		
		dbo.fnx_GetStreamingImageBOLImagePath('BOLOP','50',CAST(ISNULL(T1.ImageID, '00000000-0000-0000-0000-000000000000') AS NVARCHAR(50))) AS Imagefilepath,
		T1.Sort,
		0 
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
		AND T1.StyleID=@StyleId
		AND T1.StyleSet=@StyleSet  		

	/* SELECT Unlinked Operations or Unlinked Macro*/ 
	INSERT INTO #tempStyleBOLOperations(PageOperationId,Code,MachineCode,Name,VendorCode,StyleID,StyleSet,IsDutiable,Comments,Imagefilepath,Sort,IsLink)	
	SELECT 			
		T4.PageOperationId, 
		T4.Code AS Code,
		PBMC.MachineCode,  
		T4.Name AS Name, 
		CASE WHEN '(' + UTV.VendorCode + ')' + UTV.VendorName IS NULL  THEN 'NA' ELSE '(' + UTV.VendorCode + ')' + UTV.VendorName END AS VendorCode,
		T4.StyleID,
		T4.StyleSet,
		'N' AS IsDutiable,
		T4.Comments,	
		dbo.fnx_GetStreamingImageBOLImagePath('BOLS','50',CAST(ISNULL(T4.ImageID, '00000000-0000-0000-0000-000000000000') AS NVARCHAR(50))) AS Imagefilepath, 
		T4.Sort,
		0
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
		AND T4.StyleID=@StyleId
		AND T4.StyleSet=@StyleSet  		
		
/* Final Select Query*/
	
	SELECT 		
		(RowID/4) AS RowNumber,	
		(RowID%4) ColNumber,	
		PageOperationId,	
		Code,	
		MachineCode,		
		Name,	
		VendorCode,	
		StyleID,		
		StyleSet,		
		IsDutiable,		
		Comments,			
		Imagefilepath,
		Sort,
		IsLink			
	FROM 	
		#tempStyleBOLOperations		
	ORDER BY 	
		RowNumber,ColNumber
		
	DROP TABLE #tempStyleBOLOperations	
	
END		

GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='02304'))
	BEGIN
		INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
		VALUES ('DB_Version', '4.1.0000', '02304', GetDate())
	END
GO	

