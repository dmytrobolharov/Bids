IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.ROUTINES WHERE SPECIFIC_NAME = N'spx_pGRMeasurementsPOMTemplate_INSERT_Yunify')
   DROP PROCEDURE spx_pGRMeasurementsPOMTemplate_INSERT_Yunify
GO


Create PROCEDURE spx_pGRMeasurementsPOMTemplate_INSERT_Yunify
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
Declare @IncrCols nvarchar(2000)
Declare @Maxcount int
Declare @RowCnt int
DECLARE @query NVARCHAR(max)
Declare @sTemplatecol nvarchar(3)

set @Maxcount=49
set @RowCnt =0
set @IncrCols = ''

select @SizeClassId=SizeClassId, @SizeRangeId=SizeRangeId, @SizeClass=SizeClass, @SizeRange=SizeRange
from pGRMeasurementsClassRange where ClassRangeId=@ClassRangeId

--Get Template samplesizecolumn
WHILE @RowCnt <= @Maxcount
	begin
		set @IncrCols = @IncrCols + 'Sel' + convert(nvarchar(3), @RowCnt) + ','				
		set @RowCnt = @RowCnt + 1
	end	
	if right(@IncrCols,1)=',' set @IncrCols=substring(@IncrCols, 1, len(@IncrCols)-1)		
	
CREATE TABLE tempSampleSize (
			 sizeRowid int NOT NULL IDENTITY (0, 1)				 
			 ,SizeRangeId UNIQUEIDENTIFIER	
			 ,SizeRange nvarchar(50)			 
			 ,Sampleid nvarchar(10)
			 ,SampleSel int	
			 )	
			 		 
SET @query = N'select SizeRangeId, SizeRange ,Sampleid, SampleSel
from 
	(select CustomId as SizeRangeId, SizeRangeCode as SizeRange ,  ' + @IncrCols + ' from pSizeRange
	 where CustomId = ''' + convert(nvarchar(50),@SizeRangeId) + ''' and SizeRangeCode = ''' + convert(nvarchar(50),@SizeRange) + ''') p 
	 unpivot
    (SampleSel For Sampleid in (' + @IncrCols + ')) as unpvt where SampleSel=1 ;'

--select @query as igcqry

INSERT tempSampleSize EXEC (@query) 
--select * from tempSampleSize

select @sTemplatecol = substring(Sampleid,4,LEN(Sampleid)) from tempSampleSize

drop table tempSampleSize

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
       ,samplesize                   
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
       ,@sTemplatecol           
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


IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.ROUTINES WHERE SPECIFIC_NAME = N'spx_pGRMeasurementsPOMTemplate_Add_Yunify')
   DROP PROCEDURE spx_pGRMeasurementsPOMTemplate_Add_Yunify
GO



create PROCEDURE [dbo].[spx_pGRMeasurementsPOMTemplate_Add_Yunify]
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
Declare @Maxcount int
Declare @RowCnt int
DECLARE @query NVARCHAR(max)
Declare @sTemplatecol nvarchar(3)
Declare @IncrCols nvarchar(2000)

set @Maxcount=49
set @RowCnt =0
set @IncrCols =''
select @ClassRangeId=ClassRangeId , @SizeClass=SizeClass, @SizeRange=SizeRange
from pGRMeasurementsClassRange where SizeClassId=@SizeClassId and SizeRangeId=@SizeRangeId

select @POMType=POMType , @CopyClassRangeId=Classrangeid, @POMDesc=POMTypeDescription, @IsRelative=[Relative], @Negative=Negative, @Metric=Metric
from pGRMeasurementsPOMTemplateGroup where POMTempID=@POMTempID and POMTempGroupID=@POMTempGroupId

select @Custom1=COALESCE(CustomField1,'') , @Custom2=COALESCE(CustomField2,'') , @Custom3=COALESCE(CustomField3,'') , @Custom4=COALESCE(CustomField4,'') , @Custom5=COALESCE(CustomField5,'') 
from pGRMeasurementsPOMTemplate where POMTempID=@POMTempID and POMTempGroupID=@POMTempGroupId


set @ClassRange=@SizeClass + ' (' + @SizeRange + ')'

WHILE @RowCnt <= @Maxcount
	begin
		set @IncrCols = @IncrCols + 'Sel' + convert(nvarchar(3), @RowCnt) + ','				
		set @RowCnt = @RowCnt + 1
	end	
	if right(@IncrCols,1)=',' set @IncrCols=substring(@IncrCols, 1, len(@IncrCols)-1)		
	
CREATE TABLE tempSampleSize (
			 sizeRowid int NOT NULL IDENTITY (0, 1)				 
			 ,SizeRangeId UNIQUEIDENTIFIER	
			 ,SizeRange nvarchar(50)			 
			 ,Sampleid nvarchar(10)
			 ,SampleSel int	
			 )	
			 		 
SET @query = N'select SizeRangeId, SizeRange ,Sampleid, SampleSel
from 
	(select CustomId as SizeRangeId, SizeRangeCode as SizeRange ,  ' + @IncrCols + ' from pSizeRange
	 where CustomId = ''' + convert(nvarchar(50),@SizeRangeId) + ''' and SizeRangeCode = ''' + convert(nvarchar(50),@SizeRange) + ''') p 
	 unpivot
    (SampleSel For Sampleid in (' + @IncrCols + ')) as unpvt where SampleSel=1 ;'

--select @query as igcqry

INSERT tempSampleSize EXEC (@query) 
--select * from tempSampleSize

select @sTemplatecol = substring(Sampleid,4,LEN(Sampleid)) from tempSampleSize

drop table tempSampleSize

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
		   ,samplesize     
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
		   ,@sTemplatecol
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






IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.ROUTINES WHERE SPECIFIC_NAME = N'wpx_pSizeClass_Yunify_IMPORT')
   DROP PROCEDURE wpx_pSizeClass_Yunify_IMPORT
GO

CREATE PROCEDURE [wpx_pSizeClass_Yunify_IMPORT]
(
	@CUser NVARCHAR(200)
)
AS

SET NOCOUNT ON
BEGIN

     UPDATE pGRSizeClass
        SET FlatSizeClassId = SizeClassGuidId
     
     UPDATE pGRSizeClass
        SET FlatSizeClassId = (SELECT CustomID
                                 FROM pSizeClass
                                WHERE pSizeClass.Custom = pGRSizeClass.SizeClass)
      WHERE SizeClass in (SELECT Custom from pSizeClass)

     INSERT INTO pSizeClass ( [CustomID]
                             ,[Custom]
                             ,[CustomKey]
                             ,[CustomSort]
                             ,[NewStyle]
                             ,[TableRelation]
                             ,[Active]
                             ,[CUser]
                             ,[CDate]
                             ,[MUser]
                             ,[MDate]
                             ,[SpecConversion]
                             ,[StyleCosting] )
     SELECT [FlatSizeClassId] as Customid
           ,[SizeClass] as Custom
           ,Null as CustomKey
           ,Null as CustomSort
           ,0 as NewStyle
           ,Null as TableRelation
           ,1 as Active
           ,[CUser]
           ,[CDate]
           ,[Muser]
           ,[MDate]
           ,0 as SpecConversion
           ,1 as StyleCosting
     FROM pGRSizeClass
     WHERE SizeClass not in (SELECT Custom from pSizeClass)

     UPDATE pGRSizeClassCompany
        SET FlatSizeClassId = (SELECT FlatSizeClassId
                                 FROM PGRSizeClass
                                WHERE SizeClassGuidId = pGRSizeClassCompany.SizeClassGuidId)

END
GO

IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.ROUTINES WHERE SPECIFIC_NAME = N'wpx_pSizeRange_Yunify_IMPORT')
   DROP PROCEDURE wpx_pSizeRange_Yunify_IMPORT
GO

CREATE PROCEDURE [wpx_pSizeRange_Yunify_IMPORT]
(
	@CUser NVARCHAR(200)
)
AS

DECLARE @SizeRangeId uniqueidentifier
DECLARE @SizeRangeIdvalue nvarchar(48)
DECLARE   @SizeCount int
DECLARE    @SizeName nvarchar(50)
DECLARE      @Sample int
DECLARe @SAMPLEValue NVARCHAR(1)

DECLARE @RealCount int

DECLARE @SizeCol   nvarchar(9)
DECLARE @SelCol    nvarchar(9)

DECLARE @RowCount int
DECLARe @SizeRangeGuidId uniqueidentifier
DECLARe @SaveRangeGuidId uniqueidentifier
DECLARe @SaveClassGuidId uniqueidentifier
DECLARE @FlatSizeRangeId uniqueidentifier
DECLARE @XFER2SizeRange int

DECLARE @SizeRange NVARCHAR(60)


DECLARE @ParamDefinitions NVARCHAR(4000)
DECLARE @MYSQL            NVARCHAR(4000)

