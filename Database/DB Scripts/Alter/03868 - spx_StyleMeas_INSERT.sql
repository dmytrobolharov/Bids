IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleMeas_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleMeas_INSERT]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spx_StyleMeas_INSERT]
(	@AMLMeasHdrId uniqueidentifier,
	@RefCode nvarchar(10),	
	@MUser nvarchar(200),
	@MDate datetime 
)

AS 


DECLARE @MaxPomRow int 
DECLARE @MaxWSRowid	int 
DECLARE @MaxSizeCol int
DECLARE @SizeColCnt int
DECLARE @AMLMeasPomId uniqueidentifier 
DECLARE @MaxSort int


SELECT @MaxPomRow = isnull(MAX(pom_row),0), @MaxSort=ISNULL(MAX(SortId), 0), @MaxWSRowid = COALESCE(max(WSRowid),0) FROM pamlmeaspom WITH (NOLOCK) WHERE AMLMeasHdrId = @AMLMeasHdrId

SELECT @MaxSizeCol = isnull(MAX(SizeCol),0) FROM pamlmeaslbl WITH (NOLOCK) WHERE AMLMeasHdrId = @AMLMeasHdrId

Set @MaxPomRow=@MaxPomRow+1
Set @SizeColCnt=0
Set @MaxSort = @MaxSort+1

UPDATE pamlmeashdr SET MeasRowCnt=@MaxPomRow WHERE AMLMeasHdrId = @AMLMeasHdrId


INSERT INTO pamlmeaspom(AMLMeasHdrId, POM_Row, Refcode, Description, WSRowid, CUser, CDate, 
	MUser, MDate)
values (@AMLMeasHdrId, @MaxPomRow, @RefCode, @RefCode, @MaxWSRowid, @MUser, @MDate, @MUser, @MDate)


select @AMLMeasPomId = AMLMeasPomId from pamlmeaspom where AMLMeasHdrId= @AMLMeasHdrId and POM_Row=@MaxPomRow and Refcode=@RefCode


WHILE @SizeColCnt <= @MaxSizeCol 
BEGIN
		INSERT INTO pamlmeasigc(AMLMeasHdrId, AMLMeasPomId, POM_Row, WSRowid, SizeCol, CUser, CDate,
			MUser, MDate)
		values (@AMLMeasHdrId, @AMLMeasPomId, @MaxPomRow, @MaxWSRowid, @SizeColCnt, @MUser, @MDate, @MUser, @MDate)
		
		SET @SizeColCnt = @SizeColCnt + 1
END

UPDATE pAMLMeasPOM SET SortId = @MaxSort WHERE SortId = 0 AND AMLMeasPOMId=@AMLMeasPomId

return @SizeColCnt


GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES              ('DB_Version', '5.0.0000', '03868', GetDate())
GO
