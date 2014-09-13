SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.ROUTINES WHERE SPECIFIC_NAME = N'spx_pSizeRange_INSERT')
   DROP PROCEDURE spx_pSizeRange_INSERT
GO


Create PROCEDURE [dbo].[spx_pSizeRange_INSERT]
(@SizeRangeCode nvarchar(50),
@Size0 nvarchar(9),
@Size1 nvarchar(9),
@Size2 nvarchar(9),
@Size3 nvarchar(9),
@Size4 nvarchar(9),
@Size5 nvarchar(9),
@Size6 nvarchar(9),
@Size7 nvarchar(9),
@Size8 nvarchar(9),
@Size9 nvarchar(9),
@Size10 nvarchar(9),
@Size11 nvarchar(9),
@Size12 nvarchar(9),
@Size13 nvarchar(9),
@Size14 nvarchar(9),
@Size15 nvarchar(9),
@Size16 nvarchar(9),
@Size17 nvarchar(9),
@Size18 nvarchar(9),
@Size19 nvarchar(9),
@Size20 nvarchar(9),
@Size21 nvarchar(9),
@Size22 nvarchar(9),
@Size23 nvarchar(9),
@Size24 nvarchar(9),
@Size25 nvarchar(9),
@Size26 nvarchar(9),
@Size27 nvarchar(9),
@Size28 nvarchar(9),
@Size29 nvarchar(9),
@Size30 nvarchar(9),
@Size31 nvarchar(9),
@Size32 nvarchar(9),
@Size33 nvarchar(9),
@Size34 nvarchar(9),
@Size35 nvarchar(9),
@Size36 nvarchar(9),
@Size37 nvarchar(9),
@Size38 nvarchar(9),
@Size39 nvarchar(9),
@Size40 nvarchar(9),
@Size41 nvarchar(9),
@Size42 nvarchar(9),
@Size43 nvarchar(9),
@Size44 nvarchar(9),
@Size45 nvarchar(9),
@Size46 nvarchar(9),
@Size47 nvarchar(9),
@Size48 nvarchar(9),
@Size49 nvarchar(9),
@Sel0 bit,
@Sel1 bit,
@Sel2 bit,
@Sel3 bit,
@Sel4 bit,
@Sel5 bit,
@Sel6 bit,
@Sel7 bit,
@Sel8 bit,
@Sel9 bit,
@Sel10 bit,
@Sel11 bit,
@Sel12 bit,
@Sel13 bit,
@Sel14 bit,
@Sel15 bit,
@Sel16 bit,
@Sel17 bit,
@Sel18 bit,
@Sel19 bit,
@Sel20 bit,
@Sel21 bit,
@Sel22 bit,
@Sel23 bit,
@Sel24 bit,
@Sel25 bit,
@Sel26 bit,
@Sel27 bit,
@Sel28 bit,
@Sel29 bit,
@Sel30 bit,
@Sel31 bit,
@Sel32 bit,
@Sel33 bit,
@Sel34 bit,
@Sel35 bit,
@Sel36 bit,
@Sel37 bit,
@Sel38 bit,
@Sel39 bit,
@Sel40 bit,
@Sel41 bit,
@Sel42 bit,
@Sel43 bit,
@Sel44 bit,
@Sel45 bit,
@Sel46 bit,
@Sel47 bit,
@Sel48 bit,
@Sel49 bit,
@Active bit,
@CreatedBy nvarchar(100),
@CreatedDate datetime)
AS 


begin

declare @NoOfSize int

SELECT @NoOfSize = COUNT(SizeRangeCode)  FROM  pSizeRange WITH (NOLOCK)
WHERE  (SizeRangeCode = @SizeRangeCode)

SELECT @NoOfSize As NoOfSize

end


IF @NoOfSize = 0 

BEGIN

INSERT INTO dbo.pSizeRange
	(SizeRangeCode, Size0, Size1, Size2, Size3, Size4, Size5, Size6, Size7, Size8, Size9, Size10, Size11, Size12, Size13, Size14, Size15, Size16, 
	Size17, Size18, Size19, Size20, Size21, Size22, Size23, Size24, Size25, Size26, Size27, Size28, Size29, Size30, Size31, Size32, Size33, Size34, Size35, Size36, 
	Size37, Size38, Size39, Size40, Size41, Size42, Size43, Size44, Size45, Size46, Size47, Size48, Size49,
	Sel0, Sel1, Sel2, Sel3, Sel4, Sel5, Sel6, Sel7, Sel8, Sel9, Sel10, Sel11, Sel12, Sel13, Sel14, Sel15, Sel16, Sel17, Sel18, 
	Sel19,Sel20, Sel21, Sel22, Sel23, Sel24, Sel25, Sel26, Sel27, Sel28, Sel29, Sel30, Sel31, Sel32, Sel33, Sel34, Sel35, Sel36, Sel37, Sel38, 
	Sel39, Sel40, Sel41, Sel42, Sel43, Sel44, Sel45, Sel46, Sel47, Sel48, Sel49, Active, CUser, CDate, MUser, MDate)
VALUES (@SizeRangeCode, @Size0, @Size1, @Size2, @Size3, @Size4, @Size5, @Size6, @Size7, @Size8, @Size9, @Size10, @Size11, @Size12, 
	@Size13, @Size14, @Size15, @Size16, @Size17, @Size18, @Size19, @Size20, @Size21, @Size22, @Size23, @Size24, @Size25, @Size26, @Size27, @Size28, @Size29, @Size30, @Size31, @Size32, 
	@Size33, @Size34, @Size35, @Size36, @Size37, @Size38, @Size39, @Size40, @Size41, @Size42, @Size43, @Size44, @Size45, @Size46, @Size47, @Size48, @Size49,
	@Sel0, @Sel1, @Sel2, @Sel3, @Sel4, @Sel5, @Sel6, @Sel7, @Sel8, @Sel9, @Sel10, @Sel11, @Sel12, @Sel13, @Sel14, @Sel15, @Sel16, @Sel17, @Sel18, @Sel19, 
	@Sel20, @Sel21, @Sel22, @Sel23, @Sel24, @Sel25, @Sel26, @Sel27, 
	@Sel28, @Sel29, @Sel30, @Sel31, @Sel32, @Sel33, @Sel34, @Sel35, @Sel36, @Sel37, @Sel38, @Sel39, 
	@Sel40, @Sel41, @Sel42, @Sel43, @Sel44, @Sel45, @Sel46, @Sel47, @Sel48, @Sel49, @Active, @CreatedBy, @CreatedDate, @CreatedBy, 	@CreatedDate)


SELECT 0 As NoOfSize
END

ELSE

BEGIN
SELECT @NoOfSize As NoOfSize
END


GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='02073'))
	BEGIN
		INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
		VALUES ('DB_Version', '4.1.0000', '02073', GetDate())
	END
GO