SET NOCOUNT ON
BEGIN

    UPDATE pGRSizeRange
        SET IsClassRange0 = 1

     UPDATE pGRSizeRange
        SET IsClassRange0 = 0
     WHERE SizeRangeGuidId in (SELECT DISTINCT SizeRangeId 
                                           FROM  pGRSizeRangeDetail
                                           WHERE  ClassRangeID <> '00000000-0000-0000-0000-000000000000')

    DECLARE UniqueSizeRanges INSENSITIVE CURSOR
            FOR SELECT DISTINCT SizeRange
                  FROM pGRSizeRange
                 WHERE IsClassRange0 = 0
              ORDER BY SizeRange
            FOR READ ONLY

     DECLARE SizeRangeD INSENSITIVE CURSOR
            FOR SELECT FinalSizeRangeId,SizeCount,SizeName,Sample
                  FROM pGRSizeRangeDetail
                 WHERE ClassRangeId <> '00000000-0000-0000-0000-000000000000'
                   AND XFER2SizeRange = 1
              ORDER BY SizeRangeId,SizeCount
            FOR READ ONLY 

     UPDATE pGRSizeRange
        SET FlatSizeRangeId = SizeRangeGuidId

     UPDATE pGRSizeRange
        SET FlatSizeRangeId = (SELECT CustomId
                                 FROM pSizeRange
                                WHERE SizeRangeCode = pGRSizeRange.SizeRange)
      WHERE SizeRange IN (SELECT SizeRangeCode  from pSizeRange)
     

      OPEN UniqueSizeRanges

      FETCH NEXT FROM UniqueSizeRanges INTO @SizeRange

      UPDATE pGRSizeRange
         SET XFER2SizeRange = 0

      WHILE @@FETCH_STATUS = 0
      BEGIN
           DECLARE IndivSizeRanges INSENSITIVE CURSOR
               FOR SELECT SizeRangeGuidId, SizeClassGuidIdXX
                     FROM pGRSizeRange
                    WHERE IsClassRange0 = 0
                      AND SizeRange = @SizeRange
              ORDER BY SizeRangeGuidId
            FOR READ ONLY

            SET @RowCount = 1
            SET @SaveRangeGuidId = Null

            OPEN IndivSizeRanges
            FETCH NEXT FROM IndivSizeRanges INTO @SizeRangeGuidId, @SaveClassGuidId
            WHILE @@FETCH_STATUS = 0
            BEGIN 
                 IF @RowCount = 1
                    BEGIN
                          SET @SaveRangeGuidId = (SELECT FlatSizeRangeId
                                                    FROM pGRSizeRange
                                                   WHERE SizeRangeGuidId = @SizeRangeGuidId)
                          
                          SET @FlatSizeRangeId  = @SaveRangeGuidId

                          SET @XFER2SizeRange = 1

                          IF @FlatSizeRangeId <> @SizeRangeGuidId
                             BEGIN
                                   SET @XFER2SizeRange = 0
                             END

                          UPDATE pGRSizeRange
                             SET FinalSizeRangeId  = @SaveRangeGuidId
                                ,XFER2SizeRange    = @XFER2SizeRange
                           WHERE SizeRangeGuidId   = @SizeRangeGuidId
                    END
                 ELSE
                    BEGIN

                          SET @XFER2SizeRange = 0

                          UPDATE pGRSizeRange
                             SET FinalSizeRangeId  = @SaveRangeGuidId
                                ,XFER2SizeRange    = @XFER2SizeRange
                           WHERE SizeRangeGuidId   = @SizeRangeGuidId
                    END

                 SET @RowCount = @RowCount + 1

                 FETCH NEXT FROM IndivSizeRanges INTO @SizeRangeGuidId ,@SaveClassGuidId         


            END
            CLOSE      IndivSizeRanges
            DEALLOCATE IndivSizeRanges

            SET @RowCount = 1

            FETCH NEXT FROM UniqueSizeRanges INTO @SizeRange  

        END 

      CLOSE      UniqueSizeRanges
      DEALLOCATE UniqueSizeRanges

  
     --
     -- Now move in SizeRange records kcj
     --

    INSERT INTO pSizeRange ( SizeRangeCode, CustomId, CUser, CDate, MUser, MDate, Active)
     SELECT  PGS.[SizeRange]
            ,PGS.[FinalSizeRangeId]
            ,PGS.[CUser]
            ,PGS.[CDate]
            ,PGS.[MUser]
            ,PGS.[MDate]
            ,PGS.[Active]
       FROM pGRSizeRange PGS
      WHERE XFER2SizeRange = 1
        AND IsClassRange0  = 0

         --  ,pGRSizeClass GSC 
         --  ,pGRClassRange PGCR
        --   ,pGRSizeClassCompany PGSC
         --  ,pGRCompany PCOMP
      -- WHERE PGS.SizeRangeGuidId in (SELECT SizeRangeId 
      --                            FROM pGRSizeRangeDetail
      --                           WHERE ClassRangeId <> '00000000-0000-0000-0000-000000000000')
      --   AND PGS.SizeClassGuidIdXX    = GSC.SizeClassGuidId
      --   AND PGS.SizeClassGuidIdXX   = PGCR.SizeClassGuidId
      --   AND PGS.SizeRangeGuidId     = PGCR.SizeRangeGuidId
      --   AND PGCR.SizeClassCompanyId = PGSC.SizeClassCompanyId
      --we   AND PGSC.CompanyGuidId      = PCOMP.CompanyGuidID

      SET @ParamDefinitions = N'@Sizename_INPUT NVARCHAR(50) '


      UPDATE pGRSizeRangeDetail
         SET FinalSizeRangeId = (SELECT FinalSizeRangeId 
                                   FROM pGRSizeRange
                                  WHERE SizeRangeGuidId = pGRSizeRangeDetail.SizeRangeId)
            ,XFER2SizeRange   = (SELECT XFER2SizeRange
                                   FROM pGRSizeRange
                                  WHERE SizeRangeGuidId = pGRSizeRangeDetail.SizeRangeId)

      OPEN  SizeRangeD

      FETCH NEXT FROM SizeRangeD INTO @SizeRangeId, @SizeCount, @SizeName, @Sample

      WHILE @@FETCH_STATUS = 0
      BEGIN  
            SET @RealCount = @SizeCount - 1
            SET @SizeCol = 'Size' + CAST(@RealCount as nvarchar(2))
            SET @SelCol  = 'Sel'  + CAST(@RealCount as nvarchar(2))
            SET @SAMPLEValue = CAST(@Sample as nvarchar(1))
            SET @SizeRangeIdvalue = cast(@SizeRangeId  as nvarchar(48))

            SET @MYSQL = 'UPDATE pSizeRange'
            SET @MYSQL =  @MYSQL + ' SET ' + @SizeCol + ' = @Sizename_INPUT '
            SET @MYSQL =  @MYSQL + ', ' + @SelCol + ' = ' + @SAMPLEValue + ' '
            SET @MYSQL =  @MYSQL + 'WHERE CustomId =  ' + char(39) + @SizeRangeIdvalue + char(39)

            EXECUTE sp_executesql @MYSQL 
                                , @ParamDefinitions
                                , @Sizename_INPUT     = @SizeName

            FETCH NEXT FROM SizeRangeD INTO @SizeRangeId, @SizeCount, @SizeName, @Sample

      END -- End of while loop

      CLOSE      SizeRangeD
      DEALLOCATE SizeRangeD

      DECLARE @MySizeClass nvarchar(100)
      DECLARE @MySizeRange nvarchar(100)
      DECLARE @SaveMySizeClass nvarchar(100)
      DECLARE @SaveMySizeRange nvarchar(100)
      DECLARE @pg1sizerangeguidid  uniqueidentifier
      DECLARE @sc1sizeclassguidid  uniqueidentifier


      DECLARE RightOrder INSENSITIVE CURSOR
      FOR  select sc1.sizeclass ,pg1.sizerange , pg1.sizerangeguidid, sc1.sizeclassguidid
           from pgrsizerange pg1, pgrsizeclass sc1
           where isclassrange0 = 0
           and pg1.sizeclassguididxx = sc1.sizeclassguidid
           order by  pg1.sizerange ,sc1.sizeclassguidid
      FOR READ ONLY

      OPEN RightOrder

      UPDATE pGRSizeRange
         SET XFER2SizeRange = 0

      SET @SaveMySizeClass  = '1111111111111111111111111'
      SET @SaveMySizeRange  = '1111111111111111111111111'

      FETCH NEXT FROM  RightOrder INTO @MySizeClass, @MySizeRange, @pg1sizerangeguidid  , @sc1sizeclassguidid

      WHILE @@FETCH_STATUS = 0
      BEGIN

            IF (@SaveMySizeClass <> @MySizeClass OR @SaveMySizeRange <> @MySizeRange)
               BEGIN
                     SET @SaveMySizeClass = @MySizeClass
                     SET @SaveMySizeRange = @MySizeRange

                     UPDATE pGRSizeRange
                            SET XFER2SizeRange = 1
                     WHERE sizerangeguidid = @pg1sizerangeguidid
               END

            FETCH NEXT FROM  RightOrder INTO @MySizeClass, @MySizeRange, @pg1sizerangeguidid  , @sc1sizeclassguidid 
      END -- End of while loop

      CLOSE      RightOrder
      DEALLOCATE RightOrder



END
GO



IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.ROUTINES WHERE SPECIFIC_NAME = N'wpx_pGRMeasurementsAlternates_Yunify_IMPORT')
   DROP PROCEDURE wpx_pGRMeasurementsAlternates_Yunify_IMPORT
GO

CREATE PROCEDURE [wpx_pGRMeasurementsAlternates_Yunify_IMPORT]

(
	@CUser NVARCHAR(200)
)
AS
BEGIN
        SET NOCOUNT ON

   --       UPDATE pGRAlternates
   --          SET MAPAlternatesId = AlternatesGuidId
   
  --         UPDATE pGRAlternates
  --            SET MAPAlternatesId = (SELECT AlternatesGuidId
  --                          FROM pGRAlternates
  --                         WHERE (AlternatesCode is NULL or AlternatesCode = '')
  --                               and AlternatesDesc = 'NONE')
  --          WHERE ltrim(rtrim(AlternatesCode)) = 'N'
  --            and ltrim(rtrim(AlternatesDesc)) = 'None'

 --          UPDATE pgrpomalternates
 --                 SET MAPAlternatesId = (SELECT MAPAlternatesId
 --                                          FROM pGRAlternates
 --                                         WHERE pGRAlternates.AlternatesGuidId =  pgrpomalternates.AlternatesGuidId) 

      INSERT INTO pGRMeasurementsAlternates
           ([AlternatesId]
           ,[AlternatesCode]
           ,[AlternatesDesc]
           ,[Sort]
           ,[Active]
           ,[CUser]
           ,[CDate]
           ,[Muser]
           ,[MDate])
      SELECT [AlternatesGuidId]
      ,[AlternatesCode]
      ,[AlternatesDesc]
      ,[GTSortField]
      , 1 as Active
      ,[CUser]
      ,[CDate]
      ,[Muser]
      ,[MDate]
  FROM [pGRAlternates]

END
GO


IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.ROUTINES WHERE SPECIFIC_NAME = N'wpx_pGRMeasurementsClassRange_Yunify_IMPORT')
   DROP PROCEDURE wpx_pGRMeasurementsClassRange_Yunify_IMPORT
GO

CREATE PROCEDURE [wpx_pGRMeasurementsClassRange_Yunify_IMPORT]
(
	@CUser NVARCHAR(200)
)
AS

DECLARe @SizeClass        NVARCHAR(60)
DECLARE @SizeRange        NVARCHAR(60)
DECLARe @SaveSizeClass    NVARCHAR(60)
DECLARE @SaveSizeRange    NVARCHAR(60)
DECLARE @ClassRangeId     uniqueidentifier
DECLARE @SaveClassRangeId uniqueidentifier


DECLARE @RowCount int
DECLARE @XFER2Flat int

