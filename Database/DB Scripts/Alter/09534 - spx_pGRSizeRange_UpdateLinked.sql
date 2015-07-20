IF OBJECT_ID(N'[dbo].[spx_pGRSizeRange_UpdateLinked]') IS NOT NULL
 DROP PROCEDURE [dbo].[spx_pGRSizeRange_UpdateLinked]
GO

Create PROCEDURE [dbo].[spx_pGRSizeRange_UpdateLinked]
(@SizeRangeGuidId uniqueidentifier,
@Active int,
@SizeRange nvarchar(200),
@MUser nvarchar(100),
@MDate datetime)


AS 


UPDATE pGRClassRange
set SizeRange=@SizeRange, Active =@Active, MUser = @MUser,  MDate = @MDate 
WHERE SizeRangeGuidId=@SizeRangeGuidId AND IsLinked=1


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09534', GetDate())
GO
