IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_WorkflowItem_COPY]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_WorkflowItem_COPY]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO

  
CREATE PROCEDURE [dbo].[spx_WorkflowItem_COPY]  
 (@WorkflowID uniqueidentifier,  
 @WorkFlowItemId uniqueidentifier,  
 @StyleID uniqueidentifier,  
 @CopyStyleID uniqueidentifier,  
 @StyleSet int,  
 @CopyStyleSet int,  
 @CUser nvarchar(100),  
 @CDate datetime)  
AS  
  
DECLARE @nSort as int   
DECLARE @nMax as int   
DECLARE @nCount as int  
DECLARE @vcCount as varchar (4)  
DECLARE @NewWorkFlowItemId UNIQUEIDENTIFIER  
DECLARE @WorkFlowItemTypeId UNIQUEIDENTIFIER  
Declare @NewMeasHdrId UNIQUEIDENTIFIER  
Declare @oldMeashdrId UNIQUEIDENTIFIER  
DECLARE @StyleImageLinked int  
DECLARE @StyleDetailFormID UNIQUEIDENTIFIER  
DECLARE @ImageID UNIQUEIDENTIFIER  
DECLARE @ImageVersion int  
       
BEGIN  
  
  
 SET @NewWorkFlowItemId = NEWID()  
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
 (WorkFlowItemID, WorkflowID, WorkflowItemTypeId, StyleID, WorkFlowItemName, StyleSet, Sort, MDate, MUser, CUser, CDate)  
 SELECT @NewWorkFlowItemId, @WorkflowID, WorkflowItemTypeId, @StyleID, WorkFlowItemName, @StyleSet, @vcCount, @CDate, @CUser, CUser, CDate  
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
VALUES     ('DB_Version', '5.0.0000', '03563', GetDate())
GO 