SET NOCOUNT ON
BEGIN

     UPDATE pGRClassRange
        SET FlatSizeClassId = (SELECT FlatSizeClassID
                                 FROM PGRSizeClass
                                WHERE SizeClassGuidId = pGRClassRange.SizeClassGuidId)
     WHERE SizeClassGuidId IS NOT NULL

     UPDATE pGRClassRange
        SET FlatSizeRangeId = (SELECT FinalSizeRangeId
                                 FROM PGRSizeRange
                                WHERE SizeRangeGuidId = pGRClassRange.SizeRangeGuidId
                                  AND IsClassRange0 = 0)
     WHERE SizeRangeGuidId IS NOT NULL
       AND SizeRangeGuidId IN (SELECT SizeRangeGuidId
                                 FROM PGRSizeRange
                                WHERE IsClassRange0 = 0 )

     UPDATE pGRClassRange
        SET XFER2Flat = 0


     DECLARE UniqueSizeRanges INSENSITIVE CURSOR
            FOR select psc.SizeClass as c1,pcr.SizeRange as c2, pcr.ClassRangeId
                       from pGRClassRange pcr inner join pGRSizeClass psc
                       on pcr.SizeClassGuidId =psc.SizeClassGuidId
                       inner join pGRSizeRange pgr on pgr.SizeRangeGuidId = pcr.SizeRangeGuidId
                       order by 1,2
            FOR READ ONLY

     SET @SaveSizeClass     = '111111111111111'
     SET @SaveSizeRange     = '111111111111111'
     SET @SaveClassRangeId  = '00000000-0000-0000-0000-000000000000'

     OPEN UniqueSizeRanges

     FETCH NEXT FROM UniqueSizeRanges INTO @SizeClass ,@SizeRange ,@ClassRangeId

     UPDATE pGRSizeRange
        SET XFER2SizeRange = 0

     WHILE @@FETCH_STATUS = 0
      BEGIN

           IF ( @SizeClass <> @SaveSizeClass OR @SizeRange <> @SaveSizeRange )
              BEGIN
                       SET @SaveSizeClass     = @SizeClass
                       SET @SaveSizeRange     = @SizeRange
                       SET @SaveClassRangeId  = @ClassRangeId
                       SET @XFER2Flat         = 1
              END
          ELSE
              BEGIN
                       SET @XFER2Flat         = 0
              END

          UPDATE pGRClassRange
             SET FlatClassRangeId = @SaveClassRangeId
                ,XFER2Flat =  @XFER2Flat            
           WHERE ClassRangeId     =  @ClassRangeId


           FETCH NEXT FROM UniqueSizeRanges INTO  @SizeClass ,@SizeRange ,@ClassRangeId
      END

     CLOSE      UniqueSizeRanges
     DEALLOCATE UniqueSizeRanges

     INSERT INTO pGRMeasurementsClassRange ([ClassRangeId]
                                           ,[SizeClassId]
                                           ,[SizeRangeId]
                                           ,[SizeClass]
                                           ,[SizeRange]
                                           ,[Active]
                                           ,[IsLinked]
                                           ,[CUser]
                                           ,[CDate]
                                           ,[MUser]
                                           ,[MDate] )
      SELECT pgr.[FlatClassRangeId]   as ClassRangeId
            ,pgr.[FlatSizeClassId]    as SizeClassId
            ,pgr.[FlatSizeRangeId]    as SizeRangeId
            ,pgc.SizeClass            as SizeClass
            ,PGr.SizeRange            as SizeRange
            ,1                        as Active -- used to be pgc.[Active] was always 0 tho.
            ,pgr.[IsLinked]           as IsLinked
            ,pgr.[CUser]              as CUser
            ,pgr.[CDate]              as CDate
            ,pgr.[MUser]              as MUser
            ,pgr.[MDate]              as MDate
       FROM pGRClassRange PGR INNER JOIN pGRSizeClass PGC
     on PGR.FlatSizeClassId = PGC.FlatSizeClassId
      WHERE PGR.XFER2Flat = 1

END
GO



IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.ROUTINES WHERE SPECIFIC_NAME = N'wpx_pGRMeasurementsPOM_Yunify_IMPORT_new')
   DROP PROCEDURE wpx_pGRMeasurementsPOM_Yunify_IMPORT_new
GO

CREATE PROCEDURE [wpx_pGRMeasurementsPOM_Yunify_IMPORT_new]
(
	@CUser NVARCHAR(200)
)
AS

DECLARE @RefCode           NVARCHAR(12)
DECLARE @RowCount          int
DECLARE @POMGuidId         uniqueidentifier
DECLARE @POMDesc           nvarchar(100)
DECLARE @How2MeasName      nvarchar(128)
DECLARE @How2MeasText      nvarchar(500)
DECLARE @ImageSerialNumber int
DECLARE @Imageid          uniqueidentifier

DECLARE @SavePOMGuidId         uniqueidentifier
DECLARE @SavePOMDesc           nvarchar(100)
DECLARE @SaveHow2MeasName      nvarchar(128)
DECLARE @SaveHow2MeasText      nvarchar(500)
DECLARE @SaveImageSerialNumber int
DECLARE @SaveImageid          uniqueidentifier
DECLARE @SaveRefCode NVARCHAR(12)

DECLARE @FLATRefCode      nvarchar(12)
DECLARE @FlatPOMId        uniqueidentifier

DECLARE @POMExtent        nvarchar(2)
DECLARE @MyExtent         int
DECLARE @XferPOM          int

SET NOCOUNT ON
BEGIN

     UPDATE pGRPOM
        SET IsLibPOM = 0
           ,XferPOM = 0

     UPDATE pGRPOM
        SET IsLibPOM = 1
      WHERE CompanyGuidId = '00000000-0000-0000-0000-000000000000'


    
    UPDATE pgrpom
       SET How2MeasText = ''
     WHERE How2MeasText is null


    UPDATE pgrpom
       SET How2MeasName = ''
     WHERE How2MeasName is null

     DECLARE IndivPOMS INSENSITIVE CURSOR
      FOR SELECT RefCode,POMGuidId,POMDesc,How2MeasName,How2MeasText,ImageSerialNumber,ImageId
            FROM pGRPOM
            WHERE IsLibPOM = 1
           ORDER BY Refcode,POMDesc,How2MeasName,How2MeasText,ImageSerialNumber
          FOR READ ONLY

          SET @RowCount = 1
          SET @XferPOM  = 0

          OPEN IndivPOMS

          FETCH NEXT FROM IndivPOMS INTO @RefCode,@POMGuidId,@POMDesc,@How2MeasName,
                                         @How2MeasText,@ImageSerialNumber,@ImageId
               WHILE @@FETCH_STATUS = 0

               BEGIN
                    IF @RowCount = 1
                       BEGIN
                            SET @SaveRefCode            = @RefCode
                            SET @SavePOMGuidId          = @POMGuidId
                            SET @SavePOMDesc            = @POMDesc
                            SET @SaveHow2MeasName       = @How2MeasName
                            SET @SaveHow2MeasText       = @How2MeasText
                            SET @SaveImageSerialNumber  = @ImageSerialNumber
                            SET @SaveImageId            = @ImageId
                            SET @FLATRefCode            = @RefCode
                            SET @FlatPOMId              = @SavePOMGuidId
                            SET @MyExtent               = 0
                            SET @XferPOM                = 1
                       END
                    ELSE
                       BEGIN
                            IF @SaveRefCode <> @RefCode
                               BEGIN
                                    SET @MyExtent               = -1
                               END
                       
                            IF    (@SaveRefCode           = @RefCode
                               AND @SavePOMDesc           = @POMDesc
                               AND @SaveHow2MeasName      = @How2MeasName
                               AND @SaveHow2MeasText      = @How2MeasText
                               AND @SaveImageSerialNumber = @ImageSerialNumber )
                               BEGIN
                                    SET @FlatPOMId   = @SavePOMGuidId
                                    SET @XferPOM     = 0
                               END
                            ELSE
                               BEGIN
                                    SET @MyExtent    = @MyExtent + 1
                                    SET @POMExtent   = CAST(@MyExtent as nvarchar(2))
  
                                    SET @SaveRefCode            = @RefCode 
                                    SET @SavePOMGuidId          = @POMGuidId
                                    SET @SavePOMDesc            = @POMDesc
                                    SET @SaveHow2MeasName       = @How2MeasName
                                    SET @SaveHow2MeasText       = @How2MeasText
                                    SET @SaveImageSerialNumber  = @ImageSerialNumber
                                    SET @SaveImageId            = @ImageId
                                    
                                    IF @MyExtent = 0
                                       BEGIN
                                            SET @FLATRefCode            = @RefCode                                      
                                       END
                                    ELSE
                                      BEGIN
                                          SET @FLATRefCode            = @RefCode + '.' + @POMExtent                                      
                                      END
                                    SET @FlatPOMId              = @SavePOMGuidId
                                    SET @XferPOM                = 1
                               END

                       END

                    UPDATE pGRPOM
                       SET FlatPOMId   = @FlatPOMId
                          ,FLATRefCode = @FLATRefCode
                          ,XferPOM     = @XferPOM
                     WHERE POMGuidId   = @POMGuidId

                    FETCH NEXT FROM IndivPOMS INTO @RefCode,@POMGuidId,@POMDesc,@How2MeasName,
                                                   @How2MeasText,@ImageSerialNumber,@ImageId

                    SET @RowCount =  @RowCount + 1
               END

               CLOSE      IndivPOMS
               DEALLOCATE IndivPOMS

     UPDATE  pGRPOMAlternates
        SET FlatPOMID = (SELECT FlatPOMID
                           FROM pGRPOM
                          WHERE POMGuidId = pGRPOMAlternates.POMGuidId )
                                

    INSERT INTO pGRMeasurementsPOM ( [POMId]
                                    ,[POMCode]
                                    ,[POMDesc]
                                    ,[How2MeasName]
                                    ,[How2MeasText]
                                    ,[Sort]
                                    ,[Active]
                                    ,[ImageId]
                                    ,[CUser]
                                    ,[CDate]
                                    ,[Muser]
                                    ,[MDate] )
               SELECT [FlatPOMId]    as POMId
                     ,[FLATRefCode]  as POMCode
                     ,[POMDesc]      as POMDesc
                     ,[How2MeasName] as How2MeasName
                     ,[How2MeasText] as How2MeasText
                     ,[SortField]    as Sort
                     ,1              as Active
                     ,[ImageId]      as ImageId
                     ,[CUser]        as CUser
                     ,[CDate]        as CDate
                     ,[Muser]        as Muser
                     ,[MDate]        as MDate
                   FROM pGRPOM
                   WHERE XferPOM = 1
END
GO


IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.ROUTINES WHERE SPECIFIC_NAME = N'wpx_pGRMeasurementsPOMAlternates_Yunify_IMPORT')
   DROP PROCEDURE wpx_pGRMeasurementsPOMAlternates_Yunify_IMPORT
