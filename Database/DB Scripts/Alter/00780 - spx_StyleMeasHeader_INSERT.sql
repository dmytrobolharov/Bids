/****** Object:  StoredProcedure [dbo].[spx_StyleMeasHeader_INSERT]    Script Date: 11/24/2010 09:00:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF  EXISTS (SELECT * from INFORMATION_SCHEMA.ROUTINES WHERE SPECIFIC_NAME = N'spx_StyleMeasHeader_INSERT') 
DROP PROCEDURE spx_StyleMeasHeader_INSERT
GO
Create PROCEDURE [dbo].[spx_StyleMeasHeader_INSERT]
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

--SELECT @SizeClassName = SizeClass FROM pGRSizeClass,  WITH (NOLOCK) WHERE SizeClassGuidId = @SizeClassID

SELECT @SizeClassName = pGRSizeClass.SizeClass FROM 
pGRSizeClass INNER JOIN pGRSizeClassCompany ON pGRSizeClass.SizeClassGuidId = pGRSizeClassCompany.SizeClassGuidId 
WHERE (pGRSizeClassCompany.SizeClassCompanyId = @SizeClassID) 

SELECT @SizeRangeName = SizeRange, @SizeRange = pGRSizeRange.SizeRangeGuidId
FROM pGRSizeRange INNER JOIN pGRClassRange ON pGRSizeRange.SizeRangeGuidId = pGRClassRange.SizeRangeGuidId 
WHERE  (pGRClassRange.ClassRangeId = @SizeRangeID)

--SELECT @SizeRangeName = SizeRange FROM pGRSizeRange WITH (NOLOCK) WHERE SizeRangeGuidId = @SizeRangeID

SELECT @ProductTypeName = pGRProduct.Product FROM  pGRProduct INNER JOIN
pGRProductCompany ON pGRProduct.ProductID = pGRProductCompany.ProductId
where pGRProductCompany.ProductCompanyId = @ProductTypeID

SELECT @MaxSizeCol = count(sizecount) FROM pGRSizeRangeDetail WITH (NOLOCK) WHERE SizeRangeId = @SizeRange

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
		WHERE (SizeRangeId = @SizeRange) ORDER BY SizeCount
	
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
			(@AMLMeasHdrId, @SizeRange, @SizeRangeDetailId, @SizeCount, @SizeName, @Isvisible, @IsSample, @SizeDesc, @CUser,
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
	@PrimaryKeysOnly,
	@samplecol,
	@CUser,
	@CDate

GO	

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.0.0000', '780', GetDate())
GO