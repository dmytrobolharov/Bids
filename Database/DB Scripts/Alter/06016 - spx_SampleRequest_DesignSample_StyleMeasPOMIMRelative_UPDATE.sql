/****** Object:  StoredProcedure [dbo].[spx_SampleRequest_DesignSample_StyleMeasPOMIMRelative_UPDATE]    Script Date: 07/10/2013 12:07:27 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_SampleRequest_DesignSample_StyleMeasPOMIMRelative_UPDATE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_SampleRequest_DesignSample_StyleMeasPOMIMRelative_UPDATE]
GO
/****** Object:  StoredProcedure [dbo].[spx_SampleRequest_DesignSample_StyleMeasPOMIMRelative_UPDATE]    Script Date: 07/10/2013 12:07:27 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[spx_SampleRequest_DesignSample_StyleMeasPOMIMRelative_UPDATE]
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

select @sizecol = sizecol from pSampleRequestamlmeaslbl where SampleRequestamlmeashdrid=@AMLMeasHdrId and issample=1
select @Metric=Ismetric from pSampleRequestamlmeashdr where SampleRequestamlmeashdrid = @AMLMeasHdrId

if  @Metric = '0'
	begin
		select @samplevalue = Incr from pSampleRequestamlmeasigc  where SampleRequestamlmeashdrid = cast(@AmlMeasHdrID as nvarchar(50)) and
		SampleRequestamlmeaspomid = cast(@AMLMeasPOMId as nvarchar(50)) and pom_row = @POMRow and  sizecol = @sizecol 

		Update pSampleRequestamlmeasigc  set Grade = (@samplevalue + incr), ConvGrade=((@samplevalue + incr)*2.54) 
		where SampleRequestamlmeashdrid = cast(@AmlMeasHdrID as nvarchar(50)) and
		SampleRequestamlmeaspomid = cast(@AMLMeasPOMId as nvarchar(50)) and pom_row = @POMRow and sizecol <> @sizecol

		Update pSampleRequestamlmeasigc  set Grade = @samplevalue, ConvGrade=(@samplevalue*2.54) 
		where SampleRequestamlmeashdrid = cast(@AmlMeasHdrID as nvarchar(50)) and
		SampleRequestamlmeaspomid = cast(@AMLMeasPOMId as nvarchar(50)) and pom_row = @POMRow and sizecol = @sizecol
	end
else
	begin
		select @samplevalue = Incr from pSampleRequestamlmeasigc  where SampleRequestamlmeashdrid = cast(@AmlMeasHdrID as nvarchar(50)) and
		SampleRequestamlmeaspomid = cast(@AMLMeasPOMId as nvarchar(50)) and pom_row = @POMRow and  sizecol = @sizecol 

		Update pSampleRequestamlmeasigc  set Grade = (@samplevalue + incr), ConvGrade=((@samplevalue + incr)/(2.54)) 
		where SampleRequestamlmeashdrid = cast(@AmlMeasHdrID as nvarchar(50)) and
		SampleRequestamlmeaspomid = cast(@AMLMeasPOMId as nvarchar(50)) and pom_row = @POMRow and sizecol <> @sizecol

		Update pSampleRequestamlmeasigc  set Grade = @samplevalue, ConvGrade=(@samplevalue/(2.54)) 
		where SampleRequestamlmeashdrid = cast(@AmlMeasHdrID as nvarchar(50)) and
		SampleRequestamlmeaspomid = cast(@AMLMeasPOMId as nvarchar(50)) and pom_row = @POMRow and sizecol = @sizecol
	end

--select * from pamlmeasigc order by pom_row, sizecol





GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '06016', GetDate())
GO