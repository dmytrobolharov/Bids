/****** Object:  StoredProcedure [dbo].[spx_SampleRequest_DesignSample_Meas_INSERT]    Script Date: 07/02/2013 15:43:55 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_SampleRequest_DesignSample_Meas_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_SampleRequest_DesignSample_Meas_INSERT]
GO

/****** Object:  StoredProcedure [dbo].[spx_SampleRequest_DesignSample_Meas_INSERT]    Script Date: 07/02/2013 15:43:55 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[spx_SampleRequest_DesignSample_Meas_INSERT]
(	@SampleRequestAMLMeasHdrId uniqueidentifier,
	@RefCode nvarchar(10),	
	@MUser nvarchar(200),
	@MDate datetime 
)

AS 


DECLARE @MaxPomRow int 
DECLARE @MaxWSRowid	int 
DECLARE @MaxSizeCol int
DECLARE @SizeColCnt int
DECLARE @SampleRequestAMLMeasPomId uniqueidentifier 
DECLARE @MaxSort int


SELECT @MaxPomRow = isnull(MAX(pom_row),0), @MaxSort=ISNULL(MAX(SortId), 0), @MaxWSRowid = COALESCE(max(WSRowid),0) FROM pSampleRequestamlmeaspom WITH (NOLOCK) WHERE SampleRequestAMLMeasHdrId = @SampleRequestAMLMeasHdrId

SELECT @MaxSizeCol = isnull(MAX(SizeCol),0) FROM pSampleRequestamlmeaslbl WITH (NOLOCK) WHERE SampleRequestAMLMeasHdrId = @SampleRequestAMLMeasHdrId

Set @MaxPomRow=@MaxPomRow+1
Set @SizeColCnt=0
Set @MaxSort = @MaxSort+1

UPDATE pSampleRequestamlmeashdr SET MeasRowCnt=@MaxPomRow WHERE SampleRequestAMLMeasHdrId = @SampleRequestAMLMeasHdrId


INSERT INTO pSampleRequestamlmeaspom(SampleRequestAMLMeasHdrId, POM_Row, Refcode, Description, WSRowid, CUser, CDate, 
	MUser, MDate)
values (@SampleRequestAMLMeasHdrId, @MaxPomRow, @RefCode, @RefCode, @MaxWSRowid, @MUser, @MDate, @MUser, @MDate)


select @SampleRequestAMLMeasPomId = SampleRequestAMLMeasPomId from pSampleRequestamlmeaspom where SampleRequestAMLMeasHdrId= @SampleRequestAMLMeasHdrId and POM_Row=@MaxPomRow and Refcode=@RefCode


WHILE @SizeColCnt <= @MaxSizeCol 
BEGIN
		INSERT INTO pSampleRequestamlmeasigc(SampleRequestAMLMeasHdrId, SampleRequestAMLMeasPomId, POM_Row, WSRowid, SizeCol, CUser, CDate,
			MUser, MDate)
		values (@SampleRequestAMLMeasHdrId, @SampleRequestAMLMeasPomId, @MaxPomRow, @MaxWSRowid, @SizeColCnt, @MUser, @MDate, @MUser, @MDate)
		
		SET @SizeColCnt = @SizeColCnt + 1
END

UPDATE pSampleRequestAMLMeasPOM SET SortId = @MaxSort WHERE SortId = 0 AND SampleRequestAMLMeasPOMId=@SampleRequestAMLMeasPomId

return @SizeColCnt



GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '05968', GetDate())
GO