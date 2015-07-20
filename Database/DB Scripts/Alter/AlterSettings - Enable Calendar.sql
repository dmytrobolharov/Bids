--
-- Enable/Disable application settings....
--
--
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

print 'Checking for stored procs....'
IF EXISTS (select * from sysobjects where id = object_id('spx_ZZZ_AlterSettings') and sysstat & 0xf = 4)
    drop procedure spx_ZZZ_AlterSettings
GO

print 'Creat spx_ZZZ_AlterSettings...'
GO

CREATE PROCEDURE [dbo].[spx_ZZZ_AlterSettings]  (
@configFile NVARCHAR(512),
@settingKey NVARCHAR(512),
@settingValue NVARCHAR(512) 
)
AS

update sAppsetting
set AppsettingValue = @settingValue
where AppsettingKey = @settingKey 
	and ConfigFileName = @configFile

GO

print 'Altering settings....'

-- =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
--  Edit and add to these
-- =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
exec spx_ZZZ_AlterSettings 
				@configFile = 'color.config',
				@settingKey = 'EnableColorCalendar',
				@settingValue = 'TRUE'				
GO
--
exec spx_ZZZ_AlterSettings 
				@configFile = 'image.config',
				@settingKey = 'EnableImageCalendar',
				@settingValue = 'TRUE'				
GO
exec spx_ZZZ_AlterSettings 
				@configFile = 'image.config',
				@settingKey = 'EnableImagePages',
				@settingValue = 'TRUE'				
GO
--
exec spx_ZZZ_AlterSettings 
				@configFile = 'material.config',
				@settingKey = 'EnableMaterialRequestPages',
				@settingValue = 'TRUE'				
GO
exec spx_ZZZ_AlterSettings 
				@configFile = 'material.config',
				@settingKey = 'EnableMaterialRequestCalendars',
				@settingValue = 'TRUE'
GO
exec spx_ZZZ_AlterSettings 
				@configFile = 'material.config',
				@settingKey = 'EnableMaterialPages',
				@settingValue = 'TRUE'
GO
exec spx_ZZZ_AlterSettings 
				@configFile = 'material.config',
				@settingKey = 'EnableMaterialCalendar',
				@settingValue = 'TRUE'
GO
--
exec spx_ZZZ_AlterSettings 
				@configFile = 'style.config',
				@settingKey = 'ShowTextImagePageStatus',
				@settingValue = 'TRUE'
GO
exec spx_ZZZ_AlterSettings 
				@configFile = 'style.config',
				@settingKey = 'EnableSampleRequestPages',
				@settingValue = 'TRUE'
GO
exec spx_ZZZ_AlterSettings 
				@configFile = 'style.config',
				@settingKey = 'EnableSampleRequestCalendars',
				@settingValue = 'TRUE'
GO
exec spx_ZZZ_AlterSettings 
				@configFile = 'style.config',
				@settingKey = 'StyleCopyPageSelection',
				@settingValue = 'TRUE'
GO
exec spx_ZZZ_AlterSettings 
				@configFile = 'style.config',
				@settingKey = 'EnableCalendarPages',
				@settingValue = 'TRUE'
GO
exec spx_ZZZ_AlterSettings 
				@configFile = 'style.config',
				@settingKey = 'EnableStylePages',
				@settingValue = 'TRUE'
GO
exec spx_ZZZ_AlterSettings 
				@configFile = 'style.config',
				@settingKey = 'AllowStyleCalendar',
				@settingValue = 'TRUE'
GO
--
exec spx_ZZZ_AlterSettings 
				@configFile = 'system.config',
				@settingKey = 'EnableCommitmentCalendar',
				@settingValue = 'TRUE'
GO
exec spx_ZZZ_AlterSettings 
				@configFile = 'system.config',
				@settingKey = 'EnableQuoteCalendar',
				@settingValue = 'TRUE'
GO






-- =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
--  Edit the above.
-- =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
print 'Droping stored proc...'
drop procedure spx_ZZZ_AlterSettings
GO
