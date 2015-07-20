 IF OBJECT_ID(N'[dbo].[spx_SampleRequest_DesignSample_Meas_View]') IS NOT NULL
 DROP PROCEDURE [dbo].[spx_SampleRequest_DesignSample_Meas_View]
GO

/************************************************************************************************
* Name  : spx_SampleRequest_DesignSample_Meas_View
* Author: Andrey Dmitrienko
* Creation date: 02/12/2015
* Description :	return sample request measurement spec in imperial or metric units
*				used instead of spx_SampleRequest_DesignSample_Meas_Imperial and 
*			    spx_SampleRequest_DesignSample_Meas_Metric procedures
*
*           
* Change History:                  
* 
* Comment#		Date				Author						Comment
*
*************************************************************************************************/

CREATE PROCEDURE [dbo].[spx_SampleRequest_DesignSample_Meas_View](
@AmlMeasHdrID UNIQUEIDENTIFIER,
@WhereParam NVARCHAR(500) = NULL,
@IsMetric INT = 0
)
AS 
  DECLARE @ColsList NVARCHAR(2000)
  DECLARE @QueryStr NVARCHAR(4000)
  DECLARE @Coefficient nVARCHAR(20)
BEGIN
  -- create pivote columns list
  SELECT @ColsList = COALESCE(@ColsList + ',[' +  CAST(sizecol AS NVARCHAR(5)) + ']',
                              '[' +  CAST(sizecol AS NVARCHAR(5)) + ']')
  FROM pSampleRequestamlmeaslbl 
  WHERE SampleRequestamlmeashdrid = @AmlMeasHdrID
  ORDER BY sizecol

  SELECT @Coefficient = CAST(CASE WHEN IsMetric != @IsMetric THEN CASE WHEN IsMetric = 1 THEN 1/2.54 ELSE 2.54 END ELSE 1.0 END AS nVARCHAR(20))
  FROM pSampleRequestamlmeashdr 
  WHERE SampleRequestamlmeashdrid = @AMLMeasHdrId

  -- create query string
  SET @QueryStr = 
   'SELECT * FROM 
     (SELECT t1.sizecol, t2.SampleRequestamlmeaspomid, t2.pom_row, t3.sortid, t3.refcode, t3.description, 
	  	     t3.IsLength, t3.IsWidth, t3.ShrinkX, t3.ShrinkY, t3.FabricType, t3.CADModelId, 
		     CAST((t3.tolplus*' + @Coefficient + ') AS DECIMAL(18,4)) AS tolplus, 
		     CAST((t3.tolminus*' + @Coefficient + ') AS DECIMAL(18,4)) AS tolminus, 
			 CAST((t3.BeforeTreat*' + @Coefficient + ') AS DECIMAL(18,4)) AS BeforeTreat,  
		     CAST((t2.Grade*' + @Coefficient + ') AS DECIMAL(18,4)) AS Grade
	  FROM pSampleRequestamlmeaslbl t1
	  INNER JOIN pSampleRequestamlmeasigc t2 ON t1.SampleRequestAMLMeasHdrId = t2.SampleRequestAMLMeasHdrId AND 
											    t1.sizecol = t2.sizecol 
	  INNER JOIN pSampleRequestamlmeaspom t3 ON t2.SampleRequestAMLMeasHdrId = t3.SampleRequestAMLMeasHdrId AND 
											    t2.SampleRequestamlmeaspomid = t3.SampleRequestamlmeaspomid AND 
											    t2.pom_row=t3.pom_row 
	  WHERE t2.SampleRequestamlmeashdrid=''' + CAST(@AmlMeasHdrID AS NVARCHAR(50)) + ''''

  IF LEN(RTRIM(@WhereParam)) > 0	
    SET @QueryStr = @QueryStr + ' AND (' + @WhereParam + ')'

  SET @QueryStr = @QueryStr + ') p
     PIVOT (MAX([Grade]) FOR sizecol IN (' + @ColsList + ')) AS pvt
     ORDER BY sortid, refcode, description, pom_row ;'

  EXECUTE (@QueryStr)

END
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09351', GetDate())
GO

