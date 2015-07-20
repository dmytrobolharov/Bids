/****** Object:  StoredProcedure [dbo].[spx_MaterialRequestSubmitWorkflowColor_DELETE]    Script Date: 08/22/2014 16:51:30 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_MaterialRequestSubmitWorkflowColor_DELETE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_MaterialRequestSubmitWorkflowColor_DELETE]
GO

/****** Object:  StoredProcedure [dbo].[spx_MaterialRequestSubmitWorkflowColor_DELETE]    Script Date: 08/22/2014 16:51:30 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


  
  
CREATE PROCEDURE [dbo].[spx_MaterialRequestSubmitWorkflowColor_DELETE](  
 @MaterialTradePartnerColorID UNIQUEIDENTIFIER   
)  
AS  
BEGIN
  
	DECLARE @MaterialTradePartnerID UNIQUEIDENTIFIER  
	   
	SELECT @MaterialTradePartnerID = MaterialTradePartnerID   
	FROM dbo.pMaterialTradePartnerColor WITH(NOLOCK)  
	WHERE MaterialTradePartnerColorID = @MaterialTradePartnerColorID  
	  
	  
	IF EXISTS (SELECT * FROM dbo.pMaterialTradePartnerColor  
	WHERE MaterialTradePartnerID = @MaterialTradePartnerID  
	AND MaterialTradePartnerColorID <> @MaterialTradePartnerColorID  
	)   
	BEGIN   
	 --** more than 1 color in the material request   
	  
	 CREATE TABLE #AllColorWorkflow(  
	  RowID INT IDENTITY(1,1),  
	  MaterialRequestWorkflowID NVARCHAR (5),  
	  Submit INT  
	 )  
	  
	 --** Get "All Colors" workflows   
	 INSERT INTO  #AllColorWorkflow ( MaterialRequestWorkflowID )  
	 SELECT a.MaterialRequestWorkflowID  
	 FROM dbo.pMaterialRequestSubmitWorkflow a WITH(NOLOCK)  
	  INNER JOIN dbo.pMaterialRequestWorkflow b WITH(NOLOCK) ON a.MaterialRequestWorkflowID = b.MaterialRequestWorkflowID  
	 WHERE a.MaterialTradePartnerColorID = @MaterialTradePartnerColorID  
	  AND MaterialRequestWorkflowColor = 1   
	  
	  
	  
	 DECLARE   
	  @MaterialRequestWorkflowID NVARCHAR(5),  
	  @ROWID INT,  
	  @TOTAL INT,  
	  @Submit INT   
	    
	 SET @ROWID = 1   
	 SELECT  @TOTAL = COUNT(*) FROM #AllColorWorkflow  
	  
	  
	  
	  
	  
	 WHILE @ROWID <= @TOTAL   
	 BEGIN   
	  
	  SELECT @MaterialRequestWorkflowID = MaterialRequestWorkflowID   
	  FROM #AllColorWorkflow WHERE RowID  = @ROWID  
	    
	    
	  IF EXISTS (SELECT *   
	   FROM dbo.pMaterialRequestSubmit a  
		INNER JOIN pMaterialRequestSubmitWorkflow b ON a.MaterialRequestSubmitWorkflowID = b.MaterialRequestSubmitWorkflowID  
	   WHERE b.MaterialRequestWorkflowID = @MaterialRequestWorkflowID  
		AND a.MaterialTradePartnerColorID =  @MaterialTradePartnerColorID )   
	  BEGIN   
	    
	     
	   DECLARE   
		@NewColorGroupID UNIQUEIDENTIFIER,  
		@CurrentColorGroupID UNIQUEIDENTIFIER,  
		@Qty INT,  
		@NewMaterialRequestSubmitWorkflowID UNIQUEIDENTIFIER,  
		@NewMaterialTradeParnterColorGroupID UNIQUEIDENTIFIER  
	  
	  
	   --** check in group table the current ID   
	   SELECT @CurrentColorGroupID = a.MaterialTradePartnerColorID  
	   FROM dbo.pMaterialRequestSubmitGroup a  
		INNER JOIN dbo.pMaterialRequestSubmitWorkflow c ON a.MaterialTradePartnerID  = c.MaterialTradePartnerID  
		 AND a.MaterialRequestWorkflowID = c.MaterialRequestWorkflowID  
		INNER JOIN dbo.pMaterialRequestSubmit b ON b.MaterialRequestSubmitWorkflowID = c.MaterialRequestSubmitWorkflowID  
	   WHERE a.MaterialTradePartnerID = @MaterialTradePartnerID  
		AND a.MaterialRequestWorkflowID = @MaterialRequestWorkflowID  
	     
	   --** Get current submit   
	   SELECT TOP 1 @Submit = Submit  
	   FROM pMaterialRequestSubmitWorkflow WITH(NOLOCK)  
	   WHERE MaterialRequestWorkflowID = @MaterialRequestWorkflowID  
		AND MaterialTradePartnerID = @MaterialTradePartnerID  
	   ORDER BY Submit DESC   
	     
	     
	     
	   --** define new MaterialTradePartnerColorID to be the GroupID   
	     
	   SELECT TOP 1 @NewMaterialTradeParnterColorGroupID = a.MaterialTradePartnerColorID, @qty = COUNT(*)   
	   FROM pMaterialRequestSubmit a  
		INNER JOIN dbo.pMaterialRequestSubmitWorkflow  b ON a.MaterialRequestSubmitWorkflowID = b.MaterialRequestSubmitWorkflowID  
	   WHERE a.MaterialTradePartnerID = @MaterialTradePartnerID  
		AND b.MaterialRequestWorkflowID = @MaterialRequestWorkflowID  
		AND a.MaterialTradePartnerColorID <> @MaterialTradePartnerColorID  
	   GROUP BY a.MaterialTradePartnerColorID  
	   ORDER BY COUNT(*) DESC   
	     
	   IF @NewMaterialTradeParnterColorGroupID IS NULL  
	   BEGIN   
		SELECT TOP 1 @NewMaterialTradeParnterColorGroupID = a.MaterialTradePartnerColorID, @qty = Submit  
		FROM dbo.pMaterialRequestSubmitWorkflow  a   
		WHERE a.MaterialTradePartnerID = @MaterialTradePartnerID  
		 AND a.MaterialRequestWorkflowID = @MaterialRequestWorkflowID  
		 AND a.MaterialTradePartnerColorID <> @MaterialTradePartnerColorID  
		ORDER BY CDate  
	   END   
	  
	      
	     
	   IF NOT ( @NewMaterialTradeParnterColorGroupID = @CurrentColorGroupID AND @Submit = @qty)  
	   BEGIN  
		--** fix data   
	      
		-- @tmpMaterialTradePartnerColorID is the new goup ID  
	     
	    
		IF @NewMaterialTradeParnterColorGroupID IS NULL   
		BEGIN   
		 -- define from colors available in pMaterialTradeP  
		 SELECT  TOP 1 @NewMaterialTradeParnterColorGroupID = MaterialTradePartnerColorID  
		 FROM dbo.pMaterialRequestSubmitWorkflow   
		 WHERE MaterialTradePartnerID =  @MaterialTradePartnerID  
		  AND MaterialRequestWorkflowID =  @MaterialRequestWorkflowID   
		  AND MaterialTradePartnerColorID <>  @MaterialTradePartnerColorID  
		 ORDER BY CDate  
		END   
	      
	      
		SELECT @NewMaterialRequestSubmitWorkflowID = a.MaterialRequestSubmitWorkflowID  
		FROM dbo.pMaterialRequestSubmitWorkflow  a  
		WHERE  a.MaterialTradePartnerColorID = @NewMaterialTradeParnterColorGroupID  
		 AND  a.MaterialRequestWorkflowID =  @MaterialRequestWorkflowID  
	      
		DECLARE   
		 @Cont INT,  
		 @Status INT ,  
		 @NewMaterialRequestSubmitID UNIQUEIDENTIFIER,  
		 @tmpMaterialRequestSubmitID UNIQUEIDENTIFIER  
	      
		SET @Cont= 1   
	      
		SET @NewColorGroupID = NEWID()          
	      
		--** fix submits  
		WHILE @Cont <= @Submit  
		BEGIN   
	      
		 SET @NewMaterialRequestSubmitID = NULL  
	       
		 --** check if there is already a record in MaterialRequestSubmit for the new "Color Group"  
		 SELECT TOP 1   
		  @NewMaterialRequestSubmitID =  a.MaterialRequestSubmitID  
		 FROM pMaterialRequestSubmit a  
		  INNER JOIN dbo.pMaterialRequestSubmitWorkflow b ON a.MaterialRequestSubmitWorkflowID = b.MaterialRequestSubmitWorkflowID  
		 WHERE  a.MaterialTradePartnerID =  @MaterialTradePartnerID   
		  AND a.MaterialTradePartnerColorID = @NewMaterialTradeParnterColorGroupID  
		  AND b.MaterialRequestWorkflowID = @MaterialRequestWorkflowID  
		  AND  a.Submit =  @Cont  
	        
	       
		 IF @NewMaterialRequestSubmitID IS NULL   
		 BEGIN   
		  SET @tmpMaterialRequestSubmitID = NULL  
		  SET @NewMaterialRequestSubmitID = NEWID()  
	       
		  --** check other colors in the MaterialRequestSubmit table  
		  SELECT TOP 1 @tmpMaterialRequestSubmitID = a.MaterialRequestSubmitID  
		  FROM pMaterialRequestSubmit a  
		   INNER JOIN dbo.pMaterialRequestSubmitWorkflow b ON a.MaterialRequestSubmitWorkflowID = b.MaterialRequestSubmitWorkflowID  
		  WHERE  a.MaterialTradePartnerID =  @MaterialTradePartnerID   
		   AND b.MaterialRequestWorkflowID = @MaterialRequestWorkflowID  
		   AND  a.Submit =  @Cont  
	         
	        
		  --** get information from any other submit   
		  IF @tmpMaterialRequestSubmitID IS NULL         
		   SELECT TOP 1 @tmpMaterialRequestSubmitID = a.MaterialRequestSubmitID  
		   FROM pMaterialRequestSubmit a  
			INNER JOIN dbo.pMaterialRequestSubmitWorkflow b ON a.MaterialRequestSubmitWorkflowID = b.MaterialRequestSubmitWorkflowID  
		   WHERE  a.MaterialTradePartnerID =  @MaterialTradePartnerID   
			AND b.MaterialRequestWorkflowID = @MaterialRequestWorkflowID  
	  
	          
		  IF @Cont = @Submit  
		   SET @Status = 0 --** open   
		  ELSE   
		   SET @Status = 1 --** resubmit  
	         
	  
		  IF @tmpMaterialRequestSubmitID IS NOT NULL   
		  BEGIN   
	        
	        
		   INSERT INTO dbo.pMaterialRequestSubmit (   
			MaterialRequestSubmitID ,MaterialRequestSubmitWorkflowID ,MaterialTradePartnerColorID ,  
			MaterialTradePartnerID ,Submit ,Status ,AssignedTo ,StartDate ,RecDate ,  
			RecBy ,RecCarrier ,RecTrackNo ,RecWeight ,VendorWeight ,VendorDate ,  
			VendorName ,SubmitDays ,ResubmitDays ,DueDate ,RevDate ,RevBy ,  
			EndDate ,EndBy ,CUser ,CDate ,MUser ,MDate ,TUser ,TDate ,  
			AgentView ,VendorComment ,InternalComment ,SubmitComment ,MaterialRequestSubmitGroupID)  
		   SELECT @NewMaterialRequestSubmitID, @NewMaterialRequestSubmitWorkflowID ,@NewMaterialTradeParnterColorGroupID ,  
			@MaterialTradePartnerID, @Cont AS Submit ,Status ,AssignedTo ,StartDate ,RecDate ,  
			RecBy ,RecCarrier ,RecTrackNo ,RecWeight ,VendorWeight ,VendorDate ,  
			VendorName ,SubmitDays ,ResubmitDays ,DueDate ,RevDate ,RevBy ,  
			EndDate ,EndBy ,CUser ,CDate ,MUser ,MDate ,TUser ,TDate ,  
			AgentView ,VendorComment ,InternalComment ,SubmitComment ,@NewColorGroupID  
		   FROM dbo.pMaterialRequestSubmit  
		   WHERE MaterialRequestSubmitID = @tmpMaterialRequestSubmitID  
	        
		  END   
		  ELSE   
		  BEGIN  
	        
	        
		   INSERT INTO dbo.pMaterialRequestSubmit(   
			MaterialRequestSubmitID ,MaterialRequestSubmitWorkflowID ,MaterialTradePartnerColorID ,  
			MaterialTradePartnerID ,  
			Submit ,Status, MaterialRequestSubmitGroupID)  
		   VALUES ( @NewMaterialRequestSubmitID ,@NewMaterialRequestSubmitWorkflowID ,@NewMaterialTradeParnterColorGroupID ,  
			@MaterialTradePartnerID ,  
			@Cont, @Status , @NewColorGroupID )  
		  END   
	        
		  UPDATE pMaterialRequestSubmitComment  
		   SET MaterialRequestSubmitID  = @NewMaterialRequestSubmitID  
		  FROM pMaterialRequestSubmitDocument c  
		   INNER JOIN dbo.pMaterialRequestSubmit a ON a.MaterialRequestSubmitID = c.MaterialRequestSubmitID  
		   INNER JOIN dbo.pMaterialRequestSubmitWorkflow b ON a.MaterialRequestSubmitWorkflowID = b.MaterialRequestSubmitWorkflowID  
		  WHERE b.MaterialTradePartnerID = @MaterialTradePartnerID   
		   AND b.MaterialRequestWorkflowID =  @MaterialRequestWorkflowID  
		   AND a.Submit = @Cont  
	        
		  UPDATE pMaterialRequestSubmitDocument  
		   SET MaterialRequestSubmitID  = @NewMaterialRequestSubmitID  
		  FROM pMaterialRequestSubmitDocument c  
		   INNER JOIN dbo.pMaterialRequestSubmit a ON a.MaterialRequestSubmitID = c.MaterialRequestSubmitID  
		   INNER JOIN dbo.pMaterialRequestSubmitWorkflow b ON a.MaterialRequestSubmitWorkflowID = b.MaterialRequestSubmitWorkflowID  
		  WHERE b.MaterialTradePartnerID = @MaterialTradePartnerID   
		   AND b.MaterialRequestWorkflowID =  @MaterialRequestWorkflowID  
		   AND a.Submit = @Cont  
	        
		  UPDATE pMaterialRequestSubmitItem  
		   SET MaterialRequestSubmitID  = @NewMaterialRequestSubmitID  
		  FROM pMaterialRequestSubmitItem c  
		   INNER JOIN dbo.pMaterialRequestSubmit a ON a.MaterialRequestSubmitID = c.MaterialRequestSubmitID  
		   INNER JOIN dbo.pMaterialRequestSubmitWorkflow b ON a.MaterialRequestSubmitWorkflowID = b.MaterialRequestSubmitWorkflowID  
		  WHERE b.MaterialTradePartnerID = @MaterialTradePartnerID   
		   AND b.MaterialRequestWorkflowID =  @MaterialRequestWorkflowID  
		   AND a.Submit = @Cont  
	        
	         
		 END -- @NewMaterialRequestSubmitID is null  
	       
	      
		 SET @Cont = @Cont + 1   
		END  -- while  
	      
	      
		DELETE FROM dbo.pMaterialRequestSubmitGroup  
		WHERE MaterialTradePartnerID = @MaterialTradePartnerID   
		 AND  MaterialRequestWorkflowID = @MaterialRequestWorkflowID  
	      
		INSERT INTO dbo.pMaterialRequestSubmitGroup(   
		 MaterialRequestSubmitGroupID ,MaterialTradePartnerID ,MaterialRequestWorkflowID ,  
		 MaterialTradePartnerColorID)  
		VALUES  (  
		 @NewColorGroupID ,@MaterialTradePartnerID ,@MaterialRequestWorkflowID ,  
		 @NewMaterialTradeParnterColorGroupID  
		)  
	      
	   END --** else nothing to do  
	    
	  END  --** if exist, else nothing to do   
	    
	  SET @ROWID = @ROWID + 1   
	    
	 END  --** While (materialrequestWorkflows)  
	  
	  
	 --** Delete records from 'pMaterialRequestSubmitComment'  
	 DELETE dbo.pMaterialRequestSubmitComment  
	 FROM pMaterialRequestSubmitComment a  
	  INNER JOIN dbo.pMaterialRequestSubmit b ON a.MaterialRequestSubmitID  = b.MaterialRequestSubmitID  
	 WHERE b.MaterialTradePartnerColorID = @MaterialTradePartnerColorID  
	    
	 --** Delete records from 'pMaterialRequestSubmitDocument'  
	 DELETE dbo.pMaterialRequestSubmitDocument  
	 FROM pMaterialRequestSubmitDocument a  
	  INNER JOIN dbo.pMaterialRequestSubmit b ON a.MaterialRequestSubmitID  = b.MaterialRequestSubmitID  
	 WHERE b.MaterialTradePartnerColorID = @MaterialTradePartnerColorID  
	   
	 --** Delete records from 'pMaterialRequestSubmitItem'  
	 DELETE pMaterialRequestSubmitItem  
	 FROM pMaterialRequestSubmitItem a  
	  INNER JOIN dbo.pMaterialRequestSubmit b ON a.MaterialRequestSubmitID  = b.MaterialRequestSubmitID  
	 WHERE b.MaterialTradePartnerColorID = @MaterialTradePartnerColorID  
	  
	 --*** Delete records from 'pMaterialRequestSubmit'.  
	 DELETE pMaterialRequestSubmit  
	 WHERE MaterialTradePartnerColorID = @MaterialTradePartnerColorID  
	  
	 --*** Delete records from 'pMaterialRequestSubmitWorkflow'  
	 DELETE pMaterialRequestSubmitWorkflow  
	 WHERE MaterialTradePartnerColorID = @MaterialTradePartnerColorID  
	    
	  
	END  
	ELSE   
	BEGIN   
	 --** DELETE everyting    
	   
	 --** Delete records from 'pMaterialRequestSubmitComment'  
	 DELETE dbo.pMaterialRequestSubmitComment  
	 FROM pMaterialRequestSubmitComment a  
	  INNER JOIN dbo.pMaterialRequestSubmit b ON a.MaterialRequestSubmitID  = b.MaterialRequestSubmitID  
	 WHERE b.MaterialTradePartnerID = @MaterialTradePartnerID  
	    
	    
	 --** Delete records from 'pMaterialRequestSubmitDocument'  
	 DELETE dbo.pMaterialRequestSubmitDocument  
	 FROM pMaterialRequestSubmitDocument a  
	  INNER JOIN dbo.pMaterialRequestSubmit b ON a.MaterialRequestSubmitID  = b.MaterialRequestSubmitID  
	 WHERE b.MaterialTradePartnerID = @MaterialTradePartnerID  
	   
	 --** Delete records from 'pMaterialRequestSubmitItem'  
	 DELETE pMaterialRequestSubmitItem  
	 FROM pMaterialRequestSubmitItem a  
	  INNER JOIN dbo.pMaterialRequestSubmit b ON a.MaterialRequestSubmitID  = b.MaterialRequestSubmitID  
	 WHERE b.MaterialTradePartnerID = @MaterialTradePartnerID  
	  
	 --*** Delete records from 'pMaterialRequestSubmit'.  
	 DELETE pMaterialRequestSubmit  
	 WHERE MaterialTradePartnerID = @MaterialTradePartnerID  
	  
	 --*** Delete records from 'pMaterialRequestSubmitWorkflow'  
	 DELETE pMaterialRequestSubmitWorkflow  
	 WHERE MaterialTradePartnerID = @MaterialTradePartnerID  
	  
	END   
	  
	  
	DELETE FROM pMaterialTradePartnerColor  
	WHERE MaterialTradePartnerColorID  = @MaterialTradePartnerColorID   
	  
	DELETE FROM pMaterialRequestSubmitGroup  
	WHERE MaterialTradePartnerColorID  = @MaterialTradePartnerColorID   
	  
  
	-- Breaking the connections between all the calendars
	DECLARE @TACalTemplateID UNIQUEIDENTIFIER
	
	DECLARE CalendarsCursor CURSOR SCROLL FOR
	SELECT TACalTemplateID FROM pTACalReference 
	WHERE ReferenceId = @MaterialTradePartnerID AND TACalReferenceTypeId = 24
	
	OPEN CalendarsCursor
	FETCH NEXT FROM CalendarsCursor INTO @TACalTemplateID
	WHILE @@FETCH_STATUS = 0
	BEGIN
		EXEC spx_TACalendar_MaterialRequestWorkflowReferences_Progress_UPDATE NULL, NULL, @TACalTemplateID
		FETCH NEXT FROM CalendarsCursor INTO @TACalTemplateID
	END
	CLOSE CalendarsCursor
	DEALLOCATE CalendarsCursor
	
END
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.0.0000', '08970', GetDate())
GO
