SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.ROUTINES WHERE SPECIFIC_NAME = N'spx_pGRMeasurementsPOMTemplate_Add')
   DROP PROCEDURE spx_pGRMeasurementsPOMTemplate_Add
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


Create PROCEDURE [dbo].[spx_pGRMeasurementsPOMTemplate_Add]
(	@POMTempID  uniqueidentifier,
	@NewPOMTempID  uniqueidentifier,
	@POMTempGroupId  uniqueidentifier,	
	@SizeClassId nvarchar(50),
	@SizeRangeId nvarchar(50),	
	@CreatedBy nvarchar(200),
	@CreatedDate datetime
)
as


Declare @SizeClass nvarchar(200)
Declare @SizeRange nvarchar(200)
Declare @ClassRange nvarchar(400)
Declare @ClassRangeId nvarchar(50)
Declare @CopyClassRangeId nvarchar(50)
Declare @IsRelative int
Declare @Negative int
Declare @Metric int
Declare @POMType nvarchar(100)
Declare	@POMDesc nvarchar(200)
Declare @Custom1 nvarchar(50)
Declare @Custom2 nvarchar(50)
Declare @Custom3 nvarchar(50)
Declare @Custom4 nvarchar(50)
Declare @Custom5 nvarchar(50)

select @ClassRangeId=ClassRangeId , @SizeClass=SizeClass, @SizeRange=SizeRange
from pGRMeasurementsClassRange where SizeClassId=@SizeClassId and SizeRangeId=@SizeRangeId

select @POMType=POMType , @CopyClassRangeId=Classrangeid, @POMDesc=POMTypeDescription, @IsRelative=[Relative], @Negative=Negative, @Metric=Metric
from pGRMeasurementsPOMTemplateGroup where POMTempID=@POMTempID and POMTempGroupID=@POMTempGroupId

select @Custom1=COALESCE(CustomField1,'') , @Custom2=COALESCE(CustomField2,'') , @Custom3=COALESCE(CustomField3,'') , @Custom4=COALESCE(CustomField4,'') , @Custom5=COALESCE(CustomField5,'') 
from pGRMeasurementsPOMTemplate where POMTempID=@POMTempID and POMTempGroupID=@POMTempGroupId


set @ClassRange=@SizeClass + ' (' + @SizeRange + ')'

IF (SELECT COUNT(ClassRangeId)  AS CountSizeRage FROM  dbo.pGRMeasurementsPOMTemplateGroup WITH (NOLOCK) WHERE  (POMTempID = @PomTempID) AND (ClassRangeId=@ClassRangeId))  = 0 
	begin	
		INSERT INTO pGRMeasurementsPOMTemplateGroup
		(POMTempGroupId, POMTempID, POMType, POMTypeDescription, SizeClassId, SizeRangeId, ClassRangeId, SizeClass
		,SizeRange, ClassRange, [Relative], Negative, Metric, Active, Cuser, Cdate, Mdate, MUser)
		 values(@POMTempGroupId, @NewPOMTempID, @POMType, @POMDesc, @SizeClassId, 
		 @SizeRangeId, @ClassRangeId, @SizeClass
		,@SizeRange, @ClassRange, @IsRelative, @Negative, @Metric, 1, @CreatedBy, @CreatedDate, @CreatedDate, @CreatedBy) 			 	   

		INSERT INTO pGRMeasurementsPOMTemplate
		   (POMTempID
			,POMTempGroupId
		   ,POMType
		   ,POMTypeDescription     
		   ,SizeClassId
		   ,SizeRangeId
		   ,ClassRangeId
		   ,SizeClass
		   ,SizeRange  
		   ,ClassRange  
		   ,CUser
		   ,CDate
		   ,MDate
		   ,MUser     
		   ,Active
		   ,CustomField1,CustomField2,CustomField3,CustomField4,CustomField5
		   )
	 VALUES
		   (@NewPOMTempID    
		   ,@POMTempGroupId   
		   ,@POMType     
		   ,@POMDesc     
		   ,@SizeClassId
		   ,@SizeRangeId
		   ,@ClassRangeId
		   ,@SizeClass
		   ,@SizeRange    
		   ,@ClassRange
		   ,@CreatedBy
		   ,@CreatedDate
		   ,@CreatedDate
		   ,@CreatedBy    
		   ,1
		   ,@Custom1,@Custom2,@Custom3,@Custom4,@Custom5
		   )