GO

CREATE PROCEDURE [wpx_pGRMeasurementsPOMAlternates_Yunify_IMPORT]
(
	@CUser NVARCHAR(200)
)
AS

DECLARE @CDate as datetime
DECLARE @AlternatesId uniqueidentifier

SET NOCOUNT ON
BEGIN

     SET @CDate = GetUTCDate()
     SET @AlternatesId = Null

     UPDATE pGRAlternates
        SET MAPAlternatesId = AlternatesGuidId
   
    -- UPDATE pGRAlternates
    --    SET MAPAlternatesId = (SELECT AlternatesGuidId
    --                        FROM pGRAlternates
    --                       WHERE (AlternatesCode is NULL or AlternatesCode = '')
    --                             and AlternatesDesc = 'NONE')
    -- WHERE ltrim(rtrim(AlternatesCode)) = 'N'
    --   and ltrim(rtrim(AlternatesDesc)) = 'None'

 
     INSERT INTO pGRMeasurementsPOMAlternates ([POMAlternatesId]
                                              ,[POMId]
                                              ,[AlternatesId]
                                              ,[POMCode]
                                              ,[POMDesc]
                                              ,[AlternatesCode]
                                              ,[AlternatesDesc]
                                              ,[Active]
                                              ,[POMSort]
                                              ,[AlternateSort]
                                              ,[ImageId]
                                              ,[How2MeasName]
                                              ,[How2MeasText]
                                              ,[IsLinked]
                                              ,[Cuser]
                                              ,[MUser]
                                              ,[CDate]
                                              ,[MDate] )  
           SELECT pga.[POMAlternatesId]  as POMAlternatesId
                 ,pom.[FlatPOMId]        as POMId
                 ,pga.[AlternatesGuidId] as AlternatesId
                 ,pom.FlatRefCode        as POMCode
                 ,pom.POMDesc            as POMDesc
                 ,pgga.AlternatesCode    as AlternatesCode
                 ,pgga.AlternatesDesc    as AlternatesDesc
                 ,1                      as Active
                 ,pom.SortField          as POMSort
                 ,pgga.GTSortField       as AlternateSort
                 ,pom.ImageId            as ImageId
                 ,pom.How2MeasName       as How2MeasName
                 ,pom.How2MeasText       as How2MeasText
                 ,0                      as IsLinked
                 ,@Cuser                 as Cuser
                 ,@CUser                 as MUser
                 ,@CDate                 as CDate
                 ,@CDate                 as MDate
         FROM pGRPOMAlternates pga  INNER JOIN pGRPOM pom
              ON pga.flatpomid = pom.FlatPOMId
              INNER JOIN pGRAlternates pgga
              on  pga.AlternatesGuidId = pgga.AlternatesGuidId
         WHERE pom.XferPom = 1
              order by 4

     

         /*
         SET @AlternatesId = (select TOP 1 AlternatesId
                                  from pGRMeasurementsPOMAlternates
                                 where (AlternatesCode = '' or AlternatesCode is null)
                                   and alternatesdesc = 'None')

         UPDATE pGRMeasurementsAlternates
            SET AlternatesId = '00000000-0000-0000-0000-000000000000'
          WHERE AlternatesId = @AlternatesId


         UPDATE pGRMeasurementsPOMAlternates
            SET AlternatesId = '00000000-0000-0000-0000-000000000000'
          WHERE AlternatesId = @AlternatesId
*/
    

END
GO


IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.ROUTINES WHERE SPECIFIC_NAME = N'wpx_pGRMeasurementsTempGroup_Yunify_IMPORT')
   DROP PROCEDURE wpx_pGRMeasurementsTempGroup_Yunify_IMPORT
GO

CREATE PROCEDURE [wpx_pGRMeasurementsTempGroup_Yunify_IMPORT]
(
	@CUser NVARCHAR(200)
)
AS

DECLARE @POMTempGroupItemID     uniqueidentifier
DECLARE @POMTypeDescription     nvarchar(200)
DECLARE @SavePOMTypeDescription nvarchar(200)
DECLARE @RowNum                 int
DECLARE @IsDiff                 int
DECLARE @MYSQL                  nvarchar(4000)
DECLARE @SizeCount              int
DECLARE @MySizeCount            int
DECLARE @SizeName               nvarchar(50)
DECLARE @Sample                 int
DECLARE @SizeCol                nvarchar(8)
DECLARE @POMTempID_String       nvarchar(40)
DECLARE @ParamDefinitions       nvarchar(4000)

DECLARE @rowcounter             int

DECLARE @maximumrows            int

DECLARE @SavePOMType            nvarchar(100)
DECLARE @SavePOMDesc            nvarchar(100)

DECLARE @myrownumber            int
DECLARE @POMTempID              uniqueidentifier
DECLARE @POMTempGroupId         uniqueidentifier
DECLARE @POMType                nvarchar(100)
DECLARE @POMDesc                nvarchar(100)
DECLARE @ClassRangeId           uniqueidentifier
DECLARE @Relative               int
DECLARE @Negative               int
DECLARE @Metric                 int
DECLARe @CUser1                 nvarchar(200)
DECLARE @CDate                  datetime
DECLARE @MyCompany              nvarchar(60)
DECLARE @CompanyGuidId          uniqueidentifier
DECLARE @NewPOMTempID           uniqueidentifier
DECLARE @SizeRangeId            uniqueidentifier
DECLARE @SizeClassId            uniqueidentifier
DECLARE @ProductCompanyId       uniqueidentifier

DECLARE @POMTempItemID          uniqueidentifier

DECLARE @T2POMTempId           uniqueidentifier
DECLARE @T2POMId               uniqueidentifier
DECLARE @T2AlternatesId        uniqueidentifier
DECLARE @T2POMAlternatesId     uniqueidentifier
DECLARE @T2SizeClassId         uniqueidentifier
DECLARE @T2SizeRangeId         uniqueidentifier
DECLARE @T2ClassRangeId        uniqueidentifier
DECLARE @T2mycount             int

DECLARE @MYPOMTempGroupId           uniqueidentifier
DECLARE @MYPOMTempId           uniqueidentifier

DECLARE @ProductClassImageId   uniqueidentifier
DECLARE @MYFlatClassRangeId uniqueidentifier
DECLARE @MYFlatSizeClassId uniqueidentifier
DECLARE @MYFlatSizeRangeId uniqueidentifier


SET NOCOUNT ON
BEGIN

 INSERT INTO iCustom1 ([CustomId]
                      ,[Custom]
                      ,[Active]
                      ,[CUser]
                      ,[CDate]
                      ,[MUser]
                      ,[MDate])
                SELECT [CompanyGuidID]
                      ,[Company]
                      ,[IsActive]
                      ,[CUser]
                      ,[CDate]
                      ,[Muser]
                      ,[MDate]
                  FROM pGRCompany
                  WHERE Company not in (select custom from iCustom1)

        UPDATE pGRProductCompany
           SET Company = (SELECT Company
                            FROM pGRCompany 
                           WHERE CompanyGuidID = pGRProductCompany.CompanyGuidID)

        UPDATE pGRProductClassImage
           SET FlatSizeClassId = (SELECT FlatSizeClassId
                                  FROM pGRSizeClass
                                  WHERE SizeClassGuidId = pGRProductClassImage.SizeClassGuidId )


        --
        -- This section handle templates and template groups....
        --

        CREATE TABLE TempMeas1 ( myrownumber int identity(1,1) not null
                                ,CompanyGuidId uniqueidentifier
                                ,productcompanyid uniqueidentifier
                                ,productid uniqueidentifier 
                                ,POMType nvarchar(100)
                                ,POMDesc nvarchar(100)
                                ,ClassRangeId uniqueidentifier
                                ,[Relative] int
                                ,Negative   int
                                ,Metric int
                                ,Cuser nvarchar(25)
                                ,CDate datetime )

        UPDATE pGRSizeClassCompany
           SET Company     = (SELECT Company from pGRCompany WHERE CompanyGuidId = pGRSizeClassCompany.CompanyGuidId)
              ,IsRelative =  (SELECT IsRelative from pGRCompany WHERE CompanyGuidId = pGRSizeClassCompany.CompanyGuidId)
              ,IsNegative =  (SELECT IsNegative from pGRCompany WHERE CompanyGuidId = pGRSizeClassCompany.CompanyGuidId)
              ,IsMetric   =  (SELECT IsMetric from pGRCompany WHERE CompanyGuidId = pGRSizeClassCompany.CompanyGuidId)

         insert into TempMeas1 

