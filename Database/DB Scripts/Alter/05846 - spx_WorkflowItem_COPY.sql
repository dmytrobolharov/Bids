/****** Object:  StoredProcedure [dbo].[spx_WorkflowItem_COPY]    Script Date: 06/13/2013 10:44:02 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_WorkflowItem_COPY]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_WorkflowItem_COPY]
GO

CREATE PROCEDURE [dbo].[spx_WorkflowItem_COPY]  
 (@WorkflowID uniqueidentifier,  
 @WorkFlowItemId uniqueidentifier,  
 @StyleID uniqueidentifier,  
 @CopyStyleID uniqueidentifier,  
 @StyleSet int,  
 @CopyStyleSet int,  
 @CUser nvarchar(100),  
 @CDate datetime,
 @NewWorkFlowItemId uniqueidentifier = NULL)  
AS  
  
DECLARE @nSort as int   
DECLARE @nMax as int   
DECLARE @nCount as int  
DECLARE @vcCount as varchar (4)  
DECLARE @WorkFlowItemTypeId UNIQUEIDENTIFIER  
Declare @NewMeasHdrId UNIQUEIDENTIFIER  
Declare @oldMeashdrId UNIQUEIDENTIFIER  
DECLARE @StyleImageLinked int  
DECLARE @StyleDetailFormID UNIQUEIDENTIFIER  
DECLARE @ImageID UNIQUEIDENTIFIER  
DECLARE @ImageVersion int  


Declare @NewBOMId UNIQUEIDENTIFIER
Declare @oldBOMId UNIQUEIDENTIFIER
Declare @ItemDim1TypeId nvarchar(50)	
Declare @ItemDim2TypeId nvarchar(50)	
Declare @ItemDim3TypeId nvarchar(50)
       
BEGIN  
  
  
 if @NewWorkFlowItemId IS NULL SET @NewWorkFlowItemId = NEWID()
 SELECT @WorkFlowItemTypeId = WorkFlowItemTypeId from pWorkFlowItem WHERE WorkFlowItemId = @WorkFlowItemId  
  
 SELECT @nCount = count(*) FROM pWorkFlowItem WITH (NOLOCK) WHERE StyleId = @StyleID  AND  StyleSet = @StyleSet AND  WorkFlowItemTypeId = @WorkFlowItemTypeId  
 SELECT @nMax = cast (   MAX (Sort)  as int ) FROM pWorkFlowItem WITH (NOLOCK) WHERE StyleId = @StyleID  AND  StyleSet = @StyleSet AND  WorkFlowItemTypeId = @WorkFlowItemTypeId  
 IF  @nCount IS NULL   SET @nCount = 0   
 IF @nMax IS NULL SET @nMax = 0   
 IF @nCount > @nMax  SET @nSort = @nCount   
 ELSE  SET @nSort = @nMax   
 print  'nCount=' + Cast(@nCount  as varchar (10) ) + '   nMax=' + Cast( @nMax as varchar (10) ) + '   nSort=' + Cast( @nSort  as varchar (10) )  
   
 SET @nSort = @nSort + 1  
 SET @vcCount =  RIGHT ( '0000' +  cast ( @nSort as nvarchar (4) ) , 2 )  
 print  'vccount 1 = '  + @vcCount  
  
 INSERT INTO pWorkFlowItem  
 (WorkFlowItemID, WorkflowID, WorkflowItemTypeId, StyleID, WorkFlowItemName, StyleSet, Sort, MDate, MUser, CUser, CDate, StatusID, WorkStart, WorkDue,WorkAssignedTo,WorkStatus,WorkEscalateTo)  
 SELECT @NewWorkFlowItemId, @WorkflowID, WorkflowItemTypeId, @StyleID, WorkFlowItemName, @StyleSet, @vcCount, @CDate, @CUser, CUser, CDate,StatusID, WorkStart, WorkDue,WorkAssignedTo,WorkStatus,WorkEscalateTo
 FROM pWorkFlowItem WITH (NOLOCK)  
 WHERE (WorkFlowItemId = @WorkFlowItemId)  
  
 IF @@Error <> 0 OR @@RowCount <> 1 GOTO Error  
  If @WorkFlowId = '80000000-0000-0000-0000-000000000008'   
  BEGIN  
   INSERT INTO pConPageDetail  
   ( StyleID, WorkflowID, WorkFlowItemId, Sort, StyleSet, Detail, OrigOperationSN, Level0Desc, Level1Desc, Level2Desc, Level3Desc, ImageID, AuxField1, AuxField2, AuxField3,   
     AuxField4, AuxField5, Linked, Level0ID, Level1ID, Level2ID, Level3ID, CUser, CDate, MUser, MDate)  
   SELECT @StyleID, @WorkflowID, @NewWorkFlowItemId, Sort, @StyleSet, Detail, OrigOperationSN, Level0Desc, Level1Desc, Level2Desc, Level3Desc, ImageID, AuxField1, AuxField2, AuxField3,   
   AuxField4, AuxField5, Linked, Level0ID, Level1ID, Level2ID, Level3ID, @CUser, @CDate, @CUser, @CDate  
   FROM pConPageDetail WITH (NOLOCK)  
   WHERE StyleID = @CopyStyleID  
   AND WorkflowItemID = @WorkflowItemID  
   AND StyleSet = @CopyStyleSet  
  END  
  Else If @WorkFlowId = '40000000-0000-0000-0000-000000000050'   
    
   BEGIN  
     
   set @NewMeasHdrId = NEWID()  
        
   select @oldMeashdrId = AMLMeasHdrId from pamlmeashdr where WorkflowID = @WorkflowID AND WorkflowItemID = @WorkflowItemID AND StyleSet = @CopyStyleSet     
     
   INSERT INTO pamlmeashdr (AMLMeasHdrId, Workflowid, StyleId, StyleSet, CompanyId, CompanyName, IsRelative,  
   IsNegative, IsMetric, SizeClass, SizeClassId, SizeRange, SizeRangeId, ProductType, ProductTypeId, MeasRowCnt,  
   CUser, CDate, MUser, MDate, WorkFlowItemId)  
   select @NewMeasHdrId, @WorkflowID, @StyleID, @StyleSet, CompanyId, CompanyName, IsRelative,  
   IsNegative, IsMetric, SizeClass, SizeClassId, SizeRange, SizeRangeId, ProductType, ProductTypeId, MeasRowCnt,  
   @CUser, @CDate, @CUser, @CDate, @NewWorkFlowItemId  
   from pamlmeashdr where AMLMeasHdrId = @oldMeashdrId        
             
      INSERT INTO pamlmeaslbl (AMLMeasHdrId, SizeRangeId, SizeRangeDetailId, SizeCol, MeasLbl, IsVisible, IsSample,  
      MeasDesc, CUser, CDate, MUser, MDate)  
      Select @NewMeasHdrId, SizeRangeId, SizeRangeDetailId, SizeCol, MeasLbl, IsVisible, IsSample,  
      MeasDesc, @CUser, @CDate, @CUser, @CDate  
      from pamlmeaslbl where AMLMeasHdrId = @oldMeashdrId               
             
            INSERT INTO pamlmeaspom (AMLMeasHdrId, GRPOMCompanyId, POMGuidId, POMAlternatesId, POM_Row, RefCode, Description,  
            TolPlus, TolMinus, Flag4QA, WSRowId, SortId, ImageId,  How2MeasText, CUser, CDate, MUser, MDate)  
            select @NewMeasHdrId, GRPOMCompanyId, POMGuidId, POMAlternatesId, POM_Row, RefCode, Description,  
            TolPlus, TolMinus, Flag4QA, WSRowId, SortId, ImageId,  How2MeasText, @CUser, @CDate, @CUser, @CDate  
      from pamlmeaspom where AMLMeasHdrId = @oldMeashdrId         
        
   INSERT INTO pamlmeasigc (AMLMeasHdrId, POM_Row, WSRowId, SizeCol, Incr, Grade, ConvGrade,  
   CUser, CDate, MUser, MDate)  
   select @NewMeasHdrId, POM_Row, WSRowId, SizeCol, Incr, Grade, ConvGrade,  
   @CUser, @CDate, @CUser, @CDate from pamlmeasigc where AMLMeasHdrId = @oldMeashdrId   
     
   Update pamlmeasigc set AMLMeasPOMId = p.AMLMeasPOMId from pamlmeasigc i inner join pamlmeaspom p on   
   i.AMLMeasHdrId=p.AMLMeasHdrId and i.pom_row=p.pom_row and i.WSRowId=p.WSRowId            
   where i.amlmeashdrid=@NewMeasHdrId and i.amlmeaspomid is null  
     
     
   END  
   Else If @WorkFlowId = '40000000-0000-0000-0000-000000000080' 
		
			BEGIN
			
			set @NewBOMId = NEWID()
						
			select @oldBOMId = StyleBOMDimensionId from pStyleBOMDimension where WorkflowID = @WorkflowID AND WorkflowItemID = @WorkflowItemID AND styleid=@CopyStyleID and StyleSet = @CopyStyleSet			
			
			INSERT INTO pStyleBOMDimension (StyleBOMDimensionID, StyleBOMDimensionCopyMasterID, Workflowid, WorkFlowItemID, StyleId, StyleSet, ItemDim1TypeId, ItemDim2TypeId, ItemDim3TypeId,
			ItemDim1TypeName, ItemDim2TypeName, ItemDim3TypeName, Comments, ImageId, CUser, CDate, MUser, MDate)			
			select @NewBOMId, @oldBOMId, @WorkflowID, @NewWorkFlowItemId, @StyleID, @StyleSet, ItemDim1TypeId, ItemDim2TypeId, ItemDim3TypeId,
			ItemDim1TypeName, ItemDim2TypeName, ItemDim3TypeName, Comments, ImageId,
			@CUser, @CDate, @CUser, @CDate 
			from pStyleBOMDimension where StyleBOMDimensionID = @oldBOMId				
           
		    INSERT INTO pStyleBOMDimensionItem (StyleBOMDimensionID, WorkFlowID, WorkFlowItemID, StyleID, StyleSet,
		    ItemDim1TypeId, ItemDim2TypeId, ItemDim3TypeId, ItemDim1Id, ItemDim2Id, ItemDim3Id, 
		    ItemDim1Name, ItemDim2Name, ItemDim3Name, ItemDim1Sort, ItemDim2Sort, ItemDim3Sort, 
		    ItemDim1Active, ItemDim2Active, ItemDim3Active, Comments, ImageId, CUser, CDate, MUser, MDate)
		    Select @NewBOMId, @WorkflowID, @NewWorkFlowItemId, @StyleID, @StyleSet,
		    ItemDim1TypeId, ItemDim2TypeId, ItemDim3TypeId, ItemDim1Id, ItemDim2Id, ItemDim3Id, 
		    ItemDim1Name, ItemDim2Name, ItemDim3Name, ItemDim1Sort, ItemDim2Sort, ItemDim3Sort, 
		    ItemDim1Active, ItemDim2Active, ItemDim3Active, Comments, ImageId,
		    @CUser, @CDate, @CUser, @CDate
		    from pStyleBOMDimensionItem where StyleBOMDimensionID = @oldBOMId                       
            
            INSERT INTO pStyleBOMDimensionItems (StyleBOMDimensionID, WorkFlowID, WorkFlowItemID, StyleID, StyleSet,
		    ItemDim1TypeId, ItemDim2TypeId, ItemDim3TypeId, ItemDim1Id, ItemDim2Id, ItemDim3Id, 
		    ItemDim1Name, ItemDim2Name, ItemDim3Name, ItemDim1Sort, ItemDim2Sort, ItemDim3Sort, 
		    ItemDim1Active, ItemDim2Active, ItemDim3Active, ItemDimActive, Comments, ImageId, CUser, CDate, MUser, MDate)
		    Select @NewBOMId, @WorkflowID, @NewWorkFlowItemId, @StyleID, @StyleSet,
		    ItemDim1TypeId, ItemDim2TypeId, ItemDim3TypeId, ItemDim1Id, ItemDim2Id, ItemDim3Id, 
		    ItemDim1Name, ItemDim2Name, ItemDim3Name, ItemDim1Sort, ItemDim2Sort, ItemDim3Sort, 
		    ItemDim1Active, ItemDim2Active, ItemDim3Active, ItemDimActive, Comments, ImageId,
		    @CUser, @CDate, @CUser, @CDate
		    from pStyleBOMDimensionItems where StyleBOMDimensionID = @oldBOMId    
		    
		   
		    INSERT INTO pStyleBOM (StyleMaterialMasterID,CopyStyleMaterialID,MainMaterial,Development,MiscColor,StyleSet
			,StyleID,WorkflowId,WorkflowItemId,StyleBOMDimensionId,Dim1TypeSel,Dim2TypeSel,Dim3TypeSel,UOM,Qty,MaterialPrice
			,Ext,MaterialSize,MaterialID,MaterialPlacement,MaterialPlacementCode,MaterialPlacementDetail,MaterialImageID
			,MaterialImageVersion,NoColorMatch,SupplierID,ComponentTypeID,MaterialType,MaterialNo,MaterialName,A
			,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z,Source,Notes,Placement,VendorPrice,VolumePrice,VolumePriceMinimum
			,VendorProductionMin,VendorProductionLeadTime,DetailYesNo,ImageType,height,width,CDate,CUser,MDate,MUser
			,MChange,SChange,DChange,CChange,[Action],ColorPlacement,Artwork,License,Colorway,MaterialSort,MaterialTrack
			,MaterialLinked,MaterialDimension,MaterialSizeA0,MaterialSizeA1,MaterialSizeA2,MaterialSizeA3,MaterialSizeA4
			,MaterialSizeA5,MaterialSizeA6,MaterialSizeA7,MaterialSizeA8,MaterialSizeA9,MaterialSizeA10,MaterialSizeA11
			,MaterialSizeA12,MaterialSizeA13,MaterialSizeA14,MaterialSizeA15,MaterialSizeA16,MaterialSizeA17,MaterialSizeA18
			,MaterialSizeA19,MaterialSizeB0,MaterialSizeB1,MaterialSizeB2,MaterialSizeB3,MaterialSizeB4,MaterialSizeB5
			,MaterialSizeB6,MaterialSizeB7,MaterialSizeB8,MaterialSizeB9,MaterialSizeB10,MaterialSizeB11,MaterialSizeB12
			,MaterialSizeB13,MaterialSizeB14,MaterialSizeB15,MaterialSizeB16,MaterialSizeB17,MaterialSizeB18,MaterialSizeB19
			,MaterialLining,MaterialSizeID,MaterialColorId,MaterialPackLabelGroupID,TradePartnerID,TradePartnerVendorID
			,MaterialBOM,MaterialCode,StyleMaterialLinkID,MultiCloth,MaterialCoreItemID,MaterialSwing,MaterialLinkID
			,MultiMaterialParentID)
		    SELECT StyleMaterialMasterID,StyleMaterialID,MainMaterial,Development,MiscColor,@StyleSet
			,@StyleID,@WorkflowID,@NewWorkFlowItemId,@NewBOMId,Dim1TypeSel,Dim2TypeSel,Dim3TypeSel,UOM,Qty,MaterialPrice
			,Ext,MaterialSize,MaterialID,MaterialPlacement,MaterialPlacementCode,MaterialPlacementDetail,MaterialImageID
			,MaterialImageVersion,NoColorMatch,SupplierID,ComponentTypeID,MaterialType,MaterialNo,MaterialName,A
			,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z,Source,Notes,Placement,VendorPrice,VolumePrice,VolumePriceMinimum
			,VendorProductionMin,VendorProductionLeadTime,DetailYesNo,ImageType,height,width,CDate,CUser,MDate,MUser
			,MChange,SChange,DChange,CChange,[Action],ColorPlacement,Artwork,License,Colorway,MaterialSort,MaterialTrack
			,MaterialLinked,MaterialDimension,MaterialSizeA0,MaterialSizeA1,MaterialSizeA2,MaterialSizeA3,MaterialSizeA4
			,MaterialSizeA5,MaterialSizeA6,MaterialSizeA7,MaterialSizeA8,MaterialSizeA9,MaterialSizeA10,MaterialSizeA11
			,MaterialSizeA12,MaterialSizeA13,MaterialSizeA14,MaterialSizeA15,MaterialSizeA16,MaterialSizeA17,MaterialSizeA18
			,MaterialSizeA19,MaterialSizeB0,MaterialSizeB1,MaterialSizeB2,MaterialSizeB3,MaterialSizeB4,MaterialSizeB5
			,MaterialSizeB6,MaterialSizeB7,MaterialSizeB8,MaterialSizeB9,MaterialSizeB10,MaterialSizeB11,MaterialSizeB12
			,MaterialSizeB13,MaterialSizeB14,MaterialSizeB15,MaterialSizeB16,MaterialSizeB17,MaterialSizeB18,MaterialSizeB19
			,MaterialLining,MaterialSizeID,MaterialColorId,MaterialPackLabelGroupID,TradePartnerID,TradePartnerVendorID
			,MaterialBOM,MaterialCode,StyleMaterialLinkID,MultiCloth,MaterialCoreItemID,MaterialSwing,MaterialLinkID
			,MultiMaterialParentID
			FROM pStyleBOM where StyleBOMDimensionID = @oldBOMId 
			and WorkflowID = @WorkflowID AND WorkflowItemID = @WorkflowItemID AND StyleID = @CopyStyleID and StyleSet = @CopyStyleSet
			
			
			CREATE TABLE #tmpnewItem (
				Rec_ID INT IDENTITY (1,1),				
				StyleMaterialID NVARCHAR(50),	
				MaterialID NVARCHAR(50)	,
				MaterialCode nvarchar(200)							
			)	
					
			CREATE TABLE #tmpoldItem (
				Rec_ID INT IDENTITY (1,1),				
				oldStyleMaterialID NVARCHAR(50),	
				oldMaterialID NVARCHAR(50),
				oldMaterialCode nvarchar(200)									
			)
			
			CREATE TABLE #tmpItem (
				Rec_ID INT IDENTITY (1,1),
				StyleMaterialID NVARCHAR(50),	
				MaterialID NVARCHAR(50),	
				MaterialCode nvarchar(200),			
				oldStyleMaterialID NVARCHAR(50),	
				oldMaterialID NVARCHAR(50),
				oldMaterialCode nvarchar(200)								
			)
			
			CREATE TABLE #tmpMaterialItem (
				Rec_ID INT IDENTITY (1,1),	
				MaterialId NVARCHAR(50),	
				Dim1ID NVARCHAR(50),	
				Dim2ID NVARCHAR(50),
				Dim3ID NVARCHAR(50),		
				Qty nvarchar(20),
				ColorId nvarchar(50),
				SizeId nvarchar(50),
				Price nvarchar(20), 
				Comments nvarchar(510), 
				ImageId nvarchar(50) 			
				)	
				
				
			INSERT INTO #tmpnewItem(StyleMaterialID, MaterialId, MaterialCode)
			Select StyleMaterialID, MaterialID, MaterialCode from pStyleBOM where StyleBOMDimensionID = @NewBOMId 
			and WorkflowID = @WorkflowID AND WorkflowItemID = @NewWorkFlowItemId AND StyleID = @StyleID and StyleSet = @StyleSet
			order by MaterialId, MaterialCode
			
			INSERT INTO #tmpoldItem(oldStyleMaterialID, oldMaterialId, oldMaterialCode)
			Select StyleMaterialID, MaterialID, MaterialCode from pStyleBOM where StyleBOMDimensionID = @oldBOMId 
			and WorkflowID = @WorkflowID AND WorkflowItemID = @WorkFlowItemId AND StyleID = @copyStyleID and StyleSet = @copyStyleSet
			order by MaterialID, MaterialCode
			
			INSERT INTO #tmpItem(StyleMaterialID, MaterialId, MaterialCode, oldStyleMaterialID, oldMaterialId, oldMaterialCode)
			Select t1.StyleMaterialID, t1.MaterialID, t1.MaterialCode, t2.oldStyleMaterialID, t2.oldMaterialID, t2.oldMaterialCode
			from #tmpnewItem t1, #tmpoldItem t2 where t1.Rec_ID=t2.Rec_ID order by t1.MaterialID, t1.MaterialCode						
						
			INSERT INTO	#tmpMaterialItem (MaterialId, Dim1ID,  Dim2ID,  Dim3ID, Qty, ColorId, SizeId, Price,
			Comments, ImageId)
			select StyleMaterialId, ItemDim1ID, ItemDim2ID, ItemDim3ID, MaterialQuantity, MaterialColorId, MaterialDimension, 
			MaterialPrice, Comments, ImageId from pStyleBOMItem where styleBOMDimensionId=@oldBOMId	 			
			
			update #tmpMaterialItem set MaterialId=t1.StyleMaterialId 
			from #tmpMaterialItem t inner join #tmpItem t1  
			on t.MaterialId=t1.oldStyleMaterialId  
			
			Insert into pstylebomitem (StyleBOMDimensionId, StyleBOMDimensionItemID, StyleMaterialID, WorkflowID, WorkflowItemID, 
			StyleID, StyleSet, ItemDim1TypeId, ItemDim2TypeId, ItemDim3TypeId, ItemDim1ID,
			ItemDim2ID,ItemDim3ID, MaterialQuantity, MaterialColorId, MaterialDimension, MaterialPrice)		
			select @NewBOMId, null, MaterialID, @WorkflowID, @NewWorkFlowItemId, @StyleID, @StyleSet,
			@ItemDim1TypeId, @ItemDim2TypeId, @ItemDim3TypeId, Dim1ID , Dim2ID, Dim3ID, Qty, ColorId, SizeId, Price
			from #tmpMaterialItem
			
		    select @ItemDim1TypeId = ItemDim1TypeId, @ItemDim2TypeId = ItemDim2TypeId, @ItemDim3TypeId=ItemDim3TypeId
			from pStyleBOMDimension where StyleBOMDimensionId = @NewBOMId 		    
		    
		    if (@ItemDim3TypeId='00000000-0000-0000-0000-000000000000') and  (@ItemDim2TypeId='00000000-0000-0000-0000-000000000000') 		    
				begin										
					Update pstylebomitem set StyleBOMDimensionItemID=p.StyleBOMDimensionItemID,	
					ItemDim1Id=p.ItemDim1Id,ItemDim2Id=p.ItemDim2Id,ItemDim3Id=p.ItemDim3Id	,
					ItemDim1Name=p.ItemDim1Name,ItemDim2Name=p.ItemDim2Name,ItemDim3Name=p.ItemDim3Name,
					ItemDim1TypeId=p.ItemDim1TypeId,ItemDim2TypeId=p.ItemDim2TypeId,ItemDim3TypeId=p.ItemDim3TypeId						
					from pstylebomitem b inner join pStyleBOMDimensionItems p 
					on b.StyleBOMDimensionId=p.StyleBOMDimensionId  					
					and b.ItemDim1Id=p.ItemDim1Id where b.styleBOMDimensionId=@NewBOMId					 
					and b.StyleBOMDimensionItemID is null and b.ItemDim1Id is not null							                 
				end
			else 
				begin
					if (@ItemDim3TypeId='00000000-0000-0000-0000-000000000000')
						begin 							
							Update pstylebomitem set StyleBOMDimensionItemID=p.StyleBOMDimensionItemID,	
							ItemDim1Id=p.ItemDim1Id,ItemDim2Id=p.ItemDim2Id,ItemDim3Id=p.ItemDim3Id	,
							ItemDim1Name=p.ItemDim1Name,ItemDim2Name=p.ItemDim2Name,ItemDim3Name=p.ItemDim3Name,
							ItemDim1TypeId=p.ItemDim1TypeId,ItemDim2TypeId=p.ItemDim2TypeId,ItemDim3TypeId=p.ItemDim3TypeId						
							from pstylebomitem b inner join pStyleBOMDimensionItems p 
							on b.StyleBOMDimensionId=p.StyleBOMDimensionId  							
							and b.ItemDim1Id=p.ItemDim1Id and b.ItemDim2Id=p.ItemDim2Id
							where b.styleBOMDimensionId=@NewBOMId							
							and b.StyleBOMDimensionItemID is null
							and b.ItemDim1Id is not null and b.ItemDim2Id is not null														
						end	
					else
						begin							
							Update pstylebomitem set StyleBOMDimensionItemID=p.StyleBOMDimensionItemID,	
							ItemDim1Id=p.ItemDim1Id,ItemDim2Id=p.ItemDim2Id,ItemDim3Id=p.ItemDim3Id	,
							ItemDim1Name=p.ItemDim1Name,ItemDim2Name=p.ItemDim2Name,ItemDim3Name=p.ItemDim3Name,
							ItemDim1TypeId=p.ItemDim1TypeId,ItemDim2TypeId=p.ItemDim2TypeId,ItemDim3TypeId=p.ItemDim3TypeId						
							from pstylebomitem b inner join pStyleBOMDimensionItems p 
							on b.StyleBOMDimensionId=p.StyleBOMDimensionId  							
							and b.ItemDim1Id=p.ItemDim1Id and b.ItemDim2Id=p.ItemDim2Id and b.ItemDim3Id=p.ItemDim3Id
							where b.styleBOMDimensionId=@NewBOMId							
							and b.StyleBOMDimensionItemID is null
							and b.ItemDim1Id is not null and b.ItemDim2Id is not null and b.ItemDim3Id is not null															
						end
					
				end
				
			delete from pStyleBOMItem where StyleBOMDimensionID=@NewBOMId and StyleBOMDimensionItemID is null
					
			drop table #tmpnewItem	
			drop table #tmpoldItem	
			drop table #tmpItem	
			drop table #tmpMaterialItem
			
			END
  Else If @WorkFlowId = '40000000-0000-0000-0000-000000000018'  
   BEGIN  
     
    INSERT INTO pStyleComment  
    (StyleID, StyleSet, WorkflowID, CUser, CDate, MUser, MDate, MChange, StyleReview, StyleComment, CTeamID, Active, WorkFlowItemId)  
    SELECT @StyleID, StyleSet, WorkflowID, @CUser, @CDate, @CUser, @CDate, MChange, StyleReview, StyleComment, CTeamID, Active, @NewWorkFlowItemId   
    FROM pStyleComment WITH (NOLOCK)  
    WHERE StyleID = @CopyStyleID  
    AND WorkFlowItemId = @WorkflowItemID  
    AND StyleSet = @CopyStyleSet  
  
  
    INSERT INTO pStyleDetailForm  
    (StyleDetailFormMasterID, WorkflowID, WorkFlowItemId, StyleID, Comments, StyleSet, ImageID, ImageVersion, CUser, CDate, MUser, MDate, Sort, StyleImageLinked, SessionItemTempID, StyleDetailFormLinkID)  
    SELECT NEWID(), WorkflowID, @NewWorkFlowItemId, @StyleID, Comments, StyleSet, ImageID, ImageVersion,@CUser, @CDate, @CUser, @CDate, Sort, StyleImageLinked, SessionItemTempID, StyleDetailFormLinkID  
    FROM pStyleDetailForm WITH (NOLOCK)  
    WHERE StyleID = @CopyStyleID  
    AND WorkflowItemID = @WorkflowItemID  
    AND StyleSet = @CopyStyleSet  
   END     
  Else If @WorkFlowId = '40000000-0000-0000-0000-000000000078'  -- new BOL v.2
   BEGIN  
     
	EXEC spx_StyleNBOL_Copy
			@WorkflowID = @WorkflowID,
			@NewWorkFlowItemId = @NewWorkFlowItemId,
			@OldWorkFlowItemId = @WorkFlowItemId,
			@NewStyleID = @StyleID,
			@OldStyleID = @CopyStyleID,
			@NewStyleSet = @StyleSet,
			@OldStyleSet = @CopyStyleSet,
			@CUser = @CUser,
			@CDate = @CDate
  
   END
  ELSE
    BEGIN  
     
    INSERT INTO pStyleComment  
    (StyleID, StyleSet, WorkflowID, CUser, CDate, MUser, MDate, MChange, StyleReview, StyleComment, CTeamID, Active, WorkFlowItemId)  
    SELECT @StyleID, StyleSet, WorkflowID, @CUser, @CDate, @CUser, @CDate, MChange, StyleReview, StyleComment, CTeamID, Active, @NewWorkFlowItemId   
    FROM pStyleComment WITH (NOLOCK)  
    WHERE StyleID = @CopyStyleID  
    AND WorkFlowItemId = @WorkflowItemID  
    AND StyleSet = @CopyStyleSet  
  
  
    INSERT INTO pStyleDetailForm  
    (StyleDetailFormMasterID, WorkflowID, WorkFlowItemId, StyleID, Comments, StyleSet, ImageID, ImageVersion, CUser, CDate, MUser, MDate, Sort, StyleImageLinked, SessionItemTempID, StyleDetailFormLinkID)  
    SELECT NEWID(), WorkflowID, @NewWorkFlowItemId, @StyleID, Comments, StyleSet, ImageID, ImageVersion,@CUser, @CDate, @CUser, @CDate, Sort, StyleImageLinked, SessionItemTempID, StyleDetailFormLinkID  
    FROM pStyleDetailForm WITH (NOLOCK)  
    WHERE StyleID = @CopyStyleID  
    AND WorkflowItemID = @WorkflowItemID  
    AND StyleSet = @CopyStyleSet  
   END  
  
  
 IF @@Error <> 0 GOTO Error  
  
 RETURN  
Error:  
 ROLLBACK TRANSACTION  
END 




GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0.0000', '05846', GetDate())
GO
