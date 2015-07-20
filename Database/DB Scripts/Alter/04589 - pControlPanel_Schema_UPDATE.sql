update pControlPanel set ControlPanelEditSchema = 'Control_NBOL_OperationType_Edit.xml'
where ControlPanelName = 'Operation Type'

update pControlPanel set ControlPanelEditSchema = 'Control_NBOL_MachineClass_Edit.xml'
where ControlPanelName = 'Machine Class'

update pControlPanel set ControlPanelEditSchema = 'Control_NBOL_Template_Edit.xml'
where ControlPanelName = 'Template Library'
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04589', GetDate())
GO
