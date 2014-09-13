IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleBOMSizeRange_sel]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleBOMSizeRange_sel]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


Create PROCEDURE [dbo].[spx_StyleBOMSizeRange_sel] (
@ItemDimTypeId UNIQUEIDENTIFIER,
@StyleBOMDimensionId UNIQUEIDENTIFIER,
@StyleID UNIQUEIDENTIFIER, 
@StyleSet INT ,
@WorkflowID UNIQUEIDENTIFIER, 
@WorkflowItemID UNIQUEIDENTIFIER,
@DimLevel int
)
AS 	

Declare @Meascnt int
Declare @Sizeclass nvarchar(50)
Declare @SizeRange nvarchar(50)
declare @cols nvarchar(500)	
declare @Sizecols nvarchar(1000)	
declare @query nvarchar(4000)
declare @hdr nvarchar(50)
declare @sizecount int
declare @SizeCnt int
select @Meascnt= COUNT(Styleid) from pAMLMeasHdr where styleid=@StyleID and StyleSet=@StyleSet

select @Sizeclass = SizeClass from pStyleHeader where styleid=@StyleID and StyleSet=@StyleSet
select @SizeRange = SizeRange from pStyleHeader where styleid=@StyleID and StyleSet=@StyleSet

select @sizecount=MAX(sizecol) from pamlmeaslbl where amlmeashdrid in 
(select amlmeashdrid from pamlmeashdr where styleid=@Styleid and styleset=@Styleset)

if @Meascnt > 0
	begin				   
	   set @SizeCnt=0
	   set @Sizecols=''
	   set @cols=''
	   set @hdr=''
	   WHILE @SizeCnt <= @sizecount
			BEGIN
				set @cols = @cols + '[' + convert(nvarchar(3), @SizeCnt) + '],'					
				set @hdr= 'Size' +  convert(nvarchar(3), convert(int, @SizeCnt) + convert(int, 1))
				set @Sizecols = @Sizecols + '[' + convert(nvarchar(3), @SizeCnt) + '] as ' + @hdr + ','								
				SET @SizeCnt = @SizeCnt + 1
			END

		if right(@cols,1)=',' set @cols=substring(@cols, 1, len(@cols)-1)
		if right(@Sizecols,1)=',' set @Sizecols=substring(@Sizecols, 1, len(@Sizecols)-1)
		
	   --select @Sizecols as scols
	   --select @cols as valcols
	   --select @hdr as hdrcols
		--set @Styleid='9ffebe02-f186-4521-b352-fc0718711852'
		--select @cols= '[1],[2],[3],[4],[5],[6],[7],[8],[9],[10]'				
											
				
		SET @query = N'SELECT Sizerangeid ,  amlmeashdrid, SizeRange,  ' +
				@Sizecols + '
				FROM
				(SELECT  distinct(h.Sizerangeid) as Sizerangeid , h.amlmeashdrid as amlmeashdrid, h.SizeRange as SizeRange, 
				 Measlbl, sizecol		  
				from pAMLMeasHdr h ,  pamlmeaslbl s where h.amlmeashdrid=s.amlmeashdrid and h.SizeRangeId=s.SizeRangeId 
				and StyleId=''' + cast(@Styleid as nvarchar(50)) + '''
				and StyleSet=''' + cast(@StyleSet as nvarchar(5)) + ''' 
				) p
				PIVOT
				(
				MAX([Measlbl])
				FOR sizecol IN
				( '+
				@cols +' )
				) AS pvt order by SizeRange
				;'				
				--select @query as qry				
		Execute(@query)		
	end
	

GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='02190'))
BEGIN
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '02190', GetDate())
END	
GO