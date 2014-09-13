IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_SampleView_MaterialRequestDataTable_PIVOT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_SampleView_MaterialRequestDataTable_PIVOT]
GO

CREATE PROCEDURE [dbo].[spx_SampleView_MaterialRequestDataTable_PIVOT]        
(
@TradepartnerID UNIQUEIDENTIFIER = NULL,   
@TeamID UNIQUEIDENTIFIER, 
@Filter NVARCHAR (4000), 
@SampleStatus NVARCHAR (50), 
@NoOfSubmits NVARCHAR (10), 
@PrefLanguage NVARCHAR (50), 
@UserID INT,
@AssignedTo NVARCHAR (200),
@SeasonYear NVARCHAR (MAX),
@Agent NVARCHAR (MAX),
@Vendor NVARCHAR (MAX),
@Factory NVARCHAR (MAX) 
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
	
	DECLARE @SQL NVARCHAR(MAX)   
	
	--***  
	--** PIVOT  
	--***  
  
	CREATE TABLE #tmpSample
	(  
		MaterialTradePartnerId UNIQUEIDENTIFIER,  
		MaterialTradePartnerColorID UNIQUEIDENTIFIER,
		MaterialRequestWorkflow NVARCHAR(200),  
		MaterialID UNIQUEIDENTIFIER,  
		MaterialRequestSubmitWorkflowID UNIQUEIDENTIFIER,   
		TradePartnerID UNIQUEIDENTIFIER,   
		TradePartnerName NVARCHAR(400),
		AgentID UNIQUEIDENTIFIER,
		AgentName NVARCHAR(200),
		AgentCode NVARCHAR(200),
		VendorID UNIQUEIDENTIFIER,
		VendorName NVARCHAR(200),
		VendorCode NVARCHAR(200),
		FactoryID UNIQUEIDENTIFIER,
		FactoryName NVARCHAR(200),
		FactoryCode NVARCHAR(200),
		AssignedTo INT,   		
		ColorCode nVARCHAR(100),
		ColorName nVARCHAR(300),  				
		MaterialType NVARCHAR(100),
		MaterialNo NVARCHAR(100),
		MaterialName NVARCHAR(400),
		MaterialTypeID INT,
		Link  NVARCHAR(4000),
		MaterialImageID UNIQUEIDENTIFIER,
		MaterialImageVersion INT,
		SeasonYearID UNIQUEIDENTIFIER,
		MaterialStatus NVARCHAR(100),
		Submit INT,
		SubmitStatus INT
	)  	  
  

	INSERT INTO #tmpSample 
	SELECT
		mrs.MaterialTradePartnerId,
		mtpc.MaterialTradePartnerColorID, 	
		mrw.MaterialRequestWorkflow,	
		m.MaterialID, 
		mrsw.MaterialRequestSubmitWorkflowID,
		mtp.TradePartnerID,
		tp.TradePartnerName,
		tprl.AgentID, tprl.AgentName, tprl.AgentCode,
		tprl.VendorID, tprl.VendorName, tprl.VendorCode,
		tprl.FactoryID, tprl.FactoryName, tprl.FactoryCode,
		mrs.AssignedTo,			
		cp.ColorCode,
		cp.ColorName, 
		ct.ComponentDescription As MaterialType,
		m.MaterialNo,
		m.MaterialName, 
		ct.ComponentTypeID,			 
		'<TABLE cellSpacing=''0'' cellPadding=''0'' width=''100%'' border=''0''><TR><TD width=''18''> 
		<IMG src=''' + 
		CASE 
		WHEN mrss.ApprovedType = 1  THEN '../System/Icons/icon_ball_green.gif'
		WHEN mrs.Status = 4  THEN '../System/Icons/icon_ball_red.gif'
		WHEN mrs.Submit = 1 THEN '../System/Icons/icon_ball_blue.gif'
		ELSE '../System/Icons/icon_ball_yellow.gif'
		END
		+ '''  border=0 ALT=''Open''><TD class=''font'' align=center valign=center nowrap>&nbsp; 
		<a href=''#'' onclick="javascript:window.open(''../Material/Material_RequestSubmitRedirect.aspx?MTPID=' + 
		CAST (mtp.MaterialTradePartnerId AS nVARCHAR(40)) + '&MRSWID=' + CAST(mrsw.MaterialRequestSubmitWorkflowID AS nVARCHAR(40)) + 
		'&MTPCID=' + CAST(mtpc.MaterialTradePartnerColorID AS nVARCHAR(40)) + '&MRWID=' + CAST(mrsw.MaterialRequestWorkflowID AS nVARCHAR(40)) +
		''',''' +  
		Replace(CAST (mtpc.MaterialTradePartnerColorID AS nVARCHAR(40)) , '-', '') +
		''',''width=1024, height=700, location=yes, menubar=yes, status=yes, toolbar=yes, scrollbars=yes, resizable=yes'');">' 
		+
		CASE 
		WHEN mrss.ApprovedType = 1 Or mrs.Status = 4 THEN ISNULL(dbo.fnx_DatetimeToString(mrs.EndDate, @PrefLanguage),'NODATE')
		ELSE ISNULL(dbo.fnx_DatetimeToString(mrsw.DueDate, @PrefLanguage),'NODATE')
		END 
		+ '&nbsp;<b>(' 
		+  CAST(mrsw.Submit AS nVARCHAR(5)) + ')</b></a></TD></TR></TABLE>' AS Link,
		m.MaterialImageID, m.MaterialImageVersion, mtp.SeasonYearID, m.S AS MaterialStatus, mrs.Submit, mrs.Status
		FROM dbo.pMaterialRequestSubmit mrs  
		INNER JOIN pMaterialTradePartner mtp ON mrs.MaterialTradePartnerID = mtp.MaterialTradePartnerId	    	
		INNER JOIN pMaterialRequestSubmitStatus mrss ON mrs.Status = mrss.StatusID   
		INNER JOIN pMaterialRequestSubmitWorkflow mrsw ON mrs.MaterialRequestSubmitWorkflowID = mrsw.MaterialRequestSubmitWorkflowID
		AND  mrsw.Submit= mrs.Submit
		INNER JOIN pMaterialRequestWorkflow mrw ON mrsw.MaterialRequestWorkflowID = mrw.MaterialRequestWorkflowID     
		INNER JOIN pMaterial m ON mtp.MaterialID = m.MaterialID  
		INNER JOIN pComponentType ct ON ct.ComponentTypeID = m.MaterialType
		INNER JOIN pMaterialTradePartnerColor mtpc ON mtpc.MaterialTradePartnerColorID=mrs.MaterialTradePartnerColorID
		INNER JOIN uTradePartner tp ON mtp.TradepartnerId = tp.TradePartnerID 
		LEFT OUTER JOIN pMaterialColor mc ON mc.MaterialColorID = mtpc.MaterialColorID   
		LEFT OUTER JOIN pColorPalette cp ON cp.ColorPaletteID = mc.ColorPaletteID 
		LEFT OUTER JOIN vwx_TradePartnerRelationshipLevels_SEL tprl ON mtp.TradePartnerRelationshipLevelID = tprl.TradePartnerRelationshipLevelID
		WHERE (@TradePartnerId IS NULL OR @TradePartnerId IN (tprl.AgentID, tprl.VendorID, tprl.FactoryID, mtp.TradePartnerID))
		AND (mrs.Submit >= @NoOfSubmits OR @NoOfSubmits IS NULL OR @NoOfSubmits = '')
		AND (mrs.AssignedTo = @UserID OR @UserID IS NULL)
		AND (mrs.AssignedTo IN (SELECT value FROM dbo.fnx_Split(@AssignedTo, ',')) OR @AssignedTo IS NULL)
		AND (mtp.SeasonYearID IN (SELECT value FROM dbo.fnx_Split(@SeasonYear, ',')) OR @SeasonYear IS NULL)
		AND (tprl.AgentID IN (SELECT value FROM dbo.fnx_Split(@Agent, ',')) OR @Agent IS NULL)
		AND (tprl.VendorID IN (SELECT value FROM dbo.fnx_Split(@Vendor, ',')) OR @Vendor IS NULL)
		AND (tprl.FactoryID IN (SELECT value FROM dbo.fnx_Split(@Factory, ',')) OR @Factory IS NULL)


SET @SQL = 'SELECT REPLACE(MaterialRequestWorkflow, '' '', ''_'') AS MaterialRequestWorkflow,
            Link,
			MaterialTradePartnerId,
			MaterialTradePartnerColorId,
			MaterialID,
			TradePartnerID, TradePartnerName,
			AgentID, AgentName, AgentCode,
			VendorID, VendorName, VendorCode,
			FactoryID, FactoryName, FactoryCode,
			MaterialType,
			MaterialNo,
			MaterialName,
			ColorCode,
			ColorName,
			MaterialImageID, MaterialImageVersion, SeasonYearID, MaterialStatus
			FROM #tmpSample'
  
IF @Filter IS NOT NULL AND LEN(@Filter) > 0   
	SET @SQL = @SQL + ' WHERE ' + @Filter  	


IF @SampleStatus IS NOT NULL
BEGIN
	IF CHARINDEX('WHERE',@SQL) = 0
		SET @SQL = @SQL + ' WHERE (SubmitStatus IN (' + @SampleStatus + ')'
	ELSE
		SET @SQL = @SQL + ' AND (SubmitStatus IN (' + @SampleStatus + ')'
	
	-- check for Resibmit status		
	IF CHARINDEX('1,',@SampleStatus) > 0 OR RTRIM(LTRIM(@SampleStatus)) = '1'
		SET @SQL = @SQL + ' OR (Submit > 1 AND SubmitStatus = 0)'

	SET @SQL = @SQL + ')'
END

	
EXECUTE spx_Crosstab   
		@SQL,  
		NULL,  
		NULL,  
		'MaterialRequestWorkflow',  
		'Link',  
		'MAX'  
        
 END  
 
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07037', GetDate())
GO
