/****** Object:  StoredProcedure [dbo].[spx_SampleRequest_MeasQASizeSample_SELECT]    Script Date: 08/23/2012 16:30:00 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_SampleRequest_MeasQASizeSample_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_SampleRequest_MeasQASizeSample_SELECT]
GO

/****** Object:  StoredProcedure [dbo].[spx_SampleRequest_MeasQASizeSample_SELECT]    Script Date: 08/23/2012 16:30:00 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE  PROCEDURE [dbo].[spx_SampleRequest_MeasQASizeSample_SELECT](
@SampleRequestHeaderId nvarchar(50),
@Submit Int
)
AS 

SET NOCOUNT ON

DECLARE @cols NVARCHAR(2000)
DECLARE @Sizehdrcols NVARCHAR(2000)
Declare @Sizecnt integer
Declare @SampleCnt integer
Declare @SizeIndex integer
Declare @SampleIndex integer
DECLARE @samplehdrcols NVARCHAR(2000)
Declare @CreatetblQuery NVARCHAR(4000)
Declare @DefCols NVARCHAR(2000)
Declare @samplepomid nvarchar(50) 
Declare @pomrow int 
Declare @sortid int 
Declare @refcode nvarchar(12) 
Declare @pomdescription nvarchar(204) 
Declare @tolplus  numeric(18,4) 
Declare @tolminus numeric(18,4)  
Declare @imageId  nvarchar(50) 
Declare @samplelabelid nvarchar(50)  
Declare @sizecol int 
Declare @collabel nvarchar(26)  
Declare @sampleno int

select @DefCols = 'SampleRequestHeaderId nvarchar(50), samplepomid nvarchar(50), pomrow int, sortid int, refcode nvarchar(12), pomdescription nvarchar(204),
tolplus numeric(18,4), tolminus numeric(18,4), submit int, imageId nvarchar(50)'

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'#tmpMeasQAsample') AND type in (N'U'))
drop table  [#tmpMeasQAsample]

CREATE TABLE [#tmpMeasQAsample]
(	[tmpMeasQAsampleKey] [int] IDENTITY(1,1) NOT NULL )

declare @sql varchar(2000)
select @sql = 'ALTER TABLE #tmpMeasQAsample ADD ' + @DefCols
exec(@sql)

--select * from [#tmpMeasQAsample]

set @Sizecnt=0
set @SampleCnt=0
set @SizeIndex=0
set @SampleIndex=0


--Define the rest of columns

DECLARE cursor_pQASampLbl CURSOR FOR
	SELECT samplelabelid,  sizecol, Collabel, sampleno FROM pQASampLbl						
	WHERE SampleRequestHeaderId = cast(@SampleRequestHeaderId as nvarchar(50)) ORDER BY sizecol

	OPEN cursor_pQASampLbl

	FETCH NEXT from cursor_pQASampLbl INTO  @samplelabelid, @sizecol, @collabel, @sampleno	
	DECLARE @sizeidcols nvarchar(20)
	DECLARE @sizelabelcols nvarchar(20)	
	DECLARE @sampleidcols nvarchar(20)
	DECLARE @samplelabelcols nvarchar(20)				
	DECLARE @lblIdCnt int
	DECLARE @sampleIdCnt int
	DECLARE @sizecols nvarchar(20)
	DECLARE @sizecolumns nvarchar(2000)
	DECLARE @samplecolumns nvarchar(2000)
	declare @sizesamplecols nvarchar(2000)
	DECLARE @varcolumns nvarchar(2000)
	DECLARE @varidcols nvarchar(20)
	set @lblIdCnt=1
	WHILE @@FETCH_STATUS = 0 
	BEGIN
		set @sizeidcols = 'size' + convert(nvarchar(10),@sizecol)
		set @sizecols = 'sizecol' + convert(nvarchar(10),@lblIdCnt)
		set @sizelabelcols = 'sizecollabel' + convert(nvarchar(10),@sizecol)												
		set @sizecolumns =  @sizeidcols + ' nvarchar(20) ' + ' , ' +  @sizelabelcols + ' nvarchar(26) '
		set @sampleIdCnt=1
		set @samplecolumns = ''
		set @varcolumns = ''
		while @sampleIdCnt <= @sampleno
			begin
				set @sampleidcols = @sizeidcols + '_sample' + convert(nvarchar(10),@sampleIdCnt)
				set @samplecolumns = @samplecolumns + ' , ' + @sampleidcols + ' nvarchar(20) '
				set @varidcols = @sizeidcols + '_samplevar' + convert(nvarchar(10),@sampleIdCnt)
				set @varcolumns = @varcolumns + ' , ' + @varidcols + ' nvarchar(20) '
				set @sampleIdCnt=@sampleIdCnt+1
			end
		set @lblIdCnt= @lblIdCnt + 1		
		if right(@samplecolumns,1)=',' set @samplecolumns=substring(@samplecolumns, 1, len(@samplecolumns)-1)					
		set @sizesamplecols=@sizecolumns + @samplecolumns + @varcolumns			
		--select 	@sizesamplecols	 as sizesamplecols		
		select @sql = 'ALTER TABLE #tmpMeasQAsample ADD ' + @sizesamplecols
		exec(@sql)																					
		FETCH NEXT from cursor_pQASampLbl INTO  @samplelabelid, @sizecol, @collabel, @sampleno	
	END	
	CLOSE cursor_pQASampLbl 
	DEALLOCATE cursor_pQASampLbl 
			
	--select * from [#tmpMeasQAsample]	
	
	Insert into [#tmpMeasQAsample] ([SampleRequestHeaderId], [SamplePomId], [pomrow], [sortid], [refcode], [pomdescription], 
	[tolplus], [tolminus], [submit], [imageid])
	select SampleRequestHeaderId, p.SamplePomId, p.pomrow, p.sortid, p.refcode, p.pomdescription, 
	p.tolplus, p.tolminus, @Submit, p.imageid from pQAPom p WHERE p.SampleRequestHeaderId = cast(@SampleRequestHeaderId as nvarchar(50)) 

	--select * from [#tmpMeasQAsample]

DECLARE cursor_pQAPOm CURSOR FOR
	SELECT samplepomid FROM pQApom
	WHERE SampleRequestHeaderId = cast(@SampleRequestHeaderId as nvarchar(50)) ORDER BY  sortid, refcode, pomdescription
	
	OPEN cursor_pQAPOm
	
	FETCH NEXT from cursor_pQAPOm INTO  @samplepomid
		WHILE @@FETCH_STATUS = 0 
			BEGIN
				DECLARE cursor_pQASampLblUpdate CURSOR FOR
					SELECT samplelabelid,  sizecol, Collabel, sampleno FROM pQASampLbl						
					WHERE SampleRequestHeaderId = cast(@SampleRequestHeaderId as nvarchar(50)) ORDER BY sizecol

					OPEN cursor_pQASampLblUpdate

					FETCH NEXT from cursor_pQASampLblUpdate INTO  @samplelabelid, @sizecol, @collabel, @sampleno														
					
					declare @usizesamplecols nvarchar(2000)
					declare @MeasValue nvarchar(20)
					declare @sampleMeasValue nvarchar(20)
					declare @sampleVar nvarchar(20)
					
					WHILE @@FETCH_STATUS = 0 
						BEGIN
							set @sizeidcols = 'size' + convert(nvarchar(10),@sizecol)		
							set @sizelabelcols = 'sizecollabel' + convert(nvarchar(10),@sizecol)														
							set @sampleIdCnt=1							
							while @sampleIdCnt <= @sampleno
								begin									
									set @sampleidcols = @sizeidcols + '_sample' + convert(nvarchar(10),@sampleIdCnt)				
									set @varidcols = @sizeidcols + '_samplevar' + convert(nvarchar(10),@sampleIdCnt)
									select @MeasValue = [MeasValue], @sampleMeasValue = [sampMeasValue], @sampleVar = sampMeasValue - MeasValue from pQASampMeas WHERE SampleRequestHeaderId = cast(@SampleRequestHeaderId as nvarchar(50))
									and sizecol=@sizecol and sampleNo=@sampleIdCnt and samplepomid=@samplepomid and samplelabelid=@samplelabelid and Submit = @submit							
									
									--select @MeasValue as MeasValue
									--select @sampleMeasValue as sampleMeasValue	
									
									select @usizesamplecols = ' UPDATE #tmpMeasQAsample set '
									+  @sizeidcols + '=' + @MeasValue + ' , '  
									+ @sampleidcols + '=' + @sampleMeasValue + ' , '
									+ @varidcols + '=' + @sampleVar
									+ ' where samplepomid = ''' + @samplepomid + ''' and SampleRequestHeaderId = '
									+ '''' + convert(nvarchar(50),@SampleRequestHeaderId)  + '''' + ' and submit = ' + convert(nvarchar(3),@submit)
									
									--select @usizesamplecols as usizesamplecols	
									
									exec(@usizesamplecols)
									
																										
									set @sampleIdCnt=@sampleIdCnt+1
								end														
																												
							FETCH NEXT from cursor_pQASampLblUpdate INTO  @samplelabelid, @sizecol, @collabel, @sampleno	
						END	
					CLOSE cursor_pQASampLblUpdate 
					DEALLOCATE cursor_pQASampLblUpdate 
					FETCH NEXT from cursor_pQAPOm INTO  @samplepomid
			END
			
			CLOSE cursor_pQAPOm 
			DEALLOCATE cursor_pQAPOm 
			
			select * from [#tmpMeasQAsample] order by [sortid], [refcode], [pomdescription]
			drop table [#tmpMeasQAsample]
			
			SET NOCOUNT OFF


GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '04726', GetDate())
GO



