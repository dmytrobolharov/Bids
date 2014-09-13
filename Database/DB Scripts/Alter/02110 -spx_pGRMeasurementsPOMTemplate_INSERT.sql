SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.ROUTINES WHERE SPECIFIC_NAME = N'spx_pGRMeasurementsPOMTemplate_INSERT')
   DROP PROCEDURE spx_pGRMeasurementsPOMTemplate_INSERT
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Create PROCEDURE [dbo].[spx_pGRMeasurementsPOMTemplate_INSERT]
(	@POMTempID  uniqueidentifier,
	@POMTempGroupId  uniqueidentifier,
	@POMType nvarchar(100),
	@POMDesc nvarchar(200),
	@ClassRangeId nvarchar(50),
	@Relative int,
	@Negative int,
	@Metric int,
	@CUser nvarchar(200),
	@CDate datetime
)
as

Declare @SizeClassId nvarchar(50)
Declare @SizeRangeId nvarchar(50)
Declare @SizeClass nvarchar(200)
Declare @SizeRange nvarchar(200)

select @SizeClassId=SizeClassId, @SizeRangeId=SizeRangeId, @SizeClass=SizeClass, @SizeRange=SizeRange
from pGRMeasurementsClassRange where ClassRangeId=@ClassRangeId



INSERT INTO pGRMeasurementsPOMTemplateGroup
(POMTempGroupId, POMTempID, POMType, POMTypeDescription, SizeClassId, SizeRangeId, ClassRangeId, SizeClass
 ,SizeRange, ClassRange, [Relative], Negative, Metric, Active, Cuser, Cdate, Mdate, MUser)
values (@POMTempGroupId, @POMTempID, @POMType, @POMDesc           
       ,@SizeClassId
       ,@SizeRangeId
       ,@ClassRangeId
       ,@SizeClass
       ,@SizeRange    
       ,@SizeClass + ' (' +   @SizeRange + ')'  
       ,@Relative, @Negative, @Metric
       ,1                 
       ,@CUser
       ,@CDate
       ,@CDate
       ,@CUser          
       )

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
       )
 VALUES
       (@POMTempID    
       ,@POMTempGroupId               
       ,@POMType           
       ,@POMDesc           
       ,@SizeClassId
       ,@SizeRangeId
       ,@ClassRangeId
       ,@SizeClass
       ,@SizeRange    
       ,@SizeClass + ' (' +   @SizeRange + ')'                   
       ,@CUser
       ,@CDate
       ,@CDate
       ,@CUser          
       ,1
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
where SizeRangeId=@SizeRangeId and POMTempID=@POMTempID



GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='02110'))
	BEGIN
		INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
		VALUES ('DB_Version', '4.1.0000', '02110', GetDate())
	END
GO