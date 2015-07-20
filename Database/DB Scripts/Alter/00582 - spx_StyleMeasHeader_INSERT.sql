set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON
go

IF EXISTS (select * from sysobjects where id = object_id('spx_StyleMeasHeader_INSERT') and sysstat & 0xf = 4)
    drop procedure spx_StyleMeasHeader_INSERT
GO



Create PROCEDURE [dbo].[spx_StyleMeasHeader_INSERT]
(	@StyleID uniqueidentifier,
	@WorkflowID uniqueidentifier,
	@AMLMeasHdrId uniqueidentifier,
	@CompanyID uniqueidentifier,
	@SizeClassID uniqueidentifier,
	@SizeRangeID uniqueidentifier,
	@SampleSizeID uniqueidentifier,
	@ProductTypeID uniqueidentifier,	
	@CUser nvarchar(200) ,
	@CDate datetime 
)

AS 


DECLARE @CompanyName nvarchar(60)
DECLARE @PDMCompanyId int
DECLARE @PDMSizeClassId int
DECLARE @PDMSizeRangeId int
DECLARE @PDMProductTypeId int
DECLARE @SizeClassName nvarchar(60)
DECLARE @SizeRangeName nvarchar(60)
DECLARE @ProductTypeName nvarchar(60)
DECLARE @SampleSizeName nvarchar(5)
Declare @SizeColCnt int
Declare @IsRelative int
Declare @IsNegative int
Declare @IsMetric int
DECLARE @SizeRangeDetailId nvarchar(50)
DECLARE @SizeCount int
DECLARE @SizeName nvarchar(5)
DECLARE @SizeDesc nvarchar(10)
Declare @IsSample int
Declare @Isvisible int
Declare @MaxSizeCol int
Declare @samplecol int

SELECT @CompanyName = Company, @IsRelative = IsRelative, @IsNegative = IsNegative, @IsMetric = IsMetric, @PDMCompanyId = CompanyId FROM pGRCompany WITH (NOLOCK) WHERE CompanyGuidId = @CompanyID

If @IsRelative=-1 
begin
	set @IsRelative=1
end
If @IsNegative=-1 
begin
	set @IsNegative=1
end
If @IsMetric=-1 
begin
	set @IsMetric=1
end

SELECT @SizeClassName = SizeClass, @PDMSizeClassId = SizeClassId FROM pGRSizeClass WITH (NOLOCK) WHERE SizeClassGuidId = @SizeClassID

SELECT @SizeRangeName = SizeRange, @PDMSizeRangeId = SizeRangeId FROM pGRSizeRange WITH (NOLOCK) WHERE SizeRangeGuidId = @SizeRangeID

SELECT @ProductTypeName = Garment, @PDMProductTypeId = GarmentId FROM pGRGarment WITH (NOLOCK) WHERE GarmentGuidID = @ProductTypeID

SELECT @MaxSizeCol = isnull(MAX(SizeCount),0) FROM pGRSizeRangeDetail WITH (NOLOCK) WHERE SizeRangeId = @SizeRangeID

Set @SizeColCnt=0
set @IsSample=0
set @Isvisible=1
set @SizeCount=0

INSERT INTO pamlmeashdr(AMLMeasHdrId, WorkflowID, Styleid, Companyid, PDMCompanyId, CompanyName, IsRelative, IsNegative, IsMetric,
SizeClassId, SizeClassCode, SizeClass, SizeRangeId, SizeRangeCode, SizeRange, ProductTypeId, ProductTypeCode, ProductType, MeasRowCnt, CUser, CDate, MUser, MDate)
values (@AMLMeasHdrId, @WorkflowID, @StyleID, @CompanyID, @PDMCompanyId, @CompanyName, @IsRelative, @IsNegative, @IsMetric,
@SizeClassID, @PDMSizeClassId, @SizeClassName, @SizeRangeID, @PDMSizeRangeId, @SizeRangeName, @ProductTypeID, @PDMProductTypeId, @ProductTypeName, 0, @CUser,
@CDate, @CUser, @CDate)

IF @MaxSizeCol  > 0 
	Begin
		
		DECLARE cursor_pGRSizeRangeDetail CURSOR FOR
		SELECT SizeRangeDetailId, SizeName, SizeDesc FROM pGRSizeRangeDetail
		WHERE (SizeRangeId = @SizeRangeID) AND (SizeName <> '') AND (SizeName is not null) ORDER BY SizeCount
	
		OPEN cursor_pGRSizeRangeDetail
	
		FETCH NEXT from cursor_pGRSizeRangeDetail INTO  @SizeRangeDetailId, @SizeName, @SizeDesc
		

		WHILE @@FETCH_STATUS = 0 
		BEGIN

			if @SizeRangeDetailId = @SampleSizeID
				begin
					--set @IsSample=-1	
					set @samplecol = @SizeCount
				end
			else
				begin
					set @IsSample=0
				end

			Insert into pamlmeaslbl(AMLMeasHdrId, SizeRangeId, SizeRangeDetailId, sizecol, MeasLbl, Isvisible, Issample,
			MeasDesc, Cuser, CDate, MUser, MDate) values 
			(@AMLMeasHdrId, @SizeRangeID, @SizeRangeDetailId, @SizeCount, @SizeName, @Isvisible, @IsSample, @SizeDesc, @CUser,
			@CDate, @CUser, @CDate)
			
			set @SizeCount=@SizeCount+1

			FETCH NEXT from cursor_pGRSizeRangeDetail INTO  @SizeRangeDetailId, @SizeName, @SizeDesc

		END 
	
	
	CLOSE cursor_pGRSizeRangeDetail 
	DEALLOCATE cursor_pGRSizeRangeDetail 

	End


EXEC spx_StyleMeasPom_Insert	
	@AMLMeasHdrId,
	@CompanyID,
	@SizeClassID,
	@SizeRangeID,	
	@ProductTypeID,	
	@samplecol,
	@CUser,
	@CDate



GO
INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.0.0000', '582', GetDate())
GO