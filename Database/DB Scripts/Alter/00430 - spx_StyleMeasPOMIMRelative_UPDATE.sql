
/****** Object:  StoredProcedure [dbo].[spx_StyleMeasPOMIMRelative_UPDATE]    Script Date: 09/20/2010 08:51:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spx_StyleMeasPOMIMRelative_UPDATE]
(@AMLMeasHdrId uniqueidentifier,
 @AMLMeasPOMId uniqueidentifier,
 @POMRow int
)
AS 

DECLARE @query NVARCHAR(4000)
DECLARE @queryUpd NVARCHAR(4000)
DECLARE @queryUpdSample NVARCHAR(4000)
Declare @sizecol int
Declare @samplevalue decimal(18,4)
Declare @Metric nvarchar(2)

select @sizecol = sizecol from pamlmeaslbl where amlmeashdrid=@AMLMeasHdrId and issample=-1
select @Metric=Ismetric from pamlmeashdr where amlmeashdrid = @AMLMeasHdrId

if  @Metric = '0'
	begin
		select @samplevalue = Incr from pamlmeasigc  where amlmeashdrid = cast(@AmlMeasHdrID as nvarchar(50)) and
		amlmeaspomid = cast(@AMLMeasPOMId as nvarchar(50)) and pom_row = @POMRow and  sizecol = @sizecol 

		Update pamlmeasigc  set Grade = (@samplevalue + incr), ConvGrade=((@samplevalue + incr)*2.54) 
		where amlmeashdrid = cast(@AmlMeasHdrID as nvarchar(50)) and
		amlmeaspomid = cast(@AMLMeasPOMId as nvarchar(50)) and pom_row = @POMRow and sizecol <> @sizecol

		Update pamlmeasigc  set Grade = @samplevalue, ConvGrade=(@samplevalue*2.54) 
		where amlmeashdrid = cast(@AmlMeasHdrID as nvarchar(50)) and
		amlmeaspomid = cast(@AMLMeasPOMId as nvarchar(50)) and pom_row = @POMRow and sizecol = @sizecol
	end
else
	begin
		select @samplevalue = Incr from pamlmeasigc  where amlmeashdrid = cast(@AmlMeasHdrID as nvarchar(50)) and
		amlmeaspomid = cast(@AMLMeasPOMId as nvarchar(50)) and pom_row = @POMRow and  sizecol = @sizecol 

		Update pamlmeasigc  set Grade = (@samplevalue + incr), ConvGrade=((@samplevalue + incr)/(2.54)) 
		where amlmeashdrid = cast(@AmlMeasHdrID as nvarchar(50)) and
		amlmeaspomid = cast(@AMLMeasPOMId as nvarchar(50)) and pom_row = @POMRow and sizecol <> @sizecol

		Update pamlmeasigc  set Grade = @samplevalue, ConvGrade=(@samplevalue/(2.54)) 
		where amlmeashdrid = cast(@AmlMeasHdrID as nvarchar(50)) and
		amlmeaspomid = cast(@AMLMeasPOMId as nvarchar(50)) and pom_row = @POMRow and sizecol = @sizecol
	end

--select * from pamlmeasigc order by pom_row, sizecol


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.0.0000', '430', GetDate())
GO