/* original
         select pgc.CompanyGuidId
               ,pgc.ProductCompanyId
               ,pgc.productid
               ,SUBSTRING(pgc.Company + ' ' + pgc.Product,1,100) as POMType
               ,pgc.Product                                     as POMDesc 
               ,pran.flatclassrangeid                           as ClassRangeId
               ,pc.IsRelative                                   as [Relative]
               ,pc.IsNegative                                   as Negative
               ,pc.IsMetric                                     as Metric
               ,pc.CUser                                        as Cuser
               ,pc.CDate                                        as CDAte       
           from pGRProductClassImage pci 
               INNER JOIN pGRProductCompany pgc
                          ON pci.ProductCompanyId = pgc.ProductCompanyId
               INNER JOIN pGRSizeClassCompany psc
                          ON pci.SizeClassCompanyId = psc.SizeClassCompanyId
               INNER JOIN pGRClassRange pran
                          ON pran.SizeClassCompanyId = pci.SizeClassCompanyId
                          AND pran.FlatSizeClassId = psc.FlatSizeClassId 
               INNER JOIN pGRCompany pc
                    ON pc.CompanyGuidID = pgc.CompanyGuidId
               -- where pgc.product = 'Apron'
               -- WHERE pgc.product = 'Woven Tops'
               WHERE pran.xfer2flat=1
               AND pgc.product = 'Woven Shorts'
               --AND  PC.Company not like 'Latitude%'

*/
              select distinct pgc.CompanyGuidId
               ,pgc.ProductCompanyId
               ,pgc.productid
               ,SUBSTRING(pgc.Company + ' ' + pgc.Product,1,100) as POMType
               ,pgc.Product                                     as POMDesc 
               ,pran.flatclassrangeid                           as ClassRangeId
               ,pc.IsRelative                                   as [Relative]
               ,pc.IsNegative                                   as Negative
               ,pc.IsMetric                                     as Metric
               ,pc.CUser                                        as Cuser
               ,pc.CDate                                        as CDAte 
         from pGRProductClassImage pci 
         INNER JOIN pGRProductCompany pgc
                          ON pci.ProductCompanyId = pgc.ProductCompanyId
         INNER JOIN pGRCompany pc
                    ON pc.CompanyGuidID = pgc.CompanyGuidId  
         INNER JOIN pGRSizeClassCompany psc
                         ON pci.SizeClassCompanyId = psc.SizeClassCompanyId 
                          AND psc.CompanyGuidId = pc.CompanyGuidID
         INNER JOIN pGRClassRange pran
                 ON  pran.SizeClassCompanyId = pci.SizeClassCompanyId
                 AND  pran.FlatSizeClassId = psc.FlatSizeClassId 
                 AND PRAN.SizeClassCompanyId = PSC.SizeClassCompanyId
 --   where pgc.product = 'Woven Shorts'
  --  WHERE pgc.CompanyGuidId = 'A581D8F6-4E78-4E72-A55B-E315DFDD49A6'
  --  and psc.SizeClass = 'Missy'
   -- and pran.SizeRange = '4-18'
    order by 1,3


        DECLARE TCURSE1 INSENSITIVE CURSOR
          FOR SELECT myrownumber, productcompanyid,POMType,POMDesc,ClassRangeId,[Relative],
                     Negative, Metric, Cuser, CDate, CompanyGuidId
                FROM TempMeas1
              ORDER BY POMType
          FOR READ ONLY


       OPEN TCURSE1

       FETCH NEXT FROM TCURSE1 INTO @myrownumber, @productcompanyid,@POMType,@POMDesc,@ClassRangeId,@Relative,
                     @Negative, @Metric, @Cuser1, @CDate , @CompanyGuidId


       SET @rowcounter  = 1
       SET @SavePOMType = NULL

 
       WHILE @@FETCH_STATUS = 0
        BEGIN
 
             SET @MyCompany = NULL
             SET @MyCompany = (SELECT Company FROM pGRCompany WHERE CompanyGuidId = @CompanyGuidId)

             IF @rowcounter = 1  
                BEGIN
                     SET @SavePOMType        = @POMType
                     SET @POMTempID          = NewID()
                     --SET @POMTempGroupId   = NewID()


                     print 'beginning 1st '

                                      PRINT '@POMTempID is: '        + cast (@POMTempID as nvarchar(46) )
                                      PRINT '@ProductCompanyId is: ' + cast (@ProductCompanyId as nvarchar(46) )
                                      PRINT '@POMType is: ' + @POMType
                                      PRINT '@POMDesc is: ' + @POMDesc
                                      PRINT '@ClassRangeId is: ' + cast (@ClassRangeId as nvarchar(46) )

                     IF (@ClassRangeId IS NULL )
                                 BEGIN
                                      print 'classrangeid is null being passed in '
                                 END

                     ELSE
                         BEGIN

                     print 'doing 1st spx_pGRMeasurementsPOMTemplate_INSERT_Yunify '

                     EXEC spx_pGRMeasurementsPOMTemplate_INSERT_Yunify @POMTempID,
                                                                       @ProductCompanyId,
                                                                       @POMType,
                                                                       @POMDesc,
                                                                       @ClassRangeId,
	                                                               @Relative ,
	                                                               @Negative ,
	                                                               @Metric ,
	                                                               @CUser1 ,
	                                                               @CDate

                      UPDATE pGRMeasurementsPOMTemplate
                         SET  POMType = @POMType
                            , CustomField1       = @MyCompany
                            , POMTypeDescription = @POMDesc 
                        WHERE POMTempID = @POMTempID

                     print 'finished 1st spx_pGRMeasurementsPOMTemplate_INSERT_Yunify '
                     END
                END 
             ELSE   
                BEGIN
                     IF @SavePOMType = @POMType -- Need to add in just a sizerange to existing group
                        BEGIN
                               print 'beginning 2nd '


                              SET @NewPOMTempID = NewId()

                              SELECT @SizeClassId = FlatsizeclassId,
                                     @SizeRangeId = FlatSizeRangeId
                                                    FROM pGRClassRange
                                                    WHERE FlatClassrangeId = @ClassRangeId


                              IF (@SizeClassId IS NULL OR @SizeRangeId IS NULL OR @ClassRangeId IS NULL )
                                 BEGIN
                                      PRINT '2nd null passed in '
                                 END
                              ELSE
                                 BEGIN
                                      PRINT 'Before 2nd spx_pGRMeasurementsPOMTemplate_Add_Yunify'
                                      PRINT '@POMTempID is: ' + cast (@POMTempID as nvarchar(46) )
                                      PRINT '@NewPOMTempID is: ' + cast (@NewPOMTempID as nvarchar(46) )
                                      PRINT '@ProductCompanyId is: ' + cast (@ProductCompanyId as nvarchar(46) )
                                      PRINT '@SizeClassId is: ' + cast (@SizeClassId as nvarchar(46) )
                                      PRINT '@SizeRangeId is: ' + cast (@SizeRangeId as nvarchar(46) )
                                      PRINT '@ClassRangeId is: ' + cast (@ClassRangeId as nvarchar(46) )
                                      PRINT 'After'
                                      PRINT ' '

                              EXEC spx_pGRMeasurementsPOMTemplate_Add_Yunify @POMTempID,
                                                                             @NewPOMTempID,
                                                                             @ProductCompanyId,	
                                                                             @SizeClassId,
                                                                             @SizeRangeId,
                                                                         --    @ClassRangeId,
                                                                             @CUser1 ,
                                                                             @CDate

                              print 'end 2nd spx_pGRMeasurementsPOMTemplate_Add_Yunify'
                              END
                        END
                     ELSE
                        BEGIN


                              SET @SavePOMType = @POMType

                              SET @POMTempID        = NewID()

                              SET @POMTempGroupId   = NewID()


                              PRINT 'Beginning 3rd'
                              PRINT '@POMTempID is: '        + cast (@POMTempID as nvarchar(46) )
                                      PRINT '@ProductCompanyId is: ' + cast (@ProductCompanyId as nvarchar(46) )
                                      PRINT '@POMType is: ' + @POMType
                                      PRINT '@POMDesc is: ' + @POMDesc
                                      PRINT '@ClassRangeId is: ' + cast (@ClassRangeId as nvarchar(46) )

                              IF (@ClassRangeId IS NULL )
                                 BEGIN
                                       print '3rd null passed in classrangeid'
                                 END

                              ELSE

                              BEGIN
 
                              PRINT 'doing 3rd spx_pGRMeasurementsPOMTemplate_INSERT_Yunify'

                              EXEC spx_pGRMeasurementsPOMTemplate_INSERT_Yunify @POMTempID,
                                                                                @ProductCompanyId,
                                                                                @POMType,
                                                                                @POMDesc,
                                                                                @ClassRangeId,
	                                                                        @Relative ,
	                                                                        @Negative ,
	                                                                        @Metric ,
	                                                                        @CUser1 ,
	                                                                        @CDate


                               UPDATE pGRMeasurementsPOMTemplate
                                  SET  POMType = @POMType
                                     , CustomField1       = @MyCompany
                                     , POMTypeDescription = @POMDesc 
                                WHERE POMTempID = @POMTempID
                               END

                             print 'after 3rd spx_pGRMeasurementsPOMTemplate_INSERT_Yunify'
                        END

                END       
  
      FETCH NEXT FROM TCURSE1 INTO @myrownumber, @productcompanyid,@POMType,@POMDesc,@ClassRangeId,@Relative,
                     @Negative, @Metric, @Cuser1, @CDate , @CompanyGuidId

             SET @rowcounter  = @rowcounter  + 1
        END

        CLOSE      TCURSE1
        DEALLOCATE TCURSE1

        UPDATE pGRMeasurementsPOMTemplate
           SET SampleSize = '0'
         WHERE SampleSize is NULL or SampleSize = ''

        DROP TABLE TempMeas1

        --
        -- This section handle template items....
        --

        UPDATE pGRGradeRule
           SET FlatClassRangeId = (SELECT FlatClassRangeId
                                     FROM pGRClassRange
                                    WHERE ClassRangeId = pGRGradeRule.ClassRangeId )
               ,XFER2Flat        = (SELECT XFER2Flat
                                     FROM pGRClassRange
                                    WHERE ClassRangeId = pGRGradeRule.ClassRangeId)
              ,FlatSizeClassId  = (SELECT FlatSizeClassId
                                     FROM pGRClassRange
                                    WHERE ClassRangeId = pGRGradeRule.ClassRangeId)
              ,FlatSizeRangeId  = (SELECT FlatSizeRangeId
                                     FROM pGRClassRange
                                    WHERE ClassRangeId = pGRGradeRule.ClassRangeId)


         UPDATE pGRPOMCompany
            SET XferPOM = 0

      -- original    UPDATE pGRPOMCompany
      --      SET XferPOM = 1
      --   WHERE POMAlternatesId in ( SELECT POMAlternatesId
      --                               FROM pGRPOMAlternates PGA, pGRPOM pom
      --                              WHERE pga.POMGuidId = pom.POMGuidId
      --                                AND pom.XferPOM = 1)

        UPDATE pGRPOMCompany
            SET XferPOM = 1
         WHERE POMAlternatesId in ( SELECT POMAlternatesId
                                     FROM pGRPOMAlternates PGA, pGRPOM pom
                                    WHERE pga.flatpomid = pom.FlatPOMId
                                      AND pom.XferPOM = 1)

