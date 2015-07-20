
/****** Object:  StoredProcedure [dbo].[spx_Style_MeasHowto_UPDATE]    Script Date: 10/28/2010 13:40:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create PROCEDURE [dbo].[spx_StyleMeasHowto_UPDATE]
(@AMLMeasHdrId uniqueidentifier,
@AMLMeasPOMId uniqueidentifier,
@Refcode nvarchar(10),
@How2MeasText nvarchar(4000),
@ImageId nvarchar(50),
@ModifiedBy nvarchar(200),
@ModifiedDate datetime
)
AS 

if Len(@ImageId) > 0 
	begin
		Update pamlmeaspom set How2MeasText=@How2MeasText, ImageId= cast(@ImageId as nvarchar(50)), MUser=@ModifiedBy, MDate=@ModifiedDate 
		where AMLMeasHdrId=@AMLMeasHdrId and AMLMeasPOMId=@AMLMeasPOMId and Refcode=@Refcode
	end
else
	begin
		Update pamlmeaspom set How2MeasText=@How2MeasText, MUser=@ModifiedBy, MDate=@ModifiedDate 
		where AMLMeasHdrId=@AMLMeasHdrId and AMLMeasPOMId=@AMLMeasPOMId and Refcode=@Refcode
	end
	
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '4.0.0000', '618', GetDate())
GO
