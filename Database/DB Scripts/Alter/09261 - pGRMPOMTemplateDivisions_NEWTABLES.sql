IF OBJECT_ID(N'[dbo].[pGRMPOMTemplateDivisions]') IS NULL
BEGIN

  CREATE TABLE dbo.pGRMPOMTemplateDivisions
  (
   GRMPOMTemplateDivisionID	UNIQUEIDENTIFIER NOT NULL DEFAULT NEWID(),
   GRMPOMTemplateID			UNIQUEIDENTIFIER NOT NULL,
   DivisionID					UNIQUEIDENTIFIER NOT NULL,
 
   CONSTRAINT PK_GRMPOMTemplateDivision 
   PRIMARY KEY NONCLUSTERED (GRMPOMTemplateDivisionID),
 
   CONSTRAINT FK_GRMPOMTemplateDivision_Template FOREIGN KEY (GRMPOMTemplateID) 
  	REFERENCES dbo.pGRMeasurementsPOMTemplate (POMTempID) 
  	ON DELETE CASCADE,

   CONSTRAINT FK_GRMPOMTemplateDivision_Division FOREIGN KEY (DivisionID) 
  	REFERENCES dbo.iCustom1 (CustomID) 
  	ON DELETE CASCADE
  )

  INSERT INTO pGRMPOMTemplateDivisions(GRMPOMTemplateID, DivisionID)
  SELECT t.POMTempID, d.CustomID 
  FROM pGRMeasurementsPOMTemplate t
  INNER JOIN iCustom1 d ON d.Custom = t.CustomField1

END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09261', GetDate())

GO
