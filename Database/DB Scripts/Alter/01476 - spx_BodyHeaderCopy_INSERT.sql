-- ******************************************************************************************** */
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Create Script                                                                               */
-- * Database:                                                                                  */
-- * 25 May 2011                                                                                */
-- * WorkItem#2850                                                                                          */
-- * Copyright (c) 2002-2010 Gerber Technology, Inc.  All rights reserved.                      */
-- * This information is confidential and proprietary.  You may not disseminate it              */
-- * to any other party without the express written consent of Gerber Technology, Inc.          */
-- *                                                                                            */
-- ******************************************************************************************** */
-- ******************************************************************************************** */
-- COMMENTS
--
--
--

/****** Object:  StoredProcedure [dbo].[spx_BodyHeaderCopy_INSERT]    Script Date: 05/25/2011 19:14:04 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_BodyHeaderCopy_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_BodyHeaderCopy_INSERT]
GO

/****** Object:  StoredProcedure [dbo].[spx_BodyHeaderCopy_INSERT]    Script Date: 05/25/2011 19:14:04 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spx_BodyHeaderCopy_INSERT]    
(    
@BodyID uniqueidentifier,    
@NewBodyID uniqueidentifier,    
@DesignSketchID uniqueidentifier,    
@DesignSketchVersion varchar(5),      
@CreatedBy nvarchar(200),    
@CreatedDate datetime    
)    
AS    
    
SET NOCOUNT ON    
    
BEGIN    
 INSERT INTO pBody    
  (BodyID,BodyTypeID,BodySet,BodyNo,BodyWorkflowID,Description,TempID,TempNo,StyleCategory,SizeClass,SizeRange,POMTempID,  
POMTempItemID,Season,Year,ImageID,ImageVersion,PC1,PC2,PC3,PC4,Active,CUser,CDate,MUser,MDate,POMTempID1,POMTempID2,POMTempID3,POMTempID4,WashType   
  )    
 SELECT     @NewBodyID,BodyTypeID,BodySet,BodyNo,BodyWorkflowID,Description,TempID,TempNo,StyleCategory,SizeClass,SizeRange,POMTempID,  
POMTempItemID,Season,Year,@DesignSketchID,@DesignSketchVersion,PC1,PC2,PC3,PC4,Active,CUser,CDate,MUser,MDate,POMTempID1,POMTempID2,POMTempID3,POMTempID4,WashType      
 FROM  pBody WITH (NOLOCK)    
 WHERE BodyID = @BodyID    
END      
  
BEGIN    
    
 INSERT INTO pBodyImage    
 (BodyID,SpecSketchID1,SpecSketchVersion1,SpecSketchID2,SpecSketchVersion2,SpecSketchID3,SpecSketchVersion3,SpecSketchID4,SpecSketchVersion4)    
 SELECT @NewBodyID,SpecSketchID1,SpecSketchVersion1,SpecSketchID2,SpecSketchVersion2,SpecSketchID3,SpecSketchVersion3,SpecSketchID4,SpecSketchVersion4   
 FROM pBodyImage WITH (NOLOCK)    
 WHERE BodyID = @BodyID    
    
END    
  
    
BEGIN    
    
DECLARE @BodyworkflowID uniqueidentifier
Set  @BodyworkflowID = newid()

 INSERT INTO pBodyWorkflow    
 (BodyworkflowID,BodyID,BodySet,WorkflowID,WorkDate,WorkStart,WorkDue,WorkAssignedTo,WorkStatus,WorkSort,CUser,CDate,MUser,MDate,WorkDay)    
 SELECT NEWID(), @NewBodyID As BodyID,BodySet,WorkflowID,WorkDate,WorkStart,WorkDue,WorkAssignedTo,WorkStatus,WorkSort,@CreatedBy AS CUser, @CreatedDate AS CDate, @CreatedBy AS MUser, @CreatedDate AS MDate ,WorkDay   
 FROM  pBodyWorkflow WITH (NOLOCK)    
 WHERE BodyID = @BodyID   

END    
    
    
    
/**************************************************************************************************************************************************************************************************************************************************************
  
*****************************************************    
-- INSERT LOG RECCORD     
***************************************************************************************************************************************************************************************************************************************************************
  
****************************************************/    
DECLARE @BodyNo NVARCHAR(20)    
DECLARE @Description NVARCHAR (4000)    
    
SELECT @BodyNo  = BodyNo      
FROM pBody WITH (NOLOCK) WHERE BodyID = @BodyID     
    
SET  @Description  = 'Body copied from body with BodyNo: '  +  @BodyNo      
     
INSERT INTO pBodyChange (BodyChangeID ,  BodyStatus ,  WorkflowID , BodyID , BodySet ,  BodyChangeNotifyTo , BodyChangeType,     
BodyChangeDescription ,  BodyChangeBy, BodyChangeDate,  ActiveID ,  Active  )     
VALUES  ( NEWID() ,   0 , '11111111-0000-0000-0000-000000000001' , @NewBodyID , 0 ,  '' , 'Information', @Description ,    
@CreatedBy,  @CreatedDate ,  '00000000-0000-0000-0000-000000000000'  , 1 )
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.0.0000', '01476', GetDate())

GO


