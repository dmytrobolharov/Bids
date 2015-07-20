IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_pGRMeasurementsPOMTemplateItemLib_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_pGRMeasurementsPOMTemplateItemLib_INSERT]
GO

CREATE PROCEDURE [dbo].[spx_pGRMeasurementsPOMTemplateItemLib_INSERT]
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
Declare @TempPOMID nvarchar(50)

declare @RowCnt int

select @RowCnt = COUNT(POMTempGroupId) from pGRMeasurementsPOMTemplateGroup  where POMTempGroupId=@POMTempGroupId

--select @SizeClassId=SizeClassId, @SizeRangeId=SizeRangeId, @SizeClass=SizeClass, 
--@SizeRange=SizeRange, @ClassRangeId=ClassRangeId
--from pGRMeasurementsPOMTemplate where POMTempID=@POMTempID

--INSERT INTO pGRMeasurementsPOMTemplateItem
--(POMTempGroupId, POMTempID, SizeClassId, SizeRangeId, ClassRangeId, ImageId,
--POMID, AlternatesId, POMAlternatesId, IsOnQA, IsLinked, POMCode, POMDesc, AlternatesCode, 
--AlternatesDesc, How2MeasText, How2MeasName, POMSort, alternatesSort, Active,
--Cuser, Cdate, Mdate, MUser)
--select @POMTempGroupId, @POMTempID, @SizeClassId, @SizeRangeId, @ClassRangeId,
--ImageId, POMID, AlternatesId, POMAlternatesId, 1, 1, POMCode, POMDesc, AlternatesCode, 
--AlternatesDesc, How2MeasText, How2MeasName, POMSort, AlternateSort, Active,
--@CUser, @CDate, @CDate , @CUser   from  pGRMeasurementsPOMAlternates 
--where POMAlternatesId=@POMAlternatesId


if @RowCnt>0
	begin
		DECLARE cursor_pGRMeasurementsPOMTemplate CURSOR FOR
			select SizeClassId, SizeRangeId, ClassRangeId, POMTempID from pGRMeasurementsPOMTemplate 
			where POMTempGroupId=@POMTempGroupId order by POMTempID	
		
			OPEN cursor_pGRMeasurementsPOMTemplate
		
			FETCH NEXT from cursor_pGRMeasurementsPOMTemplate INTO  @SizeClassId, @SizeRangeId, 
			@ClassRangeId, @TempPOMID
			
			WHILE @@FETCH_STATUS = 0 
				BEGIN
					INSERT INTO pGRMeasurementsPOMTemplateItem
					(POMTempGroupId, POMTempID, SizeClassId, SizeRangeId, ClassRangeId, ImageId,
					POMID, AlternatesId, POMAlternatesId, IsOnQA, IsLinked, POMCode, POMDesc, AlternatesCode, 
					AlternatesDesc, How2MeasText, How2MeasName, POMSort, Sort, alternatesSort, Active,
					Cuser, Cdate, Mdate, MUser)
					select @POMTempGroupId, @TempPOMID, @SizeClassId, @SizeRangeId, @ClassRangeId,
					ImageId, POMID, AlternatesId, POMAlternatesId, 1, 1, POMCode, POMDesc, AlternatesCode, 
					AlternatesDesc, How2MeasText, How2MeasName, POMSort, RIGHT ('0000' + cast(POMSort as nvarchar (4)), 4), AlternateSort, Active,
					@CUser, @CDate, @CDate , @CUser   from  pGRMeasurementsPOMAlternates 
					where POMAlternatesId=@POMAlternatesId       
				
					FETCH NEXT from cursor_pGRMeasurementsPOMTemplate INTO  @SizeClassId, @SizeRangeId, 
					@ClassRangeId, @TempPOMID
				END 
				
		CLOSE cursor_pGRMeasurementsPOMTemplate 
		DEALLOCATE cursor_pGRMeasurementsPOMTemplate 
		
	end

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '06070', GetDate())
GO
