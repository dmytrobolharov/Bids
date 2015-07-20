/****** Object:  StoredProcedure [dbo].[spx_SampleRequest_DesignSample_Meas_Delete]    Script Date: 07/02/2013 15:43:09 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_SampleRequest_DesignSample_Meas_Delete]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_SampleRequest_DesignSample_Meas_Delete]
GO

/****** Object:  StoredProcedure [dbo].[spx_SampleRequest_DesignSample_Meas_Delete]    Script Date: 07/02/2013 15:43:09 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spx_SampleRequest_DesignSample_Meas_Delete]
(	@SampleRequestAMLMeasHdrId uniqueidentifier,
	@SampleRequestAMLMeasPOMId uniqueidentifier,	
	@POMRow int	
)

AS 


Begin
	Delete from pSampleRequestamlmeaspom where SampleRequestAMLMeasHdrId=@SampleRequestAMLMeasHdrId and 
	SampleRequestAMLMeasPOMId=@SampleRequestAMLMeasPOMId and POM_Row=@POMRow

	Delete from pSampleRequestamlmeasigc where SampleRequestAMLMeasHdrId=@SampleRequestAMLMeasHdrId and 
	SampleRequestAMLMeasPOMId=@SampleRequestAMLMeasPOMId and POM_Row=@POMRow
End


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '05965', GetDate())
GO
