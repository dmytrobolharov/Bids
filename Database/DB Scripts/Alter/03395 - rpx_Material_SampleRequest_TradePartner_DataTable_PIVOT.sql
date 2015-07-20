/****** Object:  StoredProcedure [dbo].[rpx_Material_SampleRequest_TradePartner_DataTable_PIVOT]    Script Date: 04/27/2012 12:04:19 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[rpx_Material_SampleRequest_TradePartner_DataTable_PIVOT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[rpx_Material_SampleRequest_TradePartner_DataTable_PIVOT]

GO

/****** Object:  StoredProcedure [dbo].[rpx_Material_SampleRequest_TradePartner_DataTable_PIVOT]    Script Date: 06/9/2011 19:14:04 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[rpx_Material_SampleRequest_TradePartner_DataTable_PIVOT]        
(
	@TradepartnerID NVARCHAR(50) = NULL,
	@TeamID NVARCHAR(50),
	@Filter NVARCHAR (4000)=NULL         
)     
AS            
BEGIN
	IF  @TradePartnerID IS NULL OR @TradePartnerID=''
	BEGIN
		SET @TradePartnerID =NULL
	END
	
	DECLARE @SQL NVARCHAR(4000)
	
	CREATE TABLE #tmpSample1 
	(  
		MaterialTradePartnerId UNIQUEIDENTIFIER,  
		MaterialTradePartnerColorID UNIQUEIDENTIFIER,
		MaterialRequestWorkflow NVARCHAR(200),  
		MaterialID UNIQUEIDENTIFIER,  
		MaterialRequestSubmitWorkflowID UNIQUEIDENTIFIER,   
		TradePartnerID UNIQUEIDENTIFIER,   
		TradePartnerVendorID UNIQUEIDENTIFIER,		
		AssignedTo INT,   		
		ColorCode VARCHAR(100),
		ColorName VARCHAR(300),  				
		MaterialType NVARCHAR(100),
		MaterialNo NVARCHAR(100),
		MaterialName NVARCHAR(400),
		MaterialTypeID INT,
		TradePartnerName NVARCHAR(400),
		VendorName NVARCHAR(400),
		Season NVARCHAR(200),  
		Year NVARCHAR(200), 
		Link  NVARCHAR(4000),
		alertColor	NVARCHAR(50),
		MaterialRequestWorkflowID NVARCHAR(10),
		SubmitComment VARCHAR(8000)
	)  	  
	
	CREATE TABLE #tmpSample2 
	(  
		MaterialTradePartnerId UNIQUEIDENTIFIER,
		MaterialTradePartnerColorID UNIQUEIDENTIFIER,  
		MaterialRequestWorkflow NVARCHAR(200),  
		MaterialID UNIQUEIDENTIFIER,  
		MaterialRequestSubmitWorkflowID UNIQUEIDENTIFIER,   
		TradePartnerID UNIQUEIDENTIFIER,   
		TradePartnerVendorID UNIQUEIDENTIFIER,		
		AssignedTo INT,   		
		ColorCode VARCHAR(100), 
		ColorName VARCHAR(300),  					
		MaterialType NVARCHAR(100),
		MaterialNo NVARCHAR(100),
		MaterialName NVARCHAR(400),
		MaterialTypeID INT,
		TradePartnerName NVARCHAR(400),
		VendorName NVARCHAR(400),
		Season NVARCHAR(200),  
		Year NVARCHAR(200), 
		Link  NVARCHAR(4000),
		alertColor	NVARCHAR(50),
		MaterialRequestWorkflowID NVARCHAR(10),
		SubmitComment VARCHAR(8000) 
	)
	
	IF @TradepartnerID IS NOT NULL  
	BEGIN  
		INSERT INTO #tmpSample1 
		(
			MaterialTradePartnerId, 
			MaterialTradePartnerColorID, 
			MaterialRequestWorkflow,  
			MaterialID,  
			MaterialRequestSubmitWorkflowID,   
			TradePartnerID,   
			TradePartnerVendorID,		
			AssignedTo,   			
			ColorCode,
			ColorName,  			
			MaterialType,
			MaterialNo,
			MaterialName,
			MaterialTypeID,
			TradePartnerName,
			VendorName,
			Season,  
			Year, 
			Link,
			alertColor,
			MaterialRequestWorkflowID,
			SubmitComment
		)
		
		SELECT DISTINCT
			a.MaterialTradePartnerId,
			k.MaterialTradePartnerColorID, 	
			f.MaterialRequestWorkflow,	
			g.MaterialID, 
			e.MaterialRequestSubmitWorkflowID,
			b.TradePartnerID,
			m.TradePartnerVendorID,
			a.AssignedTo,			
			q.ColorCode,
			k.ColorName, 
			j.ComponentDescription As MaterialType,
			g.MaterialNo,
			g.MaterialName, 
			j.ComponentTypeID,			 
			l.TradePartnerName,
			m.VendorName,		
			i.Season,
			i.Year,			
			CASE   
			WHEN d.ApprovedType = 1  THEN 'Approved'  
			WHEN a.Status = 4  THEN 'Dropped'  
			WHEN a.Submit = 1 THEN 'Open'  
			ELSE 'Re-Submit'  
			END AS Link,
			CASE 
			WHEN d.ApprovedType = 1  THEN 'Green'
			WHEN a.Status = 4  THEN 'Red'
			WHEN a.Submit = 1 THEN 'Blue'
			ELSE 'Yellow'
			END  AS 'Alert Color',
			f.MaterialRequestWorkflowID,
			CONVERT(VARCHAR(8000),a.SubmitComment)
			FROM dbo.pMaterialRequestSubmit a  
			INNER JOIN pMaterialTradePartner b ON a.MaterialTradePartnerID = b.MaterialTradePartnerId	    	
			INNER JOIN pMaterialRequestSubmitStatus d ON a.Status   = d.StatusID   
			INNER JOIN pMaterialRequestSubmitWorkflow e ON a.MaterialRequestSubmitWorkflowID =e.MaterialRequestSubmitWorkflowID
			AND  e.Submit= a.Submit
			INNER JOIN pMaterialRequestWorkflow f ON e.MaterialRequestWorkflowID = f.MaterialRequestWorkflowID     
			INNER JOIN pMaterial g ON b.MaterialID =g.MaterialID  
			INNER JOIN pComponentType j ON j.ComponentTypeID=g.MaterialType
			INNER JOIN pMaterialTradePartnerColor k ON k.MaterialTradePartnerColorID=a.MaterialTradePartnerColorID
			INNER JOIN uTradePartner l ON b.TradepartnerId = l.TradePartnerID 
			INNER JOIN uTradePartnerVendor m ON b.TradepartnerVendorId = m.TradePartnerVendorID				
			LEFT OUTER JOIN pMaterialColor p ON p.MaterialColorID = k.MaterialColorID   
			LEFT OUTER JOIN pColorPalette q ON p.ColorPaletteID =q.ColorPaletteID 
			LEFT OUTER JOIN pMaterialSeasonYear h ON b.SeasonYearID=h.SeasonYearID   
			LEFT OUTER JOIN pSeasonYear i ON h.SeasonYearID=i.SeasonYearID  
			WHERE b.TradepartnerId=@TradepartnerID
			AND
			(
			F.MaterialRequestWorkflowID 
			IN 
				(
					SELECT SampleWorkflowId FROM  pMaterialSampleWorkflowViewSubmit 
					WITH (NOLOCK) WHERE TeamId = @TeamId 
				)
			) 							
	END  
	ELSE   
	BEGIN  
		INSERT INTO #tmpSample1 
		(
			MaterialTradePartnerId,
			MaterialTradePartnerColorID,  
			MaterialRequestWorkflow,  
			MaterialID,  
			MaterialRequestSubmitWorkflowID,   
			TradePartnerID,   
			TradePartnerVendorID,		
			AssignedTo,   			
			ColorCode,
			ColorName,  					
			MaterialType,
			MaterialNo,
			MaterialName,
			MaterialTypeID,
			TradePartnerName,
			VendorName,
			Season,  
			Year, 
			Link,
			alertColor,
			MaterialRequestWorkflowID,
			SubmitComment
		)  
		SELECT DISTINCT
			a.MaterialTradePartnerId,
			k.MaterialTradePartnerColorID,	
			f.MaterialRequestWorkflow,	
			g.MaterialID, 
			e.MaterialRequestSubmitWorkflowID,
			b.TradePartnerID,
			m.TradePartnerVendorID,
			a.AssignedTo,			
			q.ColorCode,
			k.ColorName,
			j.ComponentDescription As MaterialType,
			g.MaterialNo,
			g.MaterialName, 
			j.ComponentTypeID,			 
			l.TradePartnerName,
			m.VendorName,		
			i.Season,
			i.Year,
			CASE   
			WHEN d.ApprovedType = 1  THEN 'Approved'  
			WHEN a.Status = 4  THEN 'Dropped'  
			WHEN a.Submit = 1 THEN 'Open'  
			ELSE 'Re-Submit'  
			END AS Link,
			CASE 
			WHEN d.ApprovedType = 1  THEN 'Green'
			WHEN a.Status = 4  THEN 'Red'
			WHEN a.Submit = 1 THEN 'Blue'
			ELSE 'Yellow'
			END  AS 'Alert Color',
			f.MaterialRequestWorkflowID,
			CONVERT(VARCHAR(8000),a.SubmitComment)
			FROM dbo.pMaterialRequestSubmit a  
			INNER JOIN pMaterialTradePartner b ON a.MaterialTradePartnerID = b.MaterialTradePartnerId	    	
			INNER JOIN pMaterialRequestSubmitStatus d ON a.Status   = d.StatusID   
			INNER JOIN pMaterialRequestSubmitWorkflow e ON a.MaterialRequestSubmitWorkflowID =e.MaterialRequestSubmitWorkflowID
			AND  e.Submit= a.Submit
			INNER JOIN pMaterialRequestWorkflow f ON e.MaterialRequestWorkflowID = f.MaterialRequestWorkflowID     
			INNER JOIN pMaterial g ON b.MaterialID =g.MaterialID  
			INNER JOIN pComponentType j ON j.ComponentTypeID=g.MaterialType
			INNER JOIN pMaterialTradePartnerColor k ON k.MaterialTradePartnerColorID=a.MaterialTradePartnerColorID
			INNER JOIN uTradePartner l ON b.TradepartnerId = l.TradePartnerID 
			INNER JOIN uTradePartnerVendor m ON b.TradepartnerVendorId = m.TradePartnerVendorID				
			LEFT OUTER JOIN pMaterialColor p ON p.MaterialColorID = k.MaterialColorID   
			LEFT OUTER JOIN pColorPalette q ON p.ColorPaletteID =q.ColorPaletteID 
			LEFT OUTER JOIN pMaterialSeasonYear h ON b.SeasonYearID=h.SeasonYearID   
			LEFT OUTER JOIN pSeasonYear i ON h.SeasonYearID=i.SeasonYearID  
			WHERE 
			(
			F.MaterialRequestWorkflowID 
			IN 
				(
					SELECT SampleWorkflowId FROM  pMaterialSampleWorkflowViewSubmit 
					WITH (NOLOCK) WHERE TeamId = @TeamId 
				)
			)  
	END  
  
  
	DECLARE @SQL_01 NVARCHAR(4000)   
	
	IF @Filter IS NOT NULL AND LEN(@Filter) > 0   
			SET @SQL_01 = 'INSERT INTO #tmpSample2 SELECT * FROM #tmpSample1 WHERE ' + @Filter  
			 
	ELSE   
			SET @SQL_01 = 'INSERT INTO #tmpSample2 SELECT * FROM #tmpSample1 '  

	  
	EXEC (@SQL_01) 
	
	SELECT * FROM #tmpSample2  WHERE 
	(
		(CAST(TradePartnerID  AS NVARCHAR(50)) = @TradePartnerID)
		OR  
		(@TradePartnerID IS NULL)  
	)	
	DROP TABLE #tmpSample1  
	DROP TABLE #tmpSample2
 END
 
GO


	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '5.0.0000', '03395', GetDate())
GO