CREATE TABLE pGRMeasurementsPOMTemplateItem_Yunify(
	[POMTempItemID] [uniqueidentifier] ROWGUIDCOL  default newid () NOT NULL,
	[POMTempID] [uniqueidentifier] NOT NULL,
	[POMTempGroupID] [uniqueidentifier] NOT NULL,
	[POMID] [uniqueidentifier] NULL,
	[AlternatesId] [uniqueidentifier] NULL,
	[POMAlternatesID] [uniqueidentifier] NULL,
	[SizeclassID] [uniqueidentifier] NULL,
	[SizeRangeID] [uniqueidentifier] NULL,
	[ClassRangeID] [uniqueidentifier] NULL,
	[ImageId] [uniqueidentifier] NULL,
	[SampleSizeRangeID] [uniqueidentifier] NULL,
	[FitComID] [int] NULL,
	[Critical] [int] NULL,
	[IsOnQA] [int] NULL,
	[IsLinked] [int] NULL,
	[POMCode] [nvarchar](50) NULL,
	[POMDesc] [nvarchar](200) NULL,
	[AlternatesCode] [nvarchar](10) NULL,
	[AlternatesDesc] [nvarchar](100) NULL,
	[How2MeasText] [nvarchar](4000) NULL,
	[How2MeasName] [nvarchar](200) NULL,
	[POMSort] [int] NULL,
	[AlternatesSort] [int] NULL,
	[Active] [int] NULL,
	[TolPlus] [numeric](18, 4) NULL,
	[TolMinus] [numeric](18, 4) NULL,
	[Incr0] [decimal](18, 4) NULL,
	[Incr1] [decimal](18, 4) NULL,
	[Incr2] [decimal](18, 4) NULL,
	[Incr3] [decimal](18, 4) NULL,
	[Incr4] [decimal](18, 4) NULL,
	[Incr5] [decimal](18, 4) NULL,
	[Incr6] [decimal](18, 4) NULL,
	[Incr7] [decimal](18, 4) NULL,
	[Incr8] [decimal](18, 4) NULL,
	[Incr9] [decimal](18, 4) NULL,
	[Incr10] [decimal](18, 4) NULL,
	[Incr11] [decimal](18, 4) NULL,
	[Incr12] [decimal](18, 4) NULL,
	[Incr13] [decimal](18, 4) NULL,
	[Incr14] [decimal](18, 4) NULL,
	[Incr15] [decimal](18, 4) NULL,
	[Incr16] [decimal](18, 4) NULL,
	[Incr17] [decimal](18, 4) NULL,
	[Incr18] [decimal](18, 4) NULL,
	[Incr19] [decimal](18, 4) NULL,
	[Incr20] [decimal](18, 4) NULL,
	[Incr21] [decimal](18, 4) NULL,
	[Incr22] [decimal](18, 4) NULL,
	[Incr23] [decimal](18, 4) NULL,
	[Incr24] [decimal](18, 4) NULL,
	[Incr25] [decimal](18, 4) NULL,
	[Incr26] [decimal](18, 4) NULL,
	[Incr27] [decimal](18, 4) NULL,
	[Incr28] [decimal](18, 4) NULL,
	[Incr29] [decimal](18, 4) NULL,
	[Incr30] [decimal](18, 4) NULL,
	[Incr31] [decimal](18, 4) NULL,
	[Incr32] [decimal](18, 4) NULL,
	[Incr33] [decimal](18, 4) NULL,
	[Incr34] [decimal](18, 4) NULL,
	[Incr35] [decimal](18, 4) NULL,
	[Incr36] [decimal](18, 4) NULL,
	[Incr37] [decimal](18, 4) NULL,
	[Incr38] [decimal](18, 4) NULL,
	[Incr39] [decimal](18, 4) NULL,
	[Incr40] [decimal](18, 4) NULL,
	[Incr41] [decimal](18, 4) NULL,
	[Incr42] [decimal](18, 4) NULL,
	[Incr43] [decimal](18, 4) NULL,
	[Incr44] [decimal](18, 4) NULL,
	[Incr45] [decimal](18, 4) NULL,
	[Incr46] [decimal](18, 4) NULL,
	[Incr47] [decimal](18, 4) NULL,
	[Incr48] [decimal](18, 4) NULL,
	[Incr49] [decimal](18, 4) NULL,
	[CDate] [datetime] NULL,
	[CUser] [nvarchar](200) NULL,
	[MDate] [datetime] NULL,
	[MUser] [nvarchar](200) NULL,
	[Change] [int] NULL,
	[Sort] [nvarchar](4) NULL,
	[CopyPOMTempItemID] [uniqueidentifier] NULL,
	[Conv] [numeric](18, 4) NULL,
	[TempCopyPOMTempItemID] [uniqueidentifier] NULL )


         DECLARE TPCI INSENSITIVE CURSOR
               FOR SELECT  POMTempGroupId, ClassRangeId, SizeClassId ,SizeRangeId ,POMTempId                   
                     FROM pGRMeasurementsPOMTemplateGroup
               FOR READ ONLY


        OPEN TPCI

        FETCH NEXT FROM TPCI INTO @MYPOMTempGroupId, @MYFlatClassRangeId,
                                  @MYFlatSizeClassId, @MYFlatSizeRangeId, @MYPOMTempId

        WHILE @@FETCH_STATUS = 0
        BEGIN 




INSERT INTO pGRMeasurementsPOMTemplateItem_Yunify
           (
            [POMTempID]
           ,[POMTempGroupID]
           ,[POMID]
           ,[AlternatesId]
           ,[POMAlternatesID]
           ,[SizeclassID]
           ,[SizeRangeID]
           ,[ClassRangeID]
           ,[ImageId]
           ,[SampleSizeRangeID]
           ,[FitComID]
           ,[Critical]
           ,[IsOnQA]
           ,[IsLinked]
           ,[POMCode]
           ,[POMDesc]
           ,[AlternatesCode]
           ,[AlternatesDesc]
           ,[How2MeasText]
           ,[How2MeasName]
           ,[POMSort]
           ,[AlternatesSort]
           ,[Active]
           ,[TolPlus]
           ,[TolMinus]
           ,[Incr0]
           ,[Incr1]
           ,[Incr2]
           ,[Incr3]
           ,[Incr4]
           ,[Incr5]
           ,[Incr6]
           ,[Incr7]
           ,[Incr8]
           ,[Incr9]
           ,[Incr10]
           ,[Incr11]
           ,[Incr12]
           ,[Incr13]
           ,[Incr14]
           ,[Incr15]
           ,[Incr16]
           ,[Incr17]
           ,[Incr18]
           ,[Incr19]
           ,[Incr20]
           ,[Incr21]
           ,[Incr22]
           ,[Incr23]
           ,[Incr24]
           ,[Incr25]
           ,[Incr26]
           ,[Incr27]
           ,[Incr28]
           ,[Incr29]
           ,[Incr30]
           ,[Incr31]
           ,[Incr32]
           ,[Incr33]
           ,[Incr34]
           ,[Incr35]
           ,[Incr36]
           ,[Incr37]
           ,[Incr38]
           ,[Incr39]
           ,[Incr40]
           ,[Incr41]
           ,[Incr42]
           ,[Incr43]
           ,[Incr44]
           ,[Incr45]
           ,[Incr46]
           ,[Incr47]
           ,[Incr48]
           ,[Incr49]
           ,[CDate]
           ,[CUser]
           ,[MDate]
           ,[MUser]
           ,[Change]
           ,[Sort]
           ,[CopyPOMTempItemID]
           ,[Conv]
           ,[TempCopyPOMTempItemID])
