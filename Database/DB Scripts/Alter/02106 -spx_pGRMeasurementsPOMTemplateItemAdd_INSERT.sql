SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.ROUTINES WHERE SPECIFIC_NAME = N'spx_pGRMeasurementsPOMTemplateItemAdd_INSERT')
   DROP PROCEDURE spx_pGRMeasurementsPOMTemplateItemAdd_INSERT
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Create PROCEDURE [dbo].[spx_pGRMeasurementsPOMTemplateItemAdd_INSERT]
(	@POMTempID  uniqueidentifier,
	@POMTempGroupId  uniqueidentifier,
	@POM nvarchar(50),	
	@MDate datetime,
	@MUser nvarchar(200)	
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
(POMTempGroupId, POMTempID, SizeClassId, SizeRangeId, ClassRangeId, 
 POMCode, POMDesc, Active,
Cuser, Cdate, Mdate, MUser)
values (@POMTempGroupId, @POMTempID, @SizeClassId, @SizeRangeId, @ClassRangeId, @POM,
@POM, 1, @MUser, @MDate, @MDate, @MUser)

GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='02106'))
	BEGIN
		INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
		VALUES ('DB_Version', '4.1.0000', '02106', GetDate())
	END
GO