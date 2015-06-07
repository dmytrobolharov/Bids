IF OBJECT_ID(N'[dbo].[spx_pGRSizeClass_UPDATE]') IS NOT NULL
 DROP PROCEDURE [dbo].[spx_pGRSizeClass_UPDATE]
GO

CREATE PROCEDURE [dbo].[spx_pGRSizeClass_UPDATE]
(@SizeClassGuidID uniqueidentifier,
@SizeClass nvarchar(400),
@Muser nvarchar(200),
@MDate datetime)
AS 


UPDATE    pGRSizeClass
SET   SizeClass = @SizeClass, MUser = @MUser,  MDate = @MDate
WHERE     SizeClassGuidID = @SizeClassGuidID

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09530', GetDate())
GO
