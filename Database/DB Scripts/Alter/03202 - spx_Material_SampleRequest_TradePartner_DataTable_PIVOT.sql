-- ******************************************************************************************** */
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Alter Script                                                                               */
-- * Database:                                                                                  */
-- * 7 March 2012                                                                           */
-- *                                                                                            */
-- * Copyright (c) 2002-2012 Gerber Technology, Inc.  All rights reserved.                      */
-- * This information is confidential and proprietary.  You may not disseminate it              */
-- * to any other party without the express written consent of Gerber Technology, Inc.          */
-- *                                                                                            */
-- ******************************************************************************************** */
-- ******************************************************************************************** */
-- COMMENTS
--
--
--

/****** Object:  StoredProcedure [dbo].[spx_Material_SampleRequest_TradePartner_DataTable_PIVOT]    Script Date: 03/07/2012 20:48:16 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Material_SampleRequest_TradePartner_DataTable_PIVOT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_Material_SampleRequest_TradePartner_DataTable_PIVOT]
GO

/****** Object:  StoredProcedure [dbo].[spx_Material_SampleRequest_TradePartner_DataTable_PIVOT]    Script Date: 03/07/2012 20:48:16 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spx_Material_SampleRequest_TradePartner_DataTable_PIVOT]        
(
@TradepartnerID UNIQUEIDENTIFIER = NULL,         
@TeamID UNIQUEIDENTIFIER=NULL,         
@Filter NVARCHAR (4000)=NULL         
)     
AS            
BEGIN        
--***        
--** PIVOT        
--***      

	SELECT  REPLACE(MaterialRequestWorkflow, ' ', '_') AS MaterialRequestWorkflow,
            MaterialRequestWorkflowSort
	FROM pMaterialRequestWorkflow WITH(NOLOCK)
	WHERE 
	(
		MaterialRequestWorkflowID 
		IN 
		(
			SELECT SampleWorkflowId FROM  pMaterialSampleWorkflowViewSubmit WITH (NOLOCK) WHERE TeamId = @TeamId 
		)
	) 
	AND Active = 1
	ORDER BY MaterialRequestWorkflowSort
	
	DECLARE @SQL NVARCHAR(4000)   
	
	--***  
	--** PIVOT  
	--***  
  
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
		Link  NVARCHAR(4000)  
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
		Link  NVARCHAR(4000)  
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
			Link	  
		
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
			'<TABLE cellSpacing=''0'' cellPadding=''0'' width=''100%'' border=''0''><TR><TD width=''18''> 
			<IMG src=''' + 
			CASE 
			WHEN d.ApprovedType = 1  THEN '../System/Icons/icon_ball_green.gif'
			WHEN a.Status = 4  THEN '../System/Icons/icon_ball_red.gif'
			WHEN a.Submit = 1 THEN '../System/Icons/icon_ball_blue.gif'
			ELSE '../System/Icons/icon_ball_yellow.gif'
			END
			+ '''  border=0 ALT=''Open''><TD class=''font'' align=center valign=center nowrap>&nbsp; 
			<a href=''#'' onclick="javascript:window.open(''../Material/Material_RequestSubmitRedirect.aspx?MTPID=' + 
			CAST (b.MaterialTradePartnerId AS VARCHAR(40)) + '&MRSWID=' + CAST(e.MaterialRequestSubmitWorkflowID AS VARCHAR(40)) + 
			'&MTPCID=' + CAST(k.MaterialTradePartnerColorID AS VARCHAR(40)) + '&MRWID=' + CAST(e.MaterialRequestWorkflowID AS VARCHAR(40)) +
			''',''' +  
			Replace(CAST (k.MaterialTradePartnerColorID AS VARCHAR(40)) , '-', '') +
			''',''width=1024, height=700, location=yes, menubar=yes, status=yes, toolbar=yes, scrollbars=yes, resizable=yes'');">' 
			+
			CASE 
			WHEN d.ApprovedType = 1 Or a.Status = 4 THEN ISNULL(CONVERT(VARCHAR(12), a.EndDate , 107),'NODATE')
			ELSE ISNULL(CONVERT(VARCHAR(12), e.DueDate , 107),'NODATE') --CONVERT(VARCHAR(20), pMaterialRequestSubmitWorkflow.DueDate , 101)
			END 
			+ '&nbsp;<b>(' 
			+  CAST(e.Submit AS VARCHAR(5)) + ')</b></a></TD></TR></TABLE>' AS Link					
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
			--INNER JOIN pmaterialSampleWorkflowViewAgent r ON l.TradePartnerID=r.TradePartnerId 
			INNER JOIN uTradePartnerVendor m ON b.TradepartnerVendorId = m.TradePartnerVendorID				
			LEFT OUTER JOIN pMaterialColor p ON p.MaterialColorID = k.MaterialColorID   
			LEFT OUTER JOIN pColorPalette q ON p.ColorPaletteID =q.ColorPaletteID 
			LEFT OUTER JOIN pMaterialSeasonYear h ON b.SeasonYearID=h.SeasonYearID   
			--LEFT OUTER JOIN pStyleSeasonYear h ON b.SeasonYearID=h.SeasonYearID 
			LEFT OUTER JOIN pSeasonYear i ON h.SeasonYearID=i.SeasonYearID  
			--INNER JOIN pMaterialSampleWorkflowViewSubmit s ON f.MaterialRequestWorkflowID=s.SampleWorkflowId	
			WHERE b.TradepartnerId=@TradepartnerID --AND l.Active=1 AND m.Active=1								
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
			Link	  
		
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
			'<TABLE cellSpacing=''0'' cellPadding=''0'' width=''100%'' border=''0''><TR><TD width=''18''> 
			<IMG src=''' + 
			CASE 
			WHEN d.ApprovedType = 1  THEN '../System/Icons/icon_ball_green.gif'
			WHEN a.Status = 4  THEN '../System/Icons/icon_ball_red.gif'
			WHEN a.Submit = 1 THEN '../System/Icons/icon_ball_blue.gif'
			ELSE '../System/Icons/icon_ball_yellow.gif'
			END
			+ '''  border=0 ALT=''Open''><TD class=''font'' align=center valign=center nowrap>&nbsp; 
			<a href=''#'' onclick="javascript:window.open(''../Material/Material_RequestSubmitRedirect.aspx?MTPID=' + 
			CAST (b.MaterialTradePartnerId AS VARCHAR(40)) + '&MRSWID=' + CAST(e.MaterialRequestSubmitWorkflowID AS VARCHAR(40)) + 
			'&MTPCID=' + CAST(k.MaterialTradePartnerColorID AS VARCHAR(40)) + '&MRWID=' + CAST(e.MaterialRequestWorkflowID AS VARCHAR(40)) +
			''',''' +  
			Replace(CAST (k.MaterialTradePartnerColorID AS VARCHAR(40)) , '-', '') +
			''',''width=1024, height=700, location=yes, menubar=yes, status=yes, toolbar=yes, scrollbars=yes, resizable=yes'');">' 
			+
			CASE 
			WHEN d.ApprovedType = 1 Or a.Status = 4 THEN ISNULL(CONVERT(VARCHAR(12), a.EndDate , 107),'NODATE')
			ELSE ISNULL(CONVERT(VARCHAR(12), e.DueDate , 107),'NODATE') --CONVERT(VARCHAR(20), pMaterialRequestSubmitWorkflow.DueDate , 101)
			END 
			+ '&nbsp;<b>(' 
			+  CAST(e.Submit AS VARCHAR(5)) + ')</b></a></TD></TR></TABLE>' AS Link					
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
			--INNER JOIN pmaterialSampleWorkflowViewAgent r ON l.TradePartnerID=r.TradePartnerId 
			INNER JOIN uTradePartnerVendor m ON b.TradepartnerVendorId = m.TradePartnerVendorID				
			LEFT OUTER JOIN pMaterialColor p ON p.MaterialColorID = k.MaterialColorID   
			LEFT OUTER JOIN pColorPalette q ON p.ColorPaletteID =q.ColorPaletteID 
			LEFT OUTER JOIN pMaterialSeasonYear h ON b.SeasonYearID=h.SeasonYearID   
			LEFT OUTER JOIN pSeasonYear i ON h.SeasonYearID=i.SeasonYearID  
			--INNER JOIN pMaterialSampleWorkflowViewSubmit s ON f.MaterialRequestWorkflowID=s.SampleWorkflowId	
			--WHERE l.Active=1 AND m.Active=1  
	END  
  
  
	DECLARE @SQL_01 NVARCHAR(4000)   
	
	IF @Filter IS NOT NULL AND LEN(@Filter) > 0   
			SET @SQL_01 = 'INSERT INTO #tmpSample2 SELECT * FROM #tmpSample1 WHERE ' + @Filter  
			 
	ELSE   
			SET @SQL_01 = 'INSERT INTO #tmpSample2 SELECT * FROM #tmpSample1 '  

	  
	EXEC (@SQL_01) 
	
  	EXECUTE spx_Crosstab   
			'SELECT REPLACE(MaterialRequestWorkflow, '' '', ''_'') AS MaterialRequestWorkflow,
            Link,
			MaterialTradePartnerId,
			MaterialTradePartnerColorId,
			MaterialID,TradePartnerID,
			TradePartnerVendorID,
			TradePartnerName,
			VendorName,
			MaterialType,
			MaterialNo,
			MaterialName,
			ColorCode,
			ColorName,
			Season,
			Year 
			FROM #tmpSample2',  
			NULL,  
			NULL,  
			'MaterialRequestWorkflow',  
			'Link',  
			'MAX'  
        
 END  
 

GO


IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='03202'))
BEGIN

	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '5.0.0000', '03202', GetDate())

END

GO