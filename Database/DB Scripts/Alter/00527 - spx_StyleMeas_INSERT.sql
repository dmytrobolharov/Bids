set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON
go


IF EXISTS (select * from sysobjects where id = object_id('spx_StyleMeas_INSERT') and sysstat & 0xf = 4)
    drop procedure spx_StyleMeas_INSERT
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



SELECT @MaxPomRow = isnull(MAX(pom_row),0) FROM pamlmeaspom WITH (NOLOCK) WHERE AMLMeasHdrId = @AMLMeasHdrId
SELECT @MaxWSRowid = isnull(MeasRowCnt,0) FROM pamlmeasHdr WITH (NOLOCK) WHERE AMLMeasHdrId = @AMLMeasHdrId
SELECT @MaxSizeCol = isnull(MAX(SizeCol),0) FROM pamlmeaslbl WITH (NOLOCK) WHERE AMLMeasHdrId = @AMLMeasHdrId

Set @MaxPomRow=@MaxPomRow+1
Set @SizeColCnt=0

--if @MaxPomRow is null 
--	begin
--		Set @MaxPomRow=0
--	end
--else
--	begin
--		Set @MaxPomRow=@MaxPomRow+1
--	end
--
--if @MaxWSRowid = null 
--	begin
--		Set @MaxWSRowid=0
--	end
--
--if @MaxSizeCol = null 
--	begin
--		Set @MaxSizeCol=0
--	end

--Set @MaxPomRow=@MaxPomRow+1

/*
WHILE @SizeColCnt <= @MaxSizeCol 
BEGIN
	SET @SizeColCnt = @SizeColCnt + 1
end

return @SizeColCnt
*/

Update pamlmeashdr set MeasRowCnt=@MaxPomRow where AMLMeasHdrId = @AMLMeasHdrId


INSERT INTO pamlmeaspom(AMLMeasHdrId, POM_Row, Refcode, Description, WSRowid, CUser, CDate, 
	MUser, MDate)
values (@AMLMeasHdrId, @MaxPomRow, @RefCode, @RefCode, @MaxPomRow, @MUser, @MDate, @MUser, @MDate)


select @AMLMeasPomId = AMLMeasPomId from pamlmeaspom where AMLMeasHdrId= @AMLMeasHdrId and POM_Row=@MaxPomRow and Refcode=@RefCode


WHILE @SizeColCnt <= @MaxSizeCol 
BEGIN
		INSERT INTO pamlmeasigc(AMLMeasHdrId, AMLMeasPomId, POM_Row, WSRowid, SizeCol, CUser, CDate,
			MUser, MDate)
		values (@AMLMeasHdrId, @AMLMeasPomId, @MaxPomRow, @MaxPomRow, @SizeColCnt, @MUser, @MDate, @MUser, @MDate)
		
		SET @SizeColCnt = @SizeColCnt + 1
END

return @SizeColCnt

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.0.0000', '527', GetDate())
GO

