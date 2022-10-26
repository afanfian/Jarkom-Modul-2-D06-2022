;
; BIND data file for local loopback interface
;
$TTL	604800
@	IN	SOA	wise.d06.com. root.wise.d06.com. (
		     2022102601		; Serial
			 604800		; Refresh
			  86400		; Retry
			2419200		; Expire
			 604800 )	; Negative Cache TTL
;
@	IN	NS	wise.d06.com.
@	IN	A	10.18.2.2	; IP WISE
www	IN	CNAME	wise.d06.com.	; Alias
eden	IN	A	10.18.3.3	; IP Eden
www.eden	IN	A	10.18.3.3	; IP Eden
ns1	IN	A	10.18.3.2	; IP Berlint
operation	IN	NS	ns1
@	IN	A	10.18.3.3	; IP Eden
