/****** Object:  StoredProcedure [dbo].[spx_pGRMeasurementsPOMTemplateItemAdd_INSERT]    Script Date: 11/02/2012 16:17:46 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_pGRMeasurementsPOMTemplateItemAdd_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_pGRMeasurementsPOMTemplateItemAdd_INSERT]
GO

/****** Object:  StoredProcedure [dbo].[spx_pGRMeasurementsPOMTemplateItemAdd_INSERT]    Script Date: 11/02/2012 16:17:46 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
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
Declare @SizeClass nvarchar(200)
Declare @SizeRange nvarchar(200)
Declare @ClassRangeId nvarchar(50)

select @SizeClassId=SizeClassId, @SizeRangeId=SizeRangeId, @SizeClass=SizeClass, 
@SizeRange=SizeRange, @ClassRangeId=ClassRangeId
from pGRMeasurementsPOMTemplate where POMTempID=@POMTempID

INSERT INTO pGRMeasurementsPOMTemplateItem
(POMTempGroupId, POMTempID, SizeClassId, SizeRangeId, ClassRangeId, 
 POMCode, POMDesc, Active, TolPlus, TolMinus,
Cuser, Cdate, Mdate, MUser)
values (@POMTempGroupId, @POMTempID, @SizeClassId, @SizeRangeId, @ClassRangeId, @POM,
@POM, 1, 0, 0, @MUser, @MDate, @MDate, @MUser)


GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04282', GetDate())
GO