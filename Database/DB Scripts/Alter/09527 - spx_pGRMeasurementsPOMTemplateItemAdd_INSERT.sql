IF OBJECT_ID(N'[dbo].[spx_pGRMeasurementsPOMTemplateItemAdd_INSERT]') IS NOT NULL
 DROP PROCEDURE [dbo].[spx_pGRMeasurementsPOMTemplateItemAdd_INSERT]
GO

CREATE PROCEDURE [dbo].[spx_pGRMeasurementsPOMTemplateItemAdd_INSERT]
(	@POMTempID  uniqueidentifier,
	@POMTempGroupId  uniqueidentifier,
	@POM nvarchar(50),	
	@MDate datetime,
	@MUser nvarchar(200)	
)
as

Declare @SizeClassId nvarchar(50)
Declare @SizeRangeId nvarchar(50)
Declare @ClassRangeId nvarchar(50)

select @SizeClassId = SizeClassId, @SizeRangeId = SizeRangeId, 
	   @ClassRangeId = ClassRangeId
from pGRMeasurementsPOMTemplate
where POMTempID = @POMTempID

INSERT INTO pGRMeasurementsPOMTemplateItem
(POMTempGroupId, POMTempID, SizeClassId, SizeRangeId, ClassRangeId, 
 POMCode, POMDesc, Active, TolPlus, TolMinus,
Cuser, Cdate, Mdate, MUser, bKey)
values (@POMTempGroupId, @POMTempID, @SizeClassId, @SizeRangeId, @ClassRangeId, @POM,
@POM, 1, 0, 0, @MUser, @MDate, @MDate, @MUser , 1)


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09527', GetDate())
GO
