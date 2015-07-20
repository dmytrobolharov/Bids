IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('spx_StyleMeas_PomTols_UPDATE') and sysstat & 0xf = 4)
    DROP PROCEDURE spx_StyleMeas_PomTols_UPDATE
GO
/****** Object:  StoredProcedure [dbo].[spx_StyleMeas_PomTols_UPDATE]    Script Date: 04/13/2011 15:05:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
Create PROCEDURE [dbo].[spx_StyleMeas_PomTols_UPDATE]
(
    @AMLMeasHdrId UNIQUEIDENTIFIER,
    @AMLMeasPOMId UNIQUEIDENTIFIER,
    @pomrow int,
    @Refcode nvarchar(12),
    @Description nvarchar(204),
    @showsort nvarchar(4),
    @SortId int,
    @TolPlus numeric(18,4),
    @TolMinus numeric(18,4) , 
    @ModifiedBy nvarchar(204),
    @ModifiedDate datetime
)
AS

BEGIN 
	if (@showsort='1')
		begin
			UPDATE pAMLMeaspom 
			SET RefCode = @Refcode,
			[Description]=@Description,
			SortId=@SortId,
			TolPlus=@TolPlus,
			TolMinus=@TolMinus,
			MUser=@ModifiedBy,
			MDate=@ModifiedDate
			WHERE AMLMeasHdrId = @AMLMeasHdrId
			AND AMLMeasPOMId = @AMLMeasPOMId
			AND pom_row = @pomrow   
		end
	else
		begin
			UPDATE pAMLMeaspom 
			SET RefCode = @Refcode,
			[Description]=@Description,			
			TolPlus=@TolPlus,
			TolMinus=@TolMinus,
			MUser=@ModifiedBy,
			MDate=@ModifiedDate
			WHERE AMLMeasHdrId = @AMLMeasHdrId
			AND AMLMeasPOMId = @AMLMeasPOMId
			AND pom_row = @pomrow   
		end    
END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '4.1.0000', '01373', GetDate())
GO