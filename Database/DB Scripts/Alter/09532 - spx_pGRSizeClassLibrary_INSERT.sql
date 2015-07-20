IF OBJECT_ID(N'[dbo].[spx_pGRSizeClassLibrary_INSERT]') IS NOT NULL
 DROP PROCEDURE [dbo].[spx_pGRSizeClassLibrary_INSERT]
GO

CREATE PROCEDURE [dbo].[spx_pGRSizeClassLibrary_INSERT]
(@SizeClassGuidId  uniqueidentifier,
@SizeClass nvarchar(400),
@CUser nvarchar(200),
@CDate datetime,
@MUser nvarchar(200),
@MDate datetime  
)

AS 

INSERT INTO pGRSizeClass
    (SizeClassGuidId, SizeClass, CDate, CUser, MUser, MDate)
VALUES (@SizeClassGuidId, @SizeClass, @CDate, @CUser, @MUser, @MDate)

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09532', GetDate())
GO
