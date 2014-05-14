$TTL 86400
@   IN  SOA     masterdns.example.com. root.example.com. (
        2011071001  ;Serial
        3600        ;Refresh
        1800        ;Retry
        604800      ;Expire
        86400       ;Minimum TTL
)
@       IN  NS          masterdns.example.com.
@       IN  PTR         example.com.
masterdns       IN  A   192.168.1.100
client          IN  A   192.168.1.102
192.168.1.8     IN  PTR         masterdns.example.com.
192.168.1.102	IN  PTR         client.example.com.
