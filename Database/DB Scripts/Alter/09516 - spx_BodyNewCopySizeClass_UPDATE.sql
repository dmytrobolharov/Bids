IF OBJECT_ID(N'[dbo].[spx_BodyNewCopySizeClass_UPDATE]') IS NOT NULL
 DROP PROCEDURE [dbo].[spx_BodyNewCopySizeClass_UPDATE]
GO

CREATE PROCEDURE [dbo].[spx_BodyNewCopySizeClass_UPDATE] (      
@BodyID UNIQUEIDENTIFIER,       
@NewBodyID UNIQUEIDENTIFIER,       
@NewBodyDevelopmentID UNIQUEIDENTIFIER,       
@CreatedDate DATETIME,       
@CreatedBy NVARCHAR(200),      
@LinkImage INT,       
@CarryOver INT,       
      
@BodyTempID NVARCHAR(20),      
@BodyTempNo NVARCHAR(20),      
@BodyNo NVARCHAR(20),      
      
@DevelopmentTempID NVARCHAR(20),      
@DevelopmentTempNo NVARCHAR(20),      
@DevelopmentNo NVARCHAR(20) ,      
@DesignSketchID UNIQUEIDENTIFIER      
)      
AS      
BEGIN      
      
      
DECLARE @tmpBodyNo NVARCHAR(20),       
@tmpBodyTempID NVARCHAR(20),      
@tmpBodyTempNo NVARCHAR(20),       
@tmpNewBodyID UNIQUEIDENTIFIER       
      
      
SET @tmpBodyNo = @BodyNo      
SET @tmpBodyTempID =  @BodyTempID      
SET @tmpBodyTempNo = @BodyTempNo      
SET @tmpNewBodyID = @NewBodyID      
         
      
 DECLARE @BodyType AS NVARCHAR(5)      
 DECLARE @SizeRange AS NVARCHAR(200)      
       
 SELECT @BodyType = b.BodyType, @SizeRange = a.SizeRange      
 FROM  pBody a INNER JOIN pBodyType b ON a.BodyTypeID = b.BodyTypeID       
 WHERE a.BodyID = @BodyID       
      
      
 IF @BodyType = 'V'       
 BEGIN       
  EXEC dbo.spx_BodyDevelopmentCopy_INSERT  @BodyDevelopmentID = @NewBodyDevelopmentID ,       
   @BodyID = @NewBodyID,  @TempID = @DevelopmentTempID , @TempNo = @DevelopmentTempNo,      
   @BodyDevelopmentNo = @DevelopmentNo,       
   @SizeRange = @SizeRange ,  @CreatedBy = @CreatedBy , @CreatedDate = @CreatedDate      
      
      
  EXEC dbo.spx_BodyDevelopmentItemCopy_INSERT  @BodyDevelopmentID = @NewBodyDevelopmentID,       
   @BodyID = @NewBodyID ,        
   @TempID = @DevelopmentTempID , @TempNo = @DevelopmentTempNo,      
   @BodyDevelopmentNo = @DevelopmentNo,      
   @SizeRange = @SizeRange ,  @CreatedBy = @CreatedBy , @CreatedDate = @CreatedDate      
      
 END      
 ELSE      
 BEGIN      
      
  EXEC dbo.spx_BodyDevelopmentNew_INSERT @DevelopmentID = @NewBodyDevelopmentID ,       
   @BodyID = @NewBodyID,  @CUser = @CreatedBy , @CDate = @CreatedDate      
 END   
 
  UPDATE pBody SET BodyNo =  @BodyNo,   TempID = @BodyTempID ,   TempNo= @BodyTempNo WHERE BodyID = @NewBodyID    
   
--krishan comment right now not updating this value--      
-------- IF @LinkImage = 0       
-------- BEGIN      
--------      
--------  UPDATE pBody SET ImageID = @DesignSketchID , ImageVersion = 1       
--------  WHERE BodyID = @NewBodyID      
-------- END       
-- ELSE      
-- BEGIN      
  -- LINK Body DESIGN DETAIL IMAGES      
      
--  DECLARE @BodySet INT       
--      
--  SELECT @BodySet  = BodySet       
--  FROM pBodyHeader       
--  WHERE BodyID = @NewBodyID      
--      
--  IF @BodySet IS NULL      
--   SET @BodySet = 1       
--      
--  INSERT INTO pBodyImageItem  ( BodyImageItemID, BodyImageItemMasterID, WorkflowID , BodyID , BodySet, ImageID,       
--  ImageVersion, CUser, CDate, MUser, MDate, BodyImageLinked, Sort )           
--  SELECT NEWID() as BodyImageItemID , NEWID() as BodyImageItemMasterID, WorkflowID , @NewBodyID AS BodyID , BodySet,       
--  ImageID, ImageVersion, @CreatedBy AS CUser, @CreatedDate AS CDate, @CreatedBy AS MUser, @CreatedDate AS MDate, BodyImageLinked, Sort       
--  FROM pBodyImageItem       
--  WHERE BodyID = @BodyID AND BodySet <= @BodySet      
--  AND WorkflowID = '40000000-0000-0000-0000-000000000006'       
      
-- END       
      
      
 --EXEC spx_BodyImageItemVariation_SELECT @BodyId = @NewBodyID      
 --EXEC spx_BodyImageItemMasterId_UPDATE @BodyId = @NewBodyID      
 --EXEC spx_BodyMaterialMasterId_UPDATE @BodyId = @NewBodyID      
 --EXEC spx_BodyHeaderLogic_UPDATE @BodyId = @NewBodyID      
      
 -- Update SAPcode       
-- IF @CarryOver = 0      
-- BEGIN      
--  UPDATE pBodyColorway SET SAPCode  =  NULL      
--  WHERE BodyID  = @NewBodyID      
--      
--  -- Added by AG 20090827      
--  UPDATE pBodyHeader SET       
--  BodyNo = @tmpBodyNo,      
--  TempId = @tmpBodyTempID,       
--  TempNo = @tmpBodyTempNo      
--  WHERE BodyID = @tmpNewBodyID      
-- END       
      
      
 -- Update PLMCode       
-- EXEC spx_BodyColorway_PLMCode_UPDATE @NewBodyID, 0      
      
      
      
END


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09516', GetDate())
GO
