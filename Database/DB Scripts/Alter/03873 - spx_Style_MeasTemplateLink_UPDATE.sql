IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Style_MeasTemplateLink_UPDATE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_Style_MeasTemplateLink_UPDATE]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spx_Style_MeasTemplateLink_UPDATE]
(@Amlmeaspomid uniqueidentifier,
@AmlmeasHdrid uniqueidentifier,
@Linked int)
AS 

declare @POMTempItemID uniqueidentifier

Begin
	select @POMTempItemID=GRPOMCompanyId from pAMLMeasPOM where Amlmeaspomid=@Amlmeaspomid and AmlmeasHdrid=@AmlmeasHdrid 
	
	IF @Linked = 1
		BEGIN			
			update pamlmeaspom set IsLinked=1, refCode=a.POMCode, 
			[description]=a.POMDesc + case a.Alternatescode when '' then '' else '--' + AlternatesDesc end, 
			POMGuidId=a.Pomid, POMAlternatesId=a.POMAlternatesId, GRPOMCompanyId = a.POMTempItemID,
			ImageId=a.ImageId, How2MeasName=a.How2MeasName, How2MeasText=a.How2MeasText,
			tolplus=a.TolPlus, tolminus=a.tolminus, SortId=a.POMSort, Flag4QA=a.IsOnQA,
			critical=a.Critical
			from pamlmeaspom p INNER JOIN pGRMeasurementsPOMTemplateItem a ON p.POMAlternatesID = a.POMAlternatesId
			and p.GRPOMCompanyId = a.POMTempItemID and a.POMTempItemID=@POMTempItemID
			where Amlmeaspomid=@Amlmeaspomid and AmlmeasHdrid=@AmlmeasHdrid
			
			-- Updating POM grades from template
			declare @MaxSizeCol int
			declare @RowCounter int
			Declare @IncrCols nvarchar(2000)
			Declare @SizeCnt  int
			DECLARE @query NVARCHAR(max)
			Declare @IsRelative int
			Declare @IsNegative int
			Declare @IsMetric int
			Declare @IncrNullCols nvarchar(2000)
			Declare @IncrCol nvarchar(10)
			declare @samplecol int
			DECLARE @TempTableCursor CURSOR
			DECLARE @CurrentSizeCol nvarchar(10)
			DECLARE @CurrentIncr nvarchar(20)

			SELECT @MaxSizeCol = count(SizeCol) FROM pamlmeaslbl WITH (NOLOCK) WHERE AMLMeasHdrId = @AMLMeasHdrId
			select @samplecol = sizecol from pamlmeaslbl WITH (NOLOCK) WHERE AMLMeasHdrId = @AMLMeasHdrId and IsSample=1
			SELECT @IsRelative = IsRelative, @IsNegative = IsNegative, @IsMetric = IsMetric FROM pamlmeashdr WITH (NOLOCK) WHERE AMLMeasHdrId = @AMLMeasHdrId
			set @SizeCnt = 0
			set @IncrCols = ''
			set @IncrNullCols = '' 
			set @IncrCol = ''

			IF @MaxSizeCol>0
			BEGIN
				WHILE @SizeCnt <= @MaxSizeCol-1
				--Selecting the amount of size columns in current POM
				BEGIN
					set @IncrCols = @IncrCols + 'Incr' + convert(nvarchar(3), @SizeCnt) + ','
					set @IncrCol = 'Incr' + convert(nvarchar(3), @SizeCnt)
					set @IncrNullCols = @IncrNullCols + 'COALESCE(' + @IncrCol + ',' +  '0' + ') AS ' + @IncrCol + ','
					SET @SizeCnt = @SizeCnt + 1
				END
			if right(@IncrCols,1)=',' set @IncrCols=substring(@IncrCols, 1, len(@IncrCols)-1)
			if right(@IncrNullCols,1)=',' set @IncrNullCols=substring(@IncrNullCols, 1, len(@IncrNullCols)-1)
		
			--select @IncrCols as IncrCols, @IncrNullCols as IncrNullCols		

			CREATE TABLE #tempIGCData (
				 POMTempItemID uniqueidentifier
				 ,pomid UNIQUEIDENTIFIER
				 ,POMAlternatesId UNIQUEIDENTIFIER	
				 ,POMcode nvarchar(10)			
				 ,Sizecol nvarchar(10)		 
				 ,Incr nvarchar(20)				
			)		


			SET @query = N'SELECT POMTempItemID, pomid, pomalternatesid,  POMcode , Sizecol, Incr FROM     
			(SELECT POMTempItemID,   pomid, pomalternatesid, POMcode , ' + @IncrNullCols + '			 
			FROM pGRMeasurementsPOMTemplateItem  where 
			POMTempItemID = ''' + cast(@POMTempItemID as nvarchar(50)) + ''') p 							  
			UNPIVOT (Incr For Sizecol In (' + @IncrCols + ')) as unpvt ;'		

			--Now this temp table contains sizes for current POM from template
			INSERT #tempIGCData EXEC (@query)
			
			SELECT @RowCounter = COUNT(*) FROM #tempIGCData
			IF @RowCounter > 0
			BEGIN
				SET @TempTableCursor = CURSOR SCROLL
				FOR SELECT Sizecol FROM #tempIGCData
				OPEN @TempTableCursor
				FETCH NEXT FROM @TempTableCursor INTO @CurrentSizeCol
				IF @IsNegative = 1
				BEGIN
					WHILE @@FETCH_STATUS = 0
					BEGIN
						SELECT @CurrentIncr = Incr FROM #tempIGCData WHERE Sizecol = @CurrentSizeCol
						UPDATE pAMLMeasIGC
						SET Incr =  
							cast((case when (substring(cast(@CurrentSizecol as nvarchar(10)), 5, len(@CurrentSizecol))  < @samplecol) then 						
								(case COALESCE(@CurrentIncr,'0')									
									when '' then  convert(decimal(18,4),-0)					
									else
										(case when left(@CurrentIncr,1) = '-' then dbo.fnx_Frac2Num(@CurrentIncr) else dbo.fnx_Frac2Num('-' + Convert(nvarchar(25),@CurrentIncr)) end)
								 end)
							else
								dbo.fnx_Frac2Num(@CurrentIncr)
							end) as decimal(18,4))
						WHERE SizeCol = substring(cast(@CurrentSizecol as nvarchar(10)), 5, len(@CurrentSizecol))
						AND AMLMeasPOMId = @Amlmeaspomid
						FETCH NEXT FROM @TempTableCursor INTO @CurrentSizeCol
					END
				END
				ELSE
				BEGIN
					WHILE @@FETCH_STATUS = 0
					BEGIN
						SELECT @CurrentIncr = Incr FROM #tempIGCData WHERE Sizecol = @CurrentSizeCol
						UPDATE pAMLMeasIGC
						SET Incr = cast(dbo.fnx_Frac2Num(Incr)  as decimal(18,4))
						WHERE SizeCol = substring(cast(@CurrentSizecol as nvarchar(10)), 5, len(@CurrentSizecol))
						AND AMLMeasPOMId = @Amlmeaspomid
						FETCH NEXT FROM @TempTableCursor INTO @CurrentSizeCol
					END
				END
			END
			CLOSE @TempTableCursor
			DEALLOCATE @TempTableCursor
			IF @IsRelative=1 
			BEGIN
				EXEC spx_StyleMeasIMRelative_UPDATE	
				@AMLMeasHdrId		
			END
			ELSE
			BEGIN
				EXEC spx_StyleMeasIMIncrement_UPDATE	
				@AMLMeasHdrId		
			END	
		END
	END
END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES              ('DB_Version', '5.0.0000', '03873', GetDate())
GO
