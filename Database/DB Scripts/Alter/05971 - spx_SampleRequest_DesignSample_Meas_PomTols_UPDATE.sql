/****** Object:  StoredProcedure [dbo].[spx_SampleRequest_DesignSample_Meas_PomTols_UPDATE]    Script Date: 07/02/2013 15:44:50 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_SampleRequest_DesignSample_Meas_PomTols_UPDATE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_SampleRequest_DesignSample_Meas_PomTols_UPDATE]
GO

/****** Object:  StoredProcedure [dbo].[spx_SampleRequest_DesignSample_Meas_PomTols_UPDATE]    Script Date: 07/02/2013 15:44:50 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[spx_SampleRequest_DesignSample_Meas_PomTols_UPDATE]
(
    @SampleRequestAMLMeasHdrId UNIQUEIDENTIFIER,
    @SampleRequestAMLMeasPOMId UNIQUEIDENTIFIER,
    @pomrow int,
    @Refcode nvarchar(12),
    @Description nvarchar(204),
    @showsort nvarchar(4),
    @SortId int,
    @TolPlus numeric(18,4),
    @TolMinus numeric(18,4) , 
    @SampMeas numeric(18,4) ,
    @Revised numeric(18,4) ,
    @ModifiedBy nvarchar(204),
    @ModifiedDate datetime
)
AS

BEGIN 
	if (@showsort='1')
		begin
			UPDATE pSampleRequestAMLMeaspom 
			SET RefCode = @Refcode,
			[Description]=@Description,
			SortId=@SortId,
			TolPlus=@TolPlus,
			TolMinus=@TolMinus,
			MUser=@ModifiedBy,
			MDate=@ModifiedDate,
			SampMeasValue = @SampMeas,
			RevisedSpec = @Revised
			WHERE SampleRequestAMLMeasHdrId = @SampleRequestAMLMeasHdrId
			AND SampleRequestAMLMeasPOMId = @SampleRequestAMLMeasPOMId
			AND pom_row = @pomrow   
		end
	else
		begin
			UPDATE pSampleRequestAMLMeaspom 
			SET RefCode = @Refcode,
			[Description]=@Description,			
			TolPlus=@TolPlus,
			TolMinus=@TolMinus,
			SampMeasValue = @SampMeas,
			RevisedSpec = @Revised,
			MUser=@ModifiedBy,
			MDate=@ModifiedDate
			WHERE SampleRequestAMLMeasHdrId = @SampleRequestAMLMeasHdrId
			AND SampleRequestAMLMeasPOMId = @SampleRequestAMLMeasPOMId
			AND pom_row = @pomrow   
		end    
END


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '05971', GetDate())
GO
