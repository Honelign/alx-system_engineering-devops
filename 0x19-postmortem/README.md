## Postmortem

### Summary

On Friday, March 1 we experienced an outage lasting for 45 minutes from 8:00AM - 8:45AM PST. All users were completely unable to use our service for the duration of the outage. The root cause of this was a typo in the file wp-settings.php

### Timeline (PST)

8:00AM - Noticed that the web page was returning a status 500

8:10AM - all running processes on the server were checked using ps -auxf

8:25AM - used tmux to run strace in one window and curl in another window.

8:40AM - the issue was detected, as the test revealed that files were bring searched for with a .phpp extension and not a .php extension

8:45AM - the typo error was fixed in wp-settings.php with a puppet script

8:47AM - System is reloaded and operating at 100% again.


### Root cause and resolution.
A typo was made in line 137 of the file wp-settings.php that caused there to be a required file named class-wp-locale.phpp instead of class-wp-locale.php. Since the file didn’t exist anywhere, a 500 internal server error was raised and no content was able to be served causing our service to be down for 100% of our users. To fix this, a puppet script script was written using the sed -i command and was deployed across our network to fix any possible typos.

### Preventive Measures to be taken.
All code should be tested before deployment, that way issues will not be shown on the client end.
