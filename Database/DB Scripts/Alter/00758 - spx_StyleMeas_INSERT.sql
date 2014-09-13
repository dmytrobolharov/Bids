
/****** Object:  StoredProcedure [dbo].[spx_StyleMeas_INSERT]    Script Date: 11/18/2010 20:51:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF  EXISTS (SELECT * from INFORMATION_SCHEMA.ROUTINES WHERE SPECIFIC_NAME = N'spx_StyleMeas_INSERT') 
DROP PROCEDURE spx_StyleMeas_INSERT
GO

Create PROCEDURE [dbo].[spx_StyleMeas_INSERT]
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



SELECT @MaxPomRow = isnull(MAX(pom_row),0), @MaxWSRowid = COALESCE(max(WSRowid),0) FROM pamlmeaspom WITH (NOLOCK) WHERE AMLMeasHdrId = @AMLMeasHdrId

SELECT @MaxSizeCol = isnull(MAX(SizeCol),0) FROM pamlmeaslbl WITH (NOLOCK) WHERE AMLMeasHdrId = @AMLMeasHdrId

Set @MaxPomRow=@MaxPomRow+1
Set @SizeColCnt=0


Update pamlmeashdr set MeasRowCnt=@MaxPomRow where AMLMeasHdrId = @AMLMeasHdrId


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

return @SizeColCnt

GO	

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.0.0000', '758', GetDate())
GO