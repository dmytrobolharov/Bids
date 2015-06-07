IF OBJECT_ID(N'[dbo].[spx_StyleMeasHeader_INSERT]') IS NOT NULL
 DROP PROCEDURE [dbo].[spx_StyleMeasHeader_INSERT]
GO

CREATE  PROCEDURE [dbo].[spx_StyleMeasHeader_INSERT]
(	@StyleID uniqueidentifier,
	@WorkflowID uniqueidentifier,
	@WorkflowItemID uniqueidentifier,
	@StyleSet int,
	@AMLMeasHdrId uniqueidentifier,
	@CompanyID uniqueidentifier,
	@SizeClassID uniqueidentifier,
	@SizeRangeID uniqueidentifier,
	@SampleSizeID uniqueidentifier,
	@ProductTypeID uniqueidentifier,	
	@PrimaryKeysOnly int,
	@CUser nvarchar(200) ,
	@CDate datetime 
)

AS 


DECLARE @CompanyName nvarchar(60)
DECLARE @PDMCompanyId int
DECLARE @PDMSizeClassId int
DECLARE @PDMSizeRangeId int
DECLARE @PDMProductTypeId int
DECLARE @SizeClassName nvarchar(400)
DECLARE @SizeRangeName nvarchar(200)
DECLARE @ProductTypeName nvarchar(60)
DECLARE @SampleSizeName nvarchar(5)
Declare @SizeColCnt int
Declare @IsRelative int
Declare @IsNegative int
Declare @IsMetric int
DECLARE @SizeRangeDetailId nvarchar(50)
DECLARE @SizeCount int
DECLARE @SizeName nvarchar(40)
DECLARE @SizeDesc nvarchar(10)
Declare @IsSample int
Declare @Isvisible int
Declare @MaxSizeCol int
Declare @samplecol int
Declare @SizeClass uniqueidentifier
Declare @SizeRange uniqueidentifier

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

SELECT @SizeClassName = SizeClass FROM pGRSizeClassCompany  WITH (NOLOCK) WHERE SizeClassCompanyId = @SizeClassID

--SELECT @SizeClassName = pGRSizeClass.SizeClass FROM 
--pGRSizeClass INNER JOIN pGRSizeClassCompany ON pGRSizeClass.SizeClassGuidId = pGRSizeClassCompany.SizeClassGuidId 
--WHERE (pGRSizeClassCompany.SizeClassCompanyId = @SizeClassID) 

--SELECT @SizeRangeName = SizeRange, @SizeRange = pGRSizeRange.SizeRangeGuidId
--FROM pGRSizeRange INNER JOIN pGRClassRange ON pGRSizeRange.SizeRangeGuidId = pGRClassRange.SizeRangeGuidId 
--WHERE  (pGRClassRange.ClassRangeId = @SizeRangeID)

SELECT @SizeRangeName = SizeRange FROM pGRClassRange WITH (NOLOCK) WHERE ClassRangeId = @SizeRangeID

SELECT @ProductTypeName = Product FROM  pGRProductCompany WITH (NOLOCK) WHERE ProductCompanyId = @ProductTypeID


SELECT @MaxSizeCol = count(sizecount) FROM pGRSizeRangeDetail WITH (NOLOCK) WHERE ClassRangeId = @SizeRangeID

Set @SizeColCnt=0
set @IsSample=0
set @Isvisible=1
set @SizeCount=0

INSERT INTO pamlmeashdr(AMLMeasHdrId, WorkflowID, WorkflowItemID, StyleSet, Styleid, Companyid, CompanyName, IsRelative, IsNegative, IsMetric,
SizeClassId, SizeClass, SizeRangeId, SizeRange, ProductTypeId, ProductType, MeasRowCnt, CUser, CDate, MUser, MDate)
values (@AMLMeasHdrId, @WorkflowID, @WorkflowItemID, @StyleSet, @StyleID, @CompanyID, @CompanyName, @IsRelative, @IsNegative, @IsMetric,
@SizeClassID, @SizeClassName, @SizeRangeID, @SizeRangeName, @ProductTypeID, @ProductTypeName, 0, @CUser,
@CDate, @CUser, @CDate)

IF @MaxSizeCol  > 0 
	Begin
		
		DECLARE cursor_pGRSizeRangeDetail CURSOR FOR
		SELECT SizeRangeDetailId, SizeName, SizeDesc FROM pGRSizeRangeDetail
		WHERE (ClassRangeId = @SizeRangeID) ORDER BY SizeCount
	
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

			Insert into pamlmeaslbl(
			AMLMeasHdrId, 
			SizeRangeId, 
			SizeRangeDetailId, 
			sizecol, 
			MeasLbl, 
			Isvisible, 
			Issample,
			MeasDesc, 
			Cuser, 
			CDate, 
			MUser, 
			MDate) 
			values 
			(
			@AMLMeasHdrId, 
			@SizeRange, 
			@SizeRangeDetailId, 
			@SizeCount, 
			@SizeName, 
			@Isvisible, 
			@IsSample, 
			@SizeDesc, 
			@CUser,
			@CDate, 
			@CUser, 
			@CDate)
			
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
	@PrimaryKeysOnly,
	@samplecol,
	@CUser,
	@CDate
	
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09543', GetDate())
GO
