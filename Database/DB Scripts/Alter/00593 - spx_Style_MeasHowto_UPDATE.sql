set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON
go


IF EXISTS (select * from sysobjects where id = object_id('spx_Style_MeasHowto_UPDATE') and sysstat & 0xf = 4)
    drop procedure spx_Style_MeasHowto_UPDATE
GO

Create PROCEDURE [dbo].[spx_Style_MeasHowto_UPDATE]
(@AMLMeasHdrId uniqueidentifier,
@AMLMeasPOMId uniqueidentifier,
@Refcode nvarchar(10),
@How2MeasText nvarchar(4000),
@ModifiedBy nvarchar(200),
@ModifiedDate datetime
)
AS 

Update pamlmeaspom set How2MeasText=@How2MeasText, MUser=@ModifiedBy, MDate=@ModifiedDate 
where AMLMeasHdrId=@AMLMeasHdrId and AMLMeasPOMId=@AMLMeasPOMId and Refcode=@Refcode

GO
INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.0.0000', '593', GetDate())
GO