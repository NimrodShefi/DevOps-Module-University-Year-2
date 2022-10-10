output "server1" { value = "server1 ip: ${openstack_networking_floatingip_v2.floating_ip_1.address}" }
output "server2" { value = "server2 ip: ${openstack_networking_floatingip_v2.floating_ip_2.address}" }
