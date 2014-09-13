
-- ******************************************************************************************** */
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Create Script                                                                              */
-- * Database:                                                                                  */
-- * 13 March 2012                                                                             	*/
-- * WorkItem #7321                                                                             */
-- * Copyright (c) 2002-2010 Gerber Technology, Inc.  All rights reserved.                      */
-- * This information is confidential and proprietary.  You may not disseminate it              */
-- * to any other party without the express written consent of Gerber Technology, Inc.          */
-- *                                                                                            */
-- ******************************************************************************************** */
-- ******************************************************************************************** */
-- COMMENTS
--
--
--

/****** Object:  StoredProcedure [dbo].[spx_StyleMeas_Imperial]    Script Date: 03/13/2012 15:46:01 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleMeas_Imperial]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleMeas_Imperial]
GO



/****** Object:  StoredProcedure [dbo].[spx_StyleMeas_Imperial]    Script Date: 03/13/2012 15:46:01 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE  PROCEDURE [dbo].[spx_StyleMeas_Imperial](
@AmlMeasHdrID UNIQUEIDENTIFIER,
@WhereParam NVARCHAR(500)
)
AS 

--Declare @AmlMeasHdrID varchar(50)

--set @AmlMeasHdrID='ef36d356-f5dd-4a73-b00d-a108a497715c'

DECLARE @cols NVARCHAR(2000)
SELECT  @cols = COALESCE(@cols + ',[' +  cast(sizecol as nvarchar(5)) + ']',
                         '[' +  cast(sizecol as nvarchar(5)) + ']')
FROM    pamlmeaslbl where amlmeashdrid = @AmlMeasHdrID
ORDER BY sizecol

--select @cols as Sizecols

DECLARE @query NVARCHAR(4000)
Declare @Metric nvarchar(2)

select @Metric=Ismetric from pamlmeashdr where amlmeashdrid = @AMLMeasHdrId

if @Metric='0'
	begin
		if Len(@WhereParam) > 0	
			begin
				SET @query = N'SELECT amlmeaspomid, pom_row, sortid, refcode, description, tolplus, tolminus, BeforeTreat, IsLength, IsWidth, ShrinkX, ShrinkY, FabricType,CADModelId, ' +
				@cols +'
				FROM
				(SELECT  t2.amlmeaspomid, t2.pom_row, t3.sortid, t3.refcode, t3.description, t3.tolplus, t3.tolminus
					  , t1.sizecol, t3.BeforeTreat, t3.IsLength, t3.IsWidth, t3.ShrinkX, t3.ShrinkY, t3.FabricType, t3.CADModelId
					  , t2.Grade
				FROM    pamlmeaslbl AS t1
						INNER JOIN pamlmeasigc AS t2 ON t1.AMLMeasHdrId = t2.AMLMeasHdrId and t1.sizecol = t2.sizecol 
						INNER JOIN pamlmeaspom as t3 ON t2.AMLMeasHdrId = t3.AMLMeasHdrId and t2.amlmeaspomid=t3.amlmeaspomid and t2.pom_row=t3.pom_row where t2.amlmeashdrid=''' + cast(@AmlMeasHdrID as nvarchar(50)) + ''' 						
						and  ' + @WhereParam + ' ) p
				PIVOT
				(
				MAX([Grade])
				FOR sizecol IN
				( '+
				@cols +' )
				) AS pvt
				ORDER BY sortid, refcode, description, pom_row ;'
			end
		else
			begin
				SET @query = N'SELECT amlmeaspomid, pom_row, sortid, refcode, description, tolplus, tolminus, BeforeTreat, IsLength, IsWidth, ShrinkX, ShrinkY, FabricType,CADModelId, ' +
				@cols +'
				FROM
				(SELECT  t2.amlmeaspomid, t2.pom_row, t3.sortid, t3.refcode, t3.description, t3.tolplus, t3.tolminus
					  , t1.sizecol, t3.BeforeTreat, t3.IsLength, t3.IsWidth, t3.ShrinkX, t3.ShrinkY, t3.FabricType, t3.CADModelId
					  , t2.Grade
				FROM    pamlmeaslbl AS t1
						INNER JOIN pamlmeasigc AS t2 ON t1.AMLMeasHdrId = t2.AMLMeasHdrId and t1.sizecol = t2.sizecol 
						INNER JOIN pamlmeaspom as t3 ON t2.AMLMeasHdrId = t3.AMLMeasHdrId and t2.amlmeaspomid=t3.amlmeaspomid and t2.pom_row=t3.pom_row where t2.amlmeashdrid=''' + cast(@AmlMeasHdrID as nvarchar(50)) + ''' 						
						) p
				PIVOT
				(
				MAX([Grade])
				FOR sizecol IN
				( '+
				@cols +' )
				) AS pvt
				ORDER BY sortid, refcode, description, pom_row ;'
			end
	end
else
	begin
		if Len(@WhereParam) > 0	
			begin
				SET @query = N'SELECT amlmeaspomid, pom_row, sortid, refcode, description, tolplus, tolminus, BeforeTreat, IsLength, IsWidth, ShrinkX, ShrinkY, FabricType,CADModelId, ' +
				@cols +'
				FROM
				(SELECT  t2.amlmeaspomid, t2.pom_row, t3.sortid, t3.refcode, t3.description, 
				--cast((t3.tolplus/(2.54)) as decimal(18,4)) as tolplus, 
				--cast((t3.tolminus/(2.54)) as decimal(18,4)) as tolminus
				cast((t3.tolplus) as decimal(18,4)) as tolplus, 
				cast((t3.tolminus) as decimal(18,4)) as tolminus
					  , t1.sizecol, t3.BeforeTreat, t3.IsLength, t3.IsWidth, t3.ShrinkX, t3.ShrinkY, t3.FabricType, t3.CADModelId
					  , t2.Grade
				FROM    pamlmeaslbl AS t1
						INNER JOIN pamlmeasigc AS t2 ON t1.AMLMeasHdrId = t2.AMLMeasHdrId and t1.sizecol = t2.sizecol 
						INNER JOIN pamlmeaspom as t3 ON t2.AMLMeasHdrId = t3.AMLMeasHdrId and t2.amlmeaspomid=t3.amlmeaspomid and t2.pom_row=t3.pom_row where t2.amlmeashdrid=''' + cast(@AmlMeasHdrID as nvarchar(50)) + ''' 						
						and  ' + @WhereParam + ' ) p
				PIVOT
				(
				MAX([Grade])
				FOR sizecol IN
				( '+
				@cols +' )
				) AS pvt
				ORDER BY sortid, refcode, description, pom_row ;'
			end
		else
			begin
				SET @query = N'SELECT amlmeaspomid, pom_row, sortid, refcode, description, tolplus, tolminus, BeforeTreat, IsLength, IsWidth, ShrinkX, ShrinkY, FabricType,CADModelId, ' +
				@cols +'
				FROM
				(SELECT  t2.amlmeaspomid, t2.pom_row, t3.sortid, t3.refcode, t3.description, 
				--cast((t3.tolplus/(2.54)) as decimal(18,4)) as tolplus, 
				--cast((t3.tolminus/(2.54)) as decimal(18,4)) as tolminus
				cast((t3.tolplus) as decimal(18,4)) as tolplus, 
				cast((t3.tolminus) as decimal(18,4)) as tolminus
					  , t1.sizecol, t3.BeforeTreat, t3.IsLength, t3.IsWidth, t3.ShrinkX, t3.ShrinkY, t3.FabricType, t3.CADModelId
					  , t2.Grade
				FROM    pamlmeaslbl AS t1
						INNER JOIN pamlmeasigc AS t2 ON t1.AMLMeasHdrId = t2.AMLMeasHdrId and t1.sizecol = t2.sizecol 
						INNER JOIN pamlmeaspom as t3 ON t2.AMLMeasHdrId = t3.AMLMeasHdrId and t2.amlmeaspomid=t3.amlmeaspomid and t2.pom_row=t3.pom_row where t2.amlmeashdrid=''' + cast(@AmlMeasHdrID as nvarchar(50)) + ''' 						
						) p
				PIVOT
				(
				MAX([Grade])
				FOR sizecol IN
				( '+
				@cols +' )
				) AS pvt
				ORDER BY sortid, refcode, description, pom_row ;'
			end
	end
EXECute(@query)


GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='03217'))
BEGIN

	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '5.0.0000', '03217', GetDate())

END

GO 