select -- distinct
          PTG.POMTempId
         ,PTG.POMTempGroupID
         ,PT.POMId                      as [POMID]
         ,PT.AlternatesId               as [AlternatesId]
         ,PT.POMAlternatesId            as [POMAlternatesID]
         ,PTG.SizeClassId                 as [SizeclassID]
         ,PTG.SizeRangeId                 as [SizeRangeID]
         ,PTG.ClassRangeId                as [ClassRangeID]
         ,PT.ImageId                    as [ImageId]
         ,NULL                            as [SampleSizeRangeID]
         ,NULL                            as [FitComID]
         ,ISNULL(pgt.IsPrimaryKeyMeas,0)  as [Critical]
         ,ISNULL(pgt.IsOnQA ,0)           as [IsOnQA]
          ,PT.IsLinked                   as [IsLinked]
          ,PT.POMCode                    as [POMCode]
          ,PT.POMDesc                    as [POMDesc]
          ,PT.AlternatesCode            as [AlternatesCode]
          ,PT.AlternatesDesc            as [AlternatesDesc]
          ,PT.How2MeasText              as [How2MeasText]
          ,PT.How2MeasName              as [How2MeasName]
          ,PT.POMSort                   as [POMSort]
          ,PT.AlternateSort             as [AlternatesSort]
          ,PT.Active                     as [Active]
          ,pgt.TolPlus                    as [TolPlus]
          ,pgt.TolMinus                   as [TolMinus]
           ,prul.[Incr1]                  as Incr0
           ,prul.[Incr2]                    as Incr1
           ,prul.[Incr3]                    as Incr2
           ,prul.[Incr4]                    as Incr3
           ,prul.[Incr5]                    as Incr4
           ,prul.[Incr6]                    as Incr5
           ,prul.[Incr7]                    as Incr6
           ,prul.[Incr8]                    as Incr7
           ,prul.[Incr9]                    as Incr8
           ,prul.[Incr10]                   as Incr9
           ,prul.[Incr11]                   as Incr10
           ,prul.[Incr12]                   as Incr11
           ,prul.[Incr13]                   as Incr12
           ,prul.[Incr14]                   as Incr13
           ,prul.[Incr15]                   as Incr14
           ,prul.[Incr16]                   as Incr15
           ,prul.[Incr17]                   as Incr16
           ,prul.[Incr18]                   as Incr17
           ,prul.[Incr19]                   as Incr18
           ,prul.[Incr20]                   as Incr19
           ,prul.[Incr21]                   as Incr20
           ,prul.[Incr22]                   as Incr21
           ,prul.[Incr23]                   as Incr22
           ,prul.[Incr24]                   as Incr23
           ,prul.[Incr25]                   as Incr24
           ,prul.[Incr26]                   as Incr25
           ,prul.[Incr27]                   as Incr26
           ,prul.[Incr28]                   as Incr27
           ,prul.[Incr29]                   as Incr28
           ,prul.[Incr30]                   as Incr29
           ,prul.[Incr31]                   as Incr30
           ,prul.[Incr32]                   as Incr31
           ,prul.[Incr33]                   as Incr32
           ,prul.[Incr34]                   as Incr33
           ,prul.[Incr35]                   as Incr34
           ,prul.[Incr36]                   as Incr35
           ,prul.[Incr37]                   as Incr36
           ,prul.[Incr38]                   as Incr37
           ,prul.[Incr39]                   as Incr38
           ,prul.[Incr40]                   as Incr39
           ,prul.[Incr41]                   as Incr40
           ,prul.[Incr42]                   as Incr41
           ,prul.[Incr43]                   as Incr42
           ,prul.[Incr44]                   as Incr43
           ,prul.[Incr45]                   as Incr44
           ,prul.[Incr46]                   as Incr45
           ,prul.[Incr47]                   as Incr46
           ,prul.[Incr48]                   as Incr47
           ,0.0                             as Incr48
           ,0.0                             as Incr49
           ,prul.CDate                      as [CDate]
           ,prul.CUser                      as [CUser]
           ,prul.MDate                      as [MDate]
           ,prul.Muser                      as [MUser]
           ,NULL                            as [Change]
           ,POM.SortField                   as [Sort]
           ,NULL                           as [CopyPOMTempItemID]
           ,NULL                           as [Conv]
           ,NULL                           as [TempCopyPOMTempItemID] 
 FROM pGRPOMCompany POM 
     INNER JOIN pGRTolerance PGT           ON POM.POMCompanyId = PGT.POMCompanyId 
     INNER JOIN pGRProductClassImage PGCI  ON PGT.ProductClassImageId = PGCI.ProductClassImageID 
     INNER JOIN pGRPOMAlternates PGPA      ON POM.POMAlternatesId = PGPA.POMAlternatesId
     INNER JOIN pGRAlternates AS PGA       ON PGPA.AlternatesGuidId = PGA.AlternatesGuidId      
     INNER JOIN pGRMeasurementsPOMTemplate PTG on PTG.POMTempGroupID = PGCI.ProductCompanyId
                                           AND PTG.SizeClassId = PGCI.FlatSizeClassId
     LEFT JOIN pGRGradeRule PRUL         ON PRUL.POMCompanyId = POM.POMCompanyId
                                           AND PRUL.FlatSizeRangeId = ptg.SizeRangeId
                                           AND PRUL.FlatSizeClassId = ptg.SizeClassId
     INNER JOIN pGRMeasurementsPOMAlternates PT on pt.POMId = PGPA.FlatPOMId
                                             AND PT.AlternatesId = PGA.AlternatesGuidId
    WHERE   ptg.SizeClassId    = @MYFlatSizeClassId
      and   ptg.SizeRangeId    = @MYFlatSizeRangeId
      and   ptg.ClassRangeId   = @MYFlatClassRangeId
      and   ptg.POMTempGroupID = @MYPOMTempGroupId
      and   ptg.POMTempID      = @MYPOMTempId
   
        FETCH NEXT FROM TPCI INTO @MYPOMTempGroupId, @MYFlatClassRangeId,
                                  @MYFlatSizeClassId, @MYFlatSizeRangeId, @MYPOMTempId

      END -- end of loop

        CLOSE      TPCI
        DEALLOCATE TPCI

  INSERT INTO pGRMeasurementsPOMTemplateItem
           (
            [POMTempID]
           ,[POMTempGroupID]
           ,[POMID]
           ,[AlternatesId]
           ,[POMAlternatesID]
           ,[SizeclassID]
           ,[SizeRangeID]
           ,[ClassRangeID]
           ,[ImageId]
           ,[SampleSizeRangeID]
           ,[FitComID]
           ,[Critical]
           ,[IsOnQA]
           ,[IsLinked]
           ,[POMCode]
           ,[POMDesc]
           ,[AlternatesCode]
           ,[AlternatesDesc]
           ,[How2MeasText]
           ,[How2MeasName]
           ,[POMSort]
           ,[AlternatesSort]
           ,[Active]
           ,[TolPlus]
           ,[TolMinus]
           ,[Incr0]
           ,[Incr1]
           ,[Incr2]
           ,[Incr3]
           ,[Incr4]
           ,[Incr5]
           ,[Incr6]
           ,[Incr7]
           ,[Incr8]
           ,[Incr9]
           ,[Incr10]
           ,[Incr11]
           ,[Incr12]
           ,[Incr13]
           ,[Incr14]
           ,[Incr15]
           ,[Incr16]
           ,[Incr17]
           ,[Incr18]
           ,[Incr19]
           ,[Incr20]
           ,[Incr21]
           ,[Incr22]
           ,[Incr23]
           ,[Incr24]
           ,[Incr25]
           ,[Incr26]
           ,[Incr27]
           ,[Incr28]
           ,[Incr29]
           ,[Incr30]
           ,[Incr31]
           ,[Incr32]
           ,[Incr33]
           ,[Incr34]
           ,[Incr35]
           ,[Incr36]
           ,[Incr37]
           ,[Incr38]
           ,[Incr39]
           ,[Incr40]
           ,[Incr41]
           ,[Incr42]
           ,[Incr43]
           ,[Incr44]
           ,[Incr45]
           ,[Incr46]
           ,[Incr47]
           ,[Incr48]
           ,[Incr49]
           ,[CDate]
           ,[CUser]
           ,[MDate]
           ,[MUser]
           ,[Change]
           ,[Sort]
           ,[CopyPOMTempItemID]
           ,[Conv]
           ,[TempCopyPOMTempItemID])

          SELECT
            [POMTempID]
           ,[POMTempGroupID]
           ,[POMID]
           ,[AlternatesId]
           ,[POMAlternatesID]
           ,[SizeclassID]
           ,[SizeRangeID]
           ,[ClassRangeID]
           ,[ImageId]
           ,[SampleSizeRangeID]
           ,[FitComID]
           ,[Critical]
           ,[IsOnQA]
           ,[IsLinked]
           ,[POMCode]
           ,[POMDesc]
           ,[AlternatesCode]
           ,[AlternatesDesc]
           ,[How2MeasText]
           ,[How2MeasName]
           ,[POMSort]
           ,[AlternatesSort]
           ,[Active]
           ,[TolPlus]
           ,[TolMinus]
           ,[Incr0]
           ,[Incr1]
           ,[Incr2]
           ,[Incr3]
           ,[Incr4]
           ,[Incr5]
           ,[Incr6]
           ,[Incr7]
           ,[Incr8]
           ,[Incr9]
           ,[Incr10]
           ,[Incr11]
           ,[Incr12]
           ,[Incr13]
           ,[Incr14]
           ,[Incr15]
           ,[Incr16]
           ,[Incr17]
           ,[Incr18]
           ,[Incr19]
           ,[Incr20]
           ,[Incr21]
           ,[Incr22]
           ,[Incr23]
           ,[Incr24]
           ,[Incr25]
           ,[Incr26]
           ,[Incr27]
           ,[Incr28]
           ,[Incr29]
           ,[Incr30]
           ,[Incr31]
           ,[Incr32]
           ,[Incr33]
           ,[Incr34]
           ,[Incr35]
           ,[Incr36]
           ,[Incr37]
           ,[Incr38]
           ,[Incr39]
           ,[Incr40]
           ,[Incr41]
           ,[Incr42]
           ,[Incr43]
           ,[Incr44]
           ,[Incr45]
           ,[Incr46]
           ,[Incr47]
           ,[Incr48]
           ,[Incr49]
           ,[CDate]
           ,[CUser]
           ,[MDate]
           ,[MUser]
           ,[Change]
           ,[Sort]
           ,[CopyPOMTempItemID]
           ,[Conv]
           ,[TempCopyPOMTempItemID]
           FROM pGRMeasurementsPOMTemplateItem_Yunify

           UPDATE pGRMeasurementsPOMTemplateItem
              SET IsOnQA = 0
            WHERE IsOnQA is null
  
           DROP TABLE pGRMeasurementsPOMTemplateItem_Yunify 

           DECLARE @myrowcount int
           DECLARE @zerosql nvarchar(4000)
           DECLARE @myIncr nvarchar(100)
           SET @myrowcount = 0

           WHILE @myrowcount <= 49
           BEGIN
                SET @myIncr = 'Incr' + CAST(@myrowcount as nvarchar(2))
                SET @zerosql = ''
                SET @zerosql = @zerosql + ' UPDATE pGRMeasurementsPOMTemplateItem '
                SET @zerosql = @zerosql + 'SET ' + @myIncr + ' = 0.0 '
                SET @zerosql = @zerosql + 'WHERE ' + @myIncr + ' is NULL'
                --print @zerosql
                exec sp_executesql @zerosql

                SET @myrowcount = @myrowcount + 1
           END





--
-- now delete poms that don't have grading
--

DECLARE @CLPOMTempID      uniqueidentifier
DECLARE @CLPOMTempGroupID uniqueidentifier
DECLARE @CLSizeClassId    uniqueidentifier
DECLARE @CLSizerangeId    uniqueidentifier
DECLARE @CLClassRangeId   uniqueidentifier
DECLARE @CLCustomId       uniqueidentifier
DECLARE @CLSizeClass      nvarchar(200)
DECLARE @CLSizeRange      nvarchar(100)
DECLARE @CLCustom         nvarchar(100)
DECLARE @CLCompanyGuidID  uniqueidentifier

DECLARE @CLSizeClassCompanyId   uniqueidentifier
DECLARE @CLSizeRangeGuidId   uniqueidentifier

DECLARE Cursor1 INSENSITIVE CURSOR
            FOR SELECT p1.POMTempID,p1.POMTempGroupID ,p1.SizeClassId
                ,p1.SizerangeId, p1.ClassRangeId, i1.CustomID
                ,i1.Custom ,p2.SizeClass, p2.SizeRange
                FROM pGRMeasurementsPOMTemplate p1 INNER JOIN iCustom1 i1
                on p1.CustomField1 = i1.Custom   INNER JOIN pGRMeasurementsPOMTemplateGroup p2
                on p1.POMTempGroupID = p2.POMTempGroupID 
                and p1.POMTempID = p2.POMTempID
              --  WHERE p1.CustomField1 = 'Latitude - Europe'
              --    AND p1.POMTypeDescription = 'Apron'
              --    AND p1.SizeClass = 'Missy'
              --    AND p1.SizeRange = '4-18'
            FOR READ ONLY
            
 OPEN Cursor1
 
 FETCH NEXT FROM Cursor1 INTO @CLPOMTempID,@CLPOMTempGroupID,@CLSizeClassId
                             ,@CLSizerangeId,@CLClassRangeId
                              ,@CLCustomId ,@CLCustom ,@CLSizeClass ,@CLSizeRange
                              
 WHILE @@FETCH_STATUS = 0
 BEGIN
 
    -- Get Company Guid
    SET @CLCompanyGuidID = NULL
    SELECT @CLCompanyGuidID = CompanyGuidID
      FROM pGRCompany
     WHERE Company  = @CLCustom

     -- Get Size Class CompanyId  
     SET   @CLSizeClassCompanyId = NULL
     SELECT @CLSizeClassCompanyId = p1.SizeClassCompanyId  
       FROM pGRSizeClassCompany p1, pGRSizeClass p2
      WHERE p1.CompanyGuidId = @CLCompanyGuidID
        AND p1.SizeClassGuidId =p2.SizeClassGuidId
        AND p2.SizeClass = @CLSizeClass

     -- Get Size RangeGuidId  
     SET    @CLSizeRangeGuidId = Null    
     SELECT @CLSizeRangeGuidId = SizeRangeGuidId 
       FROM pGRClassRange
      WHERE SizeClassCompanyId = @CLSizeClassCompanyId
        AND SizeRange = @CLSizeRange

    /* SELECT p2.RefCode
       FROM pGRGradeRule p1, pGRPOMCompany p2
      WHERE classrangeid in ( SELECT ClassRangeId
                                FROM pGRclassRange 
                               WHERE SizeClasscompanyId=@CLSizeClassCompanyId 
                                 AND SizeRangeGuidId =  @CLSizeRangeGuidId ) 
                                AND p1.POMCompanyId =  p2.POMCompanyId */

    DELETE
    FROM pGRMeasurementsPOMTemplateItem
    WHERE POMTempItemID in (
               SELECT pomtempitemid
                FROM vwx_UnFlattenedPOMS
               WHERE POMTempGroupID = @CLPOMTempGroupID
                 AND POMTempID     =  @CLPOMTempID
                  AND REFCODE not in (
                      SELECT p2.RefCode
                        FROM pGRGradeRule p1, pGRPOMCompany p2
                       WHERE classrangeid in ( SELECT ClassRangeId
                                                 FROM pGRclassRange 
                                                 WHERE SizeClasscompanyId=@CLSizeClassCompanyId 
                                                   AND SizeRangeGuidId =  @CLSizeRangeGuidId )
                        AND p1.POMCompanyId =  p2.POMCompanyId
                     )   )  
     
    FETCH NEXT FROM Cursor1 INTO @CLPOMTempID,@CLPOMTempGroupID,@CLSizeClassId
                             ,@CLSizerangeId,@CLClassRangeId
                              ,@CLCustomId ,@CLCustom ,@CLSizeClass ,@CLSizeRange
 END
 
 CLOSE      Cursor1
 DEALLOCATE Cursor1






      delete
      FROM pGRMeasurementsPOMTemplategroup
      where POMTempID not in (select POMTempID from pGRMeasurementsPOMTemplateItem)

      delete 
      FROM pGRMeasurementsPOMTemplate
      where POMTempID not in (select POMTempID from pGRMeasurementsPOMTemplateItem)


    
