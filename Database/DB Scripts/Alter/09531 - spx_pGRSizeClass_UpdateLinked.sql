IF OBJECT_ID(N'[dbo].[spx_pGRSizeClass_UpdateLinked]') IS NOT NULL
 DROP PROCEDURE [dbo].[spx_pGRSizeClass_UpdateLinked]
GO

Create PROCEDURE [dbo].[spx_pGRSizeClass_UpdateLinked]
(@SizeClassGuidId uniqueidentifier,
@SizeClass nvarchar(400),
@MUser nvarchar(100),
@MDate datetime)


AS 


UPDATE pGRSizeClassCompany
set SizeClass=@SizeClass, MUser = @MUser,  MDate = @MDate 
WHERE SizeClassGuidId=@SizeClassGuidId AND IsLinked=1


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09531', GetDate())
GO
