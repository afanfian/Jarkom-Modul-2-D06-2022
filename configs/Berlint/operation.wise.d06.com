;
; BIND data file for local loopback interface
;
$TTL	604800
@	IN	SOA	operation.wise.d06.com. root.operation.wise.d06.com. (
		     2022102601		; Serial
			 604800		; Refresh
			  86400		; Retry
			2419200		; Expire
			 604800 )	; Negative Cache TTL
;
@	IN	NS	operation.wise.d06.com.
@	IN	A	10.18.3.3	; IP Eden
www	IN	A	10.18.3.3	; IP Eden
strix	IN	A	10.18.3.3	; IP Eden
www.strix	IN	A	10.18.3.3