END
GO


IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.ROUTINES WHERE SPECIFIC_NAME = N'wpx_Yunify_POMS_Cross_Ranges_UPDATE')
   DROP PROCEDURE wpx_Yunify_POMS_Cross_Ranges_UPDATE
GO

CREATE PROCEDURE [wpx_Yunify_POMS_Cross_Ranges_UPDATE]

(
	@CUser NVARCHAR(200)
)
AS
     DECLARE @POMTempGroupID  uniqueidentifier
     DECLARE @POMTempGroupID2 uniqueidentifier
     DECLARE @POMTempID       uniqueidentifier
     DECLARE @MergePomsCount  int 
     DECLARE @TempPomsCount   int 
     DECLARE @rowcounter      int
     DECLARE @rowcounter2     int
     DECLARE @sizeclassid     uniqueidentifier
     DECLARE @sizerangeid     uniqueidentifier
     DECLARE @classrangeid    uniqueidentifier
     DECLARe @MYDATE          datetime

     DECLARE TCURSE1 INSENSITIVE CURSOR
                   FOR SELECT POMTempGroupID,COUNT(*) as MyCount
                         FROM pGRMeasurementsPOMTemplateGroup
                     GROUP BY POMTempGroupID
                     HAVING COUNT(*) > 1
               FOR READ ONLY


     SET NOCOUNT ON
BEGIN

     SET @MYDATE = getutcdate()
 
     OPEN TCURSE1 

     FETCH NEXT FROM TCURSE1 INTO  @POMTempGroupID,@MergePomsCount

     SET @rowcounter = 1
     
     WHILE @@FETCH_STATUS = 0
         BEGIN

              DECLARE TCURSE2 INSENSITIVE CURSOR
                   FOR SELECT DISTINCT POMTempGroupID
                                 ,POMTempId
                                 ,sizeclassid
                                 ,sizerangeid
                                 ,classrangeid 
                    FROM pGRMeasurementsPOMTemplateItem
                   WHERE pomtempgroupid = @POMTempGroupID
               FOR READ ONLY


              OPEN TCURSE2 

              FETCH NEXT FROM TCURSE2 INTO  @POMTempGroupID2,@POMTempId
                                           ,@sizeclassid,@sizerangeid,@classrangeid

              WHILE @@FETCH_STATUS = 0
              BEGIN

                   INSERT INTO pGRMeasurementsPOMTemplateItem
                          ([POMTempID]
                          ,[POMTempGroupID]
                          ,[POMID]
                          ,[AlternatesId]
                          ,[POMAlternatesID]
                          ,[SizeclassID]
                          ,[SizeRangeID]
                           ,[ClassRangeID]
                          ,[ImageId]
                          ,[SampleSizeRangeID]
                          ,[FitComID]
                          ,[Critical]
                          ,[IsOnQA]
                          ,[IsLinked]
                          ,[POMCode]
                          ,[POMDesc]
                          ,[AlternatesCode]
                          ,[AlternatesDesc]
                          ,[How2MeasText]
                          ,[How2MeasName]
                          ,[POMSort]
                          ,[AlternatesSort]
                          ,[Active]
                          ,[TolPlus]
                          ,[TolMinus]
                          ,[Incr0]
                          ,[Incr1]
                          ,[Incr2]
                          ,[Incr3]
                          ,[Incr4]
                          ,[Incr5]
                          ,[Incr6]
                          ,[Incr7]
                          ,[Incr8]
                          ,[Incr9]
                          ,[Incr10]
                          ,[Incr11]
                          ,[Incr12]
                          ,[Incr13]
                          ,[Incr14]
                          ,[Incr15]
                          ,[Incr16]
                          ,[Incr17]
                          ,[Incr18]
                          ,[Incr19]
                          ,[Incr20]
                          ,[Incr21]
                          ,[Incr22]
                          ,[Incr23]
                          ,[Incr24]
                          ,[Incr25]
                          ,[Incr26]
                          ,[Incr27]
                          ,[Incr28]
                          ,[Incr29]
                          ,[Incr30]
                          ,[Incr31]
                          ,[Incr32]
                          ,[Incr33]
                          ,[Incr34]
                          ,[Incr35]
                          ,[Incr36]
                          ,[Incr37]
                          ,[Incr38]
                          ,[Incr39]
                          ,[Incr40]
                          ,[Incr41]
                          ,[Incr42]
                          ,[Incr43]
                          ,[Incr44]
                          ,[Incr45]
                          ,[Incr46]
                          ,[Incr47]
                          ,[Incr48]
                          ,[Incr49]
                          ,[CDate]
                          ,[CUser]
                          ,[MDate]
                          ,[MUser]
                          ,[Change]
                          ,[Sort]
                          ,[CopyPOMTempItemID]
                          ,[Conv]
                          ,[TempCopyPOMTempItemID])
                   SELECT DISTINCT 
                         @POMTempID
                        ,@POMTempGroupID
                        ,[POMID]
                        ,[AlternatesId]
                        ,[POMAlternatesID]
                        ,@sizeclassid  as [SizeclassID]
                        ,@sizerangeid  as[SizeRangeID]
                        ,@classrangeid as [ClassRangeID]
                        ,[ImageId]
                        ,[SampleSizeRangeID]
                        ,[FitComID]
                        ,[Critical]
                        ,[IsOnQA]
                        ,[IsLinked]
                        ,[POMCode]
                        ,[POMDesc]
                        ,[AlternatesCode]
                        ,[AlternatesDesc]
                        ,[How2MeasText]
                        ,[How2MeasName]
                        ,[POMSort]
                        ,[AlternatesSort]
                        ,[Active]
                        ,0 as [TolPlus]
                        ,0 as [TolMinus]
                        ,0 as [Incr0]
                        ,0 as [Incr1]
                        ,0 as [Incr2]
                        ,0 as [Incr3]
                        ,0 as [Incr4]
                        ,0 as [Incr5]
                        ,0 as [Incr6]
                        ,0 as [Incr7]
                        ,0 as [Incr8]
                        ,0 as [Incr9]
                        ,0 as [Incr10]
                        ,0 as [Incr11]
                        ,0 as [Incr12]
                        ,0 as [Incr13]
                        ,0 as [Incr14]
                        ,0 as [Incr15]
                        ,0 as [Incr16]
                        ,0 as [Incr17]
                        ,0 as [Incr18]
                        ,0 as [Incr19]
                        ,0 as [Incr20]
                        ,0 as [Incr21]
                        ,0 as [Incr22]
                        ,0 as [Incr23]
                        ,0 as [Incr24]
                        ,0 as [Incr25]
                        ,0 as [Incr26]
                        ,0 as [Incr27]
                        ,0 as [Incr28]
                        ,0 as [Incr29]
                        ,0 as [Incr30]
                        ,0 as [Incr31]
                        ,0 as [Incr32]
                        ,0 as [Incr33]
                        ,0 as [Incr34]
                        ,0 as [Incr35]
                        ,0 as [Incr36]
                        ,0 as [Incr37]
                        ,0 as [Incr38]
                        ,0 as [Incr39]
                        ,0 as [Incr40]
                        ,0 as [Incr41]
                        ,0 as [Incr42]
                        ,0 as [Incr43]
                        ,0 as [Incr44]
                        ,0 as [Incr45]
                        ,0 as [Incr46]
                        ,0 as [Incr47]
                        ,0 as [Incr48]
                        ,0 as [Incr49]
                        ,@mydate as [CDate]
                        ,'Yunify' as[CUser]
                        ,@mydate as [MDate]
                        ,'Yunify' as [MUser]
                        ,[Change]
                        ,[Sort]
                        ,[CopyPOMTempItemID]
                        ,[Conv]
                        ,[TempCopyPOMTempItemID]
                   FROM [pGRMeasurementsPOMTemplateItem]
                  WHERE POMTempGroupID =  @POMTempGroupID
                    AND POMTempID     <>  @POMTempID
                    AND ltrim(rtrim(POMCode)) + ' ' + ltrim(rtrim(AlternatesCode)) 
                        not IN (SELECT distinct (ltrim(rtrim(POMCODE)) + ' ' + ltrim(rtrim(AlternatesCode)))
                                                        FROM pGRMeasurementsPOMTemplateItem
                                                       WHERE POMTempGroupID = @POMTempGroupID
                                                         AND POMTempID     =  @POMTempID)


                  FETCH NEXT FROM TCURSE2 INTO  @POMTempGroupID2,@POMTempId
                                               ,@sizeclassid,@sizerangeid,@classrangeid

              END

              FETCH NEXT FROM TCURSE1 INTO  @POMTempGroupID,@MergePomsCount


              CLOSE      TCURSE2
              DEALLOCATE TCURSE2
       
         END

     CLOSE      TCURSE1
     DEALLOCATE TCURSE1
       
END
GO

