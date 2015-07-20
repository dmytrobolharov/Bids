IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleBOMSizeRange_sel]') AND type = N'P' )
	DROP PROCEDURE [dbo].[spx_StyleBOMSizeRange_sel]
GO
/****** Object:  StoredProcedure [dbo].[spx_StyleBOMSizeRange_sel]    Script Date: 09/06/2011 13:51:11 ******/
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

if @Meascnt > 0
	begin	
	   select @sizecount = max(sizecount) from pGRSizeRangeDetail where SizeRangeId In (select  SizeRangeGuidId from pGRClassRange where
	   ClassRangeId in (select SizeRangeId from pAMLMeasHdr where StyleId=@Styleid and Styleset=@Styleset))
	   --select @sizecount as scnt
	   set @SizeCnt=1
	   set @Sizecols=''
	   set @cols=''
	   set @hdr=''
	   WHILE @SizeCnt <= @sizecount
			BEGIN
				set @cols = @cols + '[' + convert(nvarchar(3), @SizeCnt) + '],'	
				set @hdr= 'Size' + convert(nvarchar(3), @SizeCnt)
				set @Sizecols = @Sizecols + '[' + convert(nvarchar(3), @SizeCnt) + '] as ' + @hdr + ','								
				SET @SizeCnt = @SizeCnt + 1
			END

		if right(@cols,1)=',' set @cols=substring(@cols, 1, len(@cols)-1)
		if right(@Sizecols,1)=',' set @Sizecols=substring(@Sizecols, 1, len(@Sizecols)-1)
	    --select @Sizecols as scols
		--set @Styleid='9ffebe02-f186-4521-b352-fc0718711852'
		--Set @cols= '[1],[2],[3],[4],[5],[6],[7],[8],[9],[10]'
		SET @query = N'SELECT SizeRangeId , SizeRange, SizeRangeGuidId, ' +
				@Sizecols + '
				FROM
				(SELECT  distinct(g.SizeRangeId) , g.SizeRange as SizeRange, a.SizeRangeGuidId as SizeRangeGuidId, 
				s.SizeName as SizeName, s.SizeCount	as 	SizeCount		  
				from pAMLMeasHdr g , pGRClassRange a, pGRSizeRangeDetail s where g.StyleId=''' + cast(@Styleid as nvarchar(50)) + '''
				and StyleSet=''' + cast(@StyleSet as nvarchar(5)) + ''' and g.SizeRangeId=a.ClassRangeId and s.SizeRangeId=a.SizeRangeGuidId  
				) p
				PIVOT
				(
				MAX([SizeName])
				FOR SizeCount IN
				( '+
				@cols +' )
				) AS pvt
				;'				
				--select @query as qry				
		Execute(@query)		
	end
	
/*	
else
	begin
		if len(@SizeRange) > 0 
			begin
				select  distinct(g.SizeRangeGuidId), g.SizeRange  from pstyleHeader a, pGRClassRange g
				where a.SizeRange=g.ClassRangeId and a.StyleId=@StyleID and StyleSet=@StyleSet and g.Active=1
				order by g.SizeRange
				select @sizecount = max(sizecount) from pGRSizeRangeDetail where SizeRangeId In (select  SizeRangeGuidId from pGRClassRange where
				ClassRangeId in (select SizeRange from pstyleHeader where StyleId=@Styleid and StyleSet=@StyleSet))	
			end
		else
			begin
				select  distinct(g.SizeRangeGuidId), g.SizeRange  from pstyleHeader a, pGRClassRange g
				where a.SizeClass=g.SizeClassGuidId and a.StyleId=@StyleID and StyleSet=@StyleSet and g.Active=1				
				order by g.SizeRange
				select @sizecount = max(sizecount) from pGRSizeRangeDetail where SizeRangeId In (select  SizeRangeGuidId from pGRClassRange where
				SizeClassGuidId in (select SizeClass from pstyleHeader where StyleId=@Styleid and StyleSet=@StyleSet))			
			end					
		set @SizeCnt=1
	    WHILE @SizeCnt <= @sizecount
			BEGIN
				set @Sizecols = @Sizecols + convert(nvarchar(3), @SizeCnt) + ','				
				SET @SizeCnt = @SizeCnt + 1
			END

		if right(@Sizecols,1)=',' set @Sizecols=substring(@Sizecols, 1, len(@Sizecols)-1)
	
		--set @Styleid='9ffebe02-f186-4521-b352-fc0718711852'
		--Set @cols= '[1],[2],[3],[4],[5],[6],[7],[8],[9],[10]'
		SET @query = N'SELECT SizeRangeId , SizeRange, SizeRangeGuidId, ' +
				@Sizecols + '
				FROM
				(SELECT  distinct(g.SizeRangeId) , g.SizeRange as SizeRange, a.SizeRangeGuidId as SizeRangeGuidId, 
				s.SizeName as SizeName, s.SizeCount	as 	SizeCount		  
				from pstyleHeader g , pGRClassRange a, pGRSizeRangeDetail s where g.StyleId=''' + cast(@Styleid as nvarchar(50)) + '''
				and StyleSet=''' + cast(@StyleSet as nvarchar(5)) + ''' and g.SizeRangeId=a.ClassRangeId and s.SizeRangeId=a.SizeRangeGuidId  
				) p
				PIVOT
				(
				MAX([SizeName])
				FOR SizeCount IN
				( '+
				@Sizecols +' )
				) AS pvt
				;'				
				select @query as qry				
		Execute(@query)
		
		
	end

*/
	
GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='01901'))
BEGIN
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '01901', GetDate())
END

GO

