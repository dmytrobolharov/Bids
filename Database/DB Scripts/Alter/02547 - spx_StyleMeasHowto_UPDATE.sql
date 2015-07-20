
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleMeasHowto_UPDATE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleMeasHowto_UPDATE]
GO

/****** Object:  StoredProcedure [dbo].[spx_StyleMeasHowto_UPDATE]  Script Date: 01/05/2012 17:39:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


Create PROCEDURE [dbo].[spx_StyleMeasHowto_UPDATE]
(@AMLMeasHdrId uniqueidentifier,
@AMLMeasPOMId uniqueidentifier,
@Refcode nvarchar(10),
@How2MeasText nvarchar(4000),
@ImageId nvarchar(50),
@ModifiedBy nvarchar(200),
@ModifiedDate datetime
)
AS 
BEGIN

Declare @POMGuidId nvarchar(50)

select @POMGuidId = POMGuidId from pamlmeaspom where AMLMeasHdrId=@AMLMeasHdrId and 
AMLMeasPOMId=@AMLMeasPOMId

IF LEN(@ImageId) > 0 
	BEGIN
		UPDATE pamlmeaspom SET How2MeasText=@How2MeasText, ImageId= CAST(@ImageId AS NVARCHAR(50)), MUser=@ModifiedBy, MDate=@ModifiedDate 
		--WHERE  AMLMeasHdrId=@AMLMeasHdrId and POMGuidId=@POMGuidId  AND RefCode=@Refcode 
		WHERE  AMLMeasHdrId=@AMLMeasHdrId and AMLMeasPOMId=@AMLMeasPOMId AND RefCode=@Refcode
	END
ELSE
	BEGIN
		UPDATE pamlmeaspom SET How2MeasText=@How2MeasText, MUser=@ModifiedBy, MDate=@ModifiedDate 
		--WHERE AMLMeasHdrId=@AMLMeasHdrId and POMGuidId=@POMGuidId  AND RefCode=@Refcode	
		WHERE  AMLMeasHdrId=@AMLMeasHdrId and AMLMeasPOMId=@AMLMeasPOMId AND RefCode=@Refcode
	END
END


GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='02547'))
BEGIN

	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.2.0000', '02547', GetDate())

END

GO