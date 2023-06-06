```
crontab -l

0 * * * * /usr/local/bin/lockrun --lockfile=/tmp/ip_top.lockrun -- /home/vagrant/top_limit_of_group_by_with_sort_fetched_ip.sh ./access-4560-644067.log 10 | mail -s "ТОП-10 IP-адресов" recipient@example.com
0 * * * * /usr/local/bin/lockrun --lockfile=/tmp/urn_top.lockrun -- /home/vagrant/top_limit_of_group_by_with_sort_fetched_urn.sh ./access-4560-644067.log 3 | mail -s "ТОП-10 URN-адресов" recipient@example.com
0 * * * * /usr/local/bin/lockrun --lockfile=/tmp/rows_with_error.lockrun -- /home/vagrant/select_rows_with_error_status.usage.sh ./access-4560-644067.log | mail -s "Все ошибки" recipient@example.com
0 * * * * /usr/local/bin/lockrun --lockfile=/tmp/http_code.lockrun -- /home/vagrant/group_by_with_sort_http_code.sh ./access-4560-644067.log | mail -s "HTTP-коды" recipient@example.com
```
