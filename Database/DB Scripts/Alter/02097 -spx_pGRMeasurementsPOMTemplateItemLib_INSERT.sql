SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.ROUTINES WHERE SPECIFIC_NAME = N'spx_pGRMeasurementsPOMTemplateItemLib_INSERT')
   DROP PROCEDURE spx_pGRMeasurementsPOMTemplateItemLib_INSERT
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Create PROCEDURE [dbo].[spx_pGRMeasurementsPOMTemplateItemLib_INSERT]
(	@POMTempID  uniqueidentifier,
	@POMTempGroupId  uniqueidentifier,
	@POMAlternatesId uniqueidentifier,	
	@CUser nvarchar(200),
	@CDate datetime
)
as

Declare @SizeClassId nvarchar(50)
Declare @SizeRangeId nvarchar(50)
Declare @SizeClass nvarchar(200)
Declare @SizeRange nvarchar(200)
Declare @ClassRangeId nvarchar(50)

select @SizeClassId=SizeClassId, @SizeRangeId=SizeRangeId, @SizeClass=SizeClass, 
@SizeRange=SizeRange, @ClassRangeId=ClassRangeId
from pGRMeasurementsPOMTemplate where POMTempID=@POMTempID

INSERT INTO pGRMeasurementsPOMTemplateItem
(POMTempGroupId, POMTempID, SizeClassId, SizeRangeId, ClassRangeId, ImageId,
POMID, AlternatesId, POMAlternatesId, IsOnQA, IsLinked, POMCode, POMDesc, AlternatesCode, 
AlternatesDesc, How2MeasText, How2MeasName, POMSort, alternatesSort, Active,
Cuser, Cdate, Mdate, MUser)
select @POMTempGroupId, @POMTempID, @SizeClassId, @SizeRangeId, @ClassRangeId,
ImageId, POMID, AlternatesId, POMAlternatesId, 1, 1, POMCode, POMDesc, AlternatesCode, 
AlternatesDesc, How2MeasText, How2MeasName, POMSort, AlternateSort, Active,
@CUser, @CDate, @CDate , @CUser   from  pGRMeasurementsPOMAlternates 
where POMAlternatesId=@POMAlternatesId
       

 GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='02097'))
	BEGIN
		INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
		VALUES ('DB_Version', '4.1.0000', '02097', GetDate())
	END
GO