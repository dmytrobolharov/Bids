if NOT EXISTS(SELECT * FROM pStyleTypeTemplate WHERE StyleTypeTemplateID = N'ac9f9c6f-c1c5-4821-bc2e-0fb92cae7e95')
begin
	INSERT [pStyleTypeTemplate] ([StyleTypeTemplateID], [StyleTypeTemplateName], [IsSilhouette]) VALUES (N'ac9f9c6f-c1c5-4821-bc2e-0fb92cae7e95', N'Style', 0)
end
GO

if NOT EXISTS(SELECT * FROM pStyleTypeTemplate WHERE StyleTypeTemplateID = N'd55056e0-4b13-4de8-9765-5d459edbfe19')
begin
	INSERT [pStyleTypeTemplate] ([StyleTypeTemplateID], [StyleTypeTemplateName], [IsSilhouette]) VALUES (N'd55056e0-4b13-4de8-9765-5d459edbfe19', N'Silho', 1)
end
GO

if NOT EXISTS(SELECT * FROM pStyleTypeTemplate WHERE StyleTypeTemplateID = N'eea180b9-ff76-494b-aec0-7f5042ad00d1')
begin
	INSERT [pStyleTypeTemplate] ([StyleTypeTemplateID], [StyleTypeTemplateName], [IsSilhouette]) VALUES (N'eea180b9-ff76-494b-aec0-7f5042ad00d1', N'Set', 0)
end
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0.0000', '05826', GetDate())
GO
