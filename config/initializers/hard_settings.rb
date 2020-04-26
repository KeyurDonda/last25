require 'ostruct'

::HardSettings = OpenStruct.new

HardSettings.dashboard_refresh_rate           = 5000
HardSettings.scan_refresh_rate                = 5000
HardSettings.comments_refresh_rate            = 5000
HardSettings.dispatcher_refresh_rate          = 5000

HardSettings.active_scan_pagination_entries   = 10
HardSettings.finished_scan_pagination_entries = 10
HardSettings.scheduled_scan_pagination_entries = 10

HardSettings.activities_pagination_entries    = 10
HardSettings.notifications_pagination_entries = 10
HardSettings.profile_pagination_entries       = 10
HardSettings.dispatcher_pagination_entries    = 10

HardSettings.max_running_scans_per_user = 10
HardSettings.max_running_scans          = 10