Update pGRMeasurementsPOMTemplate set size0=s.size0, size1=s.size1, size2=s.size2, size3=s.size3 , size4=s.size4 , size5=s.size5
, size6=s.size6 , size7=s.size7 , size8=s.Size8, size9=s.size9 , size10=s.Size10,
size11=s.size11, size12=s.size12, size13=s.size13 , size14=s.size14 , size15=s.size15
, size16=s.size16 , size17=s.size17 , size18=s.Size18, size19=s.size19 , size20=s.Size20,
size21=s.size21, size22=s.size22, size23=s.size23 , size24=s.size24 , size25=s.size25
,size26=s.size26 , size27=s.size27 , size28=s.Size28, size29=s.size29 , size30=s.Size30,
size31=s.size31, size32=s.size32, size33=s.size33 , size34=s.size34 , size35=s.size35
, size36=s.size36 , size37=s.size37 , size38=s.Size38, size39=s.size39 , size40=s.Size40,
size41=s.size41, size42=s.size42, size43=s.size43 , size44=s.size44 , size45=s.size45
, size46=s.size46 , size47=s.size47 , size48=s.Size48, size49=s.size49  
FROM  pGRMeasurementsPOMTemplate p INNER JOIN psizerange s ON SizeRangeId = s.CustomId
and SizeRange = s.SizeRangeCode
where SizeRangeId=@SizeRangeId and POMTempID=@NewPOMTempID and  ClassRangeId=@ClassRangeId


-- No grades copied
INSERT INTO pGRMeasurementsPOMTemplateItem
(POMTempGroupId, POMTempID, SizeClassId, SizeRangeId, ClassRangeId, ImageId,
POMID, AlternatesId, POMAlternatesId, IsOnQA, IsLinked, FitComId, Critical, POMCode, POMDesc, AlternatesCode, 
AlternatesDesc, How2MeasText, How2MeasName, POMSort, alternatesSort, Active, CopyPOMTempItemID,
TolPlus,TolMinus , Cuser, Cdate, Mdate, MUser)
select @POMTempGroupId, @NewPOMTempID, @SizeClassId, @SizeRangeId, @ClassRangeId,
ImageId, POMID, AlternatesId, POMAlternatesId, IsOnQA, IsLinked, FitComId, Critical, POMCode, POMDesc, AlternatesCode, 
AlternatesDesc, How2MeasText, How2MeasName, POMSort, AlternatesSort, Active, POMTempItemID,
TolPlus,TolMinus , @CreatedBy, @CreatedDate, @CreatedDate , @CreatedBy   from  pGRMeasurementsPOMTemplateItem  WITH (NOLOCK)
where POMTempGroupId=@POMTempGroupId and POMTempID=@POMTempID and  ClassRangeId=@CopyClassRangeId

/* For copying grades as well
INSERT INTO pGRMeasurementsPOMTemplateItem
(POMTempGroupId, POMTempID, SizeClassId, SizeRangeId, ClassRangeId, ImageId,
POMID, AlternatesId, POMAlternatesId, IsOnQA, IsLinked, FitComId, Critical, POMCode, POMDesc, AlternatesCode, 
AlternatesDesc, How2MeasText, How2MeasName, POMSort, alternatesSort, Active, CopyPOMTempItemID,
TolPlus,TolMinus ,Incr0,Incr1,Incr2,Incr3,Incr4,Incr5,Incr6
,Incr7,Incr8,Incr9,Incr10,Incr11,Incr12,Incr13,Incr14,Incr15,Incr16,Incr17,Incr18,Incr19,Incr20,Incr21
,Incr22,Incr23,Incr24,Incr25,Incr26,Incr27,Incr28,Incr29,Incr30,Incr31,Incr32,Incr33,Incr34,Incr35
,Incr36,Incr37,Incr38,Incr39,Incr40,Incr41,Incr42  ,Incr43,Incr44,Incr45,Incr46,Incr47
,Incr48,Incr49, Cuser, Cdate, Mdate, MUser)
select @POMTempGroupId, @NewPOMTempID, @SizeClassId, @SizeRangeId, @ClassRangeId,
ImageId, POMID, AlternatesId, POMAlternatesId, IsOnQA, IsLinked, FitComId, Critical, POMCode, POMDesc, AlternatesCode, 
AlternatesDesc, How2MeasText, How2MeasName, POMSort, AlternatesSort, Active, POMTempItemID,
TolPlus,TolMinus ,Incr0,Incr1,Incr2,Incr3,Incr4,Incr5,Incr6
,Incr7,Incr8,Incr9,Incr10,Incr11,Incr12,Incr13,Incr14,Incr15,Incr16,Incr17,Incr18,Incr19,Incr20,Incr21
,Incr22,Incr23,Incr24,Incr25,Incr26,Incr27,Incr28,Incr29,Incr30,Incr31,Incr32,Incr33,Incr34,Incr35
,Incr36,Incr37,Incr38,Incr39,Incr40,Incr41,Incr42  ,Incr43,Incr44,Incr45,Incr46,Incr47
,Incr48,Incr49, @CreatedBy, @CreatedDate, @CreatedDate , @CreatedBy   from  pGRMeasurementsPOMTemplateItem  WITH (NOLOCK)
where POMTempGroupId=@POMTempGroupId and POMTempID=@POMTempID and  ClassRangeId=@CopyClassRangeId
*/
 




end

 GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='02115'))
	BEGIN
		INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
		VALUES ('DB_Version', '4.1.0000', '02115', GetDate())
	END
GO