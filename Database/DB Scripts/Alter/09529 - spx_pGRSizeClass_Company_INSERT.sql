IF OBJECT_ID(N'[dbo].[spx_pGRSizeClass_Company_INSERT]') IS NOT NULL
 DROP PROCEDURE [dbo].[spx_pGRSizeClass_Company_INSERT]
GO

Create PROCEDURE [dbo].[spx_pGRSizeClass_Company_INSERT]
(@SizeClassCompanyID   uniqueidentifier,
@SizeClassGuidID  uniqueidentifier,
@CompanyGuidID uniqueidentifier,
@SizeClass nvarchar(400),
@IsLinked int,
@CreatedBy nvarchar(100),
@CreatedDate datetime)


AS INSERT INTO pGRSizeClassCompany
    (SizeClassCompanyID, CompanyGuidID, SizeClassGuidID, SizeClass,IsLinked, CUser, CDate, MUser, MDate)
VALUES (@SizeClassCompanyID, @CompanyGuidID, @SizeClassGuidID, @SizeClass, @IsLinked, @CreatedBy, @CreatedDate, @CreatedBy, @CreatedDate)

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09529', GetDate())
GO
