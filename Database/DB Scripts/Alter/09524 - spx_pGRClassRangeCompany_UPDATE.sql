IF OBJECT_ID(N'[dbo].[spx_pGRClassRangeCompany_UPDATE]') IS NOT NULL
 DROP PROCEDURE [dbo].[spx_pGRClassRangeCompany_UPDATE]
GO

CREATE PROCEDURE [dbo].[spx_pGRClassRangeCompany_UPDATE]
(@ClassRangeId uniqueidentifier,
@SizeRange nvarchar(200),
@Active int,
@IsLinked int,
@Muser nvarchar(200),
@MDate datetime)
AS 


UPDATE    pGRClassRange
SET   SizeRange = @SizeRange, Active = @Active, IsLinked= @IsLinked, MUser = @MUser,  MDate = @MDate
WHERE     ClassRangeId= @ClassRangeId


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09524', GetDate())
GO
