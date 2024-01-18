Get-ScheduledTask | ForEach-Object { $_.Triggers | Where-Object { $_.IsEnabled } | ForEach-Object { "Task: $($_.TaskName), Start Time: $($_.StartBoundary), End Time: $($_.EndBoundary), Repetition Interval: $($_.Repetition.Interval.Days) days, $($_.Repetition.Interval.Hours) hours, $($_.Repetition.Interval.Minutes) minutes, Execution Time: $($_.ExecutionTime)" } }