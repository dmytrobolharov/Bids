-- **********************************************************************************************/
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Alter Script                                                                               */
-- * Database:                                                                                  */
-- * 25 January 2012                                                                            */
-- *                                                                                            */
-- * Copyright (c) 2002-2012 Gerber Technology, Inc.  All rights reserved.                      */
-- * This information is confidential and proprietary.  You may not disseminate it              */
-- * to any other party without the express written consent of Gerber Technology, Inc.          */
-- *                                                                                            */
-- **********************************************************************************************/
-- **********************************************************************************************/
-- COMMENTS
--
--
--
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET NOCOUNT ON
GO

IF EXISTS (select * from sysobjects where id = object_id('spx_StyleMeasLibraryIGC_Insert') and sysstat & 0xf = 4)
    drop procedure spx_StyleMeasLibraryIGC_Insert
GO


CREATE PROCEDURE spx_StyleMeasLibraryIGC_Insert
(
	@AMLMeasHdrId nvarchar(50),
	@AMLMeasPOMId nvarchar(50),
	@POMRow int,
	@samplesizecol int,
	@prevsamplesizecol int,
	@IsNegative int	
)
AS

CREATE TABLE #tempSampleLibIGCData (
 amlmeashdrid uniqueidentifier,
 amlmeaspomid uniqueidentifier,
 amlmeasigcid uniqueidentifier,
 pom_row int,
 sizecol int, 
 Incr decimal(18,4)
 )

--select @maxsizecol = max(sizecol) from pamlmeaslbl where amlmeashdrid=@AMLMeasHdrId
--select @minsizecol =min(sizecol) from pamlmeaslbl where amlmeashdrid=@AMLMeasHdrId
--select @samplesizecol = sizecol from pamlmeaslbl where amlmeashdrid=@AMLMeasHdrId and issample=-1


Begin

if @samplesizecol < @prevsamplesizecol
	begin
        If @IsNegative=1
			begin
				Insert into #tempSampleLibIGCData
				SELECT x.amlmeashdrid, x.amlmeaspomid, x.amlmeasigcid, x.pom_row,  x.sizecol as sizecol,
				cast((case left(y.Incr,1) when '-' then substring(convert(nvarchar(20),y.incr), 2,(len(y.incr)-1))  else y.incr end) as decimal(18,4)) as Incr
				FROM pamlmeasigc AS x
				left JOIN pamlmeasigc AS y
				ON x.sizecol = y.sizecol + 1 where x.pom_row=y.pom_row and x.amlmeaspomid=y.amlmeaspomid 
				and x.amlmeashdrid=y.amlmeashdrid and x.amlmeashdrid = @AMLMeasHdrId  and x.amlmeaspomid = @AMLMeasPOMId
				and x.pom_row = @POMRow and x.sizecol >= @samplesizecol and x.sizecol <= @prevsamplesizecol order by x.pom_row, x.sizecol		
			end
		else
			begin
				Insert into #tempSampleLibIGCData
				SELECT x.amlmeashdrid, x.amlmeaspomid, x.amlmeasigcid, x.pom_row,  x.sizecol as sizecol, y.incr as Incr				
				FROM pamlmeasigc AS x
				left JOIN pamlmeasigc AS y
				ON x.sizecol = y.sizecol + 1 where x.pom_row=y.pom_row and x.amlmeaspomid=y.amlmeaspomid 
				and x.amlmeashdrid=y.amlmeashdrid and x.amlmeashdrid =  @AMLMeasHdrId  and x.amlmeaspomid = @AMLMeasPOMId
				and x.pom_row = @POMRow and x.sizecol >= @samplesizecol and x.sizecol <= @prevsamplesizecol order by x.pom_row, x.sizecol		
			end
	end
else
	begin
		If @IsNegative=1
			begin
				Insert into #tempSampleLibIGCData
				SELECT y.amlmeashdrid, y.amlmeaspomid, y.amlmeasigcid, y.pom_row, y.sizecol as Sizecol,
				cast((case left(x.Incr,1) when '-' then x.incr else '-' + convert(nvarchar(25),x.Incr) end) as decimal(18,4)) as Incr	
				FROM pamlmeasigc AS x
				left JOIN pamlmeasigc AS y
				ON x.sizecol = y.sizecol + 1 where x.pom_row=y.pom_row and x.amlmeaspomid=y.amlmeaspomid 
				and x.amlmeashdrid=y.amlmeashdrid and y.amlmeashdrid =  @AMLMeasHdrId and x.amlmeaspomid = @AMLMeasPOMId
				and x.pom_row = @POMRow and x.sizecol > @prevsamplesizecol and x.sizecol <= @samplesizecol
				order by x.pom_row, x.sizecol
			end
		else
			begin
				Insert into #tempSampleLibIGCData
				SELECT y.amlmeashdrid, y.amlmeaspomid, y.amlmeasigcid, y.pom_row, y.sizecol as Sizecol,x.Incr as Incr					
				FROM pamlmeasigc AS x
				left JOIN pamlmeasigc AS y
				ON x.sizecol = y.sizecol + 1 where x.pom_row=y.pom_row and x.amlmeaspomid=y.amlmeaspomid 
				and x.amlmeashdrid=y.amlmeashdrid and y.amlmeashdrid =  @AMLMeasHdrId and x.amlmeaspomid = @AMLMeasPOMId
				and x.pom_row = @POMRow and x.sizecol > @prevsamplesizecol and x.sizecol <= @samplesizecol
				order by x.pom_row, x.sizecol
			end
	end

--sample column
Insert into #tempSampleLibIGCData		
SELECT amlmeashdrid, amlmeaspomid, amlmeasigcid, pom_row, sizecol, convert(decimal(18,4),0) as Incr	
		from pamlmeasigc 		
		where amlmeashdrid = @AMLMeasHdrId and amlmeaspomid = @AMLMeasPOMId and sizecol = @samplesizecol
		order by pom_row, sizecol					


--select * from #tempSampleLibIGCData

Update pamlmeasigc  set pamlmeasigc.Incr=#tempSampleLibIGCData.Incr
FROM  pamlmeasigc  INNER JOIN #tempSampleLibIGCData ON pamlmeasigc.amlmeasigcid = #tempSampleLibIGCData.amlmeasigcid AND 
pamlmeasigc.amlmeaspomid = #tempSampleLibIGCData.amlmeaspomid AND 
pamlmeasigc.amlmeashdrid = #tempSampleLibIGCData.amlmeashdrid and 
pamlmeasigc.pom_row=#tempSampleLibIGCData.pom_row and pamlmeasigc.sizecol=#tempSampleLibIGCData.sizecol 
where pamlmeasigc.amlmeashdrid=@AMLMeasHdrId and  pamlmeasigc.amlmeaspomid = @AMLMeasPOMId and pamlmeasigc.pom_row = @POMRow

--select * from pamlmeasigc where amlmeashdrid=@AMLMeasHdrId order by pom_row, sizecol
--select * from pamlmeaslbl where issample=-1 and amlmeashdrid=@AMLMeasHdrId order by sizecol
DROP TABLE #tempSampleLibIGCData
end
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '4.2.0000', '03012', GetDate())
GO

SET NOCOUNT Off
GO
