IF NOT EXISTS(SELECT * FROM INFORMATION_SCHEMA.COLUMNS
			  WHERE TABLE_NAME = 'pGRMeasurementsPOMTemplateItem' AND 
					COLUMN_NAME = 'POMTempItemGroupID')
  ALTER TABLE pGRMeasurementsPOMTemplateItem
  ADD POMTempItemGroupID UNIQUEIDENTIFIER
GO

BEGIN

  DECLARE @POMTempGroupID UNIQUEIDENTIFIER, 
 	      @POMID UNIQUEIDENTIFIER, 
		  @POMAlternatesID UNIQUEIDENTIFIER,
		  @POMTempItemGroupID UNIQUEIDENTIFIER

  DECLARE UpdItems CURSOR LOCAL FAST_FORWARD READ_ONLY FOR
    SELECT POMTempGroupID, POMID, POMAlternatesID
    FROM pGRMeasurementsPOMTemplateItem
    WHERE POMID IS NOT NULL AND POMAlternatesID IS NOT NULL
    GROUP BY POMTempGroupID, POMID, POMAlternatesID

  OPEN UpdItems
  FETCH NEXT FROM UpdItems INTO @POMTempGroupID, @POMID, @POMAlternatesID
  WHILE @@FETCH_STATUS = 0
  BEGIN
    SET @POMTempItemGroupID = NEWID()
	UPDATE pGRMeasurementsPOMTemplateItem
	SET POMTempItemGroupID = @POMTempItemGroupID
	WHERE POMTempGroupID = @POMTempGroupID AND 
		  POMID = @POMID AND 
		  POMAlternatesID = @POMAlternatesID
    FETCH NEXT FROM UpdItems INTO @POMTempGroupID, @POMID, @POMAlternatesID
  END
  CLOSE UpdItems
  DEALLOCATE UpdItems

END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09265', GetDate())

GO

