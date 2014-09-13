
	if not exists (select * from pControlPanel WHERE UPPER(ControlPanelName) = 'Class Range')
	begin
		Insert into pControlPanel (ControlPanelID,ControlPanelName,ControlPanelDescription,ControlPanelOrder,ControlPanelTableName,ControlPanelSchema,ControlPanelSearchSchema,ControlPanelUrl) 
		SELECT COALESCE(MAX(ControlPanelID),0) + 1,'Class Range','Class Range',COALESCE(MAX(ControlPanelOrder),0) + 1,'pGRMeasurementsClassrange','Control_GRMeasurements_Classrange_Default.xml','Control_GRMeasurements_Classrange_Search.xml','Control_GRMeasurements_Classrange.aspx?&CPID=' + convert(varchar(12),COALESCE(MAX(ControlPanelID),0) + 1)
		From pControlPanel
	end



	if not exists (select * from pControlPanel WHERE UPPER(ControlPanelName) = 'Measurements Alternates')
	begin
		Insert into pControlPanel (ControlPanelID,ControlPanelName,ControlPanelDescription,ControlPanelOrder,ControlPanelTableName,ControlPanelSchema,ControlPanelSearchSchema,ControlPanelUrl) 
		SELECT COALESCE(MAX(ControlPanelID),0) + 1,'Measurements Alternates','Measurements Alternates',COALESCE(MAX(ControlPanelOrder),0) + 1,'pGRMeasurementsAlternates','Control_GRMeasurements_Alternates_Default.xml', 'Control_GRMeasurements_Alternates_Search.xml', 'Control_GRMeasurements_Alternates.aspx?&CPID=' + convert(varchar(12),COALESCE(MAX(ControlPanelID),0) + 1)
		From pControlPanel
	end



	if not exists (select * from pControlPanel WHERE UPPER(ControlPanelName) = 'Measurements POM')
	begin
		Insert into pControlPanel (ControlPanelID,ControlPanelName,ControlPanelDescription,ControlPanelOrder,ControlPanelTableName,ControlPanelSchema,ControlPanelSearchSchema,ControlPanelUrl) 
		SELECT COALESCE(MAX(ControlPanelID),0) + 1,'Measurements POM','Measurements POM',COALESCE(MAX(ControlPanelOrder),0) + 1,'pGRMeasurementsPOM','Control_GRMeasurements_POM_Default.xml', 'Control_GRMeasurements_POM_Search.xml', 'Control_GRMeasurements_POM.aspx?&CPID=' + convert(varchar(12),COALESCE(MAX(ControlPanelID),0) + 1)
		From pControlPanel
	end




	if not exists (select * from pControlPanel WHERE UPPER(ControlPanelName) = 'Measurements Templates')
	begin
		Insert into pControlPanel (ControlPanelID,ControlPanelName,ControlPanelDescription,ControlPanelOrder,ControlPanelTableName,ControlPanelSchema,ControlPanelSearchSchema, ControlPanelUrl) 
		SELECT COALESCE(MAX(ControlPanelID),0) + 1,'Measurements Templates','Measurements Templates',COALESCE(MAX(ControlPanelOrder),0) + 1,'pGRMeasurementsPOMTemplate','Control_GRMeasurements_Template_Default.xml', 'Control_GRMeasurements_Template_Search.xml', 'Control_GRMeasurements_Template.aspx?&CPID=' + convert(varchar(12),COALESCE(MAX(ControlPanelID),0) + 1)
		From pControlPanel
	end


GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='02113'))
	BEGIN
		INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
		VALUES ('DB_Version', '4.1.0000', '02113', GetDate())
	END
GO