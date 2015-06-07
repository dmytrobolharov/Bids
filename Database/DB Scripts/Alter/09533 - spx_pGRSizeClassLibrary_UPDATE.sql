IF OBJECT_ID(N'[dbo].[spx_pGRSizeClassLibrary_UPDATE]') IS NOT NULL
 DROP PROCEDURE [dbo].[spx_pGRSizeClassLibrary_UPDATE]
GO

CREATE PROCEDURE [dbo].[spx_pGRSizeClassLibrary_UPDATE]
(@SizeClassGuidId  uniqueidentifier,
@SizeClass nvarchar(400),
@MUser nvarchar(200),
@MDate datetime  
)


AS 

UPDATE pGRSizeClass
SET   SizeClass =@SizeClass, MUser= @MUser, MDate = @MDate 
WHERE     (SizeClassGuidId = @SizeClassGuidId)


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09533', GetDate())
